### Homework 1 (due 10 Sep in class)

This homework covers two topics: Bayesian hypothesis testing (question 1) and regularized regression (questions 2-4). For the regularized regression problems, we assume the data are of the form $y=Xb+e$ where $e \sim N(0,s^2)$. __Also, define $||b||_1 = \sum_{i=1}^p |b_i|$ and $||b||_2 = \sum_{i=1}^p b_i^2$.__

#### Derive equation (4) in [Sharpening Ockham's Razor on a Bayesian Strop](http://jarad.me/stat615/papers/Ridge_Regression_in_Practice.pdf).

$$
B = \frac{p(a|E)}{p(a|F)} = \frac{p(a|E)}{\int p(a|\alpha)p(\alpha|F) d\alpha} = \frac{\frac{1}{\sqrt{2\pi}\sigma}e^{\frac{-(a-42.9)^2}{2\sigma^2}}}{\frac{1}{2\pi\sigma\tau} \int e^{\frac{-(a-\alpha)^2}{2\sigma^2} - \frac{-\alpha^2}{2\tau^2}} d\alpha} = \frac{\frac{1}{\sqrt{2\pi}\sigma}e^{\frac{-(a-42.9)^2}{2\sigma^2}}}{\frac{1}{\sqrt{2\pi(\sigma^2+\tau^2)}}e^{-\frac{a^2}{2(\sigma^2+\tau^2)}}} = \sqrt{\frac{\sigma^2+\tau^2}{\sigma^2}} e^{\frac{-(a-42.9)^2}{2\sigma^2}+\frac{a^2}{2(\sigma^2+\tau^2)}} = \sqrt{1+\bar{\tau}^2}e^{\frac{-D_E^2}{2}}e^{\frac{D_F^2}{2(1+\bar{\tau}^2)}}
$$

where $\bar{\tau} = \frac{\tau}{\sigma}, D_E = \frac{(a - 42.9)}{\sigma}, D_F = \frac{a}{\sigma}$

#### Show that independent normal priors on regression components lead to the ridge estimator on page 5 of [Ridge Regression in Practice](http://jarad.me/stat615/papers/Ridge_Regression_in_Practice.pdf).

Provided that 
$$
\begin{align*}
b &\sim N(\mu = 0, s^2W = \Sigma) = (2\pi)^{\frac{n}{2}}|\Sigma|^{-\frac{1}{2}}exp\{-\frac{1}{2}b'\Sigma^{-1}b\}
\\ s^2 &\sim IG(\alpha, \beta) = \frac{\beta^{\alpha}}{\Gamma(\alpha)} s^{-2(\alpha+1)} e^{-\frac{\beta}{s}}
\end{align*}
$$

$$
\begin{align*}
p(b|y) = \int p(b, s^2|y) ds  \propto \int p(y|b, s^2) p(b|s^2) p(s^2) ds &\propto \int f(s) exp\{-\frac{1}{2s^2}(y-Xb)'(y-Xb) -\frac{1}{2}b'\Sigma^{-1}b - \frac{\beta}{s}\} ds
\\ &\propto \int f'(s) exp\{-\frac{1}{2s^2}[||y-Xb||_2 + b'W^{-1}b]\} ds
\\ &\propto \int f'(s) exp\{-\frac{1}{2s^2}[||y-Xb||_2 + ||W^{\frac{-1}{2}}b||_2]\} ds
\end{align*}
$$

Viewing $p(b|y)$ as a function of $b$ and assuming $W$ is a diagonal matrix, it is clear to see that maximizing $p(b|y)$ is analagous to usual optimization function for ridge regression: 

$$
min_{b \in \mathbb{R}} \{||y-Xb||_2 + \lambda^* ||b||_2\}
$$

where $\lambda^* = \sqrt{\sum_{i=1}^p \frac{1}{w_{ii}}}$

#### Show that independent [Laplace](http://en.wikipedia.org/wiki/Laplace_distribution) priors on regression coefficients lead to the LASSO estimator on page 1 of [Bayesian LASSO](http://www.stat.ufl.edu/~casella/Papers/Lasso.pdf).

$$
\begin{align*}
b|s^2 &\sim (\frac{\lambda}{2s})^{n} e^{-\frac{\lambda||b||_1}{s}} = \prod_{i=1}^n \frac{\lambda}{2\sqrt{s^2}}e^{\frac{-\lambda|b_i|}{\sqrt{s^2}}}
\\ s^2 &\sim \frac{1}{s^2}
\end{align*}
$$

$$
\begin{align*}
p(b|y) = \int p(b, s^2|y) ds  \propto \int p(y|b, s^2) p(b|s^2) p(s^2) ds &\propto \int g(s) exp\{\frac{-1}{2s^2}||y-Xb||_2\ - \frac{1}{s} \lambda ||b||_1\} ds
\\ &= \int g(s) exp\{\frac{-1}{2s^2}(||y-Xb||_2 + 2s \lambda ||b||_1)\} ds
\end{align*}
$$

Viewing $p(b|y)$ as a function of $b$, it is clear to see that maximizing $p(b|y)$ is analagous to usual optimization function for the lasso: 

$$
min_{b \in \mathbb{R}} \{||y-Xb||_2 + \lambda^* ||b||_1\}
$$

where $\lambda^* = 2s\lambda$

#### Derive the form of the prior distribution for the [elastic net estimator](http://en.wikipedia.org/wiki/Elastic_net_regularization). 

$$
\begin{align*}
b|s^2 &\sim exp\{\frac{-1}{2s^2}(\lambda_1 ||b||_1 + \lambda_2 ||b||_2)\}
\\ s^2 &\sim \frac{1}{s^2}
\end{align*}
$$

$$
p(b|y) = \int p(b, s^2|y) ds  \propto \int p(y|b, s^2) p(b|s^2) p(s^2) ds \propto \int h(s) exp\{\frac{-1}{2s^2}(||y-Xb||_2 + \lambda_1 ||b||_1 + \lambda_2 ||b||_2)\} ds
$$

Viewing $p(b|y)$ as a function of $b$, it is clear to see that maximizing $p(b|y)$ is analagous to usual optimization function for the elastic net: 

$$
min_{b \in \mathbb{R}} \{||y-Xb||_2 + \lambda_1 ||b||_1 + \lambda_2 ||b||_2\}
$$
Adopted from [Li and Lin - 2010](http://ba.stat.cmu.edu/journal/2010/vol05/issue01/lin.pdf)

