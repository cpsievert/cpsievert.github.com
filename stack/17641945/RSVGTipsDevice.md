
```r
library(RSVGTipsDevice)
devSVGTips("plot.svg", toolTipMode = 1)
plot(0:1, 0:1, type = "n")
setSVGShapeToolTip("A rectangle", "it is red")
rect(0.1, 0.1, 0.4, 0.6, col = "red")
dev.off()
```

```
## pdf 
##   2
```


<embed src="plot.svg" type="image/svg+xml" />
