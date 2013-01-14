library(devtools)
install_github('staticdocs', 'hadley')
library(staticdocs)
dir.exists <- function(path) TRUE
build_package(package="/Users/cpsievert/Desktop/github/local/pitchRx/", 
              base_path="/Users/cpsievert/Desktop/github/local/cpsievert.github.com/pitchRx/")
