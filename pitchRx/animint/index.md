
```r
library(pitchRx)
```

```
## Loading required package: ggplot2
```

```r
library(animint)
```

```
## Loading required package: RJSONIO
## Loading required package: proto
## Loading required package: grid
## Loading required package: plyr
## Loading required package: maps
## Loading required package: reshape2
## Loading required package: MASS
## Loading required package: hexbin
## Loading required package: lattice
## Loading required package: scales
```

```r
data(pitches, package = "pitchRx")
pitches$type <- interaction(pitches$pitch_type, pitches$pitcher_name)
counts <- ddply(pitches, c("pitch_type", "pitcher_name", "type"), 
                summarise, count = length(px))
viz <- list(bars = ggplot() +
              geom_bar(aes(x = factor(pitch_type), y = count, 
                           fill = pitcher_name, clickSelects = type),
                      position = "dodge", stat = "identity", data = counts),
            scatter = ggplot() +
              geom_point(aes(px, pz, fill = pitcher_name, showSelected = type),
                         data = pitches))
gg2animint_knitr(viz)
```

<script type="text/javascript" src="vendor/d3.v3.js"></script>
<script type="text/javascript" src="animint.js"></script>

<div id="plot"> </div>

<script>
  var plot = new animint("#plot","plot.json");
</script>

