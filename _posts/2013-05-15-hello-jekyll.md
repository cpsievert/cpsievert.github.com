---
layout: post
title: "Hello Jekyll"
author: []
categories: [test]
tags: []
reviewer: []
---
{% include JB/setup %}

After some research and contemplation, I've decided to abandon my Wordpress site for this
Jekyll-Bootstrap blog. The main motivation is local file management and producing reproducible
examples of my work to share with others. Here are a few links that motivated and helped complete
the switch:

http://vis.supstat.com/

http://jfisher-usgs.github.io/

http://ramnathv.github.io/poirotBlog/posts/polychart.html

For my own sanity, this post will serve as a reminder of how to post to my own blog:

1. Navigate to the root directory in the terminal and run the following: `$ rake post title="A
Title"`

2. Open the file `_source/yyyy-mm-dd-title.Rmd`, add content and save it!

3. To compile into html: `$ ./_bin/knit _source/yyyy-mm-dd-title.Rmd`

<!-- 4. Copy figures to public Dropbox folder: `$ cp -r
~/Desktop/github/local/blog/_site/figures/yyyy-mm-dd-title ~/Dropbox/Public/blog` -->

5. Preview in all its glory! `$ rake preview`

The output will consist of pretty stuff like this:


{% highlight r %}
data(mtcars)
summary(mtcars)
{% endhighlight %}



{% highlight text %}
##       mpg            cyl            disp             hp       
##  Min.   :10.4   Min.   :4.00   Min.   : 71.1   Min.   : 52.0  
##  1st Qu.:15.4   1st Qu.:4.00   1st Qu.:120.8   1st Qu.: 96.5  
##  Median :19.2   Median :6.00   Median :196.3   Median :123.0  
##  Mean   :20.1   Mean   :6.19   Mean   :230.7   Mean   :146.7  
##  3rd Qu.:22.8   3rd Qu.:8.00   3rd Qu.:326.0   3rd Qu.:180.0  
##  Max.   :33.9   Max.   :8.00   Max.   :472.0   Max.   :335.0  
##       drat            wt            qsec            vs       
##  Min.   :2.76   Min.   :1.51   Min.   :14.5   Min.   :0.000  
##  1st Qu.:3.08   1st Qu.:2.58   1st Qu.:16.9   1st Qu.:0.000  
##  Median :3.69   Median :3.33   Median :17.7   Median :0.000  
##  Mean   :3.60   Mean   :3.22   Mean   :17.8   Mean   :0.438  
##  3rd Qu.:3.92   3rd Qu.:3.61   3rd Qu.:18.9   3rd Qu.:1.000  
##  Max.   :4.93   Max.   :5.42   Max.   :22.9   Max.   :1.000  
##        am             gear           carb     
##  Min.   :0.000   Min.   :3.00   Min.   :1.00  
##  1st Qu.:0.000   1st Qu.:3.00   1st Qu.:2.00  
##  Median :0.000   Median :4.00   Median :2.00  
##  Mean   :0.406   Mean   :3.69   Mean   :2.81  
##  3rd Qu.:1.000   3rd Qu.:4.00   3rd Qu.:4.00  
##  Max.   :1.000   Max.   :5.00   Max.   :8.00
{% endhighlight %}



{% highlight r %}
library(ggplot2)
qplot(mpg, wt, color = factor(cyl), data = mtcars) + facet_grid(. ~ 
  gear, margins = TRUE)
{% endhighlight %}

![plot of chunk test2](figs/2013-05-15-hello-jekyll/test2.png) 

