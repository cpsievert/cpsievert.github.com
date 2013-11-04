Homework 6 (due 5 Nov in class)
===============================

### The [real estate data set](http://www.biostat.umn.edu/~brad/data/BatonRouge.dat) consists of information regarding 70 sales of single-family homes in Baton Rouge, LA, during the month of June 1989 (modified from exercise 5.7 of Hierarchical Modeling and Analysis for Spatial Data). ###




#### Obtain the empirical variogram of the logarithm of selling prices. ####

<div class="chunk" id="variogram"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">library</span><span class="hl std">(geoR)</span>
<span class="hl std">br</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">read.table</span><span class="hl std">(</span><span class="hl str">&quot;http://www.biostat.umn.edu/~brad/data/BatonRouge.dat&quot;</span><span class="hl std">,</span> <span class="hl kwc">header</span> <span class="hl std">= T)</span>
<span class="hl std">br.geo</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">as.geodata</span><span class="hl std">(</span><span class="hl kwc">obj</span> <span class="hl std">= br,</span> <span class="hl kwc">coords.col</span> <span class="hl std">=</span> <span class="hl num">8</span><span class="hl opt">:</span><span class="hl num">9</span><span class="hl std">,</span> <span class="hl kwc">data.col</span> <span class="hl std">=</span> <span class="hl num">1</span><span class="hl std">)</span>
<span class="hl std">vg</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">variog</span><span class="hl std">(br.geo)</span>
<span class="hl std">vf</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">variofit</span><span class="hl std">(vg,</span> <span class="hl kwc">cov.model</span> <span class="hl std">=</span> <span class="hl str">&quot;linear&quot;</span><span class="hl std">)</span>
</pre></div>
</div></div>


<div class="chunk" id="plot1"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">plot</span><span class="hl std">(vg)</span>
<span class="hl kwd">lines</span><span class="hl std">(vf)</span>
</pre></div>
</div><div class="rimage default"><img src="figure/plot1.png" title="plot of chunk plot1" alt="plot of chunk plot1" class="plot" /></div></div>


#### Fit a standard regression model to the logarithm of selling price using all explanatory variables other than location. ####

<div class="chunk" id="reg"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">mod</span> <span class="hl kwb">&lt;-</span> <span class="hl std">br[</span><span class="hl opt">!</span><span class="hl kwd">names</span><span class="hl std">(br)</span> <span class="hl opt">%in%</span> <span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;Latitude&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;Longitude&quot;</span><span class="hl std">)]</span>
<span class="hl std">m</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">lm</span><span class="hl std">(logSellingPr</span> <span class="hl opt">~</span> <span class="hl std">.,</span> <span class="hl kwc">data</span> <span class="hl std">= mod)</span>
<span class="hl kwd">summary</span><span class="hl std">(m)</span>
</pre></div>
<div class="output"><pre class="knitr r">## 
## Call:
## lm(formula = logSellingPr ~ ., data = mod)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.5901 -0.0886  0.0115  0.1221  0.5424 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  1.02e+01   1.79e-01   57.17  < 2e-16 ***
## LivingArea   5.99e-04   8.26e-05    7.26  7.1e-10 ***
## OtherArea    1.51e-04   1.25e-04    1.21   0.2300    
## Age         -9.75e-03   3.39e-03   -2.88   0.0055 ** 
## Bedrooms    -2.13e-02   5.86e-02   -0.36   0.7171    
## Bathrooms   -3.80e-02   1.15e-01   -0.33   0.7429    
## HalfBaths    3.37e-03   8.68e-02    0.04   0.9692    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.203 on 63 degrees of freedom
## Multiple R-squared:  0.77,	Adjusted R-squared:  0.748 
## F-statistic: 35.2 on 6 and 63 DF,  p-value: <2e-16
</pre></div>
</div></div>


#### Obtain the empirical variogram of the residuals to the fit above. ####

<div class="chunk" id="variogram2"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">br</span><span class="hl opt">$</span><span class="hl std">residuals</span> <span class="hl kwb">&lt;-</span> <span class="hl std">m</span><span class="hl opt">$</span><span class="hl std">residuals</span>
<span class="hl std">br.geo2</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">as.geodata</span><span class="hl std">(</span><span class="hl kwc">obj</span> <span class="hl std">= br,</span> <span class="hl kwc">coords.col</span> <span class="hl std">=</span> <span class="hl num">8</span><span class="hl opt">:</span><span class="hl num">9</span><span class="hl std">,</span> <span class="hl kwc">data.col</span> <span class="hl std">=</span> <span class="hl num">10</span><span class="hl std">)</span>
<span class="hl std">vg2</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">variog</span><span class="hl std">(br.geo2)</span>
<span class="hl std">vf2</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">variofit</span><span class="hl std">(vg2,</span> <span class="hl kwc">cov.model</span> <span class="hl std">=</span> <span class="hl str">&quot;linear&quot;</span><span class="hl std">)</span>
</pre></div>
</div></div>


<div class="chunk" id="plot2"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">plot</span><span class="hl std">(vg2)</span>
<span class="hl kwd">lines</span><span class="hl std">(vf2)</span>
</pre></div>
</div><div class="rimage default"><img src="figure/plot2.png" title="plot of chunk plot2" alt="plot of chunk plot2" class="plot" /></div></div>


#### Perform a fully Bayesian analysis using an exponential spatial correlation function. Use a flat prior for the regression coefficients, inverse gamma priors for the variance components, and a Unif(0,10) prior on the range parameter. ####

<div class="chunk" id="bayes"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">library</span><span class="hl std">(rstan)</span>
<span class="hl kwd">set_cppo</span><span class="hl std">(</span><span class="hl str">&quot;fast&quot;</span><span class="hl std">)</span>  <span class="hl com"># for best running speed</span>
<span class="hl com">#code borrows heavily from page 133 of the stan reference manual</span>
<span class="hl std">code</span> <span class="hl kwb">&lt;-</span> <span class="hl str">'
  data {
    int&lt;lower=1&gt; N; // number of observations 
    int&lt;lower=1&gt; D; //number of spatial dimensions
    int&lt;lower=1&gt; K; // number of covariates
    vector[N] y; // log selling price
    vector[D] s[N]; //array of vectors (with lat/longs)
    matrix[N,K] x; //design matrix
  }
  parameters {
    vector[K] beta;
    real&lt;lower=0&gt; eta_sq;
    real&lt;lower=0&gt; rho_sq;
    real&lt;lower=0&gt; sigma_sq;
  }
  model {
    matrix[N,N] Sigma;
    // off-diagonal elements
    for (i in 1:(N-1)) {
      for (j in i:N) {
        Sigma[i,j] &lt;- eta_sq * exp(-rho_sq * dot_self(s[i] - s[j]));
        Sigma[j,i] &lt;- Sigma[i,j];
      }
    }
    // diagonal elements
    for (k in 1:N)
      Sigma[k,k] &lt;- eta_sq + sigma_sq; // + jitter

    eta_sq ~ inv_gamma(0.1, 0.1);
    rho_sq ~ inv_gamma(0.1, 0.1);
    sigma_sq ~ inv_gamma(0.1, 0.1);
    for (b in 1:K) 
      beta[b] ~ normal(0.0, sqrt(1e5));

    y ~ multi_normal(x * beta, Sigma);
}
'</span>
<span class="hl std">X</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">cbind</span><span class="hl std">(</span><span class="hl num">1</span><span class="hl std">,</span> <span class="hl kwd">rescaler</span><span class="hl std">(mod[,</span><span class="hl opt">-</span><span class="hl num">1</span><span class="hl std">]))</span> <span class="hl com">#design matrix with intercept and standardized covariates</span>
<span class="hl std">dat</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">list</span><span class="hl std">(</span><span class="hl kwc">N</span> <span class="hl std">=</span> <span class="hl kwd">length</span><span class="hl std">(br.geo</span><span class="hl opt">$</span><span class="hl std">data),</span>
            <span class="hl kwc">D</span> <span class="hl std">=</span> <span class="hl num">2</span><span class="hl std">,</span>
            <span class="hl kwc">K</span> <span class="hl std">=</span> <span class="hl kwd">dim</span><span class="hl std">(X)[</span><span class="hl num">2</span><span class="hl std">],</span>
            <span class="hl kwc">y</span> <span class="hl std">=</span> <span class="hl kwd">rescaler</span><span class="hl std">(br.geo</span><span class="hl opt">$</span><span class="hl std">data),</span> <span class="hl com">#standardized response</span>
            <span class="hl kwc">s</span> <span class="hl std">= br.geo[[</span><span class="hl num">1</span><span class="hl std">]],</span>
            <span class="hl kwc">x</span> <span class="hl std">= X)</span>
<span class="hl std">fit</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">stan</span><span class="hl std">(</span><span class="hl kwc">model_code</span> <span class="hl std">= code,</span> <span class="hl kwc">data</span> <span class="hl std">= dat,</span>
            <span class="hl kwc">iter</span> <span class="hl std">=</span> <span class="hl num">1000</span><span class="hl std">,</span> <span class="hl kwc">chains</span> <span class="hl std">=</span> <span class="hl num">3</span><span class="hl std">)</span>
</pre></div>
</div></div>


<div class="chunk" id="plot3"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">plot</span><span class="hl std">(fit,</span> <span class="hl kwc">display_parallel</span> <span class="hl std">=</span> <span class="hl num">TRUE</span><span class="hl std">)</span>
</pre></div>
</div><div class="rimage default"><img src="figure/plot3.png" title="plot of chunk plot3" alt="plot of chunk plot3" class="plot" /></div></div>


<div class="chunk" id="print"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">print</span><span class="hl std">(fit)</span>
</pre></div>
<div class="output"><pre class="knitr r">## Inference for Stan model: code.
## 3 chains, each with iter=1000; warmup=500; thin=1; 
## post-warmup draws per chain=500, total post-warmup draws=1500.
## 
##           mean se_mean    sd 2.5%   25%   50%   75% 97.5% n_eff Rhat
## beta[1]   -0.2     0.1   0.8 -1.0  -0.3  -0.1   0.0   0.4   146    1
## beta[2]    0.7     0.0   0.1  0.6   0.7   0.7   0.8   0.9   767    1
## beta[3]    0.1     0.0   0.1  0.0   0.0   0.1   0.1   0.2   851    1
## beta[4]   -0.2     0.0   0.1 -0.3  -0.3  -0.2  -0.2  -0.1   847    1
## beta[5]    0.0     0.0   0.1 -0.2  -0.1   0.0   0.0   0.1   982    1
## beta[6]    0.0     0.0   0.1 -0.1   0.0   0.0   0.1   0.2   860    1
## beta[7]    0.0     0.0   0.1 -0.1  -0.1   0.0   0.0   0.1   892    1
## eta_sq     1.2     0.7   8.9  0.2   0.3   0.4   0.6   2.6   166    1
## rho_sq   371.7    11.9 247.4  9.7 224.3 343.4 475.5 848.0   429    1
## sigma_sq   0.1     0.0   0.0  0.1   0.1   0.1   0.1   0.2   121    1
## lp__      21.5     0.3   2.8 14.5  20.2  22.1  23.5  25.2   115    1
## 
## Samples were drawn using NUTS(diag_e) at Fri Nov  1 23:23:03 2013.
## For each parameter, n_eff is a crude measure of effective sample size,
## and Rhat is the potential scale reduction factor on split chains (at 
## convergence, Rhat=1).
</pre></div>
</div></div>


Similar to the results from the simple regression, the significant effects are living area and age. That is, the 80% credible intervals for the other regression coefficients contain 0.

#### Provide a predictive distribution for the actual selling price for a home at location (long=-91.1174, lat=30.506) that has 938 sqft of living area, 332 sqft of other area, 25 years old with 3 bedrooms and 1 bathroom (no half baths). ####

Let $y_0$ be the selling price for a home at location $s_0$ and $x_0$ be the covariate values at this new location. Then

$$
p(y_0|y, X, x_0) = \int p(y_0|\theta, x_0, y)p(\theta|y, X) d\theta \approx \frac{1}{M} \sum_{i=1}^M p(y_0|\theta^{(i)}, x_0, y)
$$

Thus, we can take draws using the simulations generated in the previous step (ie, $y_0^{(i)} \sim p(y_0|\theta^{(i)}, x_0, y)$)

<div class="chunk" id="pred"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">x0</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">c</span><span class="hl std">(</span><span class="hl num">1</span><span class="hl std">,</span> <span class="hl num">938</span><span class="hl std">,</span> <span class="hl num">332</span><span class="hl std">,</span> <span class="hl num">25</span><span class="hl std">,</span> <span class="hl num">3</span><span class="hl std">,</span> <span class="hl num">1</span><span class="hl std">,</span> <span class="hl num">0</span><span class="hl std">)</span>
<span class="hl std">s0</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">c</span><span class="hl std">(</span><span class="hl num">30.506</span><span class="hl std">,</span> <span class="hl opt">-</span><span class="hl num">91.1174</span><span class="hl std">)</span>
<span class="hl std">la</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">extract</span><span class="hl std">(fit,</span> <span class="hl kwc">permuted</span> <span class="hl std">=</span> <span class="hl num">TRUE</span><span class="hl std">)</span>  <span class="hl com"># return a list of arrays (with draws after the warmup period)</span>
<span class="hl com"># put parameters back on original scale</span>
<span class="hl std">xbar</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">apply</span><span class="hl std">(mod[,</span> <span class="hl opt">-</span><span class="hl num">1</span><span class="hl std">],</span> <span class="hl num">2</span><span class="hl std">, mean)</span>
<span class="hl std">s_x</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">apply</span><span class="hl std">(mod[,</span> <span class="hl opt">-</span><span class="hl num">1</span><span class="hl std">],</span> <span class="hl num">2</span><span class="hl std">, sd)</span>
<span class="hl std">ybar</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">mean</span><span class="hl std">(br.geo</span><span class="hl opt">$</span><span class="hl std">data)</span>
<span class="hl std">s_y</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">sd</span><span class="hl std">(br.geo</span><span class="hl opt">$</span><span class="hl std">data)</span>
<span class="hl std">B0</span> <span class="hl kwb">&lt;-</span> <span class="hl std">ybar</span> <span class="hl opt">+</span> <span class="hl std">s_y</span> <span class="hl opt">*</span> <span class="hl std">(la</span><span class="hl opt">$</span><span class="hl std">beta[,</span> <span class="hl num">1</span><span class="hl std">]</span> <span class="hl opt">-</span> <span class="hl kwd">colSums</span><span class="hl std">(</span><span class="hl kwd">t</span><span class="hl std">(la</span><span class="hl opt">$</span><span class="hl std">beta[,</span> <span class="hl opt">-</span><span class="hl num">1</span><span class="hl std">])</span> <span class="hl opt">*</span> <span class="hl std">(xbar</span><span class="hl opt">/</span><span class="hl std">s_x)))</span>
<span class="hl std">B</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">t</span><span class="hl std">(</span><span class="hl kwd">t</span><span class="hl std">(la</span><span class="hl opt">$</span><span class="hl std">beta[,</span> <span class="hl opt">-</span><span class="hl num">1</span><span class="hl std">])</span> <span class="hl opt">*</span> <span class="hl std">(s_y</span><span class="hl opt">/</span><span class="hl std">s_x))</span>
<span class="hl std">Beta</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">cbind</span><span class="hl std">(B0, B)</span>
<span class="hl std">eta_sq</span> <span class="hl kwb">&lt;-</span> <span class="hl std">s_y</span> <span class="hl opt">*</span> <span class="hl std">la</span><span class="hl opt">$</span><span class="hl std">eta_sq</span>
<span class="hl std">sigma_sq</span> <span class="hl kwb">&lt;-</span> <span class="hl std">s_y</span> <span class="hl opt">*</span> <span class="hl std">la</span><span class="hl opt">$</span><span class="hl std">sigma_sq</span>
<span class="hl com"># now calculate mean and covariance of predictive distribution</span>
<span class="hl std">xb</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">colSums</span><span class="hl std">(</span><span class="hl kwd">t</span><span class="hl std">(Beta</span> <span class="hl opt">*</span> <span class="hl std">x0))</span>
<span class="hl std">y0</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">numeric</span><span class="hl std">(</span><span class="hl kwd">length</span><span class="hl std">(xb))</span>
<span class="hl std">sigma</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">sqrt</span><span class="hl std">(la</span><span class="hl opt">$</span><span class="hl std">sigma_sq</span> <span class="hl opt">*</span> <span class="hl std">(la</span><span class="hl opt">$</span><span class="hl std">eta_sq</span> <span class="hl opt">*</span> <span class="hl kwd">exp</span><span class="hl std">(</span><span class="hl opt">-</span><span class="hl std">la</span><span class="hl opt">$</span><span class="hl std">rho_sq)</span> <span class="hl opt">+</span> <span class="hl num">1</span><span class="hl std">))</span>
<span class="hl kwa">for</span> <span class="hl std">(i</span> <span class="hl kwa">in</span> <span class="hl kwd">seq_along</span><span class="hl std">(y0)) {</span>
    <span class="hl std">y0[i]</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">rnorm</span><span class="hl std">(</span><span class="hl num">1</span><span class="hl std">,</span> <span class="hl kwc">mean</span> <span class="hl std">= xb[i],</span> <span class="hl kwc">sd</span> <span class="hl std">= sigma[i])</span>
<span class="hl std">}</span>
<span class="hl kwd">hist</span><span class="hl std">(xb)</span>
</pre></div>
</div><div class="rimage default"><img src="figure/pred1.png" title="plot of chunk pred" alt="plot of chunk pred" class="plot" /></div><div class="rcode">
<div class="source"><pre class="knitr r"><span class="hl kwd">hist</span><span class="hl std">(</span><span class="hl kwd">exp</span><span class="hl std">(y0))</span>
</pre></div>
</div><div class="rimage default"><img src="figure/pred2.png" title="plot of chunk pred" alt="plot of chunk pred" class="plot" /></div><div class="rcode">
<div class="source"><pre class="knitr r"><span class="hl kwd">summary</span><span class="hl std">(y0[</span><span class="hl opt">-</span><span class="hl std">(</span><span class="hl num">1</span><span class="hl opt">:</span><span class="hl num">500</span><span class="hl std">)])</span>
</pre></div>
<div class="output"><pre class="knitr r">##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    -187       1      54    1890    3360   10000
</pre></div>
<div class="source"><pre class="knitr r"><span class="hl kwd">summary</span><span class="hl std">(br.geo</span><span class="hl opt">$</span><span class="hl std">data)</span>
</pre></div>
<div class="output"><pre class="knitr r">##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    10.2    10.9    11.2    11.2    11.3    12.3
</pre></div>
</div></div>

