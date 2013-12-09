Finding structure in xkcd comics with Latent Dirichlet Allocation
========================================================




[xkcd](http://xkcd.com) is self-proclaimed as a "a webcomic of romance, sarcasm, math, and language". There was a [recent effort](http://www.hotdamndata.com/2013/10/xkcd-webcomic-of-internet-small-talk.html) to quantify whether these "topics" match what the xkcd comic transcripts suggest using [Latent Dirichlet Allocation](http://en.wikipedia.org/wiki/Latent_Dirichlet_allocation) (LDA). One commonly overlooked component of modeling text with LDA is the decision of the number of topics. Instead of assuming that only four topics adequately describes the xkcd text corpus, I will explore an "optimal" number of topics using the Bayesian model selection approach suggested by Griffiths and Steyvers ([2004](http://psiexp.ss.uci.edu/research/papers/sciencetopics.pdf)).

What exactly is LDA?
---------------------

Unlike many other text classification models, LDA is a special case of a [statistical mixture model](http://en.wikipedia.org/wiki/Mixture_model). As a result, each document (in our case, comic) is assumed to be _mixture_ of latent topics. That is, each observed word originates from a topic that we do not directly observe. For demonstration purposes, consider the following xkcd comic given a hypothetical model with four topics: "romance" (in red), "sarcasm" (in blue), "math" (in black), and "language" (in green). 

<div align="center">
  <img src="sports copy.png" width="300" height="400">
</div>

Notice that "a", "to", and "of" are not assigned a topic. These are common [stopwords](http://en.wikipedia.org/wiki/Stop_words) that are filtered out before model fitting because they are seen as uninformative. Tabulating the words that were classified, this document could be summarized as having 5/17 "romance", 5/17 "sarcasm", 4/17 "math", and 3/17 "language".

As we will see in a moment, each topic has a unique distribution over the entire vocabulary of words. In our toy example, the "math" topic might have a 0.03 probability of spitting out "number" where as the "romance" topic might have 0.0001 probability of spitting out that same word.

Now that we have a bit of intuition, let's describe the model mathematically. For a given document, the probability of observing word $i$ (in a fixed vocabulary $i \in \{1, \dots, V\}$) can be represented as

$$
p(w_i) = \sum_{j=1}^T p(w_i, z_j) = \sum_{j=1}^T p(w_i|z_j)p(z_j)
$$

where $z_j$ is the $j^{th}$ topic and $T$ is the total number of topics. The two main probabilities of interest here are $\phi_i^{(z_j)} = p(w_i|z_j)$ and $\theta_j^{(d)} = p(z_j)$. It can help to think of these quantities as matrices. The term-topic matrix $\Phi$ is $V$ by $T$ - where the $j^{th}$ column contains the probability of observing word $i$ conditioned on topic $j$. The topic-document matrix $\Theta$ is $T$ by $D$ - where the $d^{th}$ column contains the topic proportions of document $d$.

It's common to think about this model in a hierarchical Bayes setting where Dirichlet priors are assigned to the parameters $\phi_i^{(z_j)}$ and $\theta_j^{(d)}$. The Dirichlet prior is used mainly for convenience as it is conjugate for the Multinomial distribution. In the notation of Griffiths and Steyvers, the data generating model can be written as:

$$
\begin{align*}
w_i | z_i, \phi_i^{(z_j)} &\sim Multinomial(\phi_i^{(z_j)}, 1)
\\ \phi &\sim Dirichlet(\beta)
\\ z_i | \theta^{(d_i)} &\sim Multinomial(\theta^{(d_i)}, 1)
\\ \theta &\sim Dirichlet(\alpha)
\end{align*}
$$

It's also common to use symmetric hyperpriors $\alpha$ and $\beta$, so these are usually thought of as scalar values. The benefit here is that we can integrate out $\phi$ and $\theta$ and use a collapsed Gibbs algorithm to obtain samples from the target distribution $p(\textbf{z}|\textbf{w})$. Posterior samples of $\textbf{z}$ can then be used to construct estimates of $\phi$ and $\theta$. This algorithm has many implementations, but I chose to use the [R](http://cran.r-project.org/) package [LDAviz](https://github.com/kshirley/LDAviz) for model fitting and post-processing.

Scraping and pre-processing xkcd corpus
---------------------------------------

Thankfully xkcd keeps an [archive](http://xkcd.com/archive/) of all their comics with url paths and corresponding dates. Also, most comics are transcribed complete with scene descriptions, speaker ids, and "meta" alternative text. In this analysis, both scene descriptions and speaker ids were removed from the text corpus. It's also worth noting that, [especially](http://xkcd.com/1299/) [recently](http://xkcd.com/1300/), transcibers have been [lazy](http://xkcd.com/444/) because transcripts are missing. Luckily, in most of those cases, there is "meta" alternative text in the HTML <img> tag that was used instead. The code below shows the detail of this process.

<div class="chunk" id="scrape"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">library</span><span class="hl std">(XML)</span>
<span class="hl kwd">library</span><span class="hl std">(plyr)</span>

<span class="hl com"># grab archive so we have the master list of urls (up to current date) and a</span>
<span class="hl com"># mapping of url to date</span>
<span class="hl std">xmldoc</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">htmlParse</span><span class="hl std">(</span><span class="hl str">&quot;http://xkcd.com/archive/&quot;</span><span class="hl std">)</span>
<span class="hl std">nodes</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">getNodeSet</span><span class="hl std">(xmldoc,</span> <span class="hl str">&quot;//a[@title]&quot;</span><span class="hl std">)</span>
<span class="hl std">dates</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">ldply</span><span class="hl std">(nodes, xmlAttrs)</span>
<span class="hl std">n.comics</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">max</span><span class="hl std">(</span><span class="hl kwd">as.numeric</span><span class="hl std">(</span><span class="hl kwd">gsub</span><span class="hl std">(</span><span class="hl str">&quot;/&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;&quot;</span><span class="hl std">, dates</span><span class="hl opt">$</span><span class="hl std">href)))</span>
<span class="hl std">dates</span><span class="hl opt">$</span><span class="hl std">href</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">paste0</span><span class="hl std">(</span><span class="hl str">&quot;http://xkcd.com&quot;</span><span class="hl std">, dates</span><span class="hl opt">$</span><span class="hl std">href)</span>
<span class="hl std">dates</span><span class="hl opt">$</span><span class="hl std">title</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">as.Date</span><span class="hl std">(dates</span><span class="hl opt">$</span><span class="hl std">title,</span> <span class="hl kwc">format</span> <span class="hl std">=</span> <span class="hl str">&quot;%Y-%m-%d&quot;</span><span class="hl std">)</span>
<span class="hl kwd">names</span><span class="hl std">(dates)</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;url&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;date&quot;</span><span class="hl std">)</span>

<span class="hl std">xmldocs</span> <span class="hl kwb">&lt;-</span> <span class="hl kwa">NULL</span>
<span class="hl kwa">for</span> <span class="hl std">(i</span> <span class="hl kwa">in</span> <span class="hl std">dates</span><span class="hl opt">$</span><span class="hl std">url) {</span>
    <span class="hl std">doc</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">htmlParse</span><span class="hl std">(i)</span>
    <span class="hl std">xmldocs</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">c</span><span class="hl std">(xmldocs, doc)</span>
<span class="hl std">}</span>

<span class="hl com"># grab transcripts</span>
<span class="hl std">nodes</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">llply</span><span class="hl std">(xmldocs,</span> <span class="hl kwa">function</span><span class="hl std">(</span><span class="hl kwc">x</span><span class="hl std">)</span> <span class="hl kwd">getNodeSet</span><span class="hl std">(x,</span> <span class="hl str">&quot;//div[@id='transcript']&quot;</span><span class="hl std">))</span>
<span class="hl std">docs</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">llply</span><span class="hl std">(nodes,</span> <span class="hl kwa">function</span><span class="hl std">(</span><span class="hl kwc">x</span><span class="hl std">)</span> <span class="hl kwd">llply</span><span class="hl std">(x, xmlValue))</span>
<span class="hl std">docs</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">lapply</span><span class="hl std">(docs,</span> <span class="hl kwa">function</span><span class="hl std">(</span><span class="hl kwc">x</span><span class="hl std">)</span> <span class="hl kwd">gsub</span><span class="hl std">(</span><span class="hl str">&quot;\n&quot;</span><span class="hl std">,</span> <span class="hl str">&quot; | &quot;</span><span class="hl std">, x))</span>

<span class="hl com"># for some reason, they've been getting lazy on transcribing more recent</span>
<span class="hl com"># comics... grab image titles and use those as the transcript (if none</span>
<span class="hl com"># exists)</span>
<span class="hl std">comics</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">llply</span><span class="hl std">(xmldocs,</span> <span class="hl kwa">function</span><span class="hl std">(</span><span class="hl kwc">x</span><span class="hl std">)</span> <span class="hl kwd">getNodeSet</span><span class="hl std">(x,</span> <span class="hl str">&quot;//div[@id='comic']&quot;</span><span class="hl std">))</span>
<span class="hl std">imgs</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">llply</span><span class="hl std">(comics,</span> <span class="hl kwa">function</span><span class="hl std">(</span><span class="hl kwc">x</span><span class="hl std">)</span> <span class="hl kwd">llply</span><span class="hl std">(x,</span> <span class="hl kwa">function</span><span class="hl std">(</span><span class="hl kwc">x</span><span class="hl std">)</span> <span class="hl kwd">xmlChildren</span><span class="hl std">(x)</span><span class="hl opt">$</span><span class="hl std">img))</span>
<span class="hl std">imgs2</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">llply</span><span class="hl std">(imgs,</span> <span class="hl kwa">function</span><span class="hl std">(</span><span class="hl kwc">x</span><span class="hl std">)</span> <span class="hl kwd">llply</span><span class="hl std">(x,</span> <span class="hl kwa">function</span><span class="hl std">(</span><span class="hl kwc">x</span><span class="hl std">)</span> <span class="hl kwd">try_default</span><span class="hl std">(</span><span class="hl kwd">xmlAttrs</span><span class="hl std">(x),</span>
    <span class="hl kwa">NULL</span><span class="hl std">,</span> <span class="hl kwc">quiet</span> <span class="hl std">=</span> <span class="hl num">TRUE</span><span class="hl std">)))</span>
<span class="hl std">t</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">sapply</span><span class="hl std">(imgs2,</span> <span class="hl kwa">function</span><span class="hl std">(</span><span class="hl kwc">x</span><span class="hl std">)</span> <span class="hl kwd">as.character</span><span class="hl std">(x[[</span><span class="hl num">1</span><span class="hl std">]][</span><span class="hl kwd">names</span><span class="hl std">(x[[</span><span class="hl num">1</span><span class="hl std">]])</span> <span class="hl opt">%in%</span> <span class="hl str">&quot;title&quot;</span><span class="hl std">]))</span>

<span class="hl com"># overwrite empty documents with image titles</span>
<span class="hl std">idx</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">which</span><span class="hl std">(</span><span class="hl kwd">nchar</span><span class="hl std">(docs)</span> <span class="hl opt">==</span> <span class="hl num">0</span><span class="hl std">)</span>
<span class="hl std">docs[idx]</span> <span class="hl kwb">&lt;-</span> <span class="hl std">t[idx]</span>
<span class="hl std">docs[</span><span class="hl kwd">sapply</span><span class="hl std">(docs, length)</span> <span class="hl opt">==</span> <span class="hl num">0</span><span class="hl std">]</span> <span class="hl kwb">&lt;-</span> <span class="hl str">&quot;&quot;</span>

<span class="hl com"># combine text with dates and write to csv</span>
<span class="hl std">doc.df</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">data.frame</span><span class="hl std">(</span><span class="hl kwc">text</span> <span class="hl std">=</span> <span class="hl kwd">as.character</span><span class="hl std">(docs),</span> <span class="hl kwc">url</span> <span class="hl std">= dates</span><span class="hl opt">$</span><span class="hl std">url,</span> <span class="hl kwc">stringsAsFactors</span> <span class="hl std">=</span> <span class="hl num">FALSE</span><span class="hl std">)</span>
<span class="hl std">docz</span> <span class="hl kwb">&lt;-</span> <span class="hl std">plyr::</span><span class="hl kwd">join</span><span class="hl std">(doc.df, dates,</span> <span class="hl kwc">by</span> <span class="hl std">=</span> <span class="hl str">&quot;url&quot;</span><span class="hl std">)</span>
<span class="hl kwd">write.csv</span><span class="hl std">(docz,</span> <span class="hl kwc">file</span> <span class="hl std">=</span> <span class="hl str">&quot;xkcdDocs.csv&quot;</span><span class="hl std">,</span> <span class="hl kwc">row.names</span> <span class="hl std">=</span> <span class="hl num">FALSE</span><span class="hl std">)</span>
</pre></div>
</div></div>



