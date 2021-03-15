+++
author = 'asepsiswu'
title = "R simple application 1"
date = "2019-10-26"
archives = "2019/10" 
tags = [ "R tutorial" ]
summary = "R的简单应用之merge"
+++
# R的简单应用之数据表单的合并和更新表
## 加载必要的R包
require和library函数加载R包，如加载不成功安装R包后再加载

```r
## 加载data.table包
if (!require(data.table)) { 
  install.package("data.table")
  library(data.table)
}
```

```
## Loading required package: data.table
```

## 生成示例数据
sample 函数用于生成随机数据。

```r
set.seed(10086) # 设置一个seed，令随机数据可以重复
n1 <- 10; n2 <- 5
tb1 <- data.table(pid1 = sample(1:n1), day = sample(1:100, n1))
tb2 <- data.table(pid1 = sample(1:n1, n2), dayNew = sample(5:50, n2))
tb1
```

```
##     pid1 day
##  1:    2  32
##  2:   10  52
##  3:    7  61
##  4:    5  41
##  5:    6  40
##  6:    4  60
##  7:    3  83
##  8:    9  68
##  9:    1   1
## 10:    8  67
```

```r
tb2
```

```
##    pid1 dayNew
## 1:    9     44
## 2:    4     38
## 3:    2     35
## 4:    6     16
## 5:    5     27
```
## data.table的合并和更新
1. 合并tb1, tb2

```r
tb3 <- merge(tb1, tb2, by = "pid1", all = TRUE, sort = FALSE)
tb3
```

```
##     pid1 day dayNew
##  1:    2  32     35
##  2:   10  52     NA
##  3:    7  61     NA
##  4:    5  41     27
##  5:    6  40     16
##  6:    4  60     38
##  7:    3  83     NA
##  8:    9  68     44
##  9:    1   1     NA
## 10:    8  67     NA
```
1. 根据tb2进行更新

```r
tb3[, dayUpdate:=day]
tb3[tb2, dayUpdate:=dayNew, on = "pid1"]
tb3
```

```
##     pid1 day dayNew dayUpdate
##  1:    2  32     35        35
##  2:   10  52     NA        52
##  3:    7  61     NA        61
##  4:    5  41     27        27
##  5:    6  40     16        16
##  6:    4  60     38        38
##  7:    3  83     NA        83
##  8:    9  68     44        44
##  9:    1   1     NA         1
## 10:    8  67     NA        67
```

## 读取数据和写入数据
1. 普通文本的格式，如txt, csv,用data.table包

```r
tb <- fread("filepath")
fwrite(tb, file = "newFilepath")
```
1. xlsx格式，用openxlsx包, 不适用与office 2003的xls格式

```r
library(openxlsx)
xlsx <- read.xlsx("filepath")
write.xlsx(xlsx, file = "newFilepath")
tb <- data.table(xlsx) 
```
