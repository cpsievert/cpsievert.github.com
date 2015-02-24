library("DiagrammeR")

# for some reason doesn't work in .Rmd
grViz("gg.gv", width = 1000, height = 500)
grViz("clickSelects.gv", width = 1000, height = 500)
grViz("showSelected.gv", width = 1000, height = 500)



# setwd("~/Desktop/github/local/cpsievert.github.com/slides/animint/20150224")
# library(curl)
# if (!file.exists("orders.tsv")) {
#   curl_download("https://raw.githubusercontent.com/TheUpshot/chipotle/master/orders.tsv",
#                 destfile = "orders.tsv")
# }
#
# orders <- read.table("orders.tsv", sep = "\t", header = TRUE)
# head(orders)
# length(unique(orders$item_name))


#library(ggplot2)

#p <- qplot(1:10, 1:10)
#aes_ <- names(p$mapping)
