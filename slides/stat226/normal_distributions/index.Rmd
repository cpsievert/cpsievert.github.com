---
title       : Modeling Populations with Normal Distributions
subtitle    : 
author      : Carson Sievert
job         : 
framework   : deck.js        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : mathjax            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
---
## Modeling Populations with Normal Distributions

<div align="center"><img src="http://i.imgur.com/ljRDF8W.jpg"></div>

---
## Random Variables

#### * Are used to model variability within a population (for now)

#### * Stat 226 focuses on "normal" random variables $X \sim N(\mu, \sigma^{2}$)

#### * $\mu$ represents the population mean

#### * $\sigma^{2}$ represents the population variance

#### * $\sigma$ represents the population standard deviation

#### * For now, we assume $\mu$ that $\sigma$ are known. __NOTE:__ this assumption is unrealistic and will be relaxed after Chapter 12.

---
## Probability Distribution Functions

#### * PDF's assign probabilities to values of a random variable ($X$)

#### * Since "normal" random variables are continuous, we are interested in the probability that $X$ is __within a range of values__.

> - __Example:__ Suppose I work on wall street. I might be interested in the probability that Apple's stock price rises tomorrow. If I define the r.v. $X$ to be the change in Apple's stock price from today to tomorrow, __what values of $X$ do I want to assign a probability to?__

> - $X \geq 0$

> - Thus, I want to know $P(X \geq 0)$.

---
## How can I think of the following expression - $P(X \geq 0)$ - in English?

> - In our example: The probability that Apple's stock price rises tomorrow.

> - More generally (for any random variable):

> - "The probability that $X$ is greater than (or equal to) 0."

> - "The area under the curve (or PDF) associated with X values greater than (or equal to) 0"

> - "The proportion of the curve associated with X values greater than (or equal to) 0"

---
## Notes on modeling

#### Suppose I have data on 2012 yearly profits for internet marketing firms (values reported in millions of dollars).

<div align="center"><img src="http://www.statsdirect.com/help/image/stat0108_wmf.gif"></img></div>

> - $P(X \geq 0)$ can now be thought of as "the proportion of internet marketing firms with a positive profit".

> - How would you provide an approximation of $P(X \geq 0)$?




