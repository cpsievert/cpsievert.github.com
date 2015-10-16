---
layout: post
title:  "A Tufte-style Jekyll blog powered by servr and knitr"
categories: [jekyll, rstats]
tags: [knitr, servr, httpuv, websocket]
---

<span class='newthought'>This post</span> demonstrate [my fork](http://github.com/cpsievert/knitr-jekyll) of Yihui's [knitr-jekyll](https://github.com/yihui/knitr-jekyll) which tweaks the default layout to resemble [tufte-jekyll](https://github.com/clayh53/tufte-jekyll). As Yihui mentions in his [knitr-jekyll blog post](http://yihui.name/knitr-jekyll/2014/09/jekyll-with-knitr.html) (which I _highly_ recommend reading), GitHub Pages does not support arbitrary Jekyll plugins, but I've managed to remove tufte-jekyll's dependency on custom plugins via custom [knitr output hooks](http://yihui.name/knitr/hooks/). Not only does this allow GitHub Pages to build and host this template automagically, but it also fixes [tufte-jekyll's problem with figure paths](https://github.com/clayh53/tufte-jekyll#which-brings-me-to-sorrow-and-shame). 

The rest of this post shows you how to use these custom hooks and some other useful things specific to this template (at some point, you might also want the [source for this post](https://raw.githubusercontent.com/cpsievert/knitr-jekyll/gh-pages/_source/2015-04-20-jekyll-tufte-servr.Rmd))



### Figures

By default, the `fig.width` [chunk option](http://yihui.name/knitr/options/) is equal to 7 inches. Assuming the zoom of your browser window is at 100%, that translates to about 3/4 of the textwidth.


{% highlight r %}
library(ggplot2)
p <- ggplot(diamonds, aes(carat)) 
p + geom_histogram()
{% endhighlight %}

<span class='marginnote'>Figure 1: A nice plot that is not quite wide enough. Note that this figure caption was created using the `fig.cap` chunk option</span><img class='fullwidth' src='figure/2015-04-20-jekyll-tufte-servr/'/>

If we increase `fig.width` to a ridiculous number, say 20 inches, it will still be constrained to the text width by default.


{% highlight r %}
p + geom_histogram(aes(y = ..density..))
{% endhighlight %}

<span class='marginnote'>Figure 2: The `fig.height` for this chunk is same as Figure 1, but the `fig.width` is now 20. Since the width is constrained by the text width, the figure is shrunken quite a bit.</span><img class='fullwidth' src='figure/2015-04-20-jekyll-tufte-servr/'/>

By constraining the figure width, it will ensure that figure captions (set via `fig.cap`) appear correctly in the side margin. If you don't want to restrict the final figure width, set the `fig.fullwidth` chunk option equal to `TRUE`. In this case, the figure caption is placed in the side margin below the figure.


{% highlight r %}
p + geom_point(aes(y = price), alpha = 0.2) + 
  facet_wrap(~cut, nrow = 1, scales = "free_x") +
  geom_smooth(aes(y = price, fill = cut))
{% endhighlight %}

<div><img class='fullwidth' src='figure/2015-04-20-jekyll-tufte-servr/'/></div><p><span class='marginnote'>Figure 3: Full width plot</span></p>

To place figures in the margin, set the `fig.margin` chunk option equal to `TRUE`.


{% highlight r %}
tmp <- tempfile()
user <- "http://user2014.stat.ucla.edu/images/useR-large.png"
download.file(user, tmp)
img <- png::readPNG(tmp)
plot(0:1, type = 'n', xlab = "", ylab = "")
lim <- par()
rasterImage(img, lim$usr[1], lim$usr[3], lim$usr[2], lim$usr[4])
{% endhighlight %}

<span class='marginnote'><img class='fullwidth' src='figure/2015-04-20-jekyll-tufte-servr/'/>Figure 4: useR logo</span>

{% highlight r %}
unlink(tmp)
{% endhighlight %}

## Sizing terminal output
 
The default `R` terminal output width is 80, which is a bit too big for the styling of this blog, but a width of 55 works pretty well:


{% highlight r %}
options(width = 55, digits = 3)
(x <- rnorm(40))
{% endhighlight %}



{% highlight text %}
##  [1] -0.6449  0.9139  1.1778  0.3289 -0.4563  1.0064
##  [7]  2.1105  0.2546 -0.3552  1.9547  0.5625  0.8631
## [13] -0.8187  0.1476 -0.9425  0.0853 -0.0732 -0.1935
## [19] -0.5244 -0.8866 -1.9853 -0.6689  0.5349  0.6818
## [25] -1.6925  0.4230 -0.8158 -0.4267  0.8955  1.2484
## [31] -1.2801  0.4927 -1.1489 -0.2046 -0.8912 -0.4038
## [37]  0.4824 -0.8536 -0.6308  0.6249
{% endhighlight %}

## Mathjax

If you want inline math rendering, put `$$ math $$` inline. For example, $$ \Gamma(\alpha) = (\alpha - 1)!$$. If you want it on it's own line, do something like:

{% highlight latex %}
$$
x = {-b \pm \sqrt{b^2-4ac} \over 2a}.
$$
{% endhighlight %}

which results in

$$
x = {-b \pm \sqrt{b^2-4ac} \over 2a}.
$$

## Margin notes

<span class='marginnote'> 
<img class="fullwidth" src="http://i.imgur.com/NCMxz5G.gif">
Much margin. So excite.
</span>

Put stuff in the side margin using the `<span>` HTML tag with a class of 'marginnote':

{% highlight html %}
<span class='marginnote'> 
  Anything here will appear in side margin 
</span>
{% endhighlight %}

Another (less cute) example of margin notes is to add a table caption. In fact, the figure captions above are just margin notes.

<span class='marginnote'> 
Table 1: Output from a simple linear regression in tabular form.
</span>


|term        | estimate| std.error| statistic| p.value|
|:-----------|--------:|---------:|---------:|-------:|
|(Intercept) |    1.357|     0.263|      5.17|   0.000|
|wt          |   -0.286|     0.078|     -3.65|   0.001|


## Sidenotes

Similar to a 'marginnote' is a 'sidenote'<sup class='sidenote-number'> 1 </sup> which works like this

<span class='sidenote'>
  <sup class='sidenote-number'> 1 </sup> 
  Sidenotes are kind of like footnotes that appear in the side margin.
</span> 

{% highlight html %}
<sup class='sidenote-number'> 1 </sup>
<span class='sidenote'>
  <sup class='sidenote-number'> 1 </sup> 
  Sidenotes are kind of like footnotes that appear in the side margin.
</span> 
{% endhighlight %}

Unfortunately, this is a lot of HTML markup, but of course[^2], you can also do footnotes, so that might be a better option.

[^2]: I hate it when people say "of course" as though this is obvious everyone.

## Contact me

If you find any issues or want to help improve the implementation, [please let me know](https://github.com/cpsievert/knitr-jekyll/issues/new)!

## Session Information


{% highlight text %}
## R version 3.2.2 (2015-08-14)
## Platform: x86_64-apple-darwin13.4.0 (64-bit)
## Running under: OS X 10.10.5 (Yosemite)
## 
## locale:
## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
## 
## attached base packages:
## [1] methods   stats     graphics  grDevices utils    
## [6] datasets  base     
## 
## other attached packages:
## [1] mgcv_1.8-7    nlme_3.1-122  ggplot2_1.0.1
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.1      knitr_1.11       servr_0.2       
##  [4] magrittr_1.5     MASS_7.3-44      mnormt_1.5-3    
##  [7] munsell_0.4.2    colorspace_1.2-6 lattice_0.20-33 
## [10] R6_2.1.1         highr_0.5.1      dplyr_0.4.3     
## [13] stringr_1.0.0    plyr_1.8.3       tools_3.2.2     
## [16] parallel_3.2.2   grid_3.2.2       broom_0.3.7     
## [19] gtable_0.1.2     png_0.1-7        psych_1.5.8     
## [22] DBI_0.3.1        assertthat_0.1   digest_0.6.8    
## [25] Matrix_1.2-2     tidyr_0.3.1      reshape2_1.4.1  
## [28] formatR_1.2.1    codetools_0.2-14 evaluate_0.8    
## [31] labeling_0.3     stringi_0.5-5    scales_0.3.0    
## [34] httpuv_1.3.3     proto_0.3-10
{% endhighlight %}
