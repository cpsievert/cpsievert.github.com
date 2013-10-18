<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{A Markdown Vignette with knitr}
-->




Introduction to XML2R package
====================================

Extracting observations
--------------------------

The  [XML2R package](https://github.com/cpsievert/XML2R) is meant to simplify scraping [XML](http://en.wikipedia.org/wiki/XML) data from XML files hosted on the web. The main function of **XML2R**, `XML2Obs`, coerces XML content into a list of _observations_. Here we define an _observation_ as a matrix with one row. One observation will contain all attributes and the XML value for a particular XML ancestory. The name of each list element (or each observation) tracks the XML hierarchy so observations can be grouped together at a later point. In the code below, we obtain 946 observations from two MLB games played on June 14th, 2013.

<div class="chunk" id="ex1"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">library</span><span class="hl std">(XML2R)</span>
<span class="hl std">pre</span> <span class="hl kwb">&lt;-</span> <span class="hl str">&quot;http://gd2.mlb.com/components/game/mlb/year_2013/month_06/day_14/&quot;</span>
<span class="hl std">post</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;gid_2013_06_14_phimlb_colmlb_1/inning/inning_all.xml&quot;</span><span class="hl std">,</span>
          <span class="hl str">&quot;gid_2013_06_14_seamlb_oakmlb_1/inning/inning_all.xml&quot;</span><span class="hl std">)</span>
<span class="hl std">urls</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">paste0</span><span class="hl std">(pre, post)</span>
<span class="hl std">obs</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">XML2Obs</span><span class="hl std">(urls)</span>
</pre></div>
</div></div>


<div class="chunk" id="n"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">length</span><span class="hl std">(obs)</span>
</pre></div>
<div class="output"><pre class="knitr r">## [1] 947
</pre></div>
</div></div>


Note that the length of the `obs` object is one longer than the true number of observations. That's because an element (named url_map) containing all the relevant file names will be appended to the end of the list. The values in this list can be used to link to the `url_key` variable back to the exact file name. This structuring helps us avoid unnecesarily repeating long file names in every observation.

<div class="chunk" id="str"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">tail</span><span class="hl std">(obs,</span> <span class="hl num">3</span><span class="hl std">)</span>
</pre></div>
<div class="output"><pre class="knitr r">## $`game//inning`
##      num away_team home_team next url_key
## [1,] "9" "sea"     "oak"     "N"  "url2" 
## 
## $game
##      atBat    deck     hole     ind url_key
## [1,] "489267" "519299" "455759" "F" "url2" 
## 
## $url_map
##                                                                                                                    url1 
## "http://gd2.mlb.com/components/game/mlb/year_2013/month_06/day_14/gid_2013_06_14_phimlb_colmlb_1/inning/inning_all.xml" 
##                                                                                                                    url2 
## "http://gd2.mlb.com/components/game/mlb/year_2013/month_06/day_14/gid_2013_06_14_seamlb_oakmlb_1/inning/inning_all.xml"
</pre></div>
</div></div>


As seen in the output above, the last observation happens at the game level while the second observation happens at the game//inning level. Of course, we can have many observations that belong to a particular level. To get a feel for how many levels we have (and their naming), we can use:

<div class="chunk" id="levels"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">lvls</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">unique</span><span class="hl std">(</span><span class="hl kwd">names</span><span class="hl std">(obs))</span>
<span class="hl std">lvls</span>
</pre></div>
<div class="output"><pre class="knitr r">##  [1] "game//inning//top//atbat//pitch"     "game//inning//top//atbat"            "game//inning//bottom//atbat//pitch" 
##  [4] "game//inning//bottom//atbat"         "game//inning//bottom//atbat//runner" "game//inning"                       
##  [7] "game//inning//top//atbat//runner"    "game//inning//bottom//atbat//po"     "game//inning//top//atbat//po"       
## [10] "game//inning//bottom//action"        "game//inning//top//action"           "game"                               
## [13] "url_map"
</pre></div>
</div></div>


Renaming observations
--------------------------

Eventually we'll want to combine observations from the same level into a common table/matrix/data.frame. Before that, we may want to regard two different levels as equivalent. For example, I know that observations at the "game//inning//top//atbat"  level are essentially the same as observations at the "game//inning//bottom//atbat" level. I may want to `rename` these observations as "game//inning//atbat" and append a variable for each relevant observation that tracks whether the atbat occured at the "top" or "bottom" of the inning.

<div class="chunk" id="rename"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">tmp</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">rename</span><span class="hl std">(obs,</span> <span class="hl kwc">equiv</span> <span class="hl std">=</span> <span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;game//inning//top//atbat&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;game//inning//bottom//atbat&quot;</span><span class="hl std">))</span>
</pre></div>
</div></div>


In this case, there is good reason to do this renaming for any name containing "pitch", "runner", "action", or "po".

<div class="chunk" id="rename2"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">pitch</span> <span class="hl kwb">&lt;-</span> <span class="hl std">lvls[</span><span class="hl kwd">grep</span><span class="hl std">(</span><span class="hl str">&quot;pitch&quot;</span><span class="hl std">, lvls)]</span>
<span class="hl std">tmp</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">rename</span><span class="hl std">(tmp,</span> <span class="hl kwc">equiv</span> <span class="hl std">= pitch,</span> <span class="hl kwc">diff.name</span> <span class="hl std">=</span> <span class="hl str">&quot;inning&quot;</span><span class="hl std">)</span>
<span class="hl std">runner</span> <span class="hl kwb">&lt;-</span> <span class="hl std">lvls[</span><span class="hl kwd">grep</span><span class="hl std">(</span><span class="hl str">&quot;runner&quot;</span><span class="hl std">, lvls)]</span>
<span class="hl std">tmp</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">rename</span><span class="hl std">(tmp,</span> <span class="hl kwc">equiv</span> <span class="hl std">= runner,</span> <span class="hl kwc">diff.name</span> <span class="hl std">=</span> <span class="hl str">&quot;inning&quot;</span><span class="hl std">)</span>
<span class="hl std">action</span> <span class="hl kwb">&lt;-</span> <span class="hl std">lvls[</span><span class="hl kwd">grep</span><span class="hl std">(</span><span class="hl str">&quot;action&quot;</span><span class="hl std">, lvls)]</span>
<span class="hl std">tmp</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">rename</span><span class="hl std">(tmp,</span> <span class="hl kwc">equiv</span> <span class="hl std">= action,</span> <span class="hl kwc">diff.name</span> <span class="hl std">=</span> <span class="hl str">&quot;inning&quot;</span><span class="hl std">)</span>
<span class="hl std">po</span> <span class="hl kwb">&lt;-</span> <span class="hl std">lvls[</span><span class="hl kwd">grep</span><span class="hl std">(</span><span class="hl str">&quot;po&quot;</span><span class="hl std">, lvls)]</span>
<span class="hl std">obs2</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">rename</span><span class="hl std">(tmp,</span> <span class="hl kwc">equiv</span> <span class="hl std">= po,</span> <span class="hl kwc">diff.name</span> <span class="hl std">=</span> <span class="hl str">&quot;inning&quot;</span><span class="hl std">)</span>
<span class="hl kwd">unique</span><span class="hl std">(</span><span class="hl kwd">names</span><span class="hl std">(obs2))</span>
</pre></div>
<div class="output"><pre class="knitr r">## [1] "game//inning//atbat//pitch"  "game//inning//atbat"         "game//inning//atbat//runner"
## [4] "game//inning"                "game//inning//atbat//po"     "game//inning//action"       
## [7] "game"                        "url_map"
</pre></div>
</div></div>


Linking observations
----------------------------

After all that renaming, we now have data on <code class="knitr inline">7</code> different levels. Next, we may want to pool together observations from a common level into a table. Note that is also important that we have an option to link a child observation back to it's parent. For example, I may want to link a particular pitch (that is, an observation from the "game//inning//atbat//pitch" level) back to the relevant atbat (that is, an observation from the "game//inning//atbat" level).

To help link children back to parents, we can use the `add_key` function. Here I will use `add_key` to create a link between an observation at the "game//inning" level and it's children. A similar link is also created to link observations at the "game//inning//atbat" level to it's children. Note that links are just another variable that is appended to relevant observations. Here I am naming those variables "inning_key" and "atbat_key". This linking works assuming that the ordering of observations is preserved from the output of `XML2Obs` (which preserves the ordering in the original document(s)).

<div class="chunk" id="add_key"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">tmp2</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">add_key</span><span class="hl std">(obs2,</span> <span class="hl kwc">parent</span> <span class="hl std">=</span> <span class="hl str">&quot;game//inning&quot;</span><span class="hl std">,</span> <span class="hl kwc">key.name</span> <span class="hl std">=</span> <span class="hl str">&quot;inning_key&quot;</span><span class="hl std">)</span>
<span class="hl std">obswkey</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">add_key</span><span class="hl std">(tmp2,</span> <span class="hl kwc">parent</span> <span class="hl std">=</span> <span class="hl str">&quot;game//inning//atbat&quot;</span><span class="hl std">,</span> <span class="hl kwc">key.name</span> <span class="hl std">=</span> <span class="hl str">&quot;atbat_key&quot;</span><span class="hl std">)</span>
</pre></div>
</div></div>


Collapsing observations
----------------------------

Finally, we are in a position to pool together observations that have a common name. The `collapse` function achieves this by row binding observations together and returning a list of matrices. Note that `collapse` doesn't require that observations from the same level to have the same set of variables. In the case where variables are missing, `NA`s will be used as the value.

<div class="chunk" id="collapse"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">tables</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">collapse</span><span class="hl std">(obswkey)</span>
<span class="hl kwd">head</span><span class="hl std">(tables[[</span><span class="hl str">&quot;game//inning//atbat//po&quot;</span><span class="hl std">]])</span>
</pre></div>
<div class="output"><pre class="knitr r">##      des                  url_key inning   inning_key atbat_key
## [1,] "Pickoff Attempt 1B" "url1"  "bottom" "3"        "26"     
## [2,] "Pickoff Attempt 1B" "url1"  "top"    "4"        "29"     
## [3,] "Pickoff Attempt 1B" "url1"  "top"    "6"        "54"     
## [4,] "Pickoff Attempt 1B" "url1"  "top"    "7"        "65"     
## [5,] "Pickoff Attempt 1B" "url1"  "top"    "8"        "72"     
## [6,] "Pickoff Attempt 1B" "url1"  "bottom" "8"        "77"
</pre></div>
</div></div>


At this point, you are probably ready to save this data structure using your favorite method. I strongly recommend writing `tables` to a database if you plan on repeatedly querying your data. 

Using XPath
--------------------------

If one is interested in just a subset of the XML document, the `xpath` option of `XML2Obs` can be used to specify [XPath syntax](http://www.w3schools.com/xpath/xpath_syntax.asp). Suppose for some reason I only want data that occurs on the "game//inning//bottom" level. 

<div class="chunk" id="xpath"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">dat2</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">XML2Obs</span><span class="hl std">(urls,</span> <span class="hl kwc">xpath</span> <span class="hl std">=</span> <span class="hl str">&quot;/game/inning/bottom&quot;</span><span class="hl std">)</span>
</pre></div>
</div></div>


<div class="chunk" id="xpath1"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">unique</span><span class="hl std">(</span><span class="hl kwd">names</span><span class="hl std">(dat2))</span>
</pre></div>
<div class="output"><pre class="knitr r">## [1] "atbat//pitch"  "atbat"         "atbat//runner" "atbat//po"     "action"        "url_map"
</pre></div>
</div></div>

