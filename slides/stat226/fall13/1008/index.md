Intro to Sampling Distributions
========================================================
incremental: true
date: 10/08/13

Announcements
========================================================

* Good job on Exam 1!
* Exam solutions are now on Blackboard. Please check where and why you lost points!
* Project step 2 is due Sunday, October 13th.

Learning Objectives for Chapter 14
========================================================

* Understand the "bigger picture".
* Understand how to specify a sampling distribution (that is, how to find it's mean, variance and __shape__).
* Understand how sampling distributions are created. [Think about exam scores.](http://glimmer.rstudio.com/cpsievert/CLT/) The lecture notes uses the K-Packs example to demonstrate this idea.
* [This video](http://www.youtube.com/embed/jvoxEYmQHNM) nicely demonstrates the behavior of the sampling distribution when we increase sample size.

Identifying shape
========================================================

* If we know $X \sim N(\mu, \sigma^2)$, then $\bar{X} \sim N(\mu, \sigma^2/n)$.
* If the population distribution ($X$) is non-normal, then the __shape of the sampling distribution__ of the sample mean depends on the sample size ($n$).
  * If $n$ is large (at least 30), then the Central Limit Theorem says that the shape is approximately normal.
  * If $n$ is small (lower than 30), the shape is non-normal.

Why does shape matter?
========================================================

* In Chapter 12, you found probabilities such as $P(X < 5)$.
* This process depends on the __shape of the population distribution__ being normal!
* If the shape of the population distribution is non-normal, you may not be able to find $P(X < 5)$!
* However, __if you have a large enough sample__, you can find $P(\bar{X} < 5)$
