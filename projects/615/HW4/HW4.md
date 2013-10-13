Homework 4 (due 8 Oct in class)
========================================================

### Find the stationary distribution for an autoregressive process of order 1. ###

An AR(1) process can be represented as: $y_t = \phi y_{t-1} + \epsilon_t$ where $\epsilon_t$ is white noise (ie, $\epsilon_t \sim N(0, \sigma^2)$). 

Note this can also be representing in the state-space model framework where the observation equation is: $y_t = 1*y_t + 0*y_{t-1} + 0$ or $y_t = F_t \theta_t + v_t$ where $F_t = 1$, $\theta_t = y_t$, and $v_t = 0$. The state equation would then be: $y_t = \phi y_{t-1} + \epsilon_t$ or $\theta_t = G_t \theta_{t-1} + w_t$ where $G_t = \phi$ and $w_t \sim N(0, \sigma^2)$

Treating this as a _dynamic linear model_, we could specify a normal prior distribution for the state at time $t=0$: $y_0 \sim N(m_0, C_0)$.

It then follows that $\theta_t|\theta_{t-1} \sim N(G_t\theta_{t-1}, W_t) \implies y_t|y_{t-1} \sim N(\phi y_{t-1}, \sigma^2)$ 

### Perform a Bayesian analysis of this [data set](http://jarad.me/stat615/data/dlm-data.csv), temperature measurements 25cm below the surface on an experimental plot in Wyoming.###







To keep things simple, consider the random walk plus noise model:

$$
y_t = \mu_t + v_t \hspace{2cm} v_t \sim N(0, V)
\\ \mu_t = \mu_{t-1} + w_t \hspace{2cm} w_t \sim N(0, W)
$$

Note that this model is constant and the only parameters are the observation and evolution variances ($V$ and $W$, respectively). These (unknown) parameters are usually estimated via Maximum Likelihood and/or Bayesian estimation. Before we head in this direction, first consider the trajectory of the random walk plus model with a low signal-to-noise ratio $r = W/V = 1/100$

<div class="chunk" id="one"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">dlmTemp</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">dlmModPoly</span><span class="hl std">(</span><span class="hl kwc">order</span> <span class="hl std">=</span> <span class="hl num">1</span><span class="hl std">,</span> <span class="hl kwc">dV</span> <span class="hl std">=</span> <span class="hl num">100</span><span class="hl std">,</span> <span class="hl kwc">dW</span> <span class="hl std">=</span> <span class="hl num">1</span><span class="hl std">)</span>
<span class="hl std">tempFilt</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">dlmFilter</span><span class="hl std">(y_tmp, dlmTemp)</span>
<span class="hl std">tempSmooth</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">dlmSmooth</span><span class="hl std">(y_tmp, dlmTemp)</span>
<span class="hl kwd">plot</span><span class="hl std">(y_tmp,</span> <span class="hl kwc">type</span> <span class="hl std">=</span> <span class="hl str">&quot;l&quot;</span><span class="hl std">)</span>
<span class="hl kwd">lines</span><span class="hl std">(tempFilt</span><span class="hl opt">$</span><span class="hl std">m[</span><span class="hl opt">-</span><span class="hl num">1</span><span class="hl std">],</span> <span class="hl kwc">col</span> <span class="hl std">=</span> <span class="hl num">2</span><span class="hl std">)</span>
<span class="hl kwd">lines</span><span class="hl std">(tempSmooth</span><span class="hl opt">$</span><span class="hl std">s[</span><span class="hl opt">-</span><span class="hl num">1</span><span class="hl std">],</span> <span class="hl kwc">col</span> <span class="hl std">=</span> <span class="hl num">3</span><span class="hl std">)</span>
<span class="hl kwd">legend</span><span class="hl std">(</span><span class="hl str">&quot;bottomright&quot;</span><span class="hl std">,</span> <span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;Filtered Trajectory&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;Smoothed Trajectory&quot;</span><span class="hl std">),</span> <span class="hl kwc">col</span> <span class="hl std">=</span> <span class="hl num">2</span><span class="hl opt">:</span><span class="hl num">3</span><span class="hl std">,</span>
    <span class="hl kwc">lty</span> <span class="hl std">=</span> <span class="hl num">1</span><span class="hl std">)</span>
</pre></div>
</div><div class="rimage center"><img src="figure/one.png" title="plot of chunk one" alt="plot of chunk one" class="plot" /></div></div>


In this case, the choice for these values of $V$ and $W$ were arbitrary. To obtain a better estimate at the true value of these parameters, we can use Maximum Likelihood:

<div class="chunk" id="two"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">buildFun</span> <span class="hl kwb">&lt;-</span> <span class="hl kwa">function</span><span class="hl std">(</span><span class="hl kwc">x</span><span class="hl std">) {</span>
    <span class="hl kwd">dlmModPoly</span><span class="hl std">(</span><span class="hl kwc">order</span> <span class="hl std">=</span> <span class="hl num">1</span><span class="hl std">,</span> <span class="hl kwc">dV</span> <span class="hl std">=</span> <span class="hl kwd">exp</span><span class="hl std">(x[</span><span class="hl num">1</span><span class="hl std">]),</span> <span class="hl kwc">dW</span> <span class="hl std">=</span> <span class="hl kwd">exp</span><span class="hl std">(x[</span><span class="hl num">2</span><span class="hl std">]))</span>
<span class="hl std">}</span>
<span class="hl std">fit</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">dlmMLE</span><span class="hl std">(y_tmp,</span> <span class="hl kwc">parm</span> <span class="hl std">=</span> <span class="hl kwd">rep</span><span class="hl std">(</span><span class="hl num">0</span><span class="hl std">,</span> <span class="hl num">3</span><span class="hl std">),</span> <span class="hl kwc">build</span> <span class="hl std">= buildFun)</span>
<span class="hl kwd">stopifnot</span><span class="hl std">(fit</span><span class="hl opt">$</span><span class="hl std">convergence</span> <span class="hl opt">==</span> <span class="hl num">0</span><span class="hl std">)</span>
<span class="hl std">dlmTemp2</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">buildFun</span><span class="hl std">(fit</span><span class="hl opt">$</span><span class="hl std">par)</span>
<span class="hl kwd">unlist</span><span class="hl std">(dlmTemp2[</span><span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;V&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;W&quot;</span><span class="hl std">)])</span>
</pre></div>
<div class="output"><pre class="knitr r">##         V         W 
## 1.092e-08 6.756e-02
</pre></div>
<div class="source"><pre class="knitr r"><span class="hl std">tempFilt2</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">dlmFilter</span><span class="hl std">(y, dlmTemp2)</span>
<span class="hl std">tempSmooth2</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">dlmSmooth</span><span class="hl std">(y, dlmTemp2)</span>
<span class="hl kwd">plot</span><span class="hl std">(y_tmp,</span> <span class="hl kwc">type</span> <span class="hl std">=</span> <span class="hl str">&quot;l&quot;</span><span class="hl std">)</span>
<span class="hl kwd">lines</span><span class="hl std">(tempFilt2</span><span class="hl opt">$</span><span class="hl std">m[</span><span class="hl opt">-</span><span class="hl num">1</span><span class="hl std">],</span> <span class="hl kwc">col</span> <span class="hl std">=</span> <span class="hl num">2</span><span class="hl std">)</span>
<span class="hl kwd">lines</span><span class="hl std">(tempSmooth2</span><span class="hl opt">$</span><span class="hl std">s[</span><span class="hl opt">-</span><span class="hl num">1</span><span class="hl std">],</span> <span class="hl kwc">col</span> <span class="hl std">=</span> <span class="hl num">3</span><span class="hl std">)</span>
<span class="hl kwd">legend</span><span class="hl std">(</span><span class="hl str">&quot;bottomright&quot;</span><span class="hl std">,</span> <span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;Filtered Trajectory&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;Smoothed Trajectory&quot;</span><span class="hl std">),</span> <span class="hl kwc">col</span> <span class="hl std">=</span> <span class="hl num">2</span><span class="hl opt">:</span><span class="hl num">3</span><span class="hl std">,</span>
    <span class="hl kwc">lty</span> <span class="hl std">=</span> <span class="hl num">1</span><span class="hl std">)</span>
</pre></div>
</div><div class="rimage center"><img src="figure/two.png" title="plot of chunk two" alt="plot of chunk two" class="plot" /></div></div>


Note that the high signal-to-noise ratio estimated via Maximum Likelihood produces a trajectory that essentially mimics the actual trajectory. Due to this overfitting, any prediction would be highly inaccurate since predictions would be heavily influenced by the noise in previous observations. If we were to treat these parameter estimates as known and perform a Bayesian analysis, one could obtain samples from the posterior via the Forward Filtering Backward Sampling (FFBS) algorithm. However, this is not a great way to proceed since (in addition to these values not really being known) backwards sampling from this filtered object would produce samples with very little variation. Instead, we proceed by treating $V$ and $W$ as unknown. 

Assuming that $W$ is a diagonal matrix and both unknown variances have independent inverse Gamma prior distributions, we can sample from the posterior using the function `dlm::dlmGibbsDIG`.

<div class="chunk" id="gibbs"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">mcmc</span> <span class="hl kwb">&lt;-</span> <span class="hl num">1000</span>
<span class="hl std">burn</span> <span class="hl kwb">&lt;-</span> <span class="hl num">500</span>
<span class="hl std">outGibbs</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">dlmGibbsDIG</span><span class="hl std">(y_tmp,</span> <span class="hl kwc">mod</span> <span class="hl std">=</span> <span class="hl kwd">dlmModPoly</span><span class="hl std">(</span><span class="hl num">1</span><span class="hl std">),</span> <span class="hl kwc">shape.y</span> <span class="hl std">=</span> <span class="hl num">0.001</span><span class="hl std">,</span> <span class="hl kwc">rate.y</span> <span class="hl std">=</span> <span class="hl num">0.001</span><span class="hl std">,</span>
    <span class="hl kwc">shape.theta</span> <span class="hl std">=</span> <span class="hl num">0.001</span><span class="hl std">,</span> <span class="hl kwc">rate.theta</span> <span class="hl std">=</span> <span class="hl num">0.001</span><span class="hl std">,</span> <span class="hl kwc">n.sample</span> <span class="hl std">= mcmc</span> <span class="hl opt">+</span> <span class="hl std">burn)</span>
</pre></div>
</div></div>


<div class="chunk" id="stuff"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">m</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">mcmcMean</span><span class="hl std">(</span><span class="hl kwd">with</span><span class="hl std">(outGibbs,</span> <span class="hl kwd">cbind</span><span class="hl std">(</span><span class="hl kwc">V</span> <span class="hl std">= dV[</span><span class="hl opt">-</span><span class="hl std">(</span><span class="hl num">1</span><span class="hl opt">:</span><span class="hl std">burn)],</span> <span class="hl kwc">W</span> <span class="hl std">= dW[</span><span class="hl opt">-</span><span class="hl std">(</span><span class="hl num">1</span><span class="hl opt">:</span><span class="hl std">burn), ])))</span>
<span class="hl std">m[</span><span class="hl num">1</span><span class="hl std">, ]</span>  <span class="hl com">#point estimates for unknown variances</span>
</pre></div>
<div class="output"><pre class="knitr r">##         V         W 
## 0.0001737 0.0680178
</pre></div>
<div class="source"><pre class="knitr r"><span class="hl std">m[</span><span class="hl num">2</span><span class="hl std">, ]</span>  <span class="hl com">#Monte Carlo standard errors</span>
</pre></div>
<div class="output"><pre class="knitr r">##         V         W 
## 9.654e-06 5.393e-05
</pre></div>
</div></div>


Again, we obtain a low (point) estimate for the observation variance $V$ (and a very high signal-to-noise ratio). In the figure below, the upper and lower bound to the 95% credible interval for the unknown states are drawn for the actual data.

<div class="chunk" id="plot"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">thetas</span> <span class="hl kwb">&lt;-</span> <span class="hl std">outGibbs</span><span class="hl opt">$</span><span class="hl std">theta[, ,</span> <span class="hl opt">-</span><span class="hl std">(</span><span class="hl num">1</span><span class="hl opt">:</span><span class="hl std">burn)]</span>
<span class="hl std">mns</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">rowMeans</span><span class="hl std">(thetas)</span>
<span class="hl std">l</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">apply</span><span class="hl std">(thetas,</span> <span class="hl num">1</span><span class="hl std">, quantile,</span> <span class="hl num">0.025</span><span class="hl std">)</span>
<span class="hl std">u</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">apply</span><span class="hl std">(thetas,</span> <span class="hl num">1</span><span class="hl std">, quantile,</span> <span class="hl num">0.975</span><span class="hl std">)</span>
<span class="hl kwd">plot</span><span class="hl std">(y_tmp,</span> <span class="hl kwc">type</span> <span class="hl std">=</span> <span class="hl str">&quot;l&quot;</span><span class="hl std">)</span>
<span class="hl kwd">lines</span><span class="hl std">(l,</span> <span class="hl kwc">col</span> <span class="hl std">=</span> <span class="hl num">3</span><span class="hl std">,</span> <span class="hl kwc">lty</span> <span class="hl std">=</span> <span class="hl num">2</span><span class="hl std">)</span>
<span class="hl kwd">lines</span><span class="hl std">(u,</span> <span class="hl kwc">col</span> <span class="hl std">=</span> <span class="hl num">3</span><span class="hl std">,</span> <span class="hl kwc">lty</span> <span class="hl std">=</span> <span class="hl num">2</span><span class="hl std">)</span>
</pre></div>
</div><div class="rimage center"><img src="figure/plot.png" title="plot of chunk plot" alt="plot of chunk plot" class="plot" /></div></div>


Clearly, a simple random walk plus noise model is not going to work since the observation and evolution variance are so small. Next, we consider adding a fourier representation of the periodic component. This particular representation contains two harmonics.

<div class="chunk" id="explore"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">buildFun</span> <span class="hl kwb">&lt;-</span> <span class="hl kwa">function</span><span class="hl std">(</span><span class="hl kwc">x</span><span class="hl std">) {</span>
    <span class="hl kwd">dlmModPoly</span><span class="hl std">(</span><span class="hl kwc">order</span> <span class="hl std">=</span> <span class="hl num">1</span><span class="hl std">,</span> <span class="hl kwc">dV</span> <span class="hl std">=</span> <span class="hl kwd">exp</span><span class="hl std">(x[</span><span class="hl num">1</span><span class="hl std">]),</span> <span class="hl kwc">dW</span> <span class="hl std">=</span> <span class="hl kwd">exp</span><span class="hl std">(x[</span><span class="hl num">2</span><span class="hl std">]))</span> <span class="hl opt">+</span> <span class="hl kwd">dlmModTrig</span><span class="hl std">(</span><span class="hl kwc">s</span> <span class="hl std">=</span> <span class="hl num">24</span><span class="hl std">,</span>
        <span class="hl kwc">q</span> <span class="hl std">=</span> <span class="hl num">2</span><span class="hl std">,</span> <span class="hl kwc">dV</span> <span class="hl std">=</span> <span class="hl kwd">exp</span><span class="hl std">(x[</span><span class="hl num">1</span><span class="hl std">]),</span> <span class="hl kwc">dW</span> <span class="hl std">=</span> <span class="hl kwd">exp</span><span class="hl std">(x[</span><span class="hl num">2</span><span class="hl std">]))</span>
<span class="hl std">}</span>
<span class="hl std">fit</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">dlmMLE</span><span class="hl std">(</span><span class="hl kwd">log</span><span class="hl std">(y_tmp),</span> <span class="hl kwc">parm</span> <span class="hl std">=</span> <span class="hl kwd">rep</span><span class="hl std">(</span><span class="hl num">1</span><span class="hl std">,</span> <span class="hl num">2</span><span class="hl std">),</span> <span class="hl kwc">build</span> <span class="hl std">= buildFun,</span> <span class="hl kwc">lower</span> <span class="hl std">=</span> <span class="hl num">1e-08</span><span class="hl std">,</span>
    <span class="hl kwc">upper</span> <span class="hl std">=</span> <span class="hl num">10</span><span class="hl std">)</span>
<span class="hl kwd">stopifnot</span><span class="hl std">(fit</span><span class="hl opt">$</span><span class="hl std">convergence</span> <span class="hl opt">==</span> <span class="hl num">0</span><span class="hl std">)</span>
<span class="hl std">t</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">buildFun</span><span class="hl std">(fit</span><span class="hl opt">$</span><span class="hl std">par)</span>
</pre></div>
</div></div>


Note that the estimates of $V$ and $W$ are still incredibly small, but this model systematically restricts the states from mimicing the actual trajectory (as seen below). It is interesting to see the large spike in the filtered trajectory at the start of the time series, but it makes total sense considering the filtered estimates are based on _previous_ data (rather than all available data) and there is a large spike from the 1st time point to the 2nd time point.

<div class="chunk" id="plot_harm"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">tempFilt2</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">dlmFilter</span><span class="hl std">(y_tmp, t)</span>
<span class="hl std">tempSmooth2</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">dlmSmooth</span><span class="hl std">(y_tmp, t)</span>
<span class="hl kwd">plot</span><span class="hl std">(y_tmp,</span> <span class="hl kwc">type</span> <span class="hl std">=</span> <span class="hl str">&quot;l&quot;</span><span class="hl std">)</span>
<span class="hl kwd">lines</span><span class="hl std">(tempFilt2</span><span class="hl opt">$</span><span class="hl std">m[</span><span class="hl opt">-</span><span class="hl num">1</span><span class="hl std">],</span> <span class="hl kwc">col</span> <span class="hl std">=</span> <span class="hl num">2</span><span class="hl std">)</span>
<span class="hl kwd">lines</span><span class="hl std">(tempSmooth2</span><span class="hl opt">$</span><span class="hl std">s[</span><span class="hl opt">-</span><span class="hl num">1</span><span class="hl std">],</span> <span class="hl kwc">col</span> <span class="hl std">=</span> <span class="hl num">3</span><span class="hl std">)</span>
<span class="hl kwd">legend</span><span class="hl std">(</span><span class="hl str">&quot;bottomright&quot;</span><span class="hl std">,</span> <span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;Filtered Trajectory&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;Smoothed Trajectory&quot;</span><span class="hl std">),</span> <span class="hl kwc">col</span> <span class="hl std">=</span> <span class="hl num">2</span><span class="hl opt">:</span><span class="hl num">3</span><span class="hl std">,</span>
    <span class="hl kwc">lty</span> <span class="hl std">=</span> <span class="hl num">1</span><span class="hl std">)</span>
</pre></div>
</div><div class="rimage center"><img src="figure/plot_harm.png" title="plot of chunk plot_harm" alt="plot of chunk plot_harm" class="plot" /></div></div>

