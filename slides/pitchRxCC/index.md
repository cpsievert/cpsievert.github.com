---
title       : pitchRx 
subtitle    : Tools for Collecting and Visualizing MLB PITCHf/x Data
author      : Carson Sievert
job         : Department of Statistics, Iowa State University
framework   : io2012                          # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js                    # {highlight.js, prettify, highlight}
hitheme     : github                        # 
widgets     : [mathjax, bootstrap]            # {mathjax, quiz, bootstrap}
mode        : selfcontained                   # {standalone, draft}
---

## What is PITCHf/x?

<iframe src="http://www.sportvision.com/media/pitchfx"></iframe>

---
## PITCHf/x data format

<iframe src="http://gd2.mlb.com/components/game/mlb/year_2011/month_04/day_04/gid_2011_04_04_minmlb_nyamlb_1/inning/inning_all.xml"></iframe>

---
## My initial attempt at scraping PITCHf/x

<div align="center"><img src="http://i.imgur.com/Wum3mpD.png" height="550" width="800"/></div>

---
## Scraping made easy


```r
library(pitchRx)
data <- scrapeFX(start = "2011-04-04", end = "2011-04-04")
str(data, list.len = 5)
```



```
## List of 2
##  $ atbat:'data.frame':	477 obs. of  20 variables:
##   ..$ away_team_runs: chr [1:477] "1" NA NA NA ...
##   ..$ b             : chr [1:477] "2" "0" "0" "1" ...
##   ..$ b_height      : chr [1:477] "5-11" "6-1" "6-2" "6-4" ...
##   ..$ batter        : chr [1:477] "217100" "430637" "457708" "137140" ...
##   ..$ des           : chr [1:477] "Willie Bloomquist homers (1) on a fly ball to left field.  " "Kelly Johnson singles on a ground ball to right fielder Kosuke Fukudome.  " "Justin Upton flies out to left fielder Alfonso Soriano.  " "Russell Branyan strikes out swinging.  " ...
##   .. [list output truncated]
##  $ pitch:'data.frame':	1636 obs. of  35 variables:
##   ..$ ax             : chr [1:1636] "-8.087" "-11.429" "-8.23" "-5.117" ...
##   ..$ ay             : chr [1:1636] "29.033" "23.352" "21.883" "25.5" ...
##   ..$ az             : chr [1:1636] "-14.377" "-21.414" "-24.381" "-13.502" ...
##   ..$ break_angle    : chr [1:1636] "22.7" "24.7" "17.0" "16.6" ...
##   ..$ break_length   : chr [1:1636] "4.2" "6.4" "6.6" "3.8" ...
##   .. [list output truncated]
```



---
## Devil's in the details

* Among many other things, this website hosts data on almost every pitch thrown since 2008.
* That's a lot of data! Since 2008, there was:
  * Over 14,000 games
  * Over 5,000 players (each player has a unique file for each game)
  * Over 1M atbats
  * Over 3.5M pitches
* Data is stored on multiple levels. The connections aren't always intuitive.

---
## Example data

We'll focus on fastballs thrown by Mariano Rivera and Phil Hughes in 2011:


```r
atbats <- subset(data$atbat, pitcher_name %in% c("Mariano Rivera", "Phil Hughes"))
pitchFX <- join(atbats, data$pitch, by = c("num", "url"), type = "inner")
pitches <- subset(pitchFX, pitch_type %in% c("FF", "FC"))
```


---
## Animation




<div align = "center">
 <embed width="864" height="720" name="plugin" src="figure/ani.swf" type="application/x-shockwave-flash"> 
</div>


---
## Easily add ggplot layers

<div align = "center">
 <embed width="864" height="720" name="plugin" src="figure/ani3.swf" type="application/x-shockwave-flash"> 
</div>


---

## WebGL graphics




<iframe src="http://cpsievert.github.com/pitchRx/rgl1"></iframe>

---
## More WebGL




<iframe src="http://cpsievert.github.com/pitchRx/rgl2"></iframe>

---

<iframe src="http://glimmer.rstudio.com/cpsievert/pitchRx" height="950" width="1000"></iframe>

---
## Biased umpires?

* In many sports, people like to blame stuff on bad referees/umpires.

* In baseball, people love to speculate that umpires make decisions in favor of the home team.

* With PITCHf/x, we can examine evidence of any 'strikezone bias'.

<div align="center"><img src="http://i.imgur.com/0lNvqM8.jpg" height="450" width="800"/></div>

---
## Called strike

* A __called strike__ is a case where the batter does not swing and the umpire declares the pitch is within the strikezone (and thus, a strike). If the batter reaches three strikes during an atbat, he is out.

<div align="center"><img src="http://i.imgur.com/QfHfDM2.png" height="450" width="800"/></div>

---
## Every called strike!

<div align="center"><img src="http://i.imgur.com/bOa0gun.png" height="550" width="1000"/></div>

---
## Away called strikes minus home strikes

<div align="center"><img src="http://i.imgur.com/EMstIPZ.png" height="550" width="1000"/></div>

---
## Balls

* A __ball__ is an instance where the batter doesn't swing and the umpire declares the pitch is outside of the strikezone (and thus, a ball). If four balls are thrown during an atbat, the batter gets to freely reach base.

<div align="center"><img src="http://i.imgur.com/iodOiLM.jpg" height="450" width="800"/></div>

---
## Away balls minus home balls

<div align="center"><img src="http://i.imgur.com/Fe4Monz.png" height="550" width="1000"/></div>

---
## Wrapping up

> - pitchRx makes it painless to get your hands dirty with PITCHf/x

> - It also simplifies general XML parsing into data frames



---
## Special Thanks to:

### This project wouldn't be possible without the help of these people/organizations. Thank you for your great work!!!

* Dr. Heike Hofmann (my major professor) [@heike_hh](https://twitter.com/heike_hh)
* RStudio [@rstudioapp](https://twitter.com/rstudioapp)
* MLB Advanced Media [@mlbdotcom](https://twitter.com/mlbdotcom)
* Alan Nathan [@pobguy](https://twitter.com/pobguy)
* Mike Fast [@fastballs](https://twitter.com/fastballs)

