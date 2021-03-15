+++
author = 'asepsiswu'
title = "rstudio addins hugo"
#date = "2020-08-07"
date = 2020-08-07T10:04:36+08:00
archives = "2020/08" 
tags = [ "hugo" ]
summary = "Rmarkdown file to markdown for hugo"
+++

## create  basic package
1. 建包 File -> New Project -> New Directory -> R Package -> package名称Raddins -> Create Package

2. 编写addins.dcf 内容
```
Name: hugoRmd
Description: hugoRmd
Binding: hugoRmd
Interactive: false
```

3. 编写addins.R
```R
hugoRmd <- function() {
  ## helper function
  rmd <- rstudioapi::getSourceEditorContext()$path
  if (!grepl("rmd",rmd,T)) stop( rmd, " is not a Rmarkdown file. Aborting.", call.=FALSE)
  library(rmarkdown)
  # modify to generate picture inside markdown file with base64
  knitr::opts_knit$set(upload.fun = knitr::image_uri) 
  md <- gsub(x=rmd,'rmd','md',T)
  knitr::knit(rmd,md) # convert Rmarkdown file to md file
}

```

4. Build -> Install and restart
