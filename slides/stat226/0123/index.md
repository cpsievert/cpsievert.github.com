Stat 226 - Lecture 4
========================================================
date: 01/23/13
transition: rotate
incremental: true

Announcements
========================================================

* Homework 1 is due today. Homework 2 is now available (get started -- it requires __JMP__)!
* Reading quiz is due Sunday!
* Project step 1 is due Feburary 10th. I will send an e-mail on how to self-enroll on BB.

Food for thought
========================================================

* How is a bar chart different from a histogram?




Pareto Chart
========================================================

<div align="center"><img src="pareto2.jpg" width=800></div>

This is your warning...
========================================================

<div align="center"><img src="relationship.png" height=400></div>

* But seriously, label axes and put a title on any graphics you create!

Histograms Revisited
========================================================
title: false




<img src="index-figure/head.png" title="plot of chunk head" alt="plot of chunk head" style="display: block; margin: auto;" />

```
         
          [,1]
  [88,89)    2
  [89,90)   23
  [90,91)   57
  [91,92)  100
  [92,93)  100
  [93,94)   32
  [94,95)    1
```


***
* __Histograms__ are essential to this class and statistics in general. 
* A __histogram__ displays the __distribution__ of a __quantitative__ variable.
* In simpler terms, it tells us where values of a variable are likely to occur.
* These are __absolute__ frequencies (counts).
* In order to make __inferential__ statements about a __population__, we use __relative__ frequencies!

Relative frequencies
========================================================
title: false

<img src="index-figure/rel.png" title="plot of chunk rel" alt="plot of chunk rel" style="display: block; margin: auto;" />

```
         
          [,1] 
  [88,89) 0.006
  [89,90) 0.073
  [90,91) 0.181
  [91,92) 0.317
  [92,93) 0.317
  [93,94) 0.102
  [94,95) 0.003
```

***
* To find __relative__ frequencies, divide each count by the total number of observations.
* Notice how the shape of histogram is preserved. Only the y-axis is changes!
* Before, we plotted the number of pitches in each bin. Now we have the percent of pitches within each bin.
* For example, only 0.6% of all these pitches are between 88 and 89 MPH!

Percentiles
========================================================

<img src="index-figure/percents.png" title="plot of chunk percents" alt="plot of chunk percents" style="display: block; margin: auto;" />

```
         
          [,1] 
  [88,89) 0.006
  [89,90) 0.073
  [90,91) 0.181
  [91,92) 0.317
  [92,93) 0.317
  [93,94) 0.102
  [94,95) 0.003
```

***

* What percentage of pitches thrown by Rivera are less than 90 MPH?
* Add up the relative frequencies...0.006 + 0.073 = 0.079 (about 8%)
* We say that 90 MPH is the 8th __percentile__.

Percentiles continued
========================================================

<img src="index-figure/percents2.png" title="plot of chunk percents2" alt="plot of chunk percents2" style="display: block; margin: auto;" />

```
         
          [,1] 
  [88,89) 0.006
  [89,90) 0.073
  [90,91) 0.181
  [91,92) 0.317
  [92,93) 0.317
  [93,94) 0.102
  [94,95) 0.003
```

***

* What percentage of pitches thrown by Rivera are less than 91 MPH?
* Add up the relative frequencies...0.006 + 0.073 + .181 = 0.26
* We say that 91 MPH is the 26th __percentile__.

Foreshadowing
========================================================

<img src="index-figure/dens.png" title="plot of chunk dens" alt="plot of chunk dens" style="display: block; margin: auto;" />


***

* In practice, we find a "smooth curve" based on __sample__ data in order to make __inferential__ statements about __parameters__.
* For instance, based on this data, I am about 99% confident the __true average pitch speed__ is between 89 and 94 MPH.

Confused yet? Good!
========================================================

<div align="center">
<img class="decoded" src="http://gifs.gifbin.com/1238512492_the-happening-wahlberg.gif" width=800 height=600>
</div>

A Mental Exercise
========================================================

<img src="index-figure/x.png" title="plot of chunk x" alt="plot of chunk x" style="display: block; margin: auto;" />


***
* What's the difference between these two histograms?
* There is more __variability__ in the values of the bottom histogram!

Measures of spread (or variability)
========================================================

* __Range__: Maximum - Minimum
* __IQR__: Q3 - Q1
* __Variance and Standard Deviation__: see pages 75-79 in the lecture notes.





