+++
author = 'asepsiswu'
title = "ggrepel"
date =  2020-05-31T23:44:28+08:00
archives = "2020/05" 
tags = [
    "text"
]
summary = 'ggplot2 文字注释'
+++

# ggrepel: annotate overlapping text labels
## Installation
    install.packages("ggrepel")

## example
    library('ggplot2')
    library('ggrepel')
    set.seed(42)
    dat2 <- subset(mtcars, wt > 3 & wt < 4)
    ggplot(dat2, aes(wt, mpg, label = car)) +
      geom_point() +
      geom_text_repel()

## important parameters
