#!/usr/bin/env Rscript
setwd("extras/bookdown")
bookdown::render_book("index.Rmd", "bookdown::bs4_book", quiet = TRUE, output_dir = "../../docs")
