+++
author = 'asepsiswu'
title = "knitr 图片输出device设置"
date = 2020-06-06
archives = "2020/06" 
tags = [ "graphics" ]
summary = 'knitr::opts_chunk$set(dev = "png", dev.args = list(type = "cairo-png")) '
+++

# knitr 图片输出
参考网页
[Setting the Graphics Device in a RMarkdown Document](https://www.jumpingrivers.com/blog/r-knitr-markdown-png-pdf-graphics/)
## 默认
the default graphics device when creating PDF documents is grDevices::pdf() and for HTML documents it’s grDevices::png(). 

## PDF 
```r
knitr::opts_chunk$set(dev = "cairo_pdf")
```

## PNG

```r
knitr::opts_chunk$set(dev = "png", dev.args = list(type = "cairo-png"))
```

## base64
```r
knitr::opts_knit$set(upload.fun = knitr::image_uri) # modify to produce picture inside markdown file
```


