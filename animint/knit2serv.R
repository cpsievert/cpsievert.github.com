library(knitr)
library(servr)

# Function to knit a Rmd file and serve the html with local file server
knit2serv <- function(dir = "~/Desktop/github/local/cpsievert.github.com/animint", 
                      subdir, filename = subdir, port = 4000) {
  Dir = if (missing(subdir)) dir else file.path(dir, subdir)
  knit2html(file.path(Dir, paste0(filename, ".Rmd")), output = file.path(Dir, paste0(filename, ".html")))
  httd(Dir, launch.browser = TRUE)
}
knit2serv(subdir = "worldPop")
knit2serv(subdir = "knitr")
