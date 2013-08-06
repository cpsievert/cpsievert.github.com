setwd("~/Desktop/github/local/cpsievert.github.com/slides/pitchRx/jsm")
require(knitr)
knit('index.Rmd', envir=new.env()) #clicking 'knit HTML' in RStudio works better. Environment issue?
system("pandoc -s -S -i -t dzslides index.md -o index-titles.html")
system("grep -Ev '<h1>Remove Me!</h1>' index-titles.html > index.html") #Remove everything that matches '<h1>Remove Me!</h1>'