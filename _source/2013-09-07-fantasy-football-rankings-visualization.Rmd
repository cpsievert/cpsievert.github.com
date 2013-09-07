---
layout: post
title: "Fantasy Football Rankings Visualization"
author: Carson Sievert
categories: NFL, Visualization
tags: NFL, Fantasy Football, rCharts, shiny, rstats
---
{% include JB/setup %}

If you haven't seen it yet, [Boris Chen
posted](http://www.borischen.co/2013/09/week-1-consensus-tiers-and-ranks.html) some great visuals
of week 1 Fantasy Football Rankings from [Fantasy Pros](http://www.fantasypros.com/nfl/rankings/).
Inspired by his work, I decided to [scrape this same
data](https://github.com/cpsievert/FFapp/blob/master/scrape.R) and provide a different
visualization of the rankings. One thing that bothered me about Boris' plots on his site was the
difficulty of reading the player names. Thus, I decided to use the integrate the wonderful
[rCharts](http://rcharts.io/) and [shiny](http://www.rstudio.com/shiny/) libraries for a better
user experience. Note that each point corresponds to a player and by hovering over each point, we
can see the player's name, the relevant matchup, the best ranking received, the worst ranking
received, and the position. There is definitely a ton that could be added to this visualization -
and feedback and suggestions are greatly appreciated! You can also view it in its entirety
[here](http://glimmer.rstudio.com/cpsievert/FFapp/)

<iframe src="http://glimmer.rstudio.com/cpsievert/FFapp/" width="800" height="600"></iframe>
