Homework 5 (due 22 Oct in class)
========================================================

### Find the nugget, sill, and range (or effective range) for the linear, spherical, exponential, and Gaussian covariance function. ###

First consider the __linear__ case:

$$
\gamma(t) = \begin{cases} 
      \tau^2 + \sigma^2 t  & \text{if } t >0, \sigma >0, \tau >0 \\
      0 & \text{otherwise}
   \end{cases}
$$

* $\tau^2$ is the _nugget_ since $\lim_{t \rightarrow 0^+} \gamma(t) = \tau^2$.

* Note that the _sill_ infinite since $\lim_{t \rightarrow \infty} \gamma(t) = \infty$.

* Since the _sill_ is infinite, the _range_ is also infinite.

Next consider the __spherical__ case:

$$
\gamma(t) = \begin{cases} 
      \tau^2 + \sigma^2  & \text{if } t \geq 1/\phi \\
      \tau^2 + \sigma^2 (\frac{3\phi t}{2} - \frac{(\phi t)^3}{2})  & \text{if } 0 < t < 1/\phi \\
      0 & \text{otherwise}
   \end{cases}
$$

* $\tau^2$ is the _nugget_ since $\lim_{t \rightarrow 0^+} \gamma(t) = \tau^2$.

* $\tau^2 + \sigma^2$ is the _sill_ since $\lim_{t \rightarrow \infty} \gamma(t) = \tau^2 + \sigma^2$.

* $1/\phi$ is the _range_ since $\gamma(t)$ reaches the _sill_ when $t = 1/\phi$.

Next consider the __exponential__ case:

$$
\gamma(t) = \begin{cases} 
      \tau^2 + \sigma^2 (1 - exp\{ -\phi t \})  & \text{if } t > 0 \\
      0 & \text{otherwise}
   \end{cases}
$$

* $\tau^2$ is the _nugget_ since $\lim_{t \rightarrow 0^+} \gamma(t) = \tau^2$.

* $\tau^2 + \sigma^2$ is the _sill_ since $\lim_{t \rightarrow \infty} \gamma(t) = \tau^2 + \sigma^2$.

* Since the _sill_ is reached asymptotically, the _range_ must be defined in terms of _effective range_. That is, we have to find the value of $t$ such that the covariance is less than 0.05. Now, note that

$$
\begin{align*}
C(t) &= \lim_{u \rightarrow \infty} \gamma(u) - \gamma(t)
\\ &= \tau^2 + \sigma^2 - [\tau^2 + \sigma^2(1 - exp\{ - \phi t\})]
\\ &= \sigma^2exp\{ - \phi t\}
\end{align*}
$$

By setting $C(t) = 0.05$, we obtain the _effective range_ of $t = 3/\phi$

Next consider the __gaussian__ case:

$$
\gamma(t) = \begin{cases} 
      \tau^2 + \sigma^2 (1 - exp\{ -\phi^2 t^2 \})  & \text{if } t > 0 \\
      0 & \text{otherwise}
   \end{cases}
$$

* $\tau^2$ is the _nugget_ since $\lim_{t \rightarrow 0^+} \gamma(t) = \tau^2$.

* $\tau^2 + \sigma^2$ is the _sill_ since $\lim_{t \rightarrow \infty} \gamma(t) = \tau^2 + \sigma^2$.

* Since the _sill_ is reached asymptotically, the _range_ must be defined in terms of _effective range_. That is, we have to find the value of $t$ such that the covariance is less than 0.05. Now, note that

$$
\begin{align*}
C(t) &= \lim_{u \rightarrow \infty} \gamma(u) - \gamma(t)
\\ &= \tau^2 + \sigma^2 - [\tau^2 + \sigma^2(1 - exp\{ -\phi^2 t^2 \})]
\\ &= \sigma^2exp\{ -\phi^2 t^2 \}
\end{align*}
$$

By setting $C(t) = 0.05$, we obtain the _effective range_ of $t = \sqrt{3}/\phi$



### Plot the variograms for the linear, spherical, exponential, and Gaussian using the same value for the nugget, sill, and range (or effective range). ###




<div class="chunk" id="plots"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">sigma2</span> <span class="hl kwb">&lt;-</span> <span class="hl num">0.5</span>
<span class="hl std">tau2</span> <span class="hl kwb">&lt;-</span> <span class="hl num">0.2</span>
<span class="hl std">t</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">seq</span><span class="hl std">(</span><span class="hl kwc">from</span> <span class="hl std">=</span> <span class="hl num">0.001</span><span class="hl std">,</span> <span class="hl kwc">to</span> <span class="hl std">=</span> <span class="hl num">2</span><span class="hl std">,</span> <span class="hl kwc">by</span> <span class="hl std">=</span> <span class="hl num">0.01</span><span class="hl std">)</span>
<span class="hl std">linear</span> <span class="hl kwb">&lt;-</span> <span class="hl std">tau2</span> <span class="hl opt">+</span> <span class="hl std">sigma2</span> <span class="hl opt">*</span> <span class="hl std">t</span>
<span class="hl std">phi</span> <span class="hl kwb">&lt;-</span> <span class="hl num">1</span>
<span class="hl std">spherical</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">ifelse</span><span class="hl std">(t</span> <span class="hl opt">&gt;=</span> <span class="hl num">1</span><span class="hl opt">/</span><span class="hl std">phi, tau2</span> <span class="hl opt">+</span> <span class="hl std">sigma2, tau2</span> <span class="hl opt">+</span> <span class="hl std">sigma2</span> <span class="hl opt">*</span> <span class="hl std">(</span><span class="hl num">3</span> <span class="hl opt">*</span> <span class="hl std">phi</span> <span class="hl opt">*</span> <span class="hl std">t</span><span class="hl opt">/</span><span class="hl num">2</span> <span class="hl opt">-</span>
    <span class="hl std">(</span><span class="hl num">0.5</span><span class="hl std">)</span> <span class="hl opt">*</span> <span class="hl std">(phi</span> <span class="hl opt">*</span> <span class="hl std">t)</span><span class="hl opt">^</span><span class="hl num">3</span><span class="hl std">))</span>
<span class="hl std">phi_exp</span> <span class="hl kwb">&lt;-</span> <span class="hl num">3</span><span class="hl opt">/</span><span class="hl std">phi</span>
<span class="hl std">exponential</span> <span class="hl kwb">&lt;-</span> <span class="hl std">tau2</span> <span class="hl opt">+</span> <span class="hl std">sigma2</span> <span class="hl opt">*</span> <span class="hl std">(</span><span class="hl num">1</span> <span class="hl opt">-</span> <span class="hl kwd">exp</span><span class="hl std">(</span><span class="hl opt">-</span><span class="hl std">phi_exp</span> <span class="hl opt">*</span> <span class="hl std">t))</span>
<span class="hl std">phi_gauss</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">sqrt</span><span class="hl std">(</span><span class="hl num">3</span><span class="hl std">)</span><span class="hl opt">/</span><span class="hl std">phi</span>
<span class="hl std">gauss</span> <span class="hl kwb">&lt;-</span> <span class="hl std">tau2</span> <span class="hl opt">+</span> <span class="hl std">sigma2</span> <span class="hl opt">*</span> <span class="hl std">(</span><span class="hl num">1</span> <span class="hl opt">-</span> <span class="hl kwd">exp</span><span class="hl std">(</span><span class="hl opt">-</span><span class="hl std">phi_gauss</span><span class="hl opt">^</span><span class="hl num">2</span> <span class="hl opt">*</span> <span class="hl std">t</span><span class="hl opt">^</span><span class="hl num">2</span><span class="hl std">))</span>
<span class="hl kwd">plot</span><span class="hl std">(t, linear,</span> <span class="hl kwc">type</span> <span class="hl std">=</span> <span class="hl str">&quot;l&quot;</span><span class="hl std">,</span> <span class="hl kwc">main</span> <span class="hl std">=</span> <span class="hl str">&quot;Theoretical semivariogram&quot;</span><span class="hl std">,</span> <span class="hl kwc">ylim</span> <span class="hl std">=</span> <span class="hl kwd">c</span><span class="hl std">(</span><span class="hl num">0</span><span class="hl std">,</span>
    <span class="hl num">1</span><span class="hl std">),</span> <span class="hl kwc">ylab</span> <span class="hl std">=</span> <span class="hl kwd">expression</span><span class="hl std">(</span><span class="hl kwd">gamma</span><span class="hl std">(t)))</span>
<span class="hl kwd">lines</span><span class="hl std">(t, spherical,</span> <span class="hl kwc">col</span> <span class="hl std">=</span> <span class="hl num">2</span><span class="hl std">)</span>
<span class="hl kwd">lines</span><span class="hl std">(t, exponential,</span> <span class="hl kwc">col</span> <span class="hl std">=</span> <span class="hl num">3</span><span class="hl std">)</span>
<span class="hl kwd">lines</span><span class="hl std">(t, gauss,</span> <span class="hl kwc">col</span> <span class="hl std">=</span> <span class="hl num">4</span><span class="hl std">)</span>
<span class="hl kwd">legend</span><span class="hl std">(</span><span class="hl num">1.1</span><span class="hl std">,</span> <span class="hl num">0.6</span><span class="hl std">,</span> <span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;linear&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;spherical&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;exponential&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;gaussian&quot;</span><span class="hl std">),</span> <span class="hl kwc">col</span> <span class="hl std">=</span> <span class="hl num">1</span><span class="hl opt">:</span><span class="hl num">4</span><span class="hl std">,</span>
    <span class="hl kwc">lty</span> <span class="hl std">=</span> <span class="hl num">1</span><span class="hl std">)</span>
</pre></div>
</div><div class="rimage default"><img src="figure/plots.png" title="plot of chunk plots" alt="plot of chunk plots" class="plot" /></div></div>



### Use Brook's Lemma to find the joint distribution for the conditional distributions $X|Y \sim N(\rho Y, 1-\rho^2)$ and $Y|X \sim N(\rho X, 1-\rho^2)$. ###

According to Brook's Lemma, for any $X'$ and $Y'$, 

$$
\frac{p(X, Y)}{p(X', Y')} = \frac{p(X|Y)}{p(X'|Y)}\frac{p(Y|X')}{p(Y'|X')}
$$

Choosing $X', Y' = 0$ we have 

$$
\begin{align*}
\frac{p(X, Y)}{p(X', Y')} &\propto \frac{ exp\{ \frac{-(x - \rho y)^2 - y^2}{2(1-\rho^2)} \} }{ exp\{ \frac{-(\rho y)^2}{2(1-\rho^2)} \} }
\\ &\propto exp\{ \frac{ -x^2 + 2\rho xy - y^2}{2(1-\rho^2)} \}
\\ &= exp\{ - \frac{1}{2} (\begin{array}{cc} x&y \end{array}) \Sigma^{-1} (\begin{array}{c} x \\ y \end{array}) \}
\end{align*}
$$

where $\Sigma^{-1} = (\begin{array}{cc} \frac{1}{1 - \rho^2} & \frac{\rho}{1 - \rho^2} \\ \frac{\rho}{1 - \rho^2} & \frac{1}{1 - \rho^2}\end{array})$, which implies $\Sigma =  (\begin{array}{cc} 1 & \rho \\ \rho & 1 \end{array})$. Therefore, $(\begin{array}{cc} x \\ y \end{array}) \sim N(0, \Sigma)$
