all: index.html climate/index.html

index.html: index.Rmd
	Rscript -e "rmarkdown::render('index.Rmd')"

climate/index.html: climate.R
	Rscript climate.R
