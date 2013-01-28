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
<div align="center"><h1>"Getting Started with Shiny"</h1></div>


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





<h3>(1) First install Shiny if you haven't yet</h3>


```r
if (!require(shiny)) {
  install.packages("shiny")
  library(shiny)
}
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

1. Place the ui.R and server.R files into the same local directory

2. Execute the following into your R console:


```r
setwd("My Shiny Directory")
runApp()
```


### Pros: 
* Preferred avenue for development and testing.

### Cons: 
* Can't share with your friends.

--- #nonFrame
## Running apps via gist.github.com

1. If you want to create one, you need a github account.

2. "Create a gist"" with the relevant ui.R and server.R files

3. Use the relevant suffix on the url within runGist()


```r
runGist(4638469) #Runs the "Hello Shiny!" code hosted on https://gist.github.com/4638469
runGist(4440099) #Runs my PITCHf/x app
runGist(3969102) #Neat ggplot2 example by Winston Chang
```


--- #nonFrame
## Hosting via Shiny Server

1. Just released on January 22nd. I don't know much about it...

2. You can read more at: https://github.com/rstudio/shiny-server#shiny-server

--- #nonFrame
## Useful concepts for Shiny Development

* Inputs & Outputs
> - Inputs can be created via ui.R or server.R (doing this via server.R is kinda complicated)
> - Outputs are generated via server.R, then passed back to ui.R for displaying purposes.

* Reactive Functions
> - Ensures new output is generated when any inputs are changed

* UI Widgets
> - Convenient wrappers for creating options to alter inputs.

* Debugging Options
> - Available options are pretty crude. The "shiny crew" is working on better alternatives.

--- #nonFrame
## Extending "Hello Shiny!" Example

* __Challenge__: add options to change the mean and standard deviation.

* You could add either of these to ui.R:
 * sliderInput()
 * numericInput()

* Incorporate these new inputs appropriately in the server.R file.

--- #nonFrame
## Extending "Hello Shiny!" Example (part 2)

* __Challenge__: add options to plot either a normal or gamma distribution.

* You could add any of these to ui.R:
 * selectInput()
 * textInput()
 * radioButtions()
 * checkboxInput()
 * checkboxGroupInput()
 
* Incorporate the new input appropriately in the server.R file.

--- #nonFrame
## Extending "Hello Shiny!" Example (part 3)

* __Challenge__: Extend part 2 so that there are dynamic inputs according to the desired distribution. That is, display mean and std dev inputs for normal distribution and a shape input for gamma.

* You will need to use conditionalPanel() to check which distribution is desired.


--- #nonFrame
## Tips for Developing with Shiny

1. Check out what others are doing for ideas/inspiration

2. Use the Shiny Tutorial as your initial guide

3. Join the Shiny google mailing list

4. Read into HTML, CSS, Javascript, D3 for added customization

--- #nonFrame

## Questions???

* Thanks to Joe Cheng for creating such a great product!!

