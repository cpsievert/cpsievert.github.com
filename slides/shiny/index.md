---
title       : A Beginner's Introduction to Shiny
subtitle    : ISU Graphics Group (1/30/13)
author      : Carson Sievert
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : prettify  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : mathjax            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
---

## Motivating Example by Winston Cheng

<!---Height and weight of schoolchildren. Credits go to Winston Cheng.-->

<iframe src="http://glimmer.rstudio.com/winston/heightweight/"></iframe>

---
## Motivating Example by Jeff Allen

<!---Gene reconstruction networks. Credits go to Jeff Allen.-->

<iframe src="http://glimmer.rstudio.com/qbrc/grn/"></iframe>

---
## Motivating Example by Yihui Xie

<iframe src="http://glimmer.rstudio.com/yihui/knitr/"></iframe>


---
## Do I have your attention???

<div align="center"><img src="http://i.imgur.com/ljRDF8W.jpg" height=550 width=600></div>


--- 
## Run Examples Through Your Browser





* First install Shiny if you haven't yet


```r
if (!require(shiny)) {
  install.packages("shiny")
  library(shiny)
}
```


* Use runExample() to run the shiny tutorial examples


```r
runExample("01_hello")
```


--- 
## Shiny Tutorial Page - Great Intro to Shiny! 

* http://rstudio.github.com/shiny/tutorial/

<iframe src="http://rstudio.github.com/shiny/tutorial/#hello-shiny"></iframe>



