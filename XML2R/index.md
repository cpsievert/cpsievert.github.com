<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{A Markdown Vignette with knitr}
-->




Introduction to XML2R package
====================================

The  [XML2R package](https://github.com/cpsievert/XML2R) is meant to simplify scraping [XML](http://en.wikipedia.org/wiki/XML) data from XML files hosted on the web. This example page demonstrates the ideas behind **XML2R** by walking through pseudo-source code of the `scrape` function in the [pitchRx](http://cran.r-project.org/web/packages/pitchRx/) package. Similar ideas have been implemented in the [bbscrapeR](https://github.com/cpsievert/bbscrapeR) package which provides a high-level API to statistics from [nba.com](http://www.nba.com/) and [wnba.com](http://www.wnba.com/).

Extracting observations
--------------------------

The main function in **XML2R**, `XML2Obs`, coerces XML content into a list of _observations_. An _observation_ is technically a matrix with one row and possibly many columns. One observation includes all XML attributes and the XML value for a particular XML lineage. The name of each list element (or each observation) tracks the XML hierarchy so observations can be grouped together in a sensible fashion at a later point. In the code below, we obtain 946 observations from two different XML files that contain data on [Major League Baseball](http://en.wikipedia.org/wiki/Major_League_Baseball) games played on June 14th, 2013.

<div class="chunk" id="ex1"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">library</span><span class="hl std">(XML2R)</span>
<span class="hl std">pre</span> <span class="hl kwb">&lt;-</span> <span class="hl str">&quot;http://gd2.mlb.com/components/game/mlb/year_2013/month_06/day_14/&quot;</span>
<span class="hl std">post</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;gid_2013_06_14_phimlb_colmlb_1/inning/inning_all.xml&quot;</span><span class="hl std">,</span>
          <span class="hl str">&quot;gid_2013_06_14_seamlb_oakmlb_1/inning/inning_all.xml&quot;</span><span class="hl std">)</span>
<span class="hl std">urls</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">paste0</span><span class="hl std">(pre, post)</span>
<span class="hl std">obs</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">XML2Obs</span><span class="hl std">(urls,</span> <span class="hl kwc">as.equiv</span><span class="hl std">=</span><span class="hl num">TRUE</span><span class="hl std">,</span> <span class="hl kwc">quiet</span><span class="hl std">=</span><span class="hl num">TRUE</span><span class="hl std">)</span>
<span class="hl kwd">table</span><span class="hl std">(</span><span class="hl kwd">names</span><span class="hl std">(obs))</span>
</pre></div>
<div class="output"><pre class="knitr r">## 
##                                game                        game//inning        game//inning//bottom//action 
##                                   2                                  18                                  18 
##         game//inning//bottom//atbat  game//inning//bottom//atbat//pitch     game//inning//bottom//atbat//po 
##                                  76                                 255                                   6 
## game//inning//bottom//atbat//runner           game//inning//top//action            game//inning//top//atbat 
##                                  66                                  15                                  82 
##     game//inning//top//atbat//pitch        game//inning//top//atbat//po    game//inning//top//atbat//runner 
##                                 321                                  10                                  77
</pre></div>
</div></div>


This output tells us that 255 pitches were thrown in the bottom inning and 321 were thrown in the top inning during these two games. Eventually, we will want to combine observations named `'game//inning//bottom//atbat//pitch'` and `'game//inning//top//atbat//pitch'` into the same table since they share XML attributes (in other words, the observations share variables). **XML2R** has another function `collapse_obs` that can be used to aggregate observations into the same table based on their names. 

Renaming observations
--------------------------

Before aggregating observations into a collection of tables, we sometimes need to `re_name` observations. As mentioned previously, we have some observations with different names, but they should be put into the same table. By passing these names (that should be considered to be on the same level) to the `equiv` argument, `re_name` will automatically determine the difference in the naming scheme and suppress that difference.

<div class="chunk" id="re_name"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">tmp</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">re_name</span><span class="hl std">(obs,</span> <span class="hl kwc">equiv</span><span class="hl std">=</span><span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;game//inning//top//atbat//pitch&quot;</span><span class="hl std">,</span>
                           <span class="hl str">&quot;game//inning//bottom//atbat//pitch&quot;</span><span class="hl std">),</span> <span class="hl kwc">diff.name</span><span class="hl std">=</span><span class="hl str">&quot;side&quot;</span><span class="hl std">)</span>
<span class="hl std">tmp</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">re_name</span><span class="hl std">(tmp,</span> <span class="hl kwc">equiv</span><span class="hl std">=</span><span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;game//inning//top//atbat//runner&quot;</span><span class="hl std">,</span>
                           <span class="hl str">&quot;game//inning//bottom//atbat//runner&quot;</span><span class="hl std">),</span> <span class="hl kwc">diff.name</span><span class="hl std">=</span><span class="hl str">&quot;side&quot;</span><span class="hl std">)</span>
<span class="hl std">tmp</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">re_name</span><span class="hl std">(tmp,</span> <span class="hl kwc">equiv</span><span class="hl std">=</span><span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;game//inning//top//atbat//po&quot;</span><span class="hl std">,</span>
                           <span class="hl str">&quot;game//inning//bottom//atbat//po&quot;</span><span class="hl std">),</span> <span class="hl kwc">diff.name</span><span class="hl std">=</span><span class="hl str">&quot;side&quot;</span><span class="hl std">)</span>
<span class="hl std">tmp</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">re_name</span><span class="hl std">(tmp,</span> <span class="hl kwc">equiv</span><span class="hl std">=</span><span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;game//inning//top//atbat&quot;</span><span class="hl std">,</span>
                           <span class="hl str">&quot;game//inning//bottom//atbat&quot;</span><span class="hl std">),</span> <span class="hl kwc">diff.name</span><span class="hl std">=</span><span class="hl str">&quot;side&quot;</span><span class="hl std">)</span>
<span class="hl std">obs2</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">re_name</span><span class="hl std">(tmp,</span> <span class="hl kwc">equiv</span><span class="hl std">=</span><span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;game//inning//top//action&quot;</span><span class="hl std">,</span>
                           <span class="hl str">&quot;game//inning//bottom//action&quot;</span><span class="hl std">),</span> <span class="hl kwc">diff.name</span><span class="hl std">=</span><span class="hl str">&quot;side&quot;</span><span class="hl std">)</span>
<span class="hl kwd">table</span><span class="hl std">(</span><span class="hl kwd">names</span><span class="hl std">(obs2))</span>
</pre></div>
<div class="output"><pre class="knitr r">## 
##                        game                game//inning        game//inning//action         game//inning//atbat 
##                           2                          18                          33                         158 
##  game//inning//atbat//pitch     game//inning//atbat//po game//inning//atbat//runner 
##                         576                          16                         143
</pre></div>
</div></div>


Now we see that 576 pitches were thrown in total. The information we removed is not lost; however, as a new column is appended to the end of each relevant observation. For example, notice how the side column contains the part of the name we just removed:

<div class="chunk" id="look-ma"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">obs2[</span><span class="hl kwd">grep</span><span class="hl std">(</span><span class="hl str">&quot;game//inning//atbat//po&quot;</span><span class="hl std">,</span> <span class="hl kwd">names</span><span class="hl std">(obs2))][</span><span class="hl num">1</span><span class="hl opt">:</span><span class="hl num">2</span><span class="hl std">]</span>
</pre></div>
<div class="output"><pre class="knitr r">## $`game//inning//atbat//po`
##      des                 
## [1,] "Pickoff Attempt 1B"
##      url                                                                                                                    
## [1,] "http://gd2.mlb.com/components/game/mlb/year_2013/month_06/day_14/gid_2013_06_14_phimlb_colmlb_1/inning/inning_all.xml"
##      side    
## [1,] "bottom"
## 
## $`game//inning//atbat//po`
##      des                 
## [1,] "Pickoff Attempt 1B"
##      url                                                                                                                    
## [1,] "http://gd2.mlb.com/components/game/mlb/year_2013/month_06/day_14/gid_2013_06_14_phimlb_colmlb_1/inning/inning_all.xml"
##      side 
## [1,] "top"
</pre></div>
</div></div>



Linking observations
----------------------------

After all that renaming, we now have 7 different levels of observations. Let's examine observations on the `game\\inning` level:

<div class="chunk" id="inning"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">obs2[</span><span class="hl kwd">grep</span><span class="hl std">(</span><span class="hl str">&quot;^game//inning$&quot;</span><span class="hl std">,</span> <span class="hl kwd">names</span><span class="hl std">(obs2))][</span><span class="hl num">1</span><span class="hl opt">:</span><span class="hl num">3</span><span class="hl std">]</span>
</pre></div>
<div class="output"><pre class="knitr r">## $`game//inning`
##      num away_team home_team next
## [1,] "1" "phi"     "col"     "Y" 
##      url                                                                                                                    
## [1,] "http://gd2.mlb.com/components/game/mlb/year_2013/month_06/day_14/gid_2013_06_14_phimlb_colmlb_1/inning/inning_all.xml"
## 
## $`game//inning`
##      num away_team home_team next
## [1,] "2" "phi"     "col"     "Y" 
##      url                                                                                                                    
## [1,] "http://gd2.mlb.com/components/game/mlb/year_2013/month_06/day_14/gid_2013_06_14_phimlb_colmlb_1/inning/inning_all.xml"
## 
## $`game//inning`
##      num away_team home_team next
## [1,] "3" "phi"     "col"     "Y" 
##      url                                                                                                                    
## [1,] "http://gd2.mlb.com/components/game/mlb/year_2013/month_06/day_14/gid_2013_06_14_phimlb_colmlb_1/inning/inning_all.xml"
</pre></div>
</div></div>


Before we aggregate observations into tables, we should preserve the parent-to-child relationships in the XML lineage. For example, we want to be able to identify in what inning a particular pitch was thrown.

<div class="chunk" id="add_key"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">obswkey</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">add_key</span><span class="hl std">(obs2,</span> <span class="hl kwc">parent</span> <span class="hl std">=</span> <span class="hl str">&quot;game//inning&quot;</span><span class="hl std">,</span> <span class="hl kwc">recycle</span> <span class="hl std">=</span> <span class="hl str">&quot;num&quot;</span><span class="hl std">,</span> <span class="hl kwc">key.name</span> <span class="hl std">=</span> <span class="hl str">&quot;inning&quot;</span><span class="hl std">)</span>
</pre></div>
</div></div>


As it turns out, the `away_team` and `home_team` columns are redundant as this information is embeded in the `url` column. Thus, there is only one other informative attribute on this level which is `next`. By recycling this value to all of its descendants as well, we remove any need to retain a `game//inning` table.

<div class="chunk" id="add_key2"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">obswkey</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">add_key</span><span class="hl std">(obswkey,</span> <span class="hl kwc">parent</span> <span class="hl std">=</span> <span class="hl str">&quot;game//inning&quot;</span><span class="hl std">,</span> <span class="hl kwc">recycle</span> <span class="hl std">=</span> <span class="hl str">&quot;next&quot;</span><span class="hl std">)</span>
</pre></div>
</div></div>


It is also imperative that we can identify which `atbat` a particular `pitch`, `runner`, and `po` belongs to. This can be done as follows:

<div class="chunk" id="add_key3"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">obswkey</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">add_key</span><span class="hl std">(obswkey,</span> <span class="hl kwc">parent</span> <span class="hl std">=</span> <span class="hl str">&quot;game//inning//atbat&quot;</span><span class="hl std">,</span> <span class="hl kwc">recycle</span> <span class="hl std">=</span> <span class="hl str">&quot;num&quot;</span><span class="hl std">)</span>
</pre></div>
</div></div>


Collapsing observations
----------------------------

Finally, we are in a position to pool together observations that have a common name. The `collapse_obs` function achieves this by row binding observations together and returning a list of matrices. Note that `collapse_obs` does not require that observations from the same level to have the same set of variables in order to be binded into a common table. In the case where variables are missing, `NA`s will be used as the value.

<div class="chunk" id="collapse"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">tables</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">collapse_obs</span><span class="hl std">(obswkey)</span>
<span class="hl com"># As mentioned before, we don't need the 'inning' table</span>
<span class="hl std">tables</span> <span class="hl kwb">&lt;-</span> <span class="hl std">tables[</span><span class="hl opt">-</span><span class="hl kwd">grep</span><span class="hl std">(</span><span class="hl str">&quot;^game//inning$&quot;</span><span class="hl std">,</span> <span class="hl kwd">names</span><span class="hl std">(tables))]</span>
<span class="hl std">table.names</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;game&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;action&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;atbat&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;pitch&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;po&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;runner&quot;</span><span class="hl std">)</span>
<span class="hl std">tables</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">setNames</span><span class="hl std">(tables, table.names)</span>
<span class="hl kwd">head</span><span class="hl std">(tables[[</span><span class="hl str">&quot;runner&quot;</span><span class="hl std">]])</span>
</pre></div>
<div class="output"><pre class="knitr r">##      id       start end  event          score rbi earned
## [1,] "471865" ""    ""   "Home Run"     "T"   "T" "T"   
## [2,] "429667" ""    "1B" "Walk"         NA    NA  NA    
## [3,] "429667" "1B"  "2B" "Hit By Pitch" NA    NA  NA    
## [4,] "435623" ""    "1B" "Hit By Pitch" NA    NA  NA    
## [5,] "435623" "1B"  ""   "Flyout"       NA    NA  NA    
## [6,] "429667" "2B"  ""   "Flyout"       NA    NA  NA    
##      url                                                                                                                    
## [1,] "http://gd2.mlb.com/components/game/mlb/year_2013/month_06/day_14/gid_2013_06_14_phimlb_colmlb_1/inning/inning_all.xml"
## [2,] "http://gd2.mlb.com/components/game/mlb/year_2013/month_06/day_14/gid_2013_06_14_phimlb_colmlb_1/inning/inning_all.xml"
## [3,] "http://gd2.mlb.com/components/game/mlb/year_2013/month_06/day_14/gid_2013_06_14_phimlb_colmlb_1/inning/inning_all.xml"
## [4,] "http://gd2.mlb.com/components/game/mlb/year_2013/month_06/day_14/gid_2013_06_14_phimlb_colmlb_1/inning/inning_all.xml"
## [5,] "http://gd2.mlb.com/components/game/mlb/year_2013/month_06/day_14/gid_2013_06_14_phimlb_colmlb_1/inning/inning_all.xml"
## [6,] "http://gd2.mlb.com/components/game/mlb/year_2013/month_06/day_14/gid_2013_06_14_phimlb_colmlb_1/inning/inning_all.xml"
##      side     inning next num 
## [1,] "bottom" "1"    "Y"  "6" 
## [2,] "top"    "2"    "Y"  "8" 
## [3,] "top"    "2"    "Y"  "9" 
## [4,] "top"    "2"    "Y"  "9" 
## [5,] "top"    "2"    "Y"  "12"
## [6,] "top"    "2"    "Y"  "12"
</pre></div>
</div></div>


At this point, you probably want to save these tables. I strongly recommend writing to a database if you plan on repeatedly querying your data. There are multiple packages that allow one to write tables to a database in R including: [RSQLite](http://cran.r-project.org/web/packages/RSQLite/index.html), [RMySQL](http://cran.r-project.org/web/packages/RMySQL/index.html), [rmongodb](http://cran.r-project.org/web/packages/rmongodb/index.html), and [DBI](http://cran.r-project.org/web/packages/DBI/index.html). Here is a simple way to create a SQLite database using the [dplyr](http://cran.r-project.org/web/packages/dplyr/index.html) package and copy our tables to that database:

<div class="chunk" id="lies"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">library</span><span class="hl std">(dplyr)</span>
<span class="hl std">db</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">src_sqlite</span><span class="hl std">(</span><span class="hl str">&quot;my_db.sqlite3&quot;</span><span class="hl std">)</span>
<span class="hl kwa">for</span> <span class="hl std">(i</span> <span class="hl kwa">in</span> <span class="hl kwd">names</span><span class="hl std">(tables))</span> <span class="hl kwd">copy_to</span><span class="hl std">(db,</span> <span class="hl kwc">df</span> <span class="hl std">= tables[[i]],</span> <span class="hl kwc">name</span> <span class="hl std">= i)</span>
</pre></div>
</div></div>


