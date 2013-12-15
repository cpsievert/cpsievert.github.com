library(LDAviz)
source("preprocess.R")
doc.id <- rep(dtm$i, dtm$v)
word.id <- rep(dtm$j, dtm$v)
n.iter <- 1000
Ks <- seq(5, 50, by=5)
rez <- NULL
ctr <- 1
for (i in Ks) {
  rez[[ctr]] <- fitLDA(word.id, doc.id, k=i, n.chains=3, n.iter=n.iter, alpha=25/i, beta=0.1)
  ctr <- ctr + 1
}