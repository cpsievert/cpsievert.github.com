Reproducible web documents with R, knitr & Markdown
========================================================
author: Carson Sievert
transition: rotate
incremental: true

Follow along at - http://cpsievert.github.io/slides/markdown

Why Markdown?
========================================================

<div align="center">
<img class="decoded" src="internet.gif" width=800 height=600>
</div>

All the cool kids use it...
========================================================

* GitHub, StackOverflow, Reddit and many other websites use Markdown.
* Many popular blogging frameworks support Markdown.
* Thanks to the R package __knitr__, it's easy to create __reproducible__ and __dynamic__ web documents!
  * Later we will integrate `R` code with Markdown, but you are not limited to `R` code!
* Thanks to __slidify__ and RStudio presentations, one can also easily create HTML5 presentations (like this one)!
* Thanks to tools like __pandoc__, your Markdown files can easily be converted to many different formats!

Yes, even word documents...
========================================================

<div align="center">
<img src="word.jpg" width=800 height=600>
</div>

Some Examples
========================================================

* [R learning resources at UCLA by Joshua Wiley et al](http://www.ats.ucla.edu/stat/r/)
* [Advanced R programming by Hadley](http://adv-r.had.co.nz/memory.html)
* [My R package vignette for pitchRx](http://cpsievert.github.io/pitchRx/demo/)
* [knitrBootstrap](https://github.com/jimhester/knitrBootstrap?source=c) makes it incredibly easy to make Bootstrap flavored [documents](http://cpsievert.github.io/projects/615/HW5/HW5.html).
* Inject JavaScript for [interactive visualizations](http://timelyportfolio.github.io/rCharts_nyt_home_price/)

What is Markdown?
========================================================

* Markdown is a lightweight markup language for creating HTML (or XHTML) documents.
* Markup languages are designed produce documents from human readable text (and annotations).
* Some of you may be familiar with _LaTeX_. This is another (less human friendly) markup language for creating pdf documents.
* Why I love Markdown:
  * Easy to learn and use.
  * Focus on __content__, rather than __coding__ and debugging __errors__.
  * Once you have the basics down, you can get fancy and add HTML, JavaScript & CSS. 


Markdown Basics
========================================================
incremental:false
title:false
right: 55%

Markdown syntax

    Header 1
    ================
    Header 2
    ----------------
    ### Header 3
    
    This is regular text.
    
    > This is a blockquote.
    > 
    > This is the second paragraph in the blockquote.
    >
    > ## This is an H2 in a blockquote

***
Resulting HTML
```
<h1>Header 1</h1>
<h2>Header 2</h2>
<h3>Header 3</h3>

<p>This is regular text.</p>

<blockquote>
<p>This is a blockquote.</p>

<p>This is the second paragraph in the blockquote.</p>

<h2>This is an H2 in a blockquote</h2>
</blockquote>
```
  
Header 1
================
incremental:false

Header 2
----------------
### Header 3

This is regular text.
    
> This is a blockquote.
> 
> This is the second paragraph in the blockquote.
>
> ## This is an H2 in a blockquote



Markdown Basics 2
========================================================
incremental:false
title:false
right: 55%

Markdown syntax

    Here we have an unordered list.
    
    * Item 1
    * Item 2
      * Item 2a
      * Item 2b
      
    Here we have an ordered list
    
    1. Item 1
    2. Item 2
      * Item 2a
      * Item 2b

***
Resulting HTML
```
<p>Here we have an unordered list.</p>
<ul>
<li>Item 1</li>
<li>Item 2
<ul>
<li>Item 2a</li>
<li>Item 2b</li>
</ul></li>
</ul>
<p>Here we have an ordered list</p>
<ol>
<li>Item 1</li>
<li>Item 2
<ul>
<li>Item 2a</li>
<li>Item 2b</li>
</ul></li>
</ol>
```

Result 2
======================
title:false
incremental:false

Here we have an unordered list.
    
* Item 1
* Item 2
  * Item 2a
  * Item 2b
      
Here we have an ordered list
    
1. Item 1
2. Item 2
  * Item 2a
  * Item 2b

Markdown Basics 3
========================================================
incremental:false
title:false
right: 55%

Markdown syntax

    What if we want to *italicize* or **bold**?
    
    * In a list, I may want to _italicize_ or __bold__ this way.
   
    I can also include inline `code` or 
    
    ```
    blocks of code
    ```
    Or even a [link](http://google.com)
    

***
Resulting HTML
```
<p>What if we want to <em>italicize</em> or <strong>bold</strong>?</p>
<ul>
<li>In a list, I may want to <em>italicize</em> or <strong>bold</strong> this way.</li>
</ul>
<p>I can also include inline <code>code</code> or </p>
<pre><code>blocks of code</code></pre>
<p>Or even a <a href="http://google.com">link</a> </p>
```

Result 3
======================
title:false
incremental:false

What if we want to *italicize* or **bold**?

* In a list, I may want to _italicize_ or __bold__ this way.

I can also include inline `code` or 

```
blocks of code
```

Or even a [link](http://google.com)


Markdown Basics 4
========================================================
incremental:false
title:false
right: 50%

Markdown syntax
    
    When in doubt, you can always put HTML into markdown:
    
    <img src="http://
    i.imgur.com/qM4s4rC.jpg">
    
    I can also do fancy latex equations $\alpha = \beta$ with help from [MathJax](http://www.mathjax.org/)
    
***
Resulting HTML
```
<p>When in doubt, you can always put HTML into markdown:</p>

<p><img src="http://
i.imgur.com/qM4s4rC.jpg"></p>

<p>I can also do fancy latex equations \( \alpha = \beta \) with help from <a href="http://www.
mathjax.org/">MathJax</a></p>

```

Result 4
======================
title:false
incremental:false

When in doubt, you can always put HTML into markdown:
    
<img src="http://i.imgur.com/qM4s4rC.jpg" height=400>
    
I can also do fancy latex equations $\alpha = \beta$ with help from [MathJax](http://www.mathjax.org/)


RStudio+knitr+markdown = awesome
========================================================

<div align="center">
<img src="new_file.png" width=1000 height=800>
</div>

RStudio+knitr+markdown = awesome
========================================================
title:false

<div align="center">
<img src="index.png" width=1000 height=800>
</div>

RStudio+knitr+markdown = awesome
========================================================
title:false

<div align="center">
<img src="preview.png" width=1000 height=800>
</div>




For non-RStudio users...
========================================================
incremental:false
right:53%

    Title
    ================
    This is an R Markdown document.
    
    ```{{r}}
    summary(cars)
    ```
    
    You can also embed plots, for example:
    
    ```{{r fig.width=7, fig.height=6}}
    plot(cars)
    ```
***

Try saving the content to the left as "index.Rmd". Then run the code below to replicate "knit HTML".


```r
library(knitr)
setwd(<working directory>)
knit2html("index.Rmd")
browseURL("index.html")
```


Custom styling...
========================================================
incremental:false

* It's easy to customize styling using the `markdownToHTML` function from the `markdown` package.


```r
library(knitr)
library(markdown)
setwd(<working directory>)
knit("index.Rmd") #generates 'index.md' file
markdownToHTML("index.md", "index.html", stylesheet='custom.css')
```


The power of code chunks
========================================================
incremental:false
right:40%

    Title
    ====================

    This is an R Markdown document.

    ```{{r results='asis'}}
    library(knitr)
    kable(cars, 'html')
    ```
    
    You can also embed plots, for example:

    ```{{r fig.width=7, fig.height=6, echo=FALSE}}
    plot(cars)
    ```


Title
========================================================
incremental:false
title:false
left:57%


This is an R Markdown document.


```r
library(knitr)
kable(cars, 'html')
```

<table>
 <thead>
  <tr>
   <th> speed </th>
   <th> dist </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td>  4 </td>
   <td>   2 </td>
  </tr>
  <tr>
   <td>  4 </td>
   <td>  10 </td>
  </tr>
  <tr>
   <td>  7 </td>
   <td>   4 </td>
  </tr>
  <tr>
   <td>  7 </td>
   <td>  22 </td>
  </tr>
  <tr>
   <td>  8 </td>
   <td>  16 </td>
  </tr>
  <tr>
   <td>  9 </td>
   <td>  10 </td>
  </tr>
  <tr>
   <td> 10 </td>
   <td>  18 </td>
  </tr>
  <tr>
   <td> 10 </td>
   <td>  26 </td>
  </tr>
  <tr>
   <td> 10 </td>
   <td>  34 </td>
  </tr>
  <tr>
   <td> 11 </td>
   <td>  17 </td>
  </tr>
  <tr>
   <td> 11 </td>
   <td>  28 </td>
  </tr>
  <tr>
   <td> 12 </td>
   <td>  14 </td>
  </tr>
  <tr>
   <td> 12 </td>
   <td>  20 </td>
  </tr>
  <tr>
   <td> 12 </td>
   <td>  24 </td>
  </tr>
  <tr>
   <td> 12 </td>
   <td>  28 </td>
  </tr>
  <tr>
   <td> 13 </td>
   <td>  26 </td>
  </tr>
  <tr>
   <td> 13 </td>
   <td>  34 </td>
  </tr>
  <tr>
   <td> 13 </td>
   <td>  34 </td>
  </tr>
  <tr>
   <td> 13 </td>
   <td>  46 </td>
  </tr>
  <tr>
   <td> 14 </td>
   <td>  26 </td>
  </tr>
  <tr>
   <td> 14 </td>
   <td>  36 </td>
  </tr>
  <tr>
   <td> 14 </td>
   <td>  60 </td>
  </tr>
  <tr>
   <td> 14 </td>
   <td>  80 </td>
  </tr>
  <tr>
   <td> 15 </td>
   <td>  20 </td>
  </tr>
  <tr>
   <td> 15 </td>
   <td>  26 </td>
  </tr>
  <tr>
   <td> 15 </td>
   <td>  54 </td>
  </tr>
  <tr>
   <td> 16 </td>
   <td>  32 </td>
  </tr>
  <tr>
   <td> 16 </td>
   <td>  40 </td>
  </tr>
  <tr>
   <td> 17 </td>
   <td>  32 </td>
  </tr>
  <tr>
   <td> 17 </td>
   <td>  40 </td>
  </tr>
  <tr>
   <td> 17 </td>
   <td>  50 </td>
  </tr>
  <tr>
   <td> 18 </td>
   <td>  42 </td>
  </tr>
  <tr>
   <td> 18 </td>
   <td>  56 </td>
  </tr>
  <tr>
   <td> 18 </td>
   <td>  76 </td>
  </tr>
  <tr>
   <td> 18 </td>
   <td>  84 </td>
  </tr>
  <tr>
   <td> 19 </td>
   <td>  36 </td>
  </tr>
  <tr>
   <td> 19 </td>
   <td>  46 </td>
  </tr>
  <tr>
   <td> 19 </td>
   <td>  68 </td>
  </tr>
  <tr>
   <td> 20 </td>
   <td>  32 </td>
  </tr>
  <tr>
   <td> 20 </td>
   <td>  48 </td>
  </tr>
  <tr>
   <td> 20 </td>
   <td>  52 </td>
  </tr>
  <tr>
   <td> 20 </td>
   <td>  56 </td>
  </tr>
  <tr>
   <td> 20 </td>
   <td>  64 </td>
  </tr>
  <tr>
   <td> 22 </td>
   <td>  66 </td>
  </tr>
  <tr>
   <td> 23 </td>
   <td>  54 </td>
  </tr>
  <tr>
   <td> 24 </td>
   <td>  70 </td>
  </tr>
  <tr>
   <td> 24 </td>
   <td>  92 </td>
  </tr>
  <tr>
   <td> 24 </td>
   <td>  93 </td>
  </tr>
  <tr>
   <td> 24 </td>
   <td> 120 </td>
  </tr>
  <tr>
   <td> 25 </td>
   <td>  85 </td>
  </tr>
</tbody>
</table>


***
You can also embed plots, for example:

![plot of chunk unnamed-chunk-4](index-figure/unnamed-chunk-4.png) 



Interactive Plots
========================================================
incremental:false

<link rel='stylesheet' href=http://nvd3.org/src/nv.d3.css>
<link rel='stylesheet' href=http://rawgithub.com/ramnathv/rCharts/master/inst/libraries/nvd3/css/rNVD3.css>
<script type='text/javascript' src=http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js></script>
<script type='text/javascript' src=http://d3js.org/d3.v3.min.js></script>
<script type='text/javascript' src=http://timelyportfolio.github.io/rCharts_nvd3_tests/libraries/widgets/nvd3/js/nv.d3.min-new.js></script>
<script type='text/javascript' src=http://nvd3.org/lib/fisheye.js></script>



```r
library(rCharts)
dat <- subset(as.data.frame(HairEyeColor), Sex == "Male")
n1 <- nPlot(Freq ~ Hair, group = "Eye", data = dat, type = "multiBarChart")
n1$print("nvd3mbar")
```


<div id = 'nvd3mbar' class = 'rChart nvd3'></div>
<script type='text/javascript'>
 $(document).ready(function(){
      drawnvd3mbar()
    });
    function drawnvd3mbar(){  
      var opts = {
 "dom": "nvd3mbar",
"width":    800,
"height":    400,
"x": "Hair",
"y": "Freq",
"group": "Eye",
"type": "multiBarChart",
"id": "nvd3mbar" 
},
        data = [
 {
 "Hair": "Black",
"Eye": "Brown",
"Sex": "Male",
"Freq":             32 
},
{
 "Hair": "Brown",
"Eye": "Brown",
"Sex": "Male",
"Freq":             53 
},
{
 "Hair": "Red",
"Eye": "Brown",
"Sex": "Male",
"Freq":             10 
},
{
 "Hair": "Blond",
"Eye": "Brown",
"Sex": "Male",
"Freq":              3 
},
{
 "Hair": "Black",
"Eye": "Blue",
"Sex": "Male",
"Freq":             11 
},
{
 "Hair": "Brown",
"Eye": "Blue",
"Sex": "Male",
"Freq":             50 
},
{
 "Hair": "Red",
"Eye": "Blue",
"Sex": "Male",
"Freq":             10 
},
{
 "Hair": "Blond",
"Eye": "Blue",
"Sex": "Male",
"Freq":             30 
},
{
 "Hair": "Black",
"Eye": "Hazel",
"Sex": "Male",
"Freq":             10 
},
{
 "Hair": "Brown",
"Eye": "Hazel",
"Sex": "Male",
"Freq":             25 
},
{
 "Hair": "Red",
"Eye": "Hazel",
"Sex": "Male",
"Freq":              7 
},
{
 "Hair": "Blond",
"Eye": "Hazel",
"Sex": "Male",
"Freq":              5 
},
{
 "Hair": "Black",
"Eye": "Green",
"Sex": "Male",
"Freq":              3 
},
{
 "Hair": "Brown",
"Eye": "Green",
"Sex": "Male",
"Freq":             15 
},
{
 "Hair": "Red",
"Eye": "Green",
"Sex": "Male",
"Freq":              7 
},
{
 "Hair": "Blond",
"Eye": "Green",
"Sex": "Male",
"Freq":              8 
} 
]
  
      if(!(opts.type==="pieChart" || opts.type==="sparklinePlus")) {
        var data = d3.nest()
          .key(function(d){
            //return opts.group === undefined ? 'main' : d[opts.group]
            //instead of main would think a better default is opts.x
            return opts.group === undefined ? opts.y : d[opts.group];
          })
          .entries(data);
      }
      
      if (opts.disabled != undefined){
        data.map(function(d, i){
          d.disabled = opts.disabled[i]
        })
      }
      
      nv.addGraph(function() {
        var chart = nv.models[opts.type]()
          .x(function(d) { return d[opts.x] })
          .y(function(d) { return d[opts.y] })
          .width(opts.width)
          .height(opts.height)
         
        
          
        

        
        
        
      
       d3.select("#" + opts.id)
        .append('svg')
        .datum(data)
        .transition().duration(500)
        .call(chart);

       nv.utils.windowResize(chart.update);
       return chart;
      });
    };
</script>


Interactive Tables
========================================================

Leveraging JavaScript, it's "easy" to make interactive stuff. Thanks to Yihui for [source](https://github.com/yihui/knitr/blob/master/vignettes/datatables.Rmd).

<script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.9.0.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>
<link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css">
<style type="text/css">
p{clear:both;}
</style>

<table id="cars_table">
 <thead>
  <tr>
   <th>   </th>
   <th> mpg </th>
   <th> cyl </th>
   <th> disp </th>
   <th> hp </th>
   <th> drat </th>
   <th> wt </th>
   <th> qsec </th>
   <th> vs </th>
   <th> am </th>
   <th> gear </th>
   <th> carb </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td> Mazda RX4 </td>
   <td> 21.0 </td>
   <td> 6 </td>
   <td> 160.0 </td>
   <td> 110 </td>
   <td> 3.90 </td>
   <td> 2.620 </td>
   <td> 16.46 </td>
   <td> 0 </td>
   <td> 1 </td>
   <td> 4 </td>
   <td> 4 </td>
  </tr>
  <tr>
   <td> Mazda RX4 Wag </td>
   <td> 21.0 </td>
   <td> 6 </td>
   <td> 160.0 </td>
   <td> 110 </td>
   <td> 3.90 </td>
   <td> 2.875 </td>
   <td> 17.02 </td>
   <td> 0 </td>
   <td> 1 </td>
   <td> 4 </td>
   <td> 4 </td>
  </tr>
  <tr>
   <td> Datsun 710 </td>
   <td> 22.8 </td>
   <td> 4 </td>
   <td> 108.0 </td>
   <td>  93 </td>
   <td> 3.85 </td>
   <td> 2.320 </td>
   <td> 18.61 </td>
   <td> 1 </td>
   <td> 1 </td>
   <td> 4 </td>
   <td> 1 </td>
  </tr>
  <tr>
   <td> Hornet 4 Drive </td>
   <td> 21.4 </td>
   <td> 6 </td>
   <td> 258.0 </td>
   <td> 110 </td>
   <td> 3.08 </td>
   <td> 3.215 </td>
   <td> 19.44 </td>
   <td> 1 </td>
   <td> 0 </td>
   <td> 3 </td>
   <td> 1 </td>
  </tr>
  <tr>
   <td> Hornet Sportabout </td>
   <td> 18.7 </td>
   <td> 8 </td>
   <td> 360.0 </td>
   <td> 175 </td>
   <td> 3.15 </td>
   <td> 3.440 </td>
   <td> 17.02 </td>
   <td> 0 </td>
   <td> 0 </td>
   <td> 3 </td>
   <td> 2 </td>
  </tr>
  <tr>
   <td> Valiant </td>
   <td> 18.1 </td>
   <td> 6 </td>
   <td> 225.0 </td>
   <td> 105 </td>
   <td> 2.76 </td>
   <td> 3.460 </td>
   <td> 20.22 </td>
   <td> 1 </td>
   <td> 0 </td>
   <td> 3 </td>
   <td> 1 </td>
  </tr>
  <tr>
   <td> Duster 360 </td>
   <td> 14.3 </td>
   <td> 8 </td>
   <td> 360.0 </td>
   <td> 245 </td>
   <td> 3.21 </td>
   <td> 3.570 </td>
   <td> 15.84 </td>
   <td> 0 </td>
   <td> 0 </td>
   <td> 3 </td>
   <td> 4 </td>
  </tr>
  <tr>
   <td> Merc 240D </td>
   <td> 24.4 </td>
   <td> 4 </td>
   <td> 146.7 </td>
   <td>  62 </td>
   <td> 3.69 </td>
   <td> 3.190 </td>
   <td> 20.00 </td>
   <td> 1 </td>
   <td> 0 </td>
   <td> 4 </td>
   <td> 2 </td>
  </tr>
  <tr>
   <td> Merc 230 </td>
   <td> 22.8 </td>
   <td> 4 </td>
   <td> 140.8 </td>
   <td>  95 </td>
   <td> 3.92 </td>
   <td> 3.150 </td>
   <td> 22.90 </td>
   <td> 1 </td>
   <td> 0 </td>
   <td> 4 </td>
   <td> 2 </td>
  </tr>
  <tr>
   <td> Merc 280 </td>
   <td> 19.2 </td>
   <td> 6 </td>
   <td> 167.6 </td>
   <td> 123 </td>
   <td> 3.92 </td>
   <td> 3.440 </td>
   <td> 18.30 </td>
   <td> 1 </td>
   <td> 0 </td>
   <td> 4 </td>
   <td> 4 </td>
  </tr>
  <tr>
   <td> Merc 280C </td>
   <td> 17.8 </td>
   <td> 6 </td>
   <td> 167.6 </td>
   <td> 123 </td>
   <td> 3.92 </td>
   <td> 3.440 </td>
   <td> 18.90 </td>
   <td> 1 </td>
   <td> 0 </td>
   <td> 4 </td>
   <td> 4 </td>
  </tr>
  <tr>
   <td> Merc 450SE </td>
   <td> 16.4 </td>
   <td> 8 </td>
   <td> 275.8 </td>
   <td> 180 </td>
   <td> 3.07 </td>
   <td> 4.070 </td>
   <td> 17.40 </td>
   <td> 0 </td>
   <td> 0 </td>
   <td> 3 </td>
   <td> 3 </td>
  </tr>
  <tr>
   <td> Merc 450SL </td>
   <td> 17.3 </td>
   <td> 8 </td>
   <td> 275.8 </td>
   <td> 180 </td>
   <td> 3.07 </td>
   <td> 3.730 </td>
   <td> 17.60 </td>
   <td> 0 </td>
   <td> 0 </td>
   <td> 3 </td>
   <td> 3 </td>
  </tr>
  <tr>
   <td> Merc 450SLC </td>
   <td> 15.2 </td>
   <td> 8 </td>
   <td> 275.8 </td>
   <td> 180 </td>
   <td> 3.07 </td>
   <td> 3.780 </td>
   <td> 18.00 </td>
   <td> 0 </td>
   <td> 0 </td>
   <td> 3 </td>
   <td> 3 </td>
  </tr>
  <tr>
   <td> Cadillac Fleetwood </td>
   <td> 10.4 </td>
   <td> 8 </td>
   <td> 472.0 </td>
   <td> 205 </td>
   <td> 2.93 </td>
   <td> 5.250 </td>
   <td> 17.98 </td>
   <td> 0 </td>
   <td> 0 </td>
   <td> 3 </td>
   <td> 4 </td>
  </tr>
  <tr>
   <td> Lincoln Continental </td>
   <td> 10.4 </td>
   <td> 8 </td>
   <td> 460.0 </td>
   <td> 215 </td>
   <td> 3.00 </td>
   <td> 5.424 </td>
   <td> 17.82 </td>
   <td> 0 </td>
   <td> 0 </td>
   <td> 3 </td>
   <td> 4 </td>
  </tr>
  <tr>
   <td> Chrysler Imperial </td>
   <td> 14.7 </td>
   <td> 8 </td>
   <td> 440.0 </td>
   <td> 230 </td>
   <td> 3.23 </td>
   <td> 5.345 </td>
   <td> 17.42 </td>
   <td> 0 </td>
   <td> 0 </td>
   <td> 3 </td>
   <td> 4 </td>
  </tr>
  <tr>
   <td> Fiat 128 </td>
   <td> 32.4 </td>
   <td> 4 </td>
   <td>  78.7 </td>
   <td>  66 </td>
   <td> 4.08 </td>
   <td> 2.200 </td>
   <td> 19.47 </td>
   <td> 1 </td>
   <td> 1 </td>
   <td> 4 </td>
   <td> 1 </td>
  </tr>
  <tr>
   <td> Honda Civic </td>
   <td> 30.4 </td>
   <td> 4 </td>
   <td>  75.7 </td>
   <td>  52 </td>
   <td> 4.93 </td>
   <td> 1.615 </td>
   <td> 18.52 </td>
   <td> 1 </td>
   <td> 1 </td>
   <td> 4 </td>
   <td> 2 </td>
  </tr>
  <tr>
   <td> Toyota Corolla </td>
   <td> 33.9 </td>
   <td> 4 </td>
   <td>  71.1 </td>
   <td>  65 </td>
   <td> 4.22 </td>
   <td> 1.835 </td>
   <td> 19.90 </td>
   <td> 1 </td>
   <td> 1 </td>
   <td> 4 </td>
   <td> 1 </td>
  </tr>
  <tr>
   <td> Toyota Corona </td>
   <td> 21.5 </td>
   <td> 4 </td>
   <td> 120.1 </td>
   <td>  97 </td>
   <td> 3.70 </td>
   <td> 2.465 </td>
   <td> 20.01 </td>
   <td> 1 </td>
   <td> 0 </td>
   <td> 3 </td>
   <td> 1 </td>
  </tr>
  <tr>
   <td> Dodge Challenger </td>
   <td> 15.5 </td>
   <td> 8 </td>
   <td> 318.0 </td>
   <td> 150 </td>
   <td> 2.76 </td>
   <td> 3.520 </td>
   <td> 16.87 </td>
   <td> 0 </td>
   <td> 0 </td>
   <td> 3 </td>
   <td> 2 </td>
  </tr>
  <tr>
   <td> AMC Javelin </td>
   <td> 15.2 </td>
   <td> 8 </td>
   <td> 304.0 </td>
   <td> 150 </td>
   <td> 3.15 </td>
   <td> 3.435 </td>
   <td> 17.30 </td>
   <td> 0 </td>
   <td> 0 </td>
   <td> 3 </td>
   <td> 2 </td>
  </tr>
  <tr>
   <td> Camaro Z28 </td>
   <td> 13.3 </td>
   <td> 8 </td>
   <td> 350.0 </td>
   <td> 245 </td>
   <td> 3.73 </td>
   <td> 3.840 </td>
   <td> 15.41 </td>
   <td> 0 </td>
   <td> 0 </td>
   <td> 3 </td>
   <td> 4 </td>
  </tr>
  <tr>
   <td> Pontiac Firebird </td>
   <td> 19.2 </td>
   <td> 8 </td>
   <td> 400.0 </td>
   <td> 175 </td>
   <td> 3.08 </td>
   <td> 3.845 </td>
   <td> 17.05 </td>
   <td> 0 </td>
   <td> 0 </td>
   <td> 3 </td>
   <td> 2 </td>
  </tr>
  <tr>
   <td> Fiat X1-9 </td>
   <td> 27.3 </td>
   <td> 4 </td>
   <td>  79.0 </td>
   <td>  66 </td>
   <td> 4.08 </td>
   <td> 1.935 </td>
   <td> 18.90 </td>
   <td> 1 </td>
   <td> 1 </td>
   <td> 4 </td>
   <td> 1 </td>
  </tr>
  <tr>
   <td> Porsche 914-2 </td>
   <td> 26.0 </td>
   <td> 4 </td>
   <td> 120.3 </td>
   <td>  91 </td>
   <td> 4.43 </td>
   <td> 2.140 </td>
   <td> 16.70 </td>
   <td> 0 </td>
   <td> 1 </td>
   <td> 5 </td>
   <td> 2 </td>
  </tr>
  <tr>
   <td> Lotus Europa </td>
   <td> 30.4 </td>
   <td> 4 </td>
   <td>  95.1 </td>
   <td> 113 </td>
   <td> 3.77 </td>
   <td> 1.513 </td>
   <td> 16.90 </td>
   <td> 1 </td>
   <td> 1 </td>
   <td> 5 </td>
   <td> 2 </td>
  </tr>
  <tr>
   <td> Ford Pantera L </td>
   <td> 15.8 </td>
   <td> 8 </td>
   <td> 351.0 </td>
   <td> 264 </td>
   <td> 4.22 </td>
   <td> 3.170 </td>
   <td> 14.50 </td>
   <td> 0 </td>
   <td> 1 </td>
   <td> 5 </td>
   <td> 4 </td>
  </tr>
  <tr>
   <td> Ferrari Dino </td>
   <td> 19.7 </td>
   <td> 6 </td>
   <td> 145.0 </td>
   <td> 175 </td>
   <td> 3.62 </td>
   <td> 2.770 </td>
   <td> 15.50 </td>
   <td> 0 </td>
   <td> 1 </td>
   <td> 5 </td>
   <td> 6 </td>
  </tr>
  <tr>
   <td> Maserati Bora </td>
   <td> 15.0 </td>
   <td> 8 </td>
   <td> 301.0 </td>
   <td> 335 </td>
   <td> 3.54 </td>
   <td> 3.570 </td>
   <td> 14.60 </td>
   <td> 0 </td>
   <td> 1 </td>
   <td> 5 </td>
   <td> 8 </td>
  </tr>
  <tr>
   <td> Volvo 142E </td>
   <td> 21.4 </td>
   <td> 4 </td>
   <td> 121.0 </td>
   <td> 109 </td>
   <td> 4.11 </td>
   <td> 2.780 </td>
   <td> 18.60 </td>
   <td> 1 </td>
   <td> 1 </td>
   <td> 4 </td>
   <td> 2 </td>
  </tr>
</tbody>
</table>


<script type="text/javascript" charset="utf-8">
$(document).ready(function() {
  $('#cars_table').dataTable();
} );
</script>

References & resources
========================================================
incremental:false

* [Markdown Quick Reference](http://web.mit.edu/r/current/RStudio/resources/markdown_help.html)
* [Daring Fireball Markdown Basics](http://daringfireball.net/projects/markdown/basics)
* [Markdown Cheat Sheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#wiki-code)
* [Using R Markdown with RStudio](http://www.rstudio.com/ide/docs/authoring/using_markdown)
* [knitr website](http://yihui.name/knitr/)
* [rCharts, Markdown and knitr](http://rpubs.com/rchavelas90/9331)

Thanks for coming!
========================================================

<div align="center">
<img class="decoded" src="picard.gif" width=800 height=600>
</div>
