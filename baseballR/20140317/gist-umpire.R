library(pitchRx)
library(dplyr)
library(mgcv)

# Establish a SQLite database connection
my_db <- src_sqlite("pitchRx.sqlite3")

# DISLCAIMER: this 'pitchfx.sqlite3' database was obtained using pitchRx version 1.1
# The code below probably won't work if you are using data collected from earlier versions or other methods
# Anyway, if you want to recreate this analysis, make sure you have pitchRx 1.1 or higher, then run:
#scrape(start="2013-01-01", end="2014-01-01", connect=my_db$con)

# Once you have your database, its a good idea to create some indicies for faster queries.
#dbSendQuery(my_db$con, "CREATE INDEX atbat_link ON atbat(gameday_link)")
#dbSendQuery(my_db$con, "CREATE INDEX pitch_link ON pitch(gameday_link)") 
#dbSendQuery(my_db$con, "CREATE INDEX umpire_link ON umpire(gameday_link)") 
#dbSendQuery(my_db$con, "CREATE INDEX des_index ON pitch(des)")

# Grab the necessary 2013 data
period <- "2013"
umpire13 <- tbl(my_db, sql(paste0("SELECT name, gameday_link FROM umpire
                                  WHERE position = 'home' 
                                  AND gameday_link LIKE '%", period, "%'")))
atbat13 <- tbl(my_db, sql(paste0("SELECT stand, b_height, num, gameday_link FROM atbat
                                 WHERE gameday_link LIKE '%", period, "%'")))
pitch13 <- tbl(my_db, sql(paste0("SELECT px, pz, des, count, num, gameday_link FROM pitch 
                                 WHERE gameday_link LIKE '%", period, "%'")))
# Further subset pitches to umpire decisions
pitch13 <- filter(pitch13, des == "Called Strike" | des == "Ball")

# The homeplate umpire changed mid-game for a couple games
# I'm not sure how to pinpoint the moment they switched, so I'll get rid of them
umpires <- collect(umpire13)
umpires <- umpires[!duplicated(umpires$gameday_link),]

# Join these tables together into one table
table <- left_join(x = atbat13, y = umpires, by = "gameday_link", copy = TRUE) %.%
  left_join(x = pitch13, by = c("gameday_link", "num"))
# Bring this data into memory
dat <- collect(table)

# Here is another way to conduct the same query, but joining is done inside (instead of outside) of memory
#pitches <- merge(collect(pitch13), collect(atbat13), by = c("gameday_link", "num"), all.x = TRUE)
#dat <- merge(pitches, umpires, by = "gameday_link", all.x = TRUE)

# Some games (preseason games in particular) don't have a PITCHf/x system in place -- get rid of these pitches
dat <- dat[!is.na(dat$px) & !is.na(dat$pz),]

# Find the top umps in terms of number of decisions made
top.umps <- names(sort(table(dat$name), decreasing = TRUE)[1:10])
df <- subset(dat, name %in% top.umps)

# Create an indicator for called strike
df$strike <- as.numeric(df$des %in% "Called Strike")
# Turn relevant model covariates into factors
df$name <- factor(df$name)
df$stand <- factor(df$stand)
# Create an indicator for two strikes from the count variable
strikes <- sub("^[0-9]-", "", df$count)
df$strikes <- factor(sub("[0-1]", "other", strikes))
# Create an indicator for three balls from the count variable
balls <- sub("-[0-9]$", "", df$count)
df$three_balls <- factor(sub("[0-2]", "other", balls))


# Use multiple cores to fit gams. Code derives from Brian Mills' work - http://princeofslides.blogspot.com/2013/07/advanced-sab-r-metrics-parallelization.html
library(parallel)
cl <- makeCluster(detectCores()-1)

# Model for 'mercy' in a two strike count
m1 <- bam(strike ~ interaction(stand, name, strikes) + 
            s(px, pz, by = interaction(stand, name, strikes)), 
          data = df, family = binomial(link = 'logit'), cluster = cl)
# This takes a while to run, so save the model output when finished
save(m1, file="m1.rda")

# Man, this takes a while too...
strikeFX(df, model = m1, density1 = list(strikes = "2"), 
         density2 = list(strikes = "other"), layer = facet_grid(name~stand)) + 
  coord_equal()

# Model for 'mercy' in a three ball count
m2 <- bam(strike ~ interaction(stand, name, balls) + 
            s(px, pz, by = interaction(stand, name, balls)), 
          data = df, family = binomial(link = 'logit'), cluster = cl)
# This takes a while to run, so save the model output when finished
save(m2, file="m2.rda")

strikeFX(df, model = m2, layer = list(coord_equal(), facet_grid(.~stand)),
         density1 = list(balls = "3"), density2 = list(strikes = "other")) + 
  
  
  # Find the top umpires in terms of games behind home plate
  # Apparently this isnt a great indicator of who saw the most pitches)
  # df <- umpire13 %.%
  #   group_by(name) %.%
  #   summarise(games = n()) %.%
  #   arrange(desc(games))
  
  # This is interesting, but how do I combine queries?
  #period <- translate_sql(url %like% "year_2013/month_06")