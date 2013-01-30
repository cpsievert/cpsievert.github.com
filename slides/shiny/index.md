---
title       : Getting Started with Shiny
subtitle    : ISU Graphics Group (1/30/13)
author      : Carson Sievert
job         : 
framework   : deck.js        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      
widgets     : mathjax            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
---
<!---CSS to fix resolution--->
<style>#iFrame { width:100%; height:90%; }</style>
<style>#nonFrame { width:100%; height:90%; }</style>
---

<img src="http://i.imgur.com/VClk4DS.png">
<div align="center"><h1>Getting Started with Shiny</h1></div>


---
## Motivating Example by Winston Chang

<!---Height and weight of schoolchildren. Credits go to Winston Chang.-->

<iframe src="http://glimmer.rstudio.com/winston/heightweight/" id="iFrame"></iframe>

---
## Motivating Example by Jeff Allen

<!---Gene reconstruction networks. Credits go to Jeff Allen.-->

<iframe src="http://glimmer.rstudio.com/qbrc/grn/" id="iFrame"></iframe>

---
## Motivating Example by Yihui Xie

<iframe src="http://glimmer.rstudio.com/yihui/knitr/" id="iFrame"></iframe>


--- #nonFrame
## Do I have your attention???

<div align="center"><img src="http://i.imgur.com/ljRDF8W.jpg"></div>


--- #nonFrame
## Run Shiny Examples From R Console




<h3>(1) First install shiny (version 0.3.0) if you haven't yet</h3>


```r
shiny.info <- sessionInfo()$otherPkgs$shiny
if (is.null(shiny.info)) {
  install.packages("shiny")
} else {
  update.packages("shiny")
}
library(shiny)
```


<h3> (2) Use runExample() to run the shiny tutorial examples</h3>


```r
runExample("01_hello")
```


<h4>NOTE:</h4>
> - R is occupied by to your local port

> - Press 'esc' (inside your R console) to quit app and return to R session...I'm not sure how to do this gracefully on the command line

--- #nonFrame
## Shiny Tutorial Page

<iframe src="http://rstudio.github.com/shiny/tutorial/#hello-shiny" id="iFrame"></iframe>

--- #nonFrame
## Running "Hello Shiny!" locally

### (1) Place the ui.R and server.R files into the same local directory

### (2) Execute the following into your R console:


```r
setwd("My Shiny Directory")
runApp()
```


### Pros: 
* Great way to develop and test your own apps.

### Cons: 
* Can't share with your friends.

--- #nonFrame
## Social shiny

### There are now two convenient ways to run apps via github:

* To demonstrate, I've copied the "Hello Shiny!" files onto my github page.

* You can run it as follows:


```r
runGitHub('shiny_apps', 'cpsievert', subdir='01_hello')
```


* Or use runUrl() - achieves the same thing


```r
runUrl("https://github.com/cpsievert/shiny_apps/archive/master.tar.gz",
  subdir = "01_hello")
```


* You can also run stuff on gist.github.com (this is older, but kinda convenient)


```r
runGist(4638469) #Runs the "Hello Shiny!" code hosted on gist.github.com/4638469
runGist(4440099) #Runs my PITCHf/x app
runGist(3969102) #Neat ggplot2 example by Winston Chang
```


--- #nonFrame
## Hosting on an actual Server

### Two Options:

* Apply for a free account with RStudio: http://www.rstudio.com/shiny/

> - I haven't done this yet, but Yihui has!

* Create your own server: https://github.com/rstudio/shiny-server#shiny-server

> - Just released on January 22nd. I don't know much about it. Any thoughts Yihui?

--- #nonFrame
## Useful concepts for Shiny Development

#### Inputs & Outputs
> - Inputs can be created via ui.R or server.R (doing this via server.R is kinda complicated)
> - Outputs are generated via server.R, then passed back to ui.R for displaying purposes.

#### Reactive Functions
> - Ensures new output is generated when any inputs are changed

#### UI Widgets
> - Convenient wrappers for creating options to alter inputs.

#### Debugging Options
> - Available options are pretty crude. The "shiny crew" is working on better alternatives.

--- #nonFrame
## Extending "Hello Shiny!"

* __Challenge__: add options to change the mean and standard deviation.

* You could add either of these to ui.R:
 * sliderInput()
 * numericInput()

* Incorporate these new inputs appropriately in the server.R file.

--- #nonFrame
## Solution 1

### You can access the appropriately modified app here:


```r
runGitHub('shiny_apps', 'cpsievert', subdir='extend1')
```



--- #nonFrame
## Extending "Hello Shiny!" (part 2)

* __Challenge__: add options to plot either a normal or gamma distribution.

* You could add any of these to ui.R:
 * selectInput()
 * textInput()
 * radioButtions()
 * checkboxInput()
 * checkboxGroupInput()
 
* Incorporate the new input appropriately in the server.R file.

--- #nonFrame
## Solution 2

### You can access the appropriately modified app here:


```r
runGitHub('shiny_apps', 'cpsievert', subdir='extend2')
```



--- #nonFrame
## Extending "Hello Shiny!" (part 3)

* __Challenge__: Extend part 2 so that there are dynamic inputs according to the desired distribution. That is, display mean and std dev inputs for normal distribution and a shape input for gamma.

* You will need to use conditionalPanel() to check which distribution is desired.

--- #nonFrame
## Solution 3

### You can access the appropriately modified app here:


```r
runGitHub('shiny_apps', 'cpsievert', subdir='extend3')
```


--- #nonFrame
## Tips for Developing with Shiny

#### (1) Check out what others are doing for ideas/inspiration

#### (2) Use the Shiny Tutorial as your initial guide

#### (3) Join the Shiny google mailing list

#### (4) Read into HTML, CSS, Javascript, D3 for added customization

--- #nonFrame

## Questions???

#### Thanks to Joe Cheng \& Winston Chang for creating/maintaining such a great product!!

