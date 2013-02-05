---
title       : Normal Calculations in a nutshell
subtitle    : 
author      : Carson Sievert
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : mathjax            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
---

## Normal Distributions are Everywhere!

<div align="center"><img src="http://cdn.memegenerator.net/instances/250x250/27108995.jpg" height=80%></div>

---
## Empirical Rule

<div align="center"><img src="http://s3.amazonaws.com/answer-board-image/20091181628176339329449713087508798.gif"></div>

> - Allows you to approximate probabilities such as $P(X < \mu + \sigma)$

> - This is nice, but what if I'm interested in something like: $P(X < \mu + \sigma/2)$?

------------------------------------------------
## Foreshadowing

#### * Ultimately, I can classify normal calculation problems into two cases:

> - __(1) What is the _probability_ that $X$ is within a range of values?__

> - Suppose I give you values $x_1, x_2$; find $P(x_1 < X < x_2) = \underline{\hspace{1cm}}$
  
> - __(2) What _value(s)_ return the desired percentile(s)?__

> - For example, $P(X < \underline{\hspace{1cm}}) = 0.9$
  
------------------------------------------------
## Standard Normal Distribution
  
#### * I can solve any problem (of this kind) associated any random variable $X \sim N(\mu, \sigma^2)$ using the standard normal distribution.
  
> - We typically denote the standard normal (random variable) by $Z \sim N(0, 1)$
  
> - It turns out that $Z = \frac{X-\mu}{\sigma}$.

> - Problems expressed in terms of any random variable can translate to $Z$.

---
## Table A

<div align="center"><img src="http://math.rwinters.com/101/supplements/TableApage2.jpg"></div>

---
## Putting it all together

#### Suppose $X \sim N(3, 16)$. Find $P(X < 4)$.

> - First I should "standardize" $X$. To standardize: $z = \frac{x-\mu}{\sigma} = \frac{4-3}{4} = 0.25$.

> - Thus, $P(X < 4) = P(Z < 0.25)$

> - From table A,  $P(Z < 0.25) = .5987$

---
## Some helpful hints/tricks

#### Table A returns probabilities of the form: $P(Z < z)$.

> - What if I want $P(Z > z)$ or $P(z_1 < Z < z_2)$?

> - For any random variable, $P(X > x) = 1 - P(X < x)$.

> - Also, $P(x_1 < X < x_2) = P(X < x_2) - P(X < x_1)$.






  

