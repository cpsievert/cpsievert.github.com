library(XML)
library(plyr)

#grab archive so we have the master list of urls and a map to the date
xmldoc <- htmlParse("http://xkcd.com/archive/")
nodes <- getNodeSet(xmldoc, "//a[@title]")
dates <- ldply(nodes, xmlAttrs)
n.comics <- max(as.numeric(gsub("/", "", dates$href)))
dates$href <- paste0("http://xkcd.com", dates$href)
dates$title <- as.Date(dates$title, format="%Y-%m-%d")
names(dates) <- c("url", "date")

xmldocs <- NULL
for (i in dates$url) {
  doc <- htmlParse(i)
  xmldocs <- c(xmldocs, doc)
}

#grab transcripts
nodes <- llply(xmldocs, function(x) getNodeSet(x, "//div[@id='transcript']"))
docs <- llply(nodes, function(x) llply(x, xmlValue))
docs <- sapply(docs, function(x) gsub("\n", " | ", x))
doc.df <- data.frame(text=docs, url=dates$url, stringsAsFactors=FALSE)

docz <- plyr::join(doc.df, dates, by="url")

#for some reason, they've been getting lazy on transcribing more recent comics...
#grab image titles and use that as the transcript (if none exists)
comics <- llply(xmldocs, function(x) getNodeSet(x, "//div[@id='comic']"))
imgs <- llply(comics, function(x) llply(x, xmlValue))
