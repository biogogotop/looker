+++
author = 'asepsiswu'
title = "rstudio addins"
date = "2019-10-14"
archives = "2019/10" 
tags = [ "Rstudio" ]
summary = "rstudio 使用addins插件"
+++

# Rstudio 使用addins插件
1. Create an R package,
1. Create some R functions, and
1. Create a file at inst/rstudio/addins.dcf

## 示例
1. 建包
File -> New Project -> New Directory -> R Package -> package名称Raddins -> Create Package

1. 编写addins.dcf 内容
```bash
mkdir -p inst/restudio
```

```
Name: Rmd2md
Description: Rmd2md
Binding: Rmd2md
Interactive: false
```

1. 编写addins.R
```r
Rmd2md <- function(){
  knitr::knit(rstudioapi::getSourceEditorContext()$path)
  
}
```
1. Build -> Install and Rstart

