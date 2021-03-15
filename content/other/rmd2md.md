+++
author = 'asepsiswu'
title = "hugo with r markdown"
date = "2019-10-14"
archives = "2019/10" 
tags = [ "hugo", "rstudio","markdown" ]
summary = "hugo写Rmarkdown 文件"
+++

# R markdown to hugo markdown
1. 通过R的`knitr::knit` 转化Rmd 为md文件

    可以通过R的addins插件实现[一键转换](https://biogo.top/2019/10/14/rstudio-addins/)，免去输入文件名

1. 或通过shell alias 转化rmd
``` {bash}
alias knit="Rscript -e 'files = commandArgs(trailingOnly=T);sapply(files, knitr::knit)' "
# bash 
knit xxx.rmd xx2.rmd
```

2. 打开生成的md文件，更新图片的路径

    将生成的图片复制到static文件夹下面，更新图片的链接。

    如图片复制到static/figure/R/目录下
`![A fancy pie chart.](figure/pie-1.png)` 更改为
`![A fancy pie chart.](/figure/R/pie-1.png)` 

    注意： /figured的实际路径为/static/figure,需要在hugo的config.toml添加
    ```
    staticDir = ["static", "figure"]
    ```
