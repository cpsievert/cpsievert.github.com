Starting and updating a PITCHf/x database with pitchRx and dplyr
=============================================================

First of all, let me say that I am truly honored Jim Albert invited me to join Ben Baumer in contributing to this blog. I hope to share some useful knowledge I've gained in relation to baseball data and R over the past couple years. Most of my experience comes from developing the R package [pitchRx](http://cran.r-project.org/web/packages/pitchRx/) which provides tools for collecting, storing and visualizing PITCHf/x data. If your interested, my pitchRx paper is available online via the [RJournal](http://journal.r-project.org/archive/accepted/), but you also can catch the cliff notes [here](http://cpsievert.github.io/pitchRx/).

## Setting up a PITCHf/x Database

For my first post, I want to clearly explain how to get up and running with a PITCHf/x database. I know that working with a database can be intimidating, but trust me, your hard work will pay off as we enter the [FIELDf/x era](http://grantland.com/the-triangle/mlb-advanced-media-play-tracking-bob-bowman-interview/). There are a lot of database options, but most are difficult and/or time consuming to setup. Luckily, the [dplyr](http://cran.r-project.org/web/packages/dplyr/index.html) package makes it incredibly simple to create a [SQLite](https://sqlite.org/) database.





```r
library(dplyr)
my_db <- src_sqlite("pitchRx.sqlite3", create = TRUE)
```


This will create a file in the current directory named 'pitchRx.sqlite3'. This is the SQLite database. There are many [SQLite interfaces](http://stackoverflow.com/questions/835069/which-sqlite-administration-console-do-you-recommend), but we will do everything from within the `R` session. Most importantly, the `my_db` object contains a connection that allows us to interact with the database from within `R`! Before we write data to this database, make sure the database is empty (i.e., it has no tables).


```r
my_db
```

```
## src:  sqlite 3.7.17 [pitchRx.sqlite3]
## tbls:
```


Using the `scrape` function in the pitchRx package, we can collect and store data in `my_db` using the database connection (`my_db$con`). Note that approach also works with a [MySQL](http://en.wikipedia.org/wiki/MySQL) database connection.


```r
library(pitchRx)
scrape(start = "2008-01-01", end = Sys.Date(), connect = my_db$con)
```


This snippet of code will download, manipulate, and store all available PITCHf/x starting with the 2008 season and all the way up to today. [Here](http://gd2.mlb.com/components/game/mlb/year_2011/month_04/day_04/gid_2011_04_04_minmlb_nyamlb_1/inning/inning_all.xml) is an example of just one of thousands of files it will query. Please note is a lot of data -- it takes a few hours to run -- but your patience will pay off as you will soon have data on every pitch, atbat, and other "plays" over the past six years. One may also obtain supplementary data on games, players, coaches, umpires, and even locations of balls hit into play from other files using the `suffix` argument (here are [some](http://gd2.mlb.com/components/game/mlb/year_2011/month_04/day_04/gid_2011_04_04_minmlb_nyamlb_1/inning/inning_hit.xml) [example](http://gd2.mlb.com/components/game/mlb/year_2011/month_04/day_04/gid_2011_04_04_minmlb_nyamlb_1/players.xml) [files](http://gd2.mlb.com/components/game/mlb/year_2011/month_04/day_04/miniscoreboard.xml)):


```r
files <- c("inning/inning_hit.xml", "miniscoreboard.xml", "players.xml")
scrape(start = "2008-01-01", end = Sys.Date(), suffix = files, connect = my_db$con)
```


Once this code is done running, you should have these tables in your database:


```r
my_db
```



```
## src:  sqlite 3.7.17 [pitchRx.sqlite3]
## tbls: action, atbat, coach, game, hip, media, pitch, player, po, runner,
##   umpire
```


Note that the 'pitch' table contains PITCHf/x data. The other tables can easily be linked to the 'pitch' table (or to each other) depending on the needs of the analysis. I won't cover those details in this post, but I hope to do so in future posts.

## Updating your PITCHf/x Database

For those of you that want to keep your database up-to-date throughout the season, one option is to use appropriate `start` and `end` values. However, this can lead to unintended results when scraping data on a particular day where game(s) have yet to be played. I see at least two immediate work-arounds: (1) only `scrape` data for a particular day *after* all the games are played (2) [remove duplicate rows](http://stackoverflow.com/questions/18932/how-can-i-remove-duplicate-rows?lq=1) from your tables after updating.

No matter what route you take, the first thing you'll want is the date of the most recent data point in your database. Doing this is easy if you have the 'game' table from the [miniscoreboard.xml](http://gd2.mlb.com/components/game/mlb/year_2011/month_04/day_04/miniscoreboard.xml) files since it has an 'original_date' column which can be used to find the most recent date.


```r
dates <- collect(select(tbl(my_db, "game"), original_date))
max.date <- max(as.Date(dates[!is.na(dates)], "%Y/%m/%d"))
```


If you're taking option (1), we can set `start` to be `max.date + 1` and `end` to be `Sys.Date()` without worrying about data being duplicated in the database.


```r
# Append new PITCHf/x data
scrape(start = max.date + 1, end = Sys.Date(), connect = my_db$con)
# Append other data
scrape(start = max.date + 1, end = Sys.Date(), suffix = files, connect = my_db$con)
```


For my next post, I'll demonstrate how to grab data from our database using dplyr's grammar for data manipulation. In the meantime, you might find it helpful you review dplyr's [database](http://cran.r-project.org/web/packages/dplyr/vignettes/databases.html) vignette. If you have any questions or run into problems using pitchRx, please leave a comment below or post an issue on [GitHub](https://github.com/cpsievert/pitchRx/issues?state=open). 

**DISCLAIMER**: CRAN's current version of pitchRx (1.2) does not have support for collecting 2014 data. If you'd like to collect 2014 data, please install version 1.3 (or above) from GitHub. The [devtools](http://cran.r-project.org/web/packages/devtools/devtools.pdf) package makes it really easy to do so:


```r
library(devtools)
install_github("cpsievert/pitchRx")
library(pitchRx)
```



