---
layout: post
title: "Visualizing ggplot2 internals with shiny and D3"
author: Carson Sievert
categories: [interactive visualization]
tags: [animint, ggplot2, shiny, D3]
---
{% include JB/setup %}


TL;DR -- I built [this shiny app](https://cpsievert.shinyapps.io/ggtree/) to visualize ggplot2
internals.

I'm fortunate enough to be participating in the Google's Summer of Code program where I'm helping
develop the R package [animint](https://github.com/tdhock/animint). This package is one of
[many](http://ggvis.rstudio.com/) [attempts](http://rcharts.io/) to bring interactive web graphics
to the R console. Animint's approach is somewhat unique in it's translation of ggplot2 code to
HTML/SVG output. To do this, animint first
[compiles](https://github.com/tdhock/animint/wiki/Compiler-details) a list of ggplot objects and
extracts the parts necessary for
[rendering](https://github.com/tdhock/animint/wiki/Renderer-details) output. Although the language
is incredibly expressive and powerful for users, as any ggplot2 developer could tell you, the
structure underlying a ggplot object is quite complicated (sometimes, [even the original author
needs help](https://twitter.com/hadleywickham/status/317279035937923072)).


{% highlight r %}
library(ggplot2)
p <- ggplot(mtcars, aes(mpg, wt)) +
 geom_point(colour='grey50', size = 4) +
 geom_point(aes(colour = cyl)) + facet_wrap(~am, nrow = 2)
str(p)
{% endhighlight %}



{% highlight text %}
## List of 9
##  $ data       :'data.frame':	32 obs. of  11 variables:
##   ..$ mpg : num [1:32] 21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
##   ..$ cyl : num [1:32] 6 6 4 6 8 6 8 4 4 6 ...
##   ..$ disp: num [1:32] 160 160 108 258 360 ...
##   ..$ hp  : num [1:32] 110 110 93 110 175 105 245 62 95 123 ...
##   ..$ drat: num [1:32] 3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
##   ..$ wt  : num [1:32] 2.62 2.88 2.32 3.21 3.44 ...
##   ..$ qsec: num [1:32] 16.5 17 18.6 19.4 17 ...
##   ..$ vs  : num [1:32] 0 0 1 1 0 1 0 1 1 1 ...
##   ..$ am  : num [1:32] 1 1 1 0 0 0 0 0 0 0 ...
##   ..$ gear: num [1:32] 4 4 4 3 3 3 3 4 4 4 ...
##   ..$ carb: num [1:32] 4 4 1 1 2 1 4 2 2 4 ...
##  $ layers     :List of 2
##   ..$ :Classes 'proto', 'environment' <environment: 0x7fb464c35e38> 
##   ..$ :Classes 'proto', 'environment' <environment: 0x7fb46a466c08> 
##  $ scales     :Reference class 'Scales' [package "ggplot2"] with 1 fields
##   ..$ scales: list()
##   ..and 21 methods, of which 9 are possibly relevant:
##   ..  add, clone, find, get_scales, has_scale, initialize, input, n,
##   ..  non_position_scales
##  $ mapping    :List of 2
##   ..$ x: symbol mpg
##   ..$ y: symbol wt
##  $ theme      : list()
##  $ coordinates:List of 1
##   ..$ limits:List of 2
##   .. ..$ x: NULL
##   .. ..$ y: NULL
##   ..- attr(*, "class")= chr [1:2] "cartesian" "coord"
##  $ facet      :List of 7
##   ..$ facets  :List of 1
##   .. ..$ am: symbol am
##   .. ..- attr(*, "env")=<environment: 0x7fb464b97068> 
##   .. ..- attr(*, "class")= chr "quoted"
##   ..$ free    :List of 2
##   .. ..$ x: logi FALSE
##   .. ..$ y: logi FALSE
##   ..$ as.table: logi TRUE
##   ..$ drop    : logi TRUE
##   ..$ ncol    : NULL
##   ..$ nrow    : num 2
##   ..$ shrink  : logi TRUE
##   ..- attr(*, "class")= chr [1:2] "wrap" "facet"
##  $ plot_env   :<environment: R_GlobalEnv> 
##  $ labels     :List of 3
##   ..$ x     : chr "mpg"
##   ..$ y     : chr "wt"
##   ..$ colour: chr "cyl"
##  - attr(*, "class")= chr [1:2] "gg" "ggplot"
{% endhighlight %}

Of course, this structure gets much more complicated after we "build" the plot --


{% highlight r %}
str(ggplot_build(p))
{% endhighlight %}



{% highlight text %}
## List of 3
##  $ data :List of 2
##   ..$ :'data.frame':	32 obs. of  4 variables:
##   .. ..$ x    : num [1:32] 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 ...
##   .. ..$ y    : num [1:32] 3.21 3.44 3.46 3.57 3.19 ...
##   .. ..$ PANEL: Factor w/ 2 levels "1","2": 1 1 1 1 1 1 1 1 1 1 ...
##   .. ..$ group: int [1:32] 1 1 1 1 1 1 1 1 1 1 ...
##   ..$ :'data.frame':	32 obs. of  5 variables:
##   .. ..$ colour: chr [1:32] "#326A97" "#55B1F7" "#326A97" "#55B1F7" ...
##   .. ..$ x     : num [1:32] 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 ...
##   .. ..$ y     : num [1:32] 3.21 3.44 3.46 3.57 3.19 ...
##   .. ..$ PANEL : Factor w/ 2 levels "1","2": 1 1 1 1 1 1 1 1 1 1 ...
##   .. ..$ group : int [1:32] 1 1 1 1 1 1 1 1 1 1 ...
##  $ panel:List of 5
##   ..$ layout  :'data.frame':	2 obs. of  8 variables:
##   .. ..$ PANEL  : Factor w/ 2 levels "1","2": 1 2
##   .. ..$ ROW    : int [1:2] 1 2
##   .. ..$ COL    : int [1:2] 1 1
##   .. ..$ am     : num [1:2] 0 1
##   .. ..$ SCALE_X: int [1:2] 1 1
##   .. ..$ SCALE_Y: int [1:2] 1 1
##   .. ..$ AXIS_X : logi [1:2] FALSE TRUE
##   .. ..$ AXIS_Y : logi [1:2] TRUE TRUE
##   ..$ shrink  : logi TRUE
##   ..$ x_scales:List of 1
##   .. ..$ :List of 17
##   .. .. ..$ call        : language continuous_scale(aesthetics = c("x", "xmin", "xmax", "xend", "xintercept"),      scale_name = "position_c", palette = identity, expand = expand,  ...
##   .. .. ..$ aesthetics  : chr [1:5] "x" "xmin" "xmax" "xend" ...
##   .. .. ..$ scale_name  : chr "position_c"
##   .. .. ..$ palette     :function (x)  
##   .. .. ..$ range       :Reference class 'Continuous' [package "scales"] with 1 fields
##   .. .. .. ..$ range: num [1:2] 10.4 33.9
##   .. .. .. ..and 15 methods, of which 3 are possibly relevant:
##   .. .. .. ..  initialize, reset, train
##   .. .. ..$ limits      : NULL
##   .. .. ..$ trans       :List of 6
##   .. .. .. ..$ name     : chr "identity"
##   .. .. .. ..$ transform:function (x)  
##   .. .. .. ..$ inverse  :function (x)  
##   .. .. .. ..$ breaks   :function (x)  
##   .. .. .. ..$ format   :function (x)  
##   .. .. .. ..$ domain   : num [1:2] -Inf Inf
##   .. .. .. ..- attr(*, "class")= chr "trans"
##   .. .. ..$ na.value    : num NA
##   .. .. ..$ expand      : list()
##   .. .. .. ..- attr(*, "class")= chr "waiver"
##   .. .. ..$ rescaler    :function (x, to = c(0, 1), from = range(x, na.rm = TRUE))  
##   .. .. ..$ oob         :function (x, range = c(0, 1), only.finite = TRUE)  
##   .. .. ..$ name        : NULL
##   .. .. ..$ breaks      : list()
##   .. .. .. ..- attr(*, "class")= chr "waiver"
##   .. .. ..$ minor_breaks: list()
##   .. .. .. ..- attr(*, "class")= chr "waiver"
##   .. .. ..$ labels      : list()
##   .. .. .. ..- attr(*, "class")= chr "waiver"
##   .. .. ..$ legend      : NULL
##   .. .. ..$ guide       : chr "none"
##   .. .. ..- attr(*, "class")= chr [1:3] "position_c" "continuous" "scale"
##   ..$ y_scales:List of 1
##   .. ..$ :List of 17
##   .. .. ..$ call        : language continuous_scale(aesthetics = c("y", "ymin", "ymax", "yend", "yintercept",      "ymin_final", "ymax_final"), scale_name = "position_c", palette = identity,  ...
##   .. .. ..$ aesthetics  : chr [1:7] "y" "ymin" "ymax" "yend" ...
##   .. .. ..$ scale_name  : chr "position_c"
##   .. .. ..$ palette     :function (x)  
##   .. .. ..$ range       :Reference class 'Continuous' [package "scales"] with 1 fields
##   .. .. .. ..$ range: num [1:2] 1.51 5.42
##   .. .. .. ..and 15 methods, of which 3 are possibly relevant:
##   .. .. .. ..  initialize, reset, train
##   .. .. ..$ limits      : NULL
##   .. .. ..$ trans       :List of 6
##   .. .. .. ..$ name     : chr "identity"
##   .. .. .. ..$ transform:function (x)  
##   .. .. .. ..$ inverse  :function (x)  
##   .. .. .. ..$ breaks   :function (x)  
##   .. .. .. ..$ format   :function (x)  
##   .. .. .. ..$ domain   : num [1:2] -Inf Inf
##   .. .. .. ..- attr(*, "class")= chr "trans"
##   .. .. ..$ na.value    : num NA
##   .. .. ..$ expand      : list()
##   .. .. .. ..- attr(*, "class")= chr "waiver"
##   .. .. ..$ rescaler    :function (x, to = c(0, 1), from = range(x, na.rm = TRUE))  
##   .. .. ..$ oob         :function (x, range = c(0, 1), only.finite = TRUE)  
##   .. .. ..$ name        : NULL
##   .. .. ..$ breaks      : list()
##   .. .. .. ..- attr(*, "class")= chr "waiver"
##   .. .. ..$ minor_breaks: list()
##   .. .. .. ..- attr(*, "class")= chr "waiver"
##   .. .. ..$ labels      : list()
##   .. .. .. ..- attr(*, "class")= chr "waiver"
##   .. .. ..$ legend      : NULL
##   .. .. ..$ guide       : chr "none"
##   .. .. ..- attr(*, "class")= chr [1:3] "position_c" "continuous" "scale"
##   ..$ ranges  :List of 2
##   .. ..$ :List of 12
##   .. .. ..$ x.range       : num [1:2] 9.22 35.07
##   .. .. ..$ x.labels      : chr [1:6] "10" "15" "20" "25" ...
##   .. .. ..$ x.major       : num [1:6] 0.03 0.223 0.417 0.61 0.804 ...
##   .. .. ..$ x.minor       : num [1:11] 0.03 0.127 0.223 0.32 0.417 ...
##   .. .. ..$ x.major_source: num [1:6] 10 15 20 25 30 35
##   .. .. ..$ x.minor_source: num [1:11] 10 12.5 15 17.5 20 22.5 25 27.5 30 32.5 ...
##   .. .. ..$ y.range       : num [1:2] 1.32 5.62
##   .. .. ..$ y.labels      : chr [1:4] "2" "3" "4" "5"
##   .. .. ..$ y.major       : num [1:4] 0.159 0.391 0.624 0.856
##   .. .. ..$ y.minor       : num [1:9] 0.0424 0.1587 0.2749 0.3911 0.5073 ...
##   .. .. ..$ y.major_source: num [1:4] 2 3 4 5
##   .. .. ..$ y.minor_source: num [1:9] 1.5 2 2.5 3 3.5 4 4.5 5 5.5
##   .. ..$ :List of 12
##   .. .. ..$ x.range       : num [1:2] 9.22 35.07
##   .. .. ..$ x.labels      : chr [1:6] "10" "15" "20" "25" ...
##   .. .. ..$ x.major       : num [1:6] 0.03 0.223 0.417 0.61 0.804 ...
##   .. .. ..$ x.minor       : num [1:11] 0.03 0.127 0.223 0.32 0.417 ...
##   .. .. ..$ x.major_source: num [1:6] 10 15 20 25 30 35
##   .. .. ..$ x.minor_source: num [1:11] 10 12.5 15 17.5 20 22.5 25 27.5 30 32.5 ...
##   .. .. ..$ y.range       : num [1:2] 1.32 5.62
##   .. .. ..$ y.labels      : chr [1:4] "2" "3" "4" "5"
##   .. .. ..$ y.major       : num [1:4] 0.159 0.391 0.624 0.856
##   .. .. ..$ y.minor       : num [1:9] 0.0424 0.1587 0.2749 0.3911 0.5073 ...
##   .. .. ..$ y.major_source: num [1:4] 2 3 4 5
##   .. .. ..$ y.minor_source: num [1:9] 1.5 2 2.5 3 3.5 4 4.5 5 5.5
##   ..- attr(*, "class")= chr "panel"
##  $ plot :List of 9
##   ..$ data       :'data.frame':	32 obs. of  11 variables:
##   .. ..$ mpg : num [1:32] 21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
##   .. ..$ cyl : num [1:32] 6 6 4 6 8 6 8 4 4 6 ...
##   .. ..$ disp: num [1:32] 160 160 108 258 360 ...
##   .. ..$ hp  : num [1:32] 110 110 93 110 175 105 245 62 95 123 ...
##   .. ..$ drat: num [1:32] 3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
##   .. ..$ wt  : num [1:32] 2.62 2.88 2.32 3.21 3.44 ...
##   .. ..$ qsec: num [1:32] 16.5 17 18.6 19.4 17 ...
##   .. ..$ vs  : num [1:32] 0 0 1 1 0 1 0 1 1 1 ...
##   .. ..$ am  : num [1:32] 1 1 1 0 0 0 0 0 0 0 ...
##   .. ..$ gear: num [1:32] 4 4 4 3 3 3 3 4 4 4 ...
##   .. ..$ carb: num [1:32] 4 4 1 1 2 1 4 2 2 4 ...
##   ..$ layers     :List of 2
##   .. ..$ :Classes 'proto', 'environment' <environment: 0x7fb46cded4b0> 
##   .. ..$ :Classes 'proto', 'environment' <environment: 0x7fb464f90f88> 
##   ..$ scales     :Reference class 'Scales' [package "ggplot2"] with 1 fields
##   .. ..$ scales:List of 3
##   .. .. ..$ :List of 17
##   .. .. .. ..$ call        : language continuous_scale(aesthetics = c("x", "xmin", "xmax", "xend", "xintercept"),      scale_name = "position_c", palette = identity, expand = expand,  ...
##   .. .. .. ..$ aesthetics  : chr [1:5] "x" "xmin" "xmax" "xend" ...
##   .. .. .. ..$ scale_name  : chr "position_c"
##   .. .. .. ..$ palette     :function (x)  
##   .. .. .. ..$ range       :Reference class 'Continuous' [package "scales"] with 1 fields
##   .. .. .. .. ..$ range: NULL
##   .. .. .. .. ..and 15 methods, of which 3 are possibly relevant:
##   .. .. .. .. ..  initialize, reset, train
##   .. .. .. ..$ limits      : NULL
##   .. .. .. ..$ trans       :List of 6
##   .. .. .. .. ..$ name     : chr "identity"
##   .. .. .. .. ..$ transform:function (x)  
##   .. .. .. .. ..$ inverse  :function (x)  
##   .. .. .. .. ..$ breaks   :function (x)  
##   .. .. .. .. ..$ format   :function (x)  
##   .. .. .. .. ..$ domain   : num [1:2] -Inf Inf
##   .. .. .. .. ..- attr(*, "class")= chr "trans"
##   .. .. .. ..$ na.value    : num NA
##   .. .. .. ..$ expand      : list()
##   .. .. .. .. ..- attr(*, "class")= chr "waiver"
##   .. .. .. ..$ rescaler    :function (x, to = c(0, 1), from = range(x, na.rm = TRUE))  
##   .. .. .. ..$ oob         :function (x, range = c(0, 1), only.finite = TRUE)  
##   .. .. .. ..$ name        : NULL
##   .. .. .. ..$ breaks      : list()
##   .. .. .. .. ..- attr(*, "class")= chr "waiver"
##   .. .. .. ..$ minor_breaks: list()
##   .. .. .. .. ..- attr(*, "class")= chr "waiver"
##   .. .. .. ..$ labels      : list()
##   .. .. .. .. ..- attr(*, "class")= chr "waiver"
##   .. .. .. ..$ legend      : NULL
##   .. .. .. ..$ guide       : chr "none"
##   .. .. .. ..- attr(*, "class")= chr [1:3] "position_c" "continuous" "scale"
##   .. .. ..$ :List of 17
##   .. .. .. ..$ call        : language continuous_scale(aesthetics = c("y", "ymin", "ymax", "yend", "yintercept",      "ymin_final", "ymax_final"), scale_name = "position_c", palette = identity,  ...
##   .. .. .. ..$ aesthetics  : chr [1:7] "y" "ymin" "ymax" "yend" ...
##   .. .. .. ..$ scale_name  : chr "position_c"
##   .. .. .. ..$ palette     :function (x)  
##   .. .. .. ..$ range       :Reference class 'Continuous' [package "scales"] with 1 fields
##   .. .. .. .. ..$ range: NULL
##   .. .. .. .. ..and 15 methods, of which 3 are possibly relevant:
##   .. .. .. .. ..  initialize, reset, train
##   .. .. .. ..$ limits      : NULL
##   .. .. .. ..$ trans       :List of 6
##   .. .. .. .. ..$ name     : chr "identity"
##   .. .. .. .. ..$ transform:function (x)  
##   .. .. .. .. ..$ inverse  :function (x)  
##   .. .. .. .. ..$ breaks   :function (x)  
##   .. .. .. .. ..$ format   :function (x)  
##   .. .. .. .. ..$ domain   : num [1:2] -Inf Inf
##   .. .. .. .. ..- attr(*, "class")= chr "trans"
##   .. .. .. ..$ na.value    : num NA
##   .. .. .. ..$ expand      : list()
##   .. .. .. .. ..- attr(*, "class")= chr "waiver"
##   .. .. .. ..$ rescaler    :function (x, to = c(0, 1), from = range(x, na.rm = TRUE))  
##   .. .. .. ..$ oob         :function (x, range = c(0, 1), only.finite = TRUE)  
##   .. .. .. ..$ name        : NULL
##   .. .. .. ..$ breaks      : list()
##   .. .. .. .. ..- attr(*, "class")= chr "waiver"
##   .. .. .. ..$ minor_breaks: list()
##   .. .. .. .. ..- attr(*, "class")= chr "waiver"
##   .. .. .. ..$ labels      : list()
##   .. .. .. .. ..- attr(*, "class")= chr "waiver"
##   .. .. .. ..$ legend      : NULL
##   .. .. .. ..$ guide       : chr "none"
##   .. .. .. ..- attr(*, "class")= chr [1:3] "position_c" "continuous" "scale"
##   .. .. ..$ :List of 17
##   .. .. .. ..$ call        : language continuous_scale(aesthetics = "colour", scale_name = "gradient", palette = seq_gradient_pal(low,      high, space), na.value = na.value, guide = guide)
##   .. .. .. ..$ aesthetics  : chr "colour"
##   .. .. .. ..$ scale_name  : chr "gradient"
##   .. .. .. ..$ palette     :function (x)  
##   .. .. .. ..$ range       :Reference class 'Continuous' [package "scales"] with 1 fields
##   .. .. .. .. ..$ range: num [1:2] 4 8
##   .. .. .. .. ..and 15 methods, of which 3 are possibly relevant:
##   .. .. .. .. ..  initialize, reset, train
##   .. .. .. ..$ limits      : NULL
##   .. .. .. ..$ trans       :List of 6
##   .. .. .. .. ..$ name     : chr "identity"
##   .. .. .. .. ..$ transform:function (x)  
##   .. .. .. .. ..$ inverse  :function (x)  
##   .. .. .. .. ..$ breaks   :function (x)  
##   .. .. .. .. ..$ format   :function (x)  
##   .. .. .. .. ..$ domain   : num [1:2] -Inf Inf
##   .. .. .. .. ..- attr(*, "class")= chr "trans"
##   .. .. .. ..$ na.value    : chr "grey50"
##   .. .. .. ..$ expand      : list()
##   .. .. .. .. ..- attr(*, "class")= chr "waiver"
##   .. .. .. ..$ rescaler    :function (x, to = c(0, 1), from = range(x, na.rm = TRUE))  
##   .. .. .. ..$ oob         :function (x, range = c(0, 1), only.finite = TRUE)  
##   .. .. .. ..$ name        : NULL
##   .. .. .. ..$ breaks      : list()
##   .. .. .. .. ..- attr(*, "class")= chr "waiver"
##   .. .. .. ..$ minor_breaks: list()
##   .. .. .. .. ..- attr(*, "class")= chr "waiver"
##   .. .. .. ..$ labels      : list()
##   .. .. .. .. ..- attr(*, "class")= chr "waiver"
##   .. .. .. ..$ legend      : NULL
##   .. .. .. ..$ guide       : chr "colourbar"
##   .. .. .. ..- attr(*, "class")= chr [1:3] "gradient" "continuous" "scale"
##   .. ..and 21 methods, of which 9 are possibly relevant:
##   .. ..  add, clone, find, get_scales, has_scale, initialize, input, n,
##   .. ..  non_position_scales
##   ..$ mapping    :List of 2
##   .. ..$ x: symbol mpg
##   .. ..$ y: symbol wt
##   ..$ theme      : list()
##   ..$ coordinates:List of 1
##   .. ..$ limits:List of 2
##   .. .. ..$ x: NULL
##   .. .. ..$ y: NULL
##   .. ..- attr(*, "class")= chr [1:2] "cartesian" "coord"
##   ..$ facet      :List of 7
##   .. ..$ facets  :List of 1
##   .. .. ..$ am: symbol am
##   .. .. ..- attr(*, "env")=<environment: 0x7fb464b97068> 
##   .. .. ..- attr(*, "class")= chr "quoted"
##   .. ..$ free    :List of 2
##   .. .. ..$ x: logi FALSE
##   .. .. ..$ y: logi FALSE
##   .. ..$ as.table: logi TRUE
##   .. ..$ drop    : logi TRUE
##   .. ..$ ncol    : NULL
##   .. ..$ nrow    : num 2
##   .. ..$ shrink  : logi TRUE
##   .. ..- attr(*, "class")= chr [1:2] "wrap" "facet"
##   ..$ plot_env   :<environment: R_GlobalEnv> 
##   ..$ labels     :List of 3
##   .. ..$ x     : chr "mpg"
##   .. ..$ y     : chr "wt"
##   .. ..$ colour: chr "cyl"
##   ..- attr(*, "class")= chr [1:2] "gg" "ggplot"
{% endhighlight %}

As I started this project, I became frustrated trying to understand/navigate through the nested
list-like structure of ggplot objects. As you can imagine, it isn't an optimal approach to print
out the structure everytime you want to checkout a particular element. Out of this frustration came
an idea to build [this tool](https://cpsievert.shinyapps.io/ggtree/) to help interact with and
visualize this structure. Thankfully, my wonderful GSoC mentor [Toby Dylan
Hocking](http://sugiyama-www.cs.titech.ac.jp/~toby/) agreed that this project could bring value to
the ggplot2 community and encouraged me to pursue it.

By default, this tool presents a [radial Reingold–Tilford
Tree](http://bl.ocks.org/mbostock/4339184) of this nested list structure, but also has options to
use the [collapsable](http://bl.ocks.org/mbostock/4339083) or
[cartesian](http://bl.ocks.org/mbostock/4339184) versions. It also leverages the
[shinyAce](https://github.com/trestletech/shinyAce) package which allows users to send arbitrary
ggplot2 code to a [shiny](http://shiny.rstudio.com/) server thats evaluate the results and
re-renders the visuals. I'm quite happy with the results as I think this tool is a great way to
quickly grasp the internal building blocks of ggplot(s). Please share your thoughts below!
