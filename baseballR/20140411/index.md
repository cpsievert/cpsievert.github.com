---
title: Modifying and Querying a PITCHf/x database with dplyr
author: "Carson Sievert"
date: "April 9, 2014"
output: html_document
---

In [my last post](http://baseballwithr.wordpress.com/2014/03/24/422/), we got up and running with a PITCHf/x database. This time, I'll share some thoughts on querying data from this database. I don't claim to be an database expert, so please share ideas for improvement if you have them. Before we get started, let me share some opinions I've gathered while developing [pitchRx](http://cran.r-project.org/web/packages/pitchRx/).

## A bit of my philosophy

When handling such a large and complex data source, there are a number of benefits to using a database. In my opinion, the biggest benefit is the ability to work around memory limitations on your machine. That is, if you `read.table` or `read.csv` every time you want to run a large scale analysis, you will most likely exhaust RAM which will cause your machine will be sluggish. Another benefit is a more reproducible workflow with less overhead due to managing loads of spreadsheets. I hope this post helps pitchRx users think carefully about the data required for a particular analysis and construct an appropriate database query.

pitchRx tries not to make assumptions about the particular type of analysis that you'd like to run. Its number one goal is to provide PITCHf/x data in its raw form. pitchRx does add some columns for sake of convenience (such as the pitch count and pitcher/batter names), but some of you may want to modify this raw form yourself. I encourage pitchRx users to modify the database to suit their preference and also let me know if you think something important is missing. However, one should be careful when doing so before performing a [database update](http://baseballwithr.wordpress.com/2014/03/24/422/). To demonstrate, this post will also show you how to add a date column to a table since we often want to query data based on a certain time period.

## Let's get started

For now, I recommend installing my fork of dplyr (I added an option for [computing permanent tables](https://groups.google.com/forum/#!topic/manipulatr/y-ql80zMv0Q) outside of `R`). This small change is very likely to be included in future versions of dplyr, so once it is, you won't have to install dplyr from my repository anymore.





```r
library(devtools)
install_github("cpsievert/dplyr")
```

```
## Error: trying to use CRAN without setting a mirror
```

```r
library(dplyr)
```


After installation, make sure we can connect to the database. Note that my database is saved under my working directory as "pitchRx.sqlite".


```r
db <- src_sqlite("pitchRx.sqlite3")
db
```

```
## src:  sqlite 3.7.17 [pitchRx.sqlite3]
## tbls:
```


## When in doubt, start with atbat

I view the atbat table as a central component of this database, since it has a direct link to the most tables in our database. Thus, in most cases, it makes sense to first subset the atbat table based on our level of interest then join it will another table. Before we explore some common subsetting operations, let's grab the atbat table. 


```r
atbats <- tbl(db, "atbat")
```

```
## Error: Table atbat not found in database pitchRx.sqlite3
```


It's important to note that we haven't actually brought this data into `R`. **dplyr** is smart enough to postpone data collection until it is absolutely necessary. In fact, `atbats` is currently a list containing meta-information that **dplyr** will use to (eventually) perform an SQL query. To emphasize my point, let's take a look at the SQL query associated with `atbats`.


```r
atbats$query
```

```
## Error: object 'atbats' not found
```


This query would pull the entire atbat table into `R` if we were to `collect(atbats)`. The neat thing about **dplyr** is that we can modify `atbats` as if it were a data frame before performing an expensive query. In fact, the **dplyr** philosophy is that the location of your data shouldn't impact your code.

### Appending a date column

Although tables returned by pitchRx do not explicitly contain a date column, dates are embedded between the 5th and 15th character of values in the "gameday_link" column. This allows us to append a date column using **dplyr**'s `mutate` function.


```r
atbat_date <- mutate(atbats, date = substr(gameday_link, 15L, -10L))
```

```
## Error: object 'atbats' not found
```

```r
atbat_date$query
```

```
## Error: object 'atbat_date' not found
```


One lofty goal of **dplyr** is to provide a set of high level verbs that abstract out common SQL operations. This allows **dplyr** to be agnostic in regards to where your data actually lives. While this is often very nice, one also has to be careful of various "gotchas" when mapping `R` functions to SQL functions. For example, arguments to the `substr` function in `R` are not exactly the same as arguments to the SQL core function `SUBSTR`. For this reason, you might find the [core function reference](http://sqlite.org/lang_corefunc.html) helpful at some point (at least I did when writing this post :). Using **dplyr**'s `compute` function, we can perform this query without actually bringing the resulting table into `R`.


```r
compute(atbat_date, name = "atbat_date", temporary = FALSE)
```

```
## Error: object 'atbat_date' not found
```

```r
db  # Note the new atbat_date table
```

```
## src:  sqlite 3.7.17 [pitchRx.sqlite3]
## tbls:
```


Once this table is computed, there is no reason to hang onto the original atbat table. We can easily remove this table using the [DBI](http://cran.r-project.org/web/packages/DBI/index.html) package which is R's database interface. Both pitchRx and dplyr import this package, so it will be installed already.


```r
library(DBI)
dbRemoveTable(db$con, name = "atbat")
```

```
## [1] FALSE
```

```r
db  # Note removal of atbat
```

```
## src:  sqlite 3.7.17 [pitchRx.sqlite3]
## tbls:
```


It is also a good idea to rename the new "atbat_date" table as "atbat" so that pitchRx can recognize it when [updating the database](http://baseballwithr.wordpress.com/2014/03/24/422/). **DBI**'s `dbSendQuery` function allows us to send arbitrary queries to the database, so let's use it to rename the table.


```r
dbSendQuery(db$con, "ALTER TABLE atbat_date RENAME TO atbat")
```

```
## Error: RS-DBI driver: (error in statement: no such table: atbat_date)
```

```r
db  # Now atbat has a date column
```

```
## src:  sqlite 3.7.17 [pitchRx.sqlite3]
## tbls:
```


## Subsetting by date

Assuming we have data on multiple years, we could grab 2013 data in the following manner. Also, before we perform an SQL query we can check the plan for the query using `explain`:


```r
atbat13 <- filter(tbl(db, "atbat"), date >= "2013_01_01" & date <= "2014_01_01")
```

```
## Error: Table atbat not found in database pitchRx.sqlite3
```

```r
explain(atbat13)
```

```
## Error: object 'atbat13' not found
```


Notice the `SCAN TABLE atbat` part under `<PLAN>`. This means that SQL will actually check each record to see if it meets our date criteria when the query is performed. We can do much better than this if we know a little about [indicies and query planning](http://www.sqlite.org/queryplanner.html). Basically, if we create an index on the date column, SQL no longer has to check every record and can perform a [binary search](http://en.wikipedia.org/wiki/Binary_search_algorithm) instead. We can easily create an index using **DBI**'s `dbSendQuery`.


```r
dbSendQuery(db$con, "CREATE INDEX date_idx ON atbat(date)")
```

```
## Error: RS-DBI driver: (error in statement: no such table: main.atbat)
```

```r
explain(atbat13)
```

```
## Error: object 'atbat13' not found
```


Now that we have an index on the date column, the `<PLAN>` section now says `SEARCH TABLE atbat USING INDEX` and as a result, our query will run faster when we decide to perform it. Note that **indices only have to be created once**, so now that we have `date_idx`, we can use it for other queries.

## Extracting data by player

In addition to dates, we often restrict our analysis to the player level. Thankfully, **pitchRx** adds player names to the atbat table so we can subset the atbats by name rather than ID. Suppose I'm interested in gathering every pitch thrown by Clayton Kershaw in 2013. I can simply apply another `filter` to `atbat13`:


```r
kershaw13 <- filter(atbat13, pitcher_name == "Clayton Kershaw")
```

```
## Error: object 'atbat13' not found
```


Since we are subsetting by pitcher name, it is a good idea to add an index just like how we did for the date.


```r
dbSendQuery(db$con, "CREATE INDEX pitcher_idx ON atbat(pitcher_name)")
```

```
## Error: RS-DBI driver: (error in statement: no such table: main.atbat)
```

```r
explain(kershaw13)
```

```
## Error: object 'kershaw13' not found
```


### Joining atbat with pitch

Remember that the pitch table is the one that contains the valuable PITCHf/x information so we usually want to join this data with the relevant atbat information.


```r
pitches <- tbl(db, "pitch")
```

```
## Error: Table pitch not found in database pitchRx.sqlite3
```

```r
k13 <- inner_join(pitches, kershaw13, by = c("num", "gameday_link"))
```

```
## Error: object 'pitches' not found
```


Note that I have included both the "num" and "gameday_link" as columns to join by. The "gameday_link" column gives us an indication of which game a particular pitch/atbat came from and the "num" column keeps track of the atbat within a game. Together, these columns create a [unique key](http://en.wikipedia.org/wiki/Unique_key) which allows us to join these tables. Note that an [inner join](http://en.wikipedia.org/wiki/Join_%28SQL%29#Inner_join) will drop records that don't have match on the a unique key value. That is, it will drop pitches where Kershaw *was not* the pitcher. 

For reasons similar to before, this query will be much, much faster if we create an index corresponding to the unique key.


```r
dbSendQuery(db$con, "CREATE INDEX atbat_idx ON atbat(gameday_link, num)")
```

```
## Error: RS-DBI driver: (error in statement: no such table: main.atbat)
```

```r
dbSendQuery(db$con, "CREATE INDEX pitch_idx ON pitch(gameday_link, num)")
```

```
## Error: RS-DBI driver: (error in statement: no such table: main.pitch)
```


Finally, we can now `collect` our query and be amazed at how fast we get a result.


```r
collect(k13)
```

```
## Error: object 'k13' not found
```


Next time, we'll start visualizing this data.
