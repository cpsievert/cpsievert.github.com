---
layout: post
title: "State of the pitchRx"
author: [cpsievert]
categories: [pitchRx, R]
tags: []
---
{% include JB/setup %}

Well, they've done it again. A few days ago, [@hadleywickham](https://twitter.com/hadleywickham/)
and [@rstudioapp](https://twitter.com/rstudioapp) provided another tool to help the layman look
like a hacker. This time, they've [provided
access](http://blog.rstudio.org/2013/06/10/rstudio-cran-mirror/) to logs of CRAN package downloads.
I've already noticed a [good](http://ramnathv.github.io/rstudio_logs/)
[amount](http://spatial.ly/2013/06/r_activity/)
[of](http://www.r-statistics.com/2013/06/answering-how-many-people-use-my-r-package/)
[analysis](http://www.r-statistics.com/2013/06/top-100-r-packages-for-2013-jan-may/) surrounding
this data. The announcement grabbed my attention because I released my first R package (`pitchRx`)
in Feburary and was curious about what type of activity it receives. Below is a plot of the number
of downloads (log transformed) for every package since Feburary 20th (the day `pitchRx` was
released). Note that the packages are ordered from lowest number of downloads to the highest. The
vertical line indicates the position of `pitchRx`.




![center](/figs/2013-06-13-state-of-the-pitchrx/other.png) 


As you can see, `pitchRx` seems to be slightly below average in terms of popularity. Please help
motivate me to keep the project going by posting an [issue on
github](https://github.com/cpsievert/pitchRx/issues?state=open)!
