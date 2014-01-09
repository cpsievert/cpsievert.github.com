#' Convert RPres to Rmd for use with Slidify
#'
#' This function converts a presentation written in the RPres format to an Rmd format
#' that is compatible with Slidify. Currently it only handles slide content, but support
#' for slide properties is on the roadmap. This is expected to be useful to those who
#' like the instant preview of Rpres, but would also like to take advantage of multiple
#' frameworks supported by Slidify.
#'
#' @param file path to Rpres file
#' @return path to Rmd file that can be slidified.
#'
#' @example
#' slidify(rpres2slidify('index.Rpres'))
rpres2slidify <- function(file){
  make_front_matter = function(x){
    fm = strsplit(x, '=+\n')[[1]]
    title = paste("title:", fm[1])
    paste(c('---\n', title, fm[2], '---\n'), collapse = "")
  }
  rpres = slidify:::read_file(file)
  rpres2 = gsub("\n([^\n]+)\n(=+)\n", "\n\n---\n\\1\n\\2", rpres)
  rpres3 = stringr::str_split_fixed(rpres2, '---', 2)
  front_matter = make_front_matter(rpres3[1])
  rmd = paste(c(front_matter, rpres3[2]), collapse = "")
  rmd_file = paste0(tools::file_path_sans_ext(file), '.Rmd')
  writeLines(rmd, rmd_file)
}

#Thanks Ramnath! https://gist.github.com/ramnathv/1c3bc052db49d1cabd17
library(slidify)
#setwd("~/Desktop/github/local/cpsievert.github.com/slides/xkcd")
rpres2slidify('index.Rpres')
slidify("index.Rmd", outputFile="slidify.html")
