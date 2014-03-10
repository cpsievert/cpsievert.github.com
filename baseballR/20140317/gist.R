library(pitchRx)
library(dplyr)
library(mgcv)

# Establish a SQLite database connection
my_db <- src_sqlite("pitchRx.sqlite3")

# DISLCAIMER: this 'pitchfx.sqlite3' database was obtained using pitchRx version 1.2
# The code below probably won't work if you are using data collected from earlier versions or other methods
# Anyway, if you want to recreate this analysis, make sure you have pitchRx 1.2 or higher, then run:
#scrape(start="2008-01-01", end="2014-01-01", connect=my_db$con)

# Once you have your database, its a good idea to create some indicies for faster queries.
#dbSendQuery(my_db$con, "CREATE INDEX atbat_link ON atbat(gameday_link)")
#dbSendQuery(my_db$con, "CREATE INDEX pitch_link ON pitch(gameday_link)") 
#dbSendQuery(my_db$con, "CREATE INDEX des_index ON pitch(des)")

# Start building an SQL query using dplyr
# Note we are 'filtering' to umpire decisions
pitches <- tbl(my_db, "pitch") %.%
            select(px, pz, des, count, num, gameday_link) %.%
              filter(des == "Called Strike" | des == "Ball")

atbats <- tbl(my_db, "atbat") %.%
            select(stand, b_height, num, gameday_link)

# Join these tables together into one table
table <- left_join(x = pitches, y = atbats, by = c("gameday_link", "num"))
# Bring this data into memory (it will take a minute or two)
dat <- collect(table)

# Some games (preseason games in particular) don't have a PITCHf/x system in place -- get rid of these pitches
dat <- dat[!is.na(dat$px) & !is.na(dat$pz),]

# Create an indicator for called strike
dat$strike <- as.numeric(dat$des %in% "Called Strike")
# Turn relevant model covariates into factors
dat$stand <- factor(dat$stand)
dat$year <- factor(substr(dat$gameday_link, 5, 8))
# Create an indicator for two strikes from the count variable
strikes <- sub("^[0-9]-", "", dat$count)
dat$strikes <- factor(sub("[0-1]", "other", strikes))
# Create an indicator for three balls from the count variable
balls <- sub("-[0-9]$", "", dat$count)
dat$three_balls <- factor(sub("[0-2]", "other", balls))

# Use multiple cores to fit gams. Code derived from Brian Mills' work - http://princeofslides.blogspot.com/2013/07/advanced-sab-r-metrics-parallelization.html
library(parallel)
cl <- makeCluster(detectCores()-1)

# Model for 'mercy' in a two strike count. WARNING: this took several hours on a cluster with 24 nodes!
m1 <- bam(strike ~ interaction(stand, year, strikes) + 
           s(px, pz, by = interaction(stand, year, strikes)), 
         data = dat, family = binomial(link = 'logit'))
# Make sure you save the model when it is finished running
save(m1, file="annual-strike.rda")

# Man, this takes a while too...
png(file = "strike-plot.png", width = 400, height = 1200, type = "cairo")
strikeFX(dat, model = m1, density1 = list(strikes = "2"), 
         density2 = list(strikes = "other"), layer = facet_grid(year ~ stand)) + 
         coord_equal()
dev.off()
