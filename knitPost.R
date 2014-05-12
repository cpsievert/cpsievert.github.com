#' Knit .Rmd file into a jekyll blog post 
#'  
#' Code modified from https://github.com/jfisher-usgs/jfisher-usgs.github.com/blob/master/R/KnitPost.R
#' Also includes ideas from https://github.com/supstat/vistat/blob/gh-pages/_bin/knit
#' 
#' @export
#' @examples
#' 
#' setwd("~/Desktop/github/local/cpsievert.github.com/")
#' knitPost("2013-05-15-hello-jekyll.Rmd")

knitPost <- function(post="2013-05-15-hello-jekyll.Rmd", baseUrl="/") {
  library(knitr)
  sourcePath <- file.path(getwd(), "_source", post)
  base <- sub("\\.[Rr]md$", "", basename(sourcePath))
  figPath <- paste0("figs/", base, "/")
  cachePath <- paste0("cache/", base, "/")
  opts_chunk$set(fig.path=figPath, cache.path=cachePath, fig.cap="center")
  opts_knit$set(animation.fun = hook_r2swf, webgl = hook_webgl, base.url=baseUrl)
  # why doesn't http://cpsievert.github.io work for a base.url????????
  # maybe try http://raw.github.com/cpsievert/cpsievert.github.com/master/
  # note: different base.urls works for figures but not animations could it be animation.fun???
  # one solution is to directly manipulate the link in the markdown file
  render_jekyll()
  wrap_rmd(file.path("_source", post), width = 100)  # reflow long lines in Rmd
  knit(sourcePath, paste('_posts/', base, '.md', sep = ''), envir=parent.frame())
}


