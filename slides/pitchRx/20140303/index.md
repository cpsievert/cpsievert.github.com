Taming MLB PITCHf/x Data with pitchRx
========================================================
author: Carson Sievert
date: 3/7/14
transition: rotate
incremental: true

What is PITCHf/x?
========================================================

<div align="center">
  <img class="decoded" src="http://i.minus.com/i3SXAH4AAxtWS.gif" alt="http://i.minus.com/i3SXAH4AAxtWS.gif">
</div>

* A system that tracks and records data on baseball trajectories from pitcher to batter.

Plotting trajectories
========================================================










<div align = "center">
 <embed width="504" height="504" name="plugin" src="index-figure/ani.swf" type="application/x-shockwave-flash"> 
</div>


Cool, but how was that created?
========================================================
title:false

* First, get the data:


```r
library(pitchRx)
game <- "gid_2013_04_24_texmlb_anamlb_1"
dat <- scrape(game.ids = game)
```


* The file which contain PITCHf/x contains observations on several levels (ie, pitch-by-pitch vs. atbat-by-atbat)
* Player information is recorded on the atbat level.


```r
atbats <- subset(dat$atbat, pitcher_name=="Yu Darvish" & batter_name=="Albert Pujols")
```


* Finally, animate pitches thrown by Darvish to Pujols:


```r
pitchfx <- plyr::join(atbats, dat$pitch, by = c("num", "url"), type = "inner")
animateFX(pitchfx)
```


























```
Error in object.size(dat, units = "Mb") : unused argument (units = "Mb")
```
