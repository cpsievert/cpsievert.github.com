library(XML)
doc <- htmlParse("http://sports.newsday.com/long-island/data/baseball/mlb-salaries-2013/")
#get the actual salary numbers
nodes <- getNodeSet(doc, "//td[@class='sdb sdb-numeric sdb-field-2013salary']") 
sals <- sapply(nodes, xmlValue)
tmp <- gsub("\\$||,", "", sals)
salary <- as.numeric(tmp)/1e6 #in millions
nodes2 <- getNodeSet(doc, "//td[@class='sdb-last sdb-numeric sdb-field-age']") 
ages <- sapply(nodes2, xmlValue)
nodes3 <- getNodeSet(doc, "//td[@class='sdb sdb-field-player']")
names <- sapply(nodes3, xmlValue)
dat <- data.frame(names, ages, salary)

# csv files copy pasted from -- http://www.baseball-reference.com/leagues/AL/2013-value-batting.shtml")
stats_al <- cbind(read.csv("2013_AL.csv", header=TRUE, stringsAsFactors=FALSE), league="AL")
stats_nl <- cbind(read.csv("2013_NL.csv", header=TRUE, stringsAsFactors=FALSE), league="NL")
stats <- rbind(stats_al, stats_nl)
names(stats) <- gsub("\\.", "", names(stats))
stats$Salary <- as.numeric(gsub("\\$||,", "", stats$Salary))
o <- order(stats$Salary, decreasing=TRUE)
top_guys <- head(stats[o,], 25)
top_guys$Salary <- as.numeric(gsub("\\$||,", "", top_guys$Salary))
top_guys2 <- top_guys
top_guys2$Salary <- as.numeric(gsub("\\$||,", "", top_guys2$Salary))/1e6

plot(top_guys$WAR, top_guys$Salary)


library(rCharts)

r1 <- rPlot(Salary ~ WAR, data = top_guys, type = "point", tooltip="function(item){return item.X + '\n' + 'Salary: $' + item.Salary + '\n' + 'WAR: ' + item.WAR }")
r1$addParams(height = 700)
r1$guides(x = list(min=-2, max=10), y = list(min=1.5e7, max=3e7, title="Salary (in dollars)"))
r1

r2 <- rPlot(Salary ~ WAR, data = top_guys2, type = "point", tooltip="function(item){return item.X + '\n' + 'Salary: $' + item.Salary + '(in millions)' + '\n' + 'WAR: ' + item.WAR }")
r2$addParams(height = 700)
r2$guides(x = list(min=-2, max=10), y = list(min=15, max=30, title="Salary (in millions of dollars)"))
r2

#help from http://rcharts.io/viewer/?7576061#.Uo2Tl42F8Xw
library(ggplot2)
o <- order(stats$WAR, decreasing=TRUE)
top_guys <- head(stats[o,], 100)
#top_guys$Salary <-  top_guys$Salary/1e6
top_guys <- top_guys[!is.na(top_guys$Salary), ]
m <- lm(Salary ~ WAR, data = top_guys)
dat <- fortify(m)
dat$player <- top_guys$X
names(dat) = gsub('\\.', '_', names(dat))
r1 <- rPlot(Salary ~ WAR, data = dat, type = "point", tooltip="#! function(item){return item.player } !#")
r1$addParams(height = 500, width=1000)
r1$layer(y = '_fitted', copy_layer = T, type = 'line', color = list(const = 'red'))
r1$guides(x = list(min=2, max=10), y = list(min=0, max=2.5e7, title="Salary"))

r1

  


# see https://github.com/ramnathv/rCharts/issues/303#issuecomment-28992584
# install_github('rCharts', 'ramnathv', ref='dev')
dat = fortify(lm(mpg ~ wt, data = mtcars))
names(dat) = gsub('\\.', '_', names(dat))
p1 <- rPlot(mpg ~ wt, data = dat, type = 'point', tooltip = "#! function(item){return item.wt + '\n' + item.mpg } !#")
p1$layer(y = '_fitted', copy_layer = T, type = 'line',
         color = list(const = 'red'))
p1

