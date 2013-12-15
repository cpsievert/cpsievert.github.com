#Pre-processing code done with help from https://github.com/CabbagesAndKings/xkcd-Topics/blob/master/scripts/getTranscripts.sh
library(tm)
library(topicmodels)

#### Text Cleaning ####
#Remove alt-text (optional)
#docz$text <- gsub("\\{\\{.*\\}\\}", "", docz$text)

#Remove scene-description.
#This might initially seem like a bad idea, but scene descriptions contain stuff like [[Man standing in a room]] ,etc. 
#I'll revisit this, to see if there's a better solution
docz$text <- gsub("\\[\\[.*?\\]\\]", "", docz$text)

#remove speaker id
#for each pipe-surrounded string, check if there is a : there. If there is, discard the part before the first :
#this is only moderately accurate, but it's the best way I could think of, without manual intervention
RemoveSpeakers <- function(trans){
  trans <- paste0("|", trans, "|")
  frames <- strsplit(trans, "\\|")[[1]]
  processed.frames <- sapply(frames[grep("\\:",frames)], 
                             function(f) {
                               dialogue <- strsplit(f,":")[[1]]
                               do.call(paste, as.list(c(dialogue[2:length(dialogue)], sep="\\:")))
                             })
  frames[grep("\\:",frames)] <- processed.frames
  do.call(paste, as.list(c(frames, sep="|")))
}

docz$text <- sapply(docz$text, RemoveSpeakers)

source('extendedStopwords.R')
dtm.control <- list(
  tolower   		= T,
  removePunctuation 	= T,
  removeNumbers 		= T,
  stopwords 			= c(stopwords("english"),extendedstopwords),
  stemming 			= T,
  wordLengths 		= c(3,Inf),
  weighting 			= weightTf
)

corp <- Corpus(VectorSource(docz$text))
dtm <- DocumentTermMatrix(corp, control = dtm.control)
dim(dtm)
dtm <- removeSparseTerms(dtm, 0.999)
dim(dtm)

# Drop documents with little or no text (left)
dtm <- dtm[rowSums(as.matrix(dtm)) > 0, ]



