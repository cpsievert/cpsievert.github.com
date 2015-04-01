# ------------------------------------------------------------------------
# DISCLAMER: This script/post was created using version 0.1 of LDAvis.
# Some backwards-incompatible changes were made since then,
# but you can still follow this example using this version of LDAvis
# devtools::install_github("cpsievert/LDAvis@v0.1")
#
# The source for the accompanying shiny app is located here --
# https://github.com/cpsievert/shiny_apps/tree/master/LDAelife
# ------------------------------------------------------------------------

library(elife)
library(LDAvis)
library(topicmodels)
library(tm)
library(Rmpfr)

# Obtain all the dois! 
dois <- searchelife(terms="*", searchin="article_title", boolean="matches")

# If you re-run this analysis, there will be more dois/articles available, which will alter results
# For this reason, I've included the dois I used as 'dois.csv'
# Also keep in mind that LDA estimation will not produce the same point estimates (but it should produce similar ones!)

dois <- read.csv("dois.csv", stringsAsFactors = FALSE)[,1]

# Obtain abstracts, subject areas, and publication dates (you really only need the abstracts)
abs <- sapply(dois, function(x) elife_doi(x, ret = "abstract"))
areas <- sapply(dois, function(x) elife_doi(x, ret = "subject_area"))
dates <- sapply(dois, function(x) elife_doi(x, ret = "pub_date_date"))

#Preprocess the text and convert to document-term matrix
dtm.control <- list(
  tolower = TRUE,
  removePunctuation = TRUE,
  removeNumbers = TRUE,
  stopwords = stopwords("english"),
  stemming = TRUE,
  wordLengths = c(3, Inf),
  weighting = weightTf
)
corp <- Corpus(VectorSource(unlist(abs, use.names=FALSE)))
dtm <- DocumentTermMatrix(corp, control = dtm.control)
dim(dtm)
dtm <- removeSparseTerms(dtm, 0.99)
dim(dtm)

# Drop documents with little or no text
dtm <- dtm[rowSums(as.matrix(dtm)) > 0, ]

# Fit models and find an optimal number of topics as suggested by Ben Marmick --
# http://stackoverflow.com/questions/21355156/topic-models-cross-validation-with-loglikelihood-or-perplexity/21394092#21394092
harmonicMean <- function(logLikelihoods, precision = 2000L) {
  llMed <- median(logLikelihoods)
  as.double(llMed - log(mean(exp(-mpfr(logLikelihoods,
                                       prec = precision) + llMed))))
}
burnin <- 1000
iter <- 1000
keep <- 50
ks <- seq(20, 40, by = 1)
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

# Get the phi matrix using LDAviz
# devtools::install_github("kshirley/LDAtools")
dat <- LDAtools::getProbs(token.id, doc.id, topic.id, vocab, K = max(topic.id), sort.topics = "byTerms")
phi <- t(dat$phi.hat)
# NOTE TO SELF: these things have to be numeric vectors or else runVis() will break...add a check in check.inputs
token.frequency <- as.numeric(table(token.id))
topic.id <- dat$topic.id
topic.proportion <- as.numeric(table(topic.id)/length(topic.id))

# Run the visualization locally using LDAvis
z <- check.inputs(K=max(topic.id), W=max(token.id), phi, token.frequency, vocab, topic.proportion)
runVis()














###############################################################
############ 'Verify' topics
###############################################################

#str(max.col(dat$theta.hat)) # This is equivalent to dat$main.topic (except the latter doesn't include prior weights) shouldn't this use reodered topics?
theta <- dat$theta.hat[, dat$topic.order]
colnames(theta) <- paste(1:dim(theta)[2])
maxes <- apply(theta, 1, max)
o <- order(maxes, decreasing = TRUE)
maxes[o][1:5] # Top 5 'most distinguished' documents (e.g., most mass on a single topic) 
w.max <- apply(theta, 1, which.max)
w.max[o][1:5] # The topic responsible for that mass

# Check that order of abstracts and subject areas match
stopifnot(all(names(abs) == names(areas)))
areas[o][1:5] # Subject areas for top 5
abs[o][1:5]


###############################################################
###########       Track topics over time --        ############
########### I didn't find anything that interesting ###########
###############################################################

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


