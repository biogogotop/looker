+++
author = 'asepsiswu'
title = "rowmean 正确计算方式"
#date = "2020-08-17"
date = 2020-08-17T08:43:12+08:00
archives = "2020/08" 
tags = [ "" ]
summary = "rowMeans"
+++

## 计算CT均值

```r
library(data.table)
df <- structure(list(sample = c(1, 2, 3, 4, 5, 6), primer = c(1, 1,  1, 1, 1, 1), CT1 = c(31.5204639434814, 29.4990825653076, NA,  31.7525939941406, 33.0189094543457, 28.9761772155762), CT2 = c(31.2446727752686,  29.3928241729736, NA, 31.3768005371094, 32.2539939880371, 28.6480121612549 ), CT3 = c(31.2595844268799, 29.1280612945557, 30.1280612945557, 31.3853378295898,  31.9838829040527, 28.5653133392334)), row.names = c(NA, -6L), class = c(  "data.frame"))
dt <- as.data.table(df)
dt
```

```
##    sample primer      CT1      CT2      CT3
## 1:      1      1 31.52046 31.24467 31.25958
## 2:      2      1 29.49908 29.39282 29.12806
## 3:      3      1       NA       NA 30.12806
## 4:      4      1 31.75259 31.37680 31.38534
## 5:      5      1 33.01891 32.25399 31.98388
## 6:      6      1 28.97618 28.64801 28.56531
```
## 错误的打开方式

```r
dt[, m.1:=mean(CT1,CT2,CT3,na.rm = T),.(sample,primer)]
```

```
## Warning in `[.data.table`(dt, , `:=`(m.1, mean(CT1, CT2, CT3, na.rm = T)), :
## Unable to optimize call to mean() and could be very slow. You must name 'na.rm'
## like that otherwise if you do mean(x,TRUE) the TRUE is taken to mean 'trim'
## which is the 2nd argument of mean. 'trim' is not yet optimized.
```

```r
dt[, m.2:=lapply(.SD,mean,na.rm = T), .SDcols = c('CT1','CT2','CT3') ,list(sample,primer)]
dt[, m.3:=sum(CT1,CT2,CT3,na.rm = T)/3,list(sample,primer)]
dt[, m.4:=rowMeans(CT1,CT2,CT3,na.rm = T),.(sample,primer)]
```

```
## Error in rowMeans(CT1, CT2, CT3, na.rm = T): unused argument (CT3)
```

```r
dt
```

```
##    sample primer      CT1      CT2      CT3      m.1      m.2      m.3
## 1:      1      1 31.52046 31.24467 31.25958 31.52046 31.52046 31.34157
## 2:      2      1 29.49908 29.39282 29.12806 29.49908 29.49908 29.33999
## 3:      3      1       NA       NA 30.12806      NaN      NaN 10.04269
## 4:      4      1 31.75259 31.37680 31.38534 31.75259 31.75259 31.50491
## 5:      5      1 33.01891 32.25399 31.98388 33.01891 33.01891 32.41893
## 6:      6      1 28.97618 28.64801 28.56531 28.97618 28.97618 28.72983
```


## 正确的打开方式

```r
dt[, m.5:=rowMeans(.SD, na.rm = T), .SDcols = c('CT1','CT2','CT3') ,list(sample,primer)]
dt
```

```
##    sample primer      CT1      CT2      CT3      m.1      m.2      m.3      m.5
## 1:      1      1 31.52046 31.24467 31.25958 31.52046 31.52046 31.34157 31.34157
## 2:      2      1 29.49908 29.39282 29.12806 29.49908 29.49908 29.33999 29.33999
## 3:      3      1       NA       NA 30.12806      NaN      NaN 10.04269 30.12806
## 4:      4      1 31.75259 31.37680 31.38534 31.75259 31.75259 31.50491 31.50491
## 5:      5      1 33.01891 32.25399 31.98388 33.01891 33.01891 32.41893 32.41893
## 6:      6      1 28.97618 28.64801 28.56531 28.97618 28.97618 28.72983 28.72983
```
