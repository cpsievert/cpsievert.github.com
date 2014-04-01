library(elife)
# Obtain all the dois! 
dois <- searchelife(terms="*", searchin="article_title", boolean="matches")
# Obtain all the abstracts (and publication dates)
abs <- NULL
dates <- NULL
for (i in 1:length(dois)) {
  ab <- elife_doi(dois[i], ret = "abstract")
  date <- elife_doi(dois[i], ret = "pub_date_date")
  abs <- c(abs, ab)
  dates <- c(dates, date)
}

#Preprocess the text and convert to document-term matrix
library(topicmodels)
library(tm)
dtm.control <- list(
  tolower = T,
  removePunctuation = T,
  removeNumbers = T,
  stopwords = stopwords("english"),
  stemming = T,
  wordLengths = c(3,Inf),
  weighting = weightTf
)

corp <- Corpus(VectorSource(unlist(abs, use.names=FALSE)))
dtm <- DocumentTermMatrix(corp, control = dtm.control)
dim(dtm)
dtm <- removeSparseTerms(dtm, 0.99)
dim(dtm)

# Drop documents with little or no text (left)
dtm <- dtm[rowSums(as.matrix(dtm)) > 0, ]

# Fit models and find an optimal number of topics as suggested by Ben Marmick --
# http://stackoverflow.com/questions/21355156/topic-models-cross-validation-with-loglikelihood-or-perplexity/21394092#21394092

harmonicMean <- function(logLikelihoods, precision=2000L) {
  library("Rmpfr")
  llMed <- median(logLikelihoods)
  as.double(llMed - log(mean(exp(-mpfr(logLikelihoods,
                                       prec = precision) + llMed))))
}
burnin = 1000
iter = 1000
keep = 50
ks <- seq(4, 100, by = 4)
models <- lapply(ks, function(k) LDA(dtm, k, method = "Gibbs", control = list(burnin = burnin, iter = iter, keep = keep)))
logLiks <- lapply(models, function(L)  L@logLiks[-c(1:(burnin/keep))])
hm <- sapply(logLiks, function(h) harmonicMean(h))
# Find optimal model
plot(ks, hm, type = "l")
opt <- models[which.max(hm)][[1]]

# Extract the 'guts' of the optimal model
doc.id <- opt@wordassignments$i
token.id <- opt@wordassignments$j
topic.id <- opt@wordassignments$v
vocab <- opt@terms

# Get the phi matrix
library(LDAviz)
dat <- getProbs(token.id, doc.id, topic.id, vocab, K = max(topic.id), sort.topics = "byTerms")
phi <- t(dat$phi.hat)
# NOTE TO SELF: these things have to be numeric vectors or else runVis() will break...add a check in check.inputs
token.frequency <- as.numeric(table(token.id))
topic.id <- dat$topic.id
topic.proportion <- as.numeric(table(topic.id)/length(topic.id))

# Run the visualization locally
library(LDAvis)
z <- check.inputs(K=max(topic.id), W=max(token.id), phi, token.frequency, vocab, topic.proportion)
runVis()

######### Not included in the post ###################
# Track the prevalence of topics over time
datez <- gsub(",", "", gsub(" ", "", tolower(dates)))
date.id <- as.Date(datez, format = "%B%d%Y")[doc.id]
#dates2 <- gsub("[0-9]+,", "", dates)

#raw number of words within each topic
time.df <- data.frame(date.id, topic.id)
time.df$date <- factor(gsub("-[0-9]+$", "", time.df$date.id))
time.df$month <- factor(gsub("^[0-9]+-", "", time.df$date))
time.dat <- ddply(time.df, .(topic.id, date), summarise, count=length(date))

time.dat$date_num <- as.numeric(time.dat$date)
slopes <- ddply(time.dat, .(topic.id), summarise, coef(lm(count~date_num))[2])
time.dat$category <- "other"
time.dat$category[time.dat$topic.id %in% which.max(slopes[,2])] <- "rising"
time.dat$category[time.dat$topic.id %in% which.min(slopes[,2])] <- "declining"
library(ggplot2)
ggplot(data=time.dat, aes(x=date, y=count, group=topic.id, color=category))+geom_line(alpha=0.4)+theme_bw()+
  scale_color_manual(name="Model Type", values = c("red", "black", "blue"))

month.dat <- ddply(time.df, .(topic.id, month), summarise, count=length(date))
ggplot(data=month.dat, aes(x=month, y=count, group=topic.id))+geom_line(alpha=0.4)+theme_bw()+
  scale_color_manual(name="Model Type", values = c("red", "black", "blue"))


