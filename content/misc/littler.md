+++
author = 'asepsiswu'
title = "littler 安装配置 "
date = "2020-06-03"
archives = "2020/06" 
tags = [ "" ]
summary = "littler 命令行下运行R相关命令"
+++

## installation
``` r
# R environment
install.packages('littler')
```

## config
``` bash
## soft link
ln -s ~/R/x86_64-pc-linux-gnu-library/4.0/littler/bin/r ~/.local/bin/littler/
cp ~/R/x86_64-pc-linux-gnu-library/4.0/littler/examples/render.r ~/.local/bin/littler/knit.r

# run command
knit.r xxx.Rmd # produce xxx.md
```

## modify knit.r
knit.r 作用是将Rmd 文件生成md文件，后者可以用于hugo静态网页生成

```bash
# content of knit.r

#!/usr/bin/env r
#
# Another example to convert markdown
#
# Copyright (C) 2016 - 2019  Dirk Eddelbuettel
#
# Released under GPL (>= 2)

## load docopt package from CRAN
library(docopt)

## configuration for docopt
doc <- "Usage: render.r [-h] [-x] [FILES...]

-h --help            show this help text
-x --usage           show help and short example usage"

opt <- docopt(doc)			# docopt parsing

if (opt$usage) {
    cat(doc, "\n\n")
    cat("Examples:
  render.r foo.Rmd bar.Rmd        # convert two given files

render.r is part of littler which brings 'r' to the command-line.
See http://dirk.eddelbuettel.com/code/littler.html for more information.\n")
    q("no")
}

library(rmarkdown)
      
# set code chunk and output background color
knitr::opts_chunk$set(class.source = "bg-danger")
knitr::opts_chunk$set(class.output = "bg-warning")
#knitr::opts_chunk$set(comment =  "")
if(require(fansi)){ # enable crayon color in output
  options(crayon.enabled = TRUE)
  old.hooks <- fansi::set_knit_hooks(knitr::knit_hooks)
}
knitr::opts_knit$set(upload.fun = knitr::image_uri) # modify to produce picture inside markdown file
## helper function
renderArg <- function(p) {
    if (!file.exists(p)) stop("No file '", p, "' found. Aborting.", call.=FALSE)
    mp <- gsub(x=p,'rmd','md',T)
    knitr::knit(p,mp) # convert Rmarkdown file to md file
}

## render files using helper function
sapply(opt$FILES, renderArg)

```

