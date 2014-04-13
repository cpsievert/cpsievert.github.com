# Return database to raw form (no date, no indicies)
library(dplyr)
db <- src_sqlite("pitchRx.sqlite3")
atbats <- tbl(db, "atbat")
atbat_nodate <- select(atbats, pitcher:gameday_link)
compute(atbat_nodate, name = "atbat_nodate", temporary = FALSE)
dbRemoveTable(db$con, name = "atbat")
dbSendQuery(db$con, "ALTER TABLE atbat_nodate RENAME TO atbat")
dbSendQuery(db$con, "DROP INDEX pitcher_idx")
dbSendQuery(db$con, "DROP INDEX pitch_idx")

# Attempt a smoother way to update table
dbSendQuery(db$con, "ALTER TABLE atbat ADD COLUMN date TEXT")
dbSendQuery(db$con, "INSERT INTO atbat (date) SELECT SUBSTR(gameday_link, 15, -10) AS date FROM atbat")

# Taken from -- http://wkmor1.wordpress.com/2012/07/01/rchievement-of-the-day-3-bloggin-from-r-14/
# setwd("~/Desktop/github/local/cpsievert.github.com/baseballR/20140411")

knitWP <- function(file) {
  require(XML)
  post.content <- readLines(file)
  post.content <- gsub(" <", "&nbsp;<", post.content)
  post.content <- gsub("> ", ">&nbsp;", post.content)
  post.content <- htmlTreeParse(post.content)
  post.content <- paste(capture.output(print(post.content$children$html$children$body,
                                             indent = FALSE, tagSeparator = "")), collapse = "\n")
  post.content <- gsub("<?.body>", "", post.content)
  #post.content <- gsub("<p>", "<p style=\"text-align: justify;\">", post.content)
  post.content <- gsub("<?pre><code class=\"r\">", "\\[/code language=\"R\" \\]",
                       post.content)
  post.content <- gsub("<?pre><code class=\"no-highlight\">", "\\1\\\n ",
                       post.content)
  post.content <- gsub("<?/code></pre>", "\\\n\\[/code\\]", post.content)
  return(post.content)
}

knitWP("index.html")