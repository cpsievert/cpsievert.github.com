devtools::install_github("tesseradata/datadr")
devtools::install_github("tesseradata/trelliscope")
devtools::install_github("hafen/housingData")

library(housingData)
library(datadr)
library(trelliscope)

# Creates a vdb folder in wd with various assets
conn <- vdbConn("vdb", name = "tesseraTutorial")

# Divide housing data by county and state
byCounty <- divide(housing, 
                   by = c("county", "state"))
byCounty
byCounty[[1]]

# Creating a panel function
timePanel <- function(x)
  xyplot(medListPriceSqft + medSoldPriceSqft ~ time,
         data = x, auto.key = TRUE, ylab = "Price / Sq. Ft.")
timePanel(byCounty[[20]]$value)
timePanel(byCounty[[22]]$value)

# create a cognostics function of metrics of interest
priceCog <- function(x) { 
  zillowString <- gsub(" ", "-", do.call(paste, getSplitVars(x)))
  list(
    slope = cog(coef(lm(medListPriceSqft ~ time, data = x))[2], 
                desc = "list price slope"),
    meanList = cogMean(x$medListPriceSqft),
    meanSold = cogMean(x$medSoldPriceSqft),
    nObs = cog(length(which(!is.na(x$medListPriceSqft))), 
               desc = "number of non-NA list prices"),
    zillowHref = cogHref(
      sprintf("http://www.zillow.com/homes/%s_rb/", zillowString), 
      desc = "zillow link")
  )
}
# test cognostics function on a subset
priceCog(byCounty[[1]]$value)

makeDisplay(byCounty,
            name = "list_sold_vs_time_quickstart",
            desc = "List and sold price over time",
            panelFn = timePanel, 
            cogFn = priceCog,
            width = 400, height = 400,
            lims = list(x = "same"))
view()
