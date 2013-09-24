An Interactive Visualization Platform for Interpreting Topic Models
========================================================
author: Carson Sievert (joint work with Kenny Shirley)
date: 9-26-2013
transition: rotate
incremental: true

The ugly truth
========================================================

<div align="center"><img src="statisticans.png" /></div>

Overview
========================================================
type: prompt

1. What is a topic model?
2. Fitting topic models via Latent Dirichlet Allocation (LDA).
3. Fitting an LDA model with the `R` package `LDAviz`.
4. Interpreting model output.
  - Topic specific keywords.
  - 'Global' keywords.
5. Measuring similarity between topics.
6. Visualizing model output.

Example Doc
========================================================
type: prompt
title: false

<div align="center"><img src="abstract.png" /></div>

Latent Dirichlet Allocation (LDA)
========================================================
type: prompt

Given $T$ topics, the probability of the $i^{th}$ word $i \in \{1, \dots, V\}$ in a given document:

$p(w_i) = \sum_{j=1}^T p(w_i, z_j) = \sum_{j=1}^T p(w_i|z_j)p(z_j)$

* Let $\phi_{i, j} = p(w_i|z_j)$ be the distribution of words for a given topic. Let the resulting $V$ by $T$ matrix be $\Phi$.
* Let $\theta_{d, j} = p(z_j)$ be the distribution of topics (for a given document $d \in \{1, \dots, D\}$).
* Let the resulting $T$ by $D$ matrix be $\Theta$.
* Assign (you guessed it) Dirichlet priors to both $\Phi$ and $\Theta$.
* Sample a topic for each word (at every iteration) of a collapsed Gibbs sampler.

AP Case Study
========================================================

* A popular dataset in the LDA literature is a set of Associated Press articles. Here is an example of one article (or document).


```
[1] " The Bechtel Group Inc. offered in 1985 to sell oil to Israel at a discount of at least $650 million for 10 years if it promised not to bomb a proposed Iraqi pipeline, a Foreign Ministry official said Wednesday. But then-Prime Minister Shimon Peres said the offer from Bruce Rappaport, a partner in the San Francisco-based construction and engineering company, was ``unimportant,'' the senior official told The Associated Press. Peres, now foreign minister, never discussed the offer with other government ministers, said the official, who spoke on condition of anonymity. The comments marked the first time Israel has acknowledged any offer was made for assurances not to bomb the planned $1 billion pipeline, which was to have run near Israel's border with Jordan. The pipeline was never built. In San Francisco, Tom Flynn, vice president for public relations for the Bechtel Group, said the company did not make any offer to Peres but that Rappaport, a Swiss financier, made it without Bechtel's knowledge or consent. Another Bechtel spokesman, Al Donner, said Bechtel ``at no point'' in development of the pipeline project had anything to do with the handling of the oil. He said proposals submitted by the company ``did not include any specific arrangements for the handling of the oil or for the disposal of the oil once it reached the terminal.'' Asked about Bechtel's disclaimers after they were made in San Francisco, the Israeli Foreign Ministry official said Peres believed Rappaport made the offer for the company. ``Rappaport came to Peres as a representative of Bechtel and said he was speaking on behalf of Bechtel,'' the official said. ``If he was not, he misrepresented himself.'' The Jerusalem Post on Wednesday quoted sources close to Peres as saying that according to Rappaport, Bechtel had said the oil sales would have to be conducted through a third party to keep the sales secret from Iraq and Jordan. The Foreign Ministry official said Peres did not take the offer seriously. ``This is a man who sees 10 people every day,'' he said. ``Thirty percent of them come with crazy ideas. He just says, `Yes, yes. We'll think about it.' That's how things work in Israel.'' The offer appeared to be the one mentioned in a September 1985 memo to Attorney General Edwin Meese III. The memo referred to an arrangement between Peres and Rappaport ``to the effect that Israel will receive somewhere between $65 million and $70 million a year for 10 years.'' The memo from Meese friend E. Robert Wallach, Rappaport's attorney, also states, ``What was also indicated to me, and which would be denied everywhere, is that a portion of those funds will go directly to Labor,'' a reference to the political party Peres leads. The Wallach memo has become the focus of an investigation into whether Meese knew of a possibly improper payment. Peres has denied any wrongdoing and has denounced the memo as ``complete nonsense.'' The Israeli official said Rappaport, a native of Israel and a close friend of Peres, relayed the offer to Peres earlier in September. ``Peres thought the offer was unimportant. For him, the most important thing was to have an Iraqi oil port near Israel's border,'' the official said. ``The thinking was that this would put Iraq in a position where it would not be able to wage war with Israel, out of concern for its pipeline.'' A person answering the telephone at Rappaport's Swiss residence said he was out of town and could not be reached for comment."
```


Input structure
========================================================
left: 55%
incremental: false


```
      words doc_id
1    adding      1
2     adult      1
3     adult      1
4       ago      1
5   alcohol      1
6 allegedly      1
```

...


```
         words doc_id
435835     uss   2246
435836     uss   2246
435837 warfare   2246
435838 william   2246
```

***

* After "preprocessing" the text, we can obtain two _long_ vectors. One with all the words and the other with the relevant document.

Output structure
========================================================
left: 65%
incremental: false


```
      words doc_id topic
1    adding      1    18
2     adult      1    18
3     adult      1    18
4       ago      1     9
5   alcohol      1    18
6 allegedly      1    18
```


...


```
         words doc_id topic
435835     uss   2246    27
435836     uss   2246    27
435837 warfare   2246    19
435838 william   2246     9
```

***

* After every iteration of gibbs sampling we will have a topic ID for each word. 
* Since memory can be an issue, we usually just save the topics from the last iteration (ans after convergence, of course).

What now?
========================================================

* From here, we construct point estimates of $\Phi$ and $\Theta$.
* In our "simple" example, $\Phi$ is 10473 by 30 and $\Theta$ is 30 by 2246
* Each topic has a unique pmf over 10473 points!!!
* __Problem__: How do we interpret topics given such a large space?
* __Solution__: Rank words based on their "relevance" to each topic

What's relevance?
========================================================
type: prompt

- For a given topic $t$, rank words by:
  1. $p(w_i|t)$: common approach, but over-ranks common words
  2. $lift = p(w_i|t)/p(w_i)$: noisy and over-ranks less common words
  3. $relevance = \lambda*log(p(w_i|t)) + (1-\lambda)*log(lift)$ where $0<\lambda<1$
  4. A value of $\lambda = 1/3$ seems to work well

Global keywords
========================================================
type: prompt

1. $distinctiveness(w_i) = \sum_t p(t|w_i) log[\frac{p(t|w_i)}{p(t)}]$
<img src='upgrade.png' style="display:inline-block; margin-left:auto; margin-right:auto; height:205px;"/>
<img src='customer.png' style="display:inline-block; margin-left:auto; margin-right:auto; height:205px;"/>
2. $saliency(w_i) = p(w_i) * distinctiveness(w_i)$

Termite: Chuang, Heer & Manning '12
========================================================
incremental: false
type: prompt

<div align="center"><img src="termite.png" width=1200 height=800/></div>

Comparing Topics
========================================================

* Remember each topic has a unique distribution over words.
* We can calculate a dissimilarity between two topics by measuring the dissimilarity of their distributions (via a measure such as symmetric KL divergence)
* Computing dissimilarity for each unique pair of topics results in a high dimensional distance matrix.
* Thus, we use MDS to scale the points down to two dimensions (in order to visualize).

<li class="fragment" data-fragment-index="5">
<div align="center"><img src="scatter.png" width=400 height=300/></div>
<li>

Live Demo
========================================================
type: prompt

* These ideas (and some others) are integrated into a [fully interactive web application](http://glimmer.rstudio.com/cpsievert/LDAviz).
* This instance makes use of: 
  * The R package shiny
  * The JavaScript library D3
* By integrating these tools we can harness the best of both worlds!
  * R for statistical algorithms
  * JavaScript for interacting with graphics


```r
library(shiny) #run application from R
runGitHub("LDAviz", "kshirley", subdir="inst/shiny/hover")
```


Acknowledgements
========================================================

- Thanks to Kenny Shirley for being a great mentor.
- Thanks to Carlos Scheidegger for sharing his love & hatred for JavaScript.
- Thanks to all the members of Statistics Research for helpful feedback and discussions.


Questions/Comments/Compliments?
========================================================

<div align="center"><img src="awesome.jpeg" width=800 height=600/></div>
