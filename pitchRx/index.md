<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{A Markdown Vignette with knitr}
-->

Introduction to pitchRx package
====================================

The  [pitchRx package](https://github.com/cpsievert/pitchRx) provides tools for collecting Major League Baseball (MLB) Gameday data and visualizing  [PITCHf/x](http://en.wikipedia.org/wiki/PITCHf/x). This page give a few examples of how to use it. You can view the source file used to generate this web page [here](https://github.com/cpsievert/cpsievert.github.com/blob/master/pitchRx/index.Rmd).







Data Collection
----------------------------

### Collecting data in bulk

**pitchRx** makes it easy to collect Gameday data directly from the source. The main scraping function in **pitchRx**, `scrape`, currently supports four different types of files. Each of the four types have a common file name ending: [miniscoreboard.xml](http://gd2.mlb.com/components/game/mlb/year_2012/month_05/day_01/miniscoreboard.xml), [players.xml](http://gd2.mlb.com/components/game/mlb/year_2012/month_05/day_01/gid_2012_05_01_arimlb_wasmlb_1/players.xml), [inning/inning_all.xml](http://gd2.mlb.com/components/game/mlb/year_2012/month_05/day_01/gid_2012_05_01_arimlb_wasmlb_1/inning/inning_all.xml), and [inning/inning_hit.xml](http://gd2.mlb.com/components/game/mlb/year_2012/month_05/day_01/gid_2012_05_01_arimlb_wasmlb_1/inning/inning_hit.xml). `scrape` extracts information from these files and returns a named list of data frames. 

<div class="chunk" id="scrape"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">library</span>(pitchRx)
files &lt;- <span class="hl kwd">c</span>(<span class="hl str">&quot;miniscoreboard.xml&quot;</span>, <span class="hl str">&quot;players.xml&quot;</span>
          <span class="hl str">&quot;inning/inning_all.xml&quot;</span>, <span class="hl str">&quot;inning/inning_hit.xml&quot;</span>)
dat &lt;- <span class="hl kwd">scrape</span>(start=<span class="hl str">&quot;2011-01-01&quot;</span>, end=<span class="hl str">&quot;2011-12-31&quot;</span>, suffix = files)
</pre></div>
</div></div>


In this example, `dat` is a very large object. It is a list of 10 data frames and the data frame `dat$pitch` alone contains more than a million rows and about 45 columns! For this reason, if the user wants to collect data in bulk, it is highly recommended to query on a bi-annual basis and append the results to a database. There are many database options, but here is a simple example of how to append the `dat$pitch` and `dat$atbat` tables to a [MySQL](http://en.wikipedia.org/wiki/MySQL) database using the [RMySQL](http://cran.r-project.org/web/packages/RMySQL/index.html) package.

<div class="chunk" id="MySQL"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">library</span><span class="hl std">(RMySQL)</span>
<span class="hl std">drv</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">dbDriver</span><span class="hl std">(</span><span class="hl str">&quot;MySQL&quot;</span><span class="hl std">)</span>
<span class="hl std">MLB</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">dbConnect</span><span class="hl std">(drv,</span> <span class="hl kwc">user</span><span class="hl std">=</span><span class="hl str">&quot;your_user_name&quot;</span><span class="hl std">,</span> <span class="hl kwc">password</span><span class="hl std">=</span><span class="hl str">&quot;your_password&quot;</span><span class="hl std">,</span>
                 <span class="hl kwc">dbname</span><span class="hl std">=</span><span class="hl str">&quot;your_database_name&quot;</span><span class="hl std">,</span> <span class="hl kwc">host</span><span class="hl std">=</span><span class="hl str">&quot;your_host&quot;</span><span class="hl std">)</span>
<span class="hl kwd">dbWriteTable</span><span class="hl std">(MLB,</span> <span class="hl kwc">value</span> <span class="hl std">= dat</span><span class="hl opt">$</span><span class="hl std">pitch,</span> <span class="hl kwc">name</span> <span class="hl std">=</span> <span class="hl str">&quot;pitch&quot;</span><span class="hl std">,</span> <span class="hl kwc">row.names</span> <span class="hl std">=</span> <span class="hl num">FALSE</span><span class="hl std">,</span> <span class="hl kwc">append</span> <span class="hl std">=</span> <span class="hl num">TRUE</span><span class="hl std">)</span>
<span class="hl kwd">dbWriteTable</span><span class="hl std">(MLB,</span> <span class="hl kwc">value</span> <span class="hl std">= dat</span><span class="hl opt">$</span><span class="hl std">atbat,</span> <span class="hl kwc">name</span> <span class="hl std">=</span> <span class="hl str">&quot;atbat&quot;</span><span class="hl std">,</span> <span class="hl kwc">row.names</span> <span class="hl std">=</span> <span class="hl num">FALSE</span><span class="hl std">,</span> <span class="hl kwc">append</span> <span class="hl std">=</span> <span class="hl num">TRUE</span><span class="hl std">)</span>
</pre></div>
</div></div>


No matter how you're storing data, you will probably want to join `data$atbat` with `data$pitch` at some point. For instance, lets combine all information on the 'at-bat and 'pitch' level for every 'four-seam' and 'cutting' fastball thrown by Mariano Rivera and Phil Hughes during the 2011 season:

<div class="chunk" id="joining"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">names</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;Mariano Rivera&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;Phil Hughes&quot;</span><span class="hl std">)</span>
<span class="hl std">atbats</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">subset</span><span class="hl std">(dat</span><span class="hl opt">$</span><span class="hl std">atbat, pitcher_name</span> <span class="hl opt">==</span> <span class="hl std">name)</span>
<span class="hl std">pitchFX</span> <span class="hl kwb">&lt;-</span> <span class="hl std">plyr::</span><span class="hl kwd">join</span><span class="hl std">(atbats, dat</span><span class="hl opt">$</span><span class="hl std">pitch,</span> <span class="hl kwc">by</span><span class="hl std">=</span><span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;num&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;url&quot;</span><span class="hl std">),</span> <span class="hl kwc">type</span><span class="hl std">=</span><span class="hl str">&quot;inner&quot;</span><span class="hl std">)</span>
<span class="hl std">pitches</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">subset</span><span class="hl std">(pitchFX, pitch_type</span> <span class="hl opt">==</span> <span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;FF&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;FC&quot;</span><span class="hl std">))</span>
</pre></div>
</div></div>


The `pitches` object is used as an example data and can be accessed by simply entering `data(pitches, package="pitchRx")` in your console. If you're using you're MySQL database, you could also recreate `pitches` using this query (if you have multiple years in your database, you'll want to add criteria for the year of interest):

<div class="chunk" id="sql"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">pitches</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">dbGetQuery</span><span class="hl std">(MLB,</span> <span class="hl str">&quot;SELECT * FROM atbat INNER JOIN pitch 
                      ON (atbat.num = pitch.num AND atbat.url = pitch.url) 
                      WHERE atbat.pitcher_name = 'Mariano Rivera' 
                      OR atbat.pitcher_name = 'Phil Hughes'&quot;</span><span class="hl std">)</span>
</pre></div>
</div></div>


### Collecting data by Gameday IDs

`scrape` also has an option named `game.ids` that allows one to query specific game(s) rather than all games between two dates. For example, suppose I want all PITCHf/x data on every game player by the Minnesota Twins in 2011. I can find the relevant Gameday IDs using information from the built in `gids` object:

<div class="chunk" id="gids"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">data</span><span class="hl std">(gids,</span> <span class="hl kwc">package</span><span class="hl std">=</span><span class="hl str">&quot;pitchRx&quot;</span><span class="hl std">)</span>
<span class="hl std">twins11</span> <span class="hl kwb">&lt;-</span> <span class="hl std">gids[</span><span class="hl kwd">grepl</span><span class="hl std">(</span><span class="hl str">&quot;min&quot;</span><span class="hl std">, gids)</span> <span class="hl opt">&amp;</span> <span class="hl kwd">grepl</span><span class="hl std">(</span><span class="hl str">&quot;2011&quot;</span><span class="hl std">, gids)]</span>
<span class="hl kwd">head</span><span class="hl std">(twins11)</span>
</pre></div>
<div class="output"><pre class="knitr r">## [1] "gid_2011_02_27_bosmlb_minmlb_1" "gid_2011_02_28_minmlb_bosmlb_1"
## [3] "gid_2011_03_01_bosmlb_minmlb_1" "gid_2011_03_02_minmlb_pitmlb_1"
## [5] "gid_2011_03_03_minmlb_balmlb_1" "gid_2011_03_04_tbamlb_minmlb_1"
</pre></div>
</div></div>


<div class="chunk" id="scrape2"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">dat</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">scrape</span><span class="hl std">(</span><span class="hl kwc">game.ids</span><span class="hl std">=twins11)</span>
</pre></div>
</div></div>


### Building your own custom scraper

The rest of this section demonstrates how to build a custom Gameday scraper using [XML2R](https://github.com/cpsievert/XML2R) (`scrape` is built on top of this package). For a more detailed look at **XML2R** [see here](http://cpsievert.github.io/XML2R/). 

#### Obtaining urls

The first (and probably most difficult) step of building a scraper is to obtain the file names of interest. `pitchRx::makeUrls` is convenient for constructing urls that are specific to the [Gameday website](http://gd2.mlb.com/components/game/mlb/). The default functionality of `makeUrls` is to "infer" all the Gameday links that exists between two dates. For example:

<div class="chunk" id="makeUrls"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">urls</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">makeUrls</span><span class="hl std">(</span><span class="hl kwc">start</span><span class="hl std">=</span><span class="hl str">&quot;2012-06-01&quot;</span><span class="hl std">,</span> <span class="hl kwc">end</span><span class="hl std">=</span><span class="hl str">&quot;2012-06-01&quot;</span><span class="hl std">)</span>
<span class="hl std">urls</span>
</pre></div>
<div class="output"><pre class="knitr r">##  [1] "http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_arimlb_sdnmlb_1"
##  [2] "http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_atlmlb_wasmlb_1"
##  [3] "http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_balmlb_tbamlb_1"
##  [4] "http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_bosmlb_tormlb_1"
##  [5] "http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_chnmlb_sfnmlb_1"
##  [6] "http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_cinmlb_houmlb_1"
##  [7] "http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_lanmlb_colmlb_1"
##  [8] "http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_miamlb_phimlb_1"
##  [9] "http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_minmlb_clemlb_1"
## [10] "http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_nyamlb_detmlb_1"
## [11] "http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_oakmlb_kcamlb_1"
## [12] "http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_pitmlb_milmlb_1"
## [13] "http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_seamlb_chamlb_1"
## [14] "http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_slnmlb_nynmlb_1"
## [15] "http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_texmlb_anamlb_1"
</pre></div>
</div></div>


As a side note, `makeUrls` can also be tricked into constructing the urls specific to each day:

<div class="chunk" id="makeUrls2"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">makeUrls</span><span class="hl std">(</span><span class="hl kwc">start</span><span class="hl std">=</span><span class="hl str">&quot;2012-06-01&quot;</span><span class="hl std">,</span> <span class="hl kwc">end</span><span class="hl std">=</span><span class="hl str">&quot;2012-06-05&quot;</span><span class="hl std">,</span> <span class="hl kwc">gid</span><span class="hl std">=</span><span class="hl str">&quot;&quot;</span><span class="hl std">)</span>
</pre></div>
<div class="output"><pre class="knitr r">## [1] "http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01"
## [2] "http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_02"
## [3] "http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_03"
## [4] "http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_04"
## [5] "http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_05"
</pre></div>
</div></div>


#### Using XML2R

The `urls` object can be used to obtain the file names for every [bench.xml](http://gd2.mlb.com/components/game/mlb/year_2011/month_06/day_12/gid_2011_06_12_texmlb_minmlb_1/bench.xml) file available for June 1st, 2012.

<div class="chunk" id="paste"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">bench.urls</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">paste0</span><span class="hl std">(urls,</span> <span class="hl str">&quot;/bench.xml&quot;</span><span class="hl std">)</span>
</pre></div>
</div></div>


Next, load the **XML2R** library and use the `XML2Obs` function:

<div class="chunk" id="XML2Obs"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">library</span><span class="hl std">(XML2R)</span>
<span class="hl std">obs</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">XML2Obs</span><span class="hl std">(bench.urls,</span> <span class="hl kwc">as.equiv</span><span class="hl std">=</span><span class="hl num">TRUE</span><span class="hl std">,</span> <span class="hl kwc">quiet</span><span class="hl std">=</span><span class="hl num">TRUE</span><span class="hl std">)</span>
<span class="hl kwd">unique</span><span class="hl std">(</span><span class="hl kwd">names</span><span class="hl std">(obs))</span>
</pre></div>
<div class="output"><pre class="knitr r">## [1] "bench//away//batters//batter"   "bench//away//pitchers//pitcher"
## [3] "bench//away"                    "bench//home//batters//batter"  
## [5] "bench//home//pitchers//pitcher" "bench//home"
</pre></div>
</div></div>


In short, the `obs` object is a named list and each element corresponds to an "observation" or "record" of data. The `names` of `obs` keeps track of the "level" of information where each observation was obtained. This is important because we eventually `collapse` observations into separate tables based on these levels. In this example, there are currently six different levels of observations. There would have been many more if the `as.equiv` option was `FALSE` since this adds a prefix to `names(obs)` to help differentiate observations that were obtained from different files. This can be useful if you have to `add_key`s for each file. In this example, we don't need to use `add_key` at all, but it can useful in many other cases (see the [XML2R page](https://github.com/cpsievert/XML2R)).

In this example, we could probably get away with not adding a key to link observations between tables, but we will for demonstration's sake. The `add_key` function will add an additional column to each relevant observation that can be used later for merging/joining purposes.

<div class="chunk" id="add_key"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">tmp</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">add_key</span><span class="hl std">(obs,</span> <span class="hl kwc">parent</span><span class="hl std">=</span><span class="hl str">&quot;bench//away&quot;</span><span class="hl std">,</span> <span class="hl kwc">key.name</span><span class="hl std">=</span><span class="hl str">&quot;away_key&quot;</span><span class="hl std">)</span>
<span class="hl std">obswkey</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">add_key</span><span class="hl std">(tmp,</span> <span class="hl kwc">parent</span><span class="hl std">=</span><span class="hl str">&quot;bench//home&quot;</span><span class="hl std">,</span> <span class="hl kwc">key.name</span><span class="hl std">=</span><span class="hl str">&quot;home_key&quot;</span><span class="hl std">)</span>
</pre></div>
</div></div>


Note that it would be cumbersome to store observations from the `'bench//away//pitchers//pitcher'` level in a separate table from the `'bench//home//pitchers//pitcher'` (and same for the batter case). This is where the `re_name` function becomes useful:

<div class="chunk" id="re_name"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">tmp</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">re_name</span><span class="hl std">(obs,</span> <span class="hl kwc">equiv</span><span class="hl std">=</span><span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;bench//away//batters//batter&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;bench//home//batters//batter&quot;</span><span class="hl std">),</span>
               <span class="hl kwc">diff.name</span><span class="hl std">=</span><span class="hl str">&quot;location&quot;</span><span class="hl std">)</span>
<span class="hl std">obs2</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">re_name</span><span class="hl std">(tmp,</span> <span class="hl kwc">equiv</span><span class="hl std">=</span><span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;bench//away//pitchers//pitcher&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;bench//home//pitchers//pitcher&quot;</span><span class="hl std">),</span>
               <span class="hl kwc">diff.name</span><span class="hl std">=</span><span class="hl str">&quot;location&quot;</span><span class="hl std">)</span>
<span class="hl kwd">unique</span><span class="hl std">(</span><span class="hl kwd">names</span><span class="hl std">(obs2))</span>
</pre></div>
<div class="output"><pre class="knitr r">## [1] "bench//batters//batter"   "bench//pitchers//pitcher"
## [3] "bench//away"              "bench//home"
</pre></div>
</div></div>


Note how the `re_name` function automatically determines the difference in the names supplied to `equiv` and suppresses that difference in the new name. This information is not lost; however, as this value is appended as an additional column (location) for each observation:

<div class="chunk" id="re_name2"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">obs2[</span><span class="hl kwd">c</span><span class="hl std">(</span><span class="hl num">1</span><span class="hl std">,</span> <span class="hl num">20</span><span class="hl std">)]</span>
</pre></div>
<div class="output"><pre class="knitr r">## $`bench//batters//batter`
##      id       last      b   pos  avg    g   ab   r   h   hr  rbi sb 
## [1,] "458679" "Bell, J" "S" "3B" ".176" "6" "17" "1" "3" "1" "3" "0"
##      url                                                                                                        
## [1,] "http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_arimlb_sdnmlb_1/bench.xml"
##      location
## [1,] "away"  
## 
## $`bench//pitchers//pitcher`
##      id       last     t   w   l   era    g   sv  ip    h   bb  so 
## [1,] "461212" "Palmer" "R" "0" "0" "9.00" "3" "0" "2.0" "2" "2" "2"
##      url                                                                                                        
## [1,] "http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_arimlb_sdnmlb_1/bench.xml"
##      location
## [1,] "home"
</pre></div>
</div></div>


Simply because of the structure of this XML file, we can use `re_name` again to have a key to merge information on the "bench" level with the "batter/pitcher" level:

<div class="chunk" id="re_name3"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">obs3</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">re_name</span><span class="hl std">(obs2,</span> <span class="hl kwc">equiv</span><span class="hl std">=</span><span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;bench//away&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;bench//home&quot;</span><span class="hl std">),</span> <span class="hl kwc">diff.name</span><span class="hl std">=</span><span class="hl str">&quot;location&quot;</span><span class="hl std">)</span>
</pre></div>
</div></div>


Finally, we can `collapse` the list of observations into a list of matrices and `merge` them accordingly to obtain a `pitcher` and `batter` data frame:

<div class="chunk" id="collapse"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">dat</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">collapse</span><span class="hl std">(obs3)</span>
<span class="hl std">batter</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">merge</span><span class="hl std">(</span><span class="hl kwc">x</span><span class="hl std">=dat[[</span><span class="hl str">&quot;bench//batters//batter&quot;</span><span class="hl std">]],</span> <span class="hl kwc">y</span><span class="hl std">=dat[[</span><span class="hl str">&quot;bench&quot;</span><span class="hl std">]],</span> <span class="hl kwc">by</span><span class="hl std">=</span><span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;url&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;location&quot;</span><span class="hl std">))</span>
<span class="hl kwd">head</span><span class="hl std">(batter)</span>
</pre></div>
<div class="output"><pre class="knitr r">##                                                                                                         url
## 1 http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_arimlb_sdnmlb_1/bench.xml
## 2 http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_arimlb_sdnmlb_1/bench.xml
## 3 http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_arimlb_sdnmlb_1/bench.xml
## 4 http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_arimlb_sdnmlb_1/bench.xml
## 5 http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_arimlb_sdnmlb_1/bench.xml
## 6 http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_arimlb_sdnmlb_1/bench.xml
##   location     id         last b pos  avg  g  ab  r  h hr rbi sb tid
## 1     away 458679      Bell, J S  3B .176  6  17  1  3  1   3  0 ari
## 2     away 111072    Blanco, H R   C .205 12  39  2  8  0   2  1 ari
## 3     away 430585        Kubel L  LF .297 46 165 17 49  4  23  1 ari
## 4     away 150348 McDonald, Jo R  SS .308 24  65  8 20  3   9  0 ari
## 5     away 407489      Overbay L  1B .345 27  58  7 20  2   6  0 ari
## 6     home 434633    Baker, Jo L   C .235 17  51  2 12  0   5  2 sdn
</pre></div>
<div class="source"><pre class="knitr r"><span class="hl std">pitcher</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">merge</span><span class="hl std">(</span><span class="hl kwc">x</span><span class="hl std">=dat[[</span><span class="hl str">&quot;bench//pitchers//pitcher&quot;</span><span class="hl std">]],</span> <span class="hl kwc">y</span><span class="hl std">=dat[[</span><span class="hl str">&quot;bench&quot;</span><span class="hl std">]],</span> <span class="hl kwc">by</span><span class="hl std">=</span><span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;url&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;location&quot;</span><span class="hl std">))</span>
<span class="hl kwd">head</span><span class="hl std">(pitcher)</span>
</pre></div>
<div class="output"><pre class="knitr r">##                                                                                                         url
## 1 http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_arimlb_sdnmlb_1/bench.xml
## 2 http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_arimlb_sdnmlb_1/bench.xml
## 3 http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_arimlb_sdnmlb_1/bench.xml
## 4 http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_arimlb_sdnmlb_1/bench.xml
## 5 http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_arimlb_sdnmlb_1/bench.xml
## 6 http://gd2.mlb.com/components/game/mlb/year_2012/month_06/day_01/gid_2012_06_01_arimlb_sdnmlb_1/bench.xml
##   location     id       last t w l  era  g sv   ip  h bb so tid
## 1     away 444520    Breslow L 1 0 2.13 23  0 25.1 16 10 22 ari
## 2     away 502239     Cahill R 2 5 3.96 10  0 61.1 55 26 42 ari
## 3     away 518567 Collmenter R 0 2 6.75 10  0 30.2 38  6 25 ari
## 4     away 543339  Hudson, D R 1 1 5.48  4  0 23.0 27  9 15 ari
## 5     away 453178 Kennedy, I R 4 5 4.26 11  0 69.2 74 18 59 ari
## 6     away 407816       Putz R 0 3 6.35 18 11 17.0 20  4 20 ari
</pre></div>
</div></div>



PITCHf/x Visualization
--------------------

### 2D animation

Let's animate the `pitches` data frame created in the previous section on a series of 2D scatterplots. The viewer should notice that as the animation progresses, pitches coming closer to them (that is, imagine you are the umpire/catcher - watching the pitcher throw directly at you). In the animation below, the horizontal and vertical location of `pitches` is plotted every tenth of a second until they reach home plate (in real time). Since looking at animations in real time can be painful, this animation delays the time between each frame to a half a second.




<div class="chunk" id="ani"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">animateFX</span><span class="hl std">(pitches,</span> <span class="hl kwc">layer</span><span class="hl std">=</span><span class="hl kwd">list</span><span class="hl std">(</span><span class="hl kwd">facet_grid</span><span class="hl std">(pitcher_name</span><span class="hl opt">~</span><span class="hl std">stand,</span> <span class="hl kwc">labeller</span> <span class="hl std">= label_both),</span> <span class="hl kwd">theme_bw</span><span class="hl std">(),</span> <span class="hl kwd">coord_equal</span><span class="hl std">()))</span>
</pre></div>
<div align = "center">
 <embed width="864" height="864" name="plugin" src="figure/ani.swf" type="application/x-shockwave-flash"> 
</div></div></div>


To avoid a cluttered animation, the `avg.by` option averages the trajectory for each unique value of the variable supplied to `avg.by`.

<div class="chunk" id="ani2"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">animateFX</span><span class="hl std">(pitches,</span> <span class="hl kwc">avg.by</span><span class="hl std">=</span><span class="hl str">&quot;pitch_types&quot;</span><span class="hl std">,</span> <span class="hl kwc">layer</span><span class="hl std">=</span><span class="hl kwd">list</span><span class="hl std">(</span><span class="hl kwd">facet_grid</span><span class="hl std">(pitcher_name</span><span class="hl opt">~</span><span class="hl std">stand,</span> <span class="hl kwc">labeller</span> <span class="hl std">= label_both),</span> <span class="hl kwd">theme_bw</span><span class="hl std">(),</span> <span class="hl kwd">coord_equal</span><span class="hl std">()))</span>
</pre></div>
<div align = "center">
 <embed width="864" height="864" name="plugin" src="figure/ani2.swf" type="application/x-shockwave-flash"> 
</div></div></div>


Note that when using `animateFX`, the user may want to wrap the expression with `animation::saveHTML` to view the result in a web browser. If you want to include the animation in a document, [knitr](http://yihui.name/knitr/options#chunk_options)'s `fig.show="animate"` chunk option is very useful. 

### Interactive 3D plots

**pitchRx** also makes use of **rgl** graphics. If I want a more revealing look as Mariano Rivera's pitches, I can subset the `pitches` data frame accordingly. Note that the plot below is interactive, so make sure you have JavaScript & [WebGL](http://get.webgl.org/) enabled (if you do, go ahead - click and drag)!

<div class="chunk" id="demo"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">Rivera</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">subset</span><span class="hl std">(pitches, pitcher_name</span><span class="hl opt">==</span><span class="hl str">&quot;Mariano Rivera&quot;</span><span class="hl std">)</span>
<span class="hl kwd">interactiveFX</span><span class="hl std">(Rivera)</span>
</pre></div>
</div></div>


<iframe src="http://cpsievert.github.io/pitchRx/rgl1/" height="600" width="1200"></iframe>

### Strike-zones

#### Raw strike-zone densities

Strike-zones capture pitch locations at the moment they cross the plate. `strikeFX`'s default functionality is to plot the relevant *raw density*. Here is the density of called strikes thrown by Rivera and Hughes in 2011 (for both right and left-handed batters).

<div class="chunk" id="strike"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">strikes</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">subset</span><span class="hl std">(pitches, des</span> <span class="hl opt">==</span> <span class="hl str">&quot;Called Strike&quot;</span><span class="hl std">)</span>
<span class="hl kwd">strikeFX</span><span class="hl std">(strikes,</span> <span class="hl kwc">geom</span><span class="hl std">=</span><span class="hl str">&quot;tile&quot;</span><span class="hl std">,</span> <span class="hl kwc">layer</span><span class="hl std">=</span><span class="hl kwd">facet_grid</span><span class="hl std">(.</span><span class="hl opt">~</span><span class="hl std">stand))</span>
</pre></div>
</div><div class="rimage center"><img src="figure/strike.png" title="plot of chunk strike" alt="plot of chunk strike" class="plot" /></div></div>


`strikeFX` allows one to easily manipulate the density of interest through two parameters: `density1` and `density2`. If these densities are identical, the density is defined accordingly. This is useful for avoiding repetitive subsetting of data frames. For example, one could use the following to also generate the density of called strikes shown previously.

<div class="chunk" id="strike2"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">strikeFX</span><span class="hl std">(pitches,</span> <span class="hl kwc">geom</span><span class="hl std">=</span><span class="hl str">&quot;tile&quot;</span><span class="hl std">,</span> <span class="hl kwc">density1</span><span class="hl std">=</span><span class="hl kwd">list</span><span class="hl std">(</span><span class="hl kwc">des</span><span class="hl std">=</span><span class="hl str">&quot;Called Strike&quot;</span><span class="hl std">),</span> <span class="hl kwc">density2</span><span class="hl std">=</span><span class="hl kwd">list</span><span class="hl std">(</span><span class="hl kwc">des</span><span class="hl std">=</span><span class="hl str">&quot;Called Strike&quot;</span><span class="hl std">),</span> <span class="hl kwc">layer</span><span class="hl std">=</span><span class="hl kwd">facet_grid</span><span class="hl std">(.</span><span class="hl opt">~</span><span class="hl std">stand))</span>
</pre></div>
</div></div>


If you specify two different densities, `strikeFX` will plot differenced densities. In this case, we are subtracting the "Ball" density from the previous "Called Strike" density.

<div class="chunk" id="strike3"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">strikeFX</span><span class="hl std">(pitches,</span> <span class="hl kwc">geom</span><span class="hl std">=</span><span class="hl str">&quot;tile&quot;</span><span class="hl std">,</span> <span class="hl kwc">density1</span><span class="hl std">=</span><span class="hl kwd">list</span><span class="hl std">(</span><span class="hl kwc">des</span><span class="hl std">=</span><span class="hl str">&quot;Called Strike&quot;</span><span class="hl std">),</span> <span class="hl kwc">density2</span><span class="hl std">=</span><span class="hl kwd">list</span><span class="hl std">(</span><span class="hl kwc">des</span><span class="hl std">=</span><span class="hl str">&quot;Ball&quot;</span><span class="hl std">),</span> <span class="hl kwc">layer</span><span class="hl std">=</span><span class="hl kwd">facet_grid</span><span class="hl std">(.</span><span class="hl opt">~</span><span class="hl std">stand))</span>
</pre></div>
</div><div class="rimage center"><img src="figure/strike3.png" title="plot of chunk strike3" alt="plot of chunk strike3" class="plot" /></div></div>


`strikeFX` also has the capability to plot tiled bar charts via the option `geom="subplot2d"`. Each grid (or sub-region) of the plot below has a distribution of outcomes among Rivera's pitches to right handed batters. The three outcomes are "S" for strike, "X" for a ball hit into play and "B" for a ball. 




<div class="chunk" id="strike4"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">Rivera.R</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">subset</span><span class="hl std">(Rivera, stand</span><span class="hl opt">==</span><span class="hl str">&quot;R&quot;</span><span class="hl std">)</span>
<span class="hl kwd">strikeFX</span><span class="hl std">(Rivera.R,</span> <span class="hl kwc">geom</span><span class="hl std">=</span><span class="hl str">&quot;subplot2d&quot;</span><span class="hl std">,</span> <span class="hl kwc">fill</span><span class="hl std">=</span><span class="hl str">&quot;type&quot;</span><span class="hl std">)</span>
</pre></div>
</div><div class="rimage center"><img src="figure/strike4.png" title="plot of chunk strike4" alt="plot of chunk strike4" class="plot" /></div></div>


#### Probabilistic strike-zone densities

Perhaps more interesting than raw strike-zone densities are probabilistic densities. These densities represent the probability of a certain event happening at a given location. A popular method for fitting such models is Generalized Additive Models. Here we use the **mgcv** library to fit such a model (which automatically chooses a proper tuning parameter via cross-validation).

<div class="chunk" id="mgcv"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl std">noswing</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">subset</span><span class="hl std">(pitches, des</span> <span class="hl opt">%in%</span> <span class="hl kwd">c</span><span class="hl std">(</span><span class="hl str">&quot;Ball&quot;</span><span class="hl std">,</span> <span class="hl str">&quot;Called Strike&quot;</span><span class="hl std">))</span>
<span class="hl std">noswing</span><span class="hl opt">$</span><span class="hl std">strike</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">as.numeric</span><span class="hl std">(noswing</span><span class="hl opt">$</span><span class="hl std">des</span> <span class="hl opt">%in%</span> <span class="hl str">&quot;Called Strike&quot;</span><span class="hl std">)</span>
<span class="hl kwd">library</span><span class="hl std">(mgcv)</span>
<span class="hl std">m1</span> <span class="hl kwb">&lt;-</span> <span class="hl kwd">bam</span><span class="hl std">(strike</span> <span class="hl opt">~</span> <span class="hl kwd">s</span><span class="hl std">(px, pz,</span> <span class="hl kwc">by</span><span class="hl std">=</span><span class="hl kwd">factor</span><span class="hl std">(stand))</span> <span class="hl opt">+</span>
          <span class="hl kwd">factor</span><span class="hl std">(stand),</span> <span class="hl kwc">data</span><span class="hl std">=noswing,</span> <span class="hl kwc">family</span> <span class="hl std">=</span> <span class="hl kwd">binomial</span><span class="hl std">(</span><span class="hl kwc">link</span><span class="hl std">=</span><span class="hl str">'logit'</span><span class="hl std">))</span>
<span class="hl kwd">strikeFX</span><span class="hl std">(noswing,</span> <span class="hl kwc">model</span><span class="hl std">=m1,</span> <span class="hl kwc">layer</span><span class="hl std">=</span><span class="hl kwd">facet_grid</span><span class="hl std">(.</span><span class="hl opt">~</span><span class="hl std">stand))</span>
</pre></div>
</div><div class="rimage center"><img src="figure/mgcv.png" title="plot of chunk mgcv" alt="plot of chunk mgcv" class="plot" /></div></div>


### Session Info

In the spirit of reproducible research, here is the `sessionInfo` used when creating this document:

<div class="chunk" id="info"><div class="rcode"><div class="source"><pre class="knitr r"><span class="hl kwd">sessionInfo</span><span class="hl std">()</span>
</pre></div>
<div class="output"><pre class="knitr r">## R version 3.0.2 (2013-09-25)
## Platform: x86_64-apple-darwin10.8.0 (64-bit)
## 
## locale:
## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] mgcv_1.7-27       nlme_3.1-113      ggsubplot_0.3.2   XML2R_0.0.3      
## [5] XML_3.95-0.2      pitchRx_1.0       ggplot2_0.9.3.1   devtools_1.4.1.99
## [9] knitr_1.5        
## 
## loaded via a namespace (and not attached):
##  [1] Cairo_1.5-5        colorspace_1.2-4   dichromat_2.0-0   
##  [4] digest_0.6.4       evaluate_0.5.1     formatR_0.10      
##  [7] grid_3.0.2         gtable_0.1.2       hexbin_1.26.3     
## [10] highr_0.3          httr_0.2           labeling_0.2      
## [13] lattice_0.20-24    lubridate_1.3.3    MASS_7.3-29       
## [16] Matrix_1.1-1.1     memoise_0.1        munsell_0.4.2     
## [19] parallel_3.0.2     plyr_1.8           proto_0.3-10      
## [22] RColorBrewer_1.0-5 RCurl_1.95-4.1     reshape2_1.2.2    
## [25] rgl_0.93.963       scales_0.2.3       stringr_0.6.2     
## [28] tools_3.0.2        whisker_0.3-2
</pre></div>
</div></div>

