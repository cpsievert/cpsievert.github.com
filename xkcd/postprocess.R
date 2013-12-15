#monitor convergence
for (i in seq_along(rez)){
  plotLoglik(rez[[i]][[2]])
}
Rhats <- data.frame(matrix(numeric(2*length(Ks)), nrow=length(Ks), ncol=2))
for (i in seq_along(rez)){
  l <- rez[[i]][[1]]
  l2 <- split(c(l), rep(1:dim(l)[2], each=dim(l)[1]))
  ml <- mcmc.list(lapply(l2, mcmc))
  Rhats[i, ] <- gelman.diag(ml)[[1]]
}
names(Rhats) <- c("Point est.", "Upper C.I.")
Rhats$num.topics <- Ks
Rhats


W <- length(word.id)
V <- length(unique(word.id))

sample_post <- function(fit){ #grabs samples from posterior
  samples <- matrix(numeric(W*n.iter), nrow=W, ncol=n.iter)
  samples[,1] <- fit[[1]][,sample(1:3, 1)] #randomly choose one chain
  k <- max(samples[,1])
  for (i in seq_len(n.iter)[-1]){
    samples[,i] <- fitLDA(word.id, doc.id, k=k, n.chains=1, n.iter=1, topics.init=samples[,i-1], 
                          alpha=25/i, beta=0.1)[[1]]
  }
  return(samples)
}

compute_ll <- function(samples, k){ #Compute log p(w|T)
  lik <- numeric(n.iter)
  for (i in seq_len(n.iter)){
    nj <- table(samples[,i])
    nwj <- table(word.id, samples[,i])
    lik[i] <- k*(lgamma(V*0.01) - V*lgamma(0.01)) + sum(colSums(lgamma(nwj + 0.01)) - lgamma(nj + V*0.01))
  }
  return(lik)
}

harmonics <- numeric(length(rez))
stderr <- numeric(length(rez))
for (i in seq_along(rez)){
  samplez <- sample_post(rez[[i]])
  ll <- compute_ll(samplez, k=Ks[i])
  harmonics[i] <- 1/mean(1/ll)  #point estimate of p(w|T)
  stderr <- mean((ll - harmonics[i])^2)   #sample variance
}

z <- qnorm(.975)

plot(Ks, harmonics, type="l", xlab="Number of Topics", ylab="Estimated log-likelihood")
#assess precision of the Monte Carlo approximation (see page 257 of Kaiser's notes)
lines(x=Ks, y=harmonics+z*sqrt((1/n.iter)*stderr), lty=2) 
lines(x=Ks, y=harmonics-z*sqrt((1/n.iter)*stderr), lty=2, col=2)
points(Ks, harmonics)

names(harmonics) <- Ks
#save(harmonics, file="4-204topics-beta0.1-alpha25byk.rda")


library(lubridate)
library(ggplot2)
idx <- which.max(harmonics) #index pointing to optimal number of topics
opt <- Ks[idx]
topic.id <- rez[[idx]][[1]][,sample(1:3, 1)]
date.id <- dates$date[doc.id]
time.df <- data.frame(date.id, topic.id)
time.df$yr <- year(time.df$date.id)

#raw number of words within each topic
time.dat <- ddply(time.df, c("topic.id", "yr"), summarise, count=length(yr))
ggplot(data=time.dat, aes(x=yr, y=count, group=topic.id))+geom_line()+theme_bw()

n <- ddply(time.df, "yr", summarise, total=length(yr))
time.dat <- plyr::join(time.dat, n, by="yr")
time.dat$prop <- with(time.dat, count/total)

#annual proportion of words within each topic
ggplot(data=time.dat, aes(x=yr, y=prop, group=topic.id))+geom_line()+theme_bw()
top <- time.dat$topic.id[order(time.dat$prop, decreasing=TRUE)][1:3] #grab top three proportions
time.dat$color <- time.dat$topic.id
time.dat$color[!time.dat$topic.id %in% top] <- "other"

#annual proportion of words within each topic (colored) by top topic proportions
ggplot(data=time.dat, aes(x=yr, y=prop, group=topic.id, colour=color))+geom_line()+theme_bw()

viz.dat1 <- data.frame(docs=doc.id, tokens=dtm$dimnames$Terms[word.id], topics=topic.id, stringsAsFactors=FALSE)
write.table(viz.dat1, file="vizdat.txt", sep="\t", row.names=FALSE)
probs <- getProbs(word.id, doc.id, topic.id, dtm$dimnames$Terms, K=max(topic.id))
viz.dat2 <- topdocs(probs$theta.hat, docz$url[as.numeric(dtm$dimnames$Docs)], n=10)
write.table(viz.dat2, file="vizdat2.txt", col.names=FALSE, row.names=FALSE)

library(shiny)
runApp("~/Desktop/github/local/LDAviz/inst/shiny/hover")
