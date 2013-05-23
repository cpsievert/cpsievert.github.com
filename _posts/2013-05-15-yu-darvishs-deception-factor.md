---
layout: post
title: "Yu Darvish's deception factor"
author: [cpsievert]
categories: [WebGL, Animation, Baseball]
tags: [MLB, PITCHfx, pitchRx, animation, rgl]
---
{% include JB/setup %}


On April 2nd, 2013 Yu Darvish [flirted with pitching
perfection](http://sports.yahoo.com/news/yu-darvish-loses-perfect-game-030913556--mlb.html). To
demonstrate his ability to deceive batters with a consistent delivery over different pitch types,
[redditor DShep created this
gif](http://www.reddit.com/r/baseball/comments/1d2z6d/all_of_darvishs_primary_pitches_at_once/),
which layers video of five different pitches thrown by Darvish on April 24th:

<div align="center">
  <img class="decoded" src="http://i.minus.com/i3SXAH4AAxtWS.gif" alt="http://i.minus.com/i3SXAH4AAxtWS.gif">
</div>

Cool, huh? Well, I will show you how to 'recreate' a similar 'gif' with publicly available PITCHf/x
data using the [pitchRx](http://cran.r-project.org/web/packages/pitchRx/)
[R](http://cran.r-project.org) package. First, we collect all the pitches thrown by Darvish to
Albert Pujols on April 24th:


{% highlight r %}
library(pitchRx)
dat <- scrapeFX(start = "2013-04-24", end = "2013-04-24")
atbats <- subset(dat$atbat, pitcher_name == "Yu Darvish" & batter_name == "Albert Pujols")
pitches <- plyr::join(atbats, dat$pitch, by = c("num", "url"), type = "inner")
{% endhighlight %}


Lets animate these `pitches` using `animateFX`. Note that we take a different perspective from
above by imagining the pitches coming closer as time progresses.





{% highlight r %}
animateFX(pitches)
{% endhighlight %}

<div align = "center">
 <embed width="504" height="504" name="plugin" src="http://cpsievert.github.io/figs/2013-05-15-yu-darvishs-deception-factor/ani.swf" type="application/x-shockwave-flash"> 
</div>


One thing to notice here is the different release points by Darvish (especially for his slider).
Furthermore, Darvish didn't even throw a curveball to Pujols. If you look closer at the original
gif, you can actually see a different batter (than Pujols) in the batter's box (look for a white
bat). Darvish's delivery looks very similar on videotape, but his arm angle (and thus) release
point might be slightly different for different pitch types according to the PITCHf/x data. Let's
take a closer look at Darvish's release point during this start.


{% highlight r %}
atbats <- subset(dat$atbat, pitcher_name == "Yu Darvish")
Darvish <- plyr::join(atbats, dat$pitch, by = c("num", "url"), type = "inner")
qplot(data = Darvish, x = as.numeric(x0), y = as.numeric(z0), color = pitch_type) + 
    coord_equal()
{% endhighlight %}

![center](/figs/2013-05-15-yu-darvishs-deception-factor/release.png) 


As you can see, Darvish has quite different release points according to pitch type. For example,
his slider tends to be more 'side-arm' compared to his four-seam fastball. Now, whether that
difference is distinguishable to the human-eye is another question...

EDIT: Thanks to a recommendation by [@Sky_Kalman](https://twitter.com/Sky_Kalkman), normalizing
release points should make it easier to make visual comparison of flight paths across the pitch
types. Here is one way to go about that:


{% highlight r %}
pitches$x0 <- mean(as.numeric(pitches$x0))
pitches$z0 <- mean(as.numeric(pitches$z0))
animateFX(pitches)
{% endhighlight %}

<div align = "center">
 <embed width="504" height="504" name="plugin" src="http://cpsievert.github.io/figs/2013-05-15-yu-darvishs-deception-factor/normalized.swf" type="application/x-shockwave-flash"> 
</div>



Lastly, just for fun, let's take an interactive look at Darvish's pitches to Pujols. If your
browser has [WebGL enabled](http://get.webgl.org/), go ahead and play with the object below!


{% highlight r %}
library(rgl)
interactiveFX(pitches)
{% endhighlight %}


<iframe src="http://cpsievert.github.io/pitchRx/YuDarvish/" width="800" height="600"></iframe>

I think it would be awesome to have a similar tool in
[pitchRx](http://cran.r-project.org/web/packages/pitchRx/) for creating 'gifs' with actual video.
If anybody has ideas on how we can connect PITCHf/x data with actual video, please contact me or
leave a comment!
