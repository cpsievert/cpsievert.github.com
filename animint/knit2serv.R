library(knitr)
library(rmarkdown)
library(servr)
library(animint)
library(grid)

render2serv <- function(dir = "~/Desktop/github/local/cpsievert.github.com/animint", 
                        subdir, filename = subdir, port = 4000, fun = rmarkdown::render, ...) {
  knit_meta() #clear metadata
  Dir = if (missing(subdir)) dir else file.path(dir, subdir)
  wd = getwd()
  setwd(Dir)
  fun(input = paste0(filename, ".Rmd"))
  setwd(wd) #go back to original working directory
  httd(Dir, launch.browser = TRUE)
}

# For some reason, self_contained works on Firefox and Safari but not Chrome
render2serv(subdir = "worldPop", output_format = "html_document", 
            output_options = list(self_contained = FALSE), envir = new.env())


render2serv(dir =  "~/Desktop/github/local/cpsievert.github.com/LDAvis",
            subdir = "newsgroup", output_format = "html_document", 
            output_options = list(self_contained = FALSE), envir = new.env())

render2serv(dir = "~/Desktop/github/local/cpsievert.github.com/LDAvis",
            subdir = "newsgroup", filename = "index", output_format = "html_document", 
            output_options = list(self_contained = FALSE), envir = new.env())


library(rmarkdown)
render(input = system.file("examples", "newsgroup.Rmd", package = "LDAvis"),
       output_file = "~/Desktop/github/local/cpsievert.github.com/LDAvis/newsgroup/index.html")
