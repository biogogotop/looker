+++
author = 'asepsiswu'
title = "split and bind"
#date = "2021-03-24"
date = 2021-03-24T10:16:37+08:00
archives = "2021/03" 
tags = [ "tidy" ]
categories = [ "R" ]
summary = "split vs rbindlist "
+++

`split` 按行拆分`data.frame`, `rbindlist`用于合并

`split.default` 按列拆分, `as.data.frame` 用于合并

`Reduce` 速度较慢,可结合`rbind`和`cbind`

`asplit`的结果是Matrix, 导致类型丢失,大部分情况不合适

-----

## split

```r
library(magrittr)
library(knitr)
library(data.table)
dat <- mtcars[9:11,1:4]
dat_list_row <- split(dat,rownames(dat))
dat_list_row2 <- split(dat,dat$cyl)
dat_list_col <- split.default(dat,colnames(dat))

dat_list_row
```

```
## $`Merc 230`
##           mpg cyl  disp hp
## Merc 230 22.8   4 140.8 95
## 
## $`Merc 280`
##           mpg cyl  disp  hp
## Merc 280 19.2   6 167.6 123
## 
## $`Merc 280C`
##            mpg cyl  disp  hp
## Merc 280C 17.8   6 167.6 123
```

```r
dat_list_row2
```

```
## $`4`
##           mpg cyl  disp hp
## Merc 230 22.8   4 140.8 95
## 
## $`6`
##            mpg cyl  disp  hp
## Merc 280  19.2   6 167.6 123
## Merc 280C 17.8   6 167.6 123
```

```r
dat_list_col
```

```
## $cyl
##           cyl
## Merc 230    4
## Merc 280    6
## Merc 280C   6
## 
## $disp
##            disp
## Merc 230  140.8
## Merc 280  167.6
## Merc 280C 167.6
## 
## $hp
##            hp
## Merc 230   95
## Merc 280  123
## Merc 280C 123
## 
## $mpg
##            mpg
## Merc 230  22.8
## Merc 280  19.2
## Merc 280C 17.8
```

```r
as.data.frame(dat_list_col)  
```



|          | cyl|  disp|  hp|  mpg|
|:---------|---:|-----:|---:|----:|
|Merc 230  |   4| 140.8|  95| 22.8|
|Merc 280  |   6| 167.6| 123| 19.2|
|Merc 280C |   6| 167.6| 123| 17.8|

## 合并
###  rbindlist

```r
rbindlist(dat_list_row)  
```



|  mpg| cyl|  disp|  hp|
|----:|---:|-----:|---:|
| 22.8|   4| 140.8|  95|
| 19.2|   6| 167.6| 123|
| 17.8|   6| 167.6| 123|

```r
rbindlist(dat_list_row2)  
```



|  mpg| cyl|  disp|  hp|
|----:|---:|-----:|---:|
| 22.8|   4| 140.8|  95|
| 19.2|   6| 167.6| 123|
| 17.8|   6| 167.6| 123|
###  do.call

```r
do.call(rbind, dat_list_row)  
```



|          |  mpg| cyl|  disp|  hp|
|:---------|----:|---:|-----:|---:|
|Merc 230  | 22.8|   4| 140.8|  95|
|Merc 280  | 19.2|   6| 167.6| 123|
|Merc 280C | 17.8|   6| 167.6| 123|

```r
do.call(rbind, dat_list_row2)  
```



|            |  mpg| cyl|  disp|  hp|
|:-----------|----:|---:|-----:|---:|
|4           | 22.8|   4| 140.8|  95|
|6.Merc 280  | 19.2|   6| 167.6| 123|
|6.Merc 280C | 17.8|   6| 167.6| 123|

###  Reduce rbind cbind

```r
Reduce(rbind, dat_list_row)  
```



|          |  mpg| cyl|  disp|  hp|
|:---------|----:|---:|-----:|---:|
|Merc 230  | 22.8|   4| 140.8|  95|
|Merc 280  | 19.2|   6| 167.6| 123|
|Merc 280C | 17.8|   6| 167.6| 123|

```r
Reduce(rbind, dat_list_row2)  
```



|          |  mpg| cyl|  disp|  hp|
|:---------|----:|---:|-----:|---:|
|Merc 230  | 22.8|   4| 140.8|  95|
|Merc 280  | 19.2|   6| 167.6| 123|
|Merc 280C | 17.8|   6| 167.6| 123|

```r
Reduce(cbind, dat_list_col)  
```



|          | cyl|  disp|  hp|  mpg|
|:---------|---:|-----:|---:|----:|
|Merc 230  |   4| 140.8|  95| 22.8|
|Merc 280  |   6| 167.6| 123| 19.2|
|Merc 280C |   6| 167.6| 123| 17.8|

###  rbindlist 其他用法

```r
lst1 <- list(a=1, b='b',aa=12)
lst2 <- list( b='b',ab=12)
lst3 <- as.list(letters[1:5])
lst4 <- as.list(LETTERS[1:5])

rbindlist(list(lst1,lst2),fill = T,use.names = T)  
```



|  a|b  | aa| ab|
|--:|:--|--:|--:|
|  1|b  | 12| NA|
| NA|b  | NA| 12|

```r
rbindlist(list(lst3,lst4))  
```



|V1 |V2 |V3 |V4 |V5 |
|:--|:--|:--|:--|:--|
|a  |b  |c  |d  |e  |
|A  |B  |C  |D  |E  |

```r
rbindlist(list(lst3,lst4),fill = T,use.names = T)  
```

```
## Error in rbindlist(list(lst3, lst4), fill = T, use.names = T): use.names=TRUE but no item of input list has any names
```

