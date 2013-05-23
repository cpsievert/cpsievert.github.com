---
layout: post
title: "Normalizing PITCHfx"
author: [cpsievert]
categories: [baseball, PITCHfx, pitchRx, animation]
tags: [MLB, animation]
---
{% include JB/setup %}

After [my most recent post](http://cpsievert.github.io/2013/05/yu-darvishs-deception-factor/),
[@Sky_Kalkman](http://twitter.com/Sky_Kalkman) threw out the idea of forcing release points to a
central point in the animation - to ease the visual comparison of flight paths across pitch types.
I implemented his idea by just using average release points; but that can be deceptive, since it
the alters the entire path of each pitch.

This got me thinking about how we might be able to do better. My (current) proposal is what I'll
call 'normalized' (or regressed towards the mean) PITCHf/x animations. The idea is to get an idea
of a 'typical' flight path for each pitch type. I think averaging over the relevant PITCHf/x
parameters is the best way to go about this - help [@pobguy](http://twitter.com/pobguy)! Anyway,
this is a starting point. Note that I'm using the same `Darvish` data frame from my most recent
post.





{% highlight r %}
library(pitchRx)
idx <- c("x0", "y0", "z0", "vx0", "vy0", "vz0", "ax", "ay", "az")
for (i in idx) Darvish[, i] <- as.numeric(Darvish[, i])
agDarvish <- ddply(Darvish, c("pitch_type", "stand"), summarize, x0 = mean(x0), 
    y0 = 55, z0 = mean(z0), vx0 = mean(vx0), vy0 = mean(vy0), vz0 = mean(vz0), 
    ax = mean(ax), ay = mean(ay), az = mean(az))
agDarvish$b_height <- "6-1"  #estimate average batter height (for strikezones)
animateFX(agDarvish, layer = facet_wrap(~stand))
{% endhighlight %}

<div align = "center">
 <embed width="504" height="504" name="plugin" src="http://cpsievert.github.io/figs/2013-05-16-normalized-pitchfx/ani1.swf" type="application/x-shockwave-flash"> 
</div>

