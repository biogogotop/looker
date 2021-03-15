+++
author = 'asepsiswu'
title = "EACHI 简单用法"
date = 2020-06-08
archives = "2020/06" 
tags = [ "" ]
summary = ".EACHI 的用法"
+++

## .EACHI变量的来路
参考网页[.EACHI in data.table?](https://stackoverflow.com/questions/27004002/eachi-in-data-table)
## example 

```r
library(data.table)
X = data.table(x = c(1,1,1,2,2,5,6), y = 7:1, key = "x")
Y = data.table(x = c(2,6), z = letters[2:1], key = "x")
X[Y]
```

```
##    x y z
## 1: 2 4 b
## 2: 2 3 b
## 3: 6 1 a
```

```r
X[Y,.N]
```

```
## [1] 3
```

```r
X[Y, .(z)]
```

```
##    z
## 1: b
## 2: b
## 3: a
```

```r
X[Y, .N, by=.EACHI]
```

```
##    x N
## 1: 2 2
## 2: 6 1
```
##  用法
x[i, j, .EACHI] 只有*i是list或data.table*的情况下，.EACHI起作用。将i的每个元素作为一个subgroup对j进行操作

```r
# subgroup 求和
X[Y, sum(y), by=.EACHI]
```

```
##    x V1
## 1: 2  7
## 2: 6  1
```

```r
# 对X中有Y交集的标记为'my'
X[Y, matchTOy:='my', by=.EACHI][]
```

```
##    x y matchTOy
## 1: 1 7     <NA>
## 2: 1 6     <NA>
## 3: 1 5     <NA>
## 4: 2 4       my
## 5: 2 3       my
## 6: 5 2     <NA>
## 7: 6 1       my
```

```r
# 对X中有Y交集的标记为X中的row number
X[Y, matchTOy:=.I, by=.EACHI][]
```

```
##    x y matchTOy
## 1: 1 7     <NA>
## 2: 1 6     <NA>
## 3: 1 5     <NA>
## 4: 2 4        4
## 5: 2 3        5
## 6: 5 2     <NA>
## 7: 6 1        7
```

```r
X[Y, smy:=sum(y), by=.EACHI][]
```

```
##    x y matchTOy smy
## 1: 1 7     <NA>  NA
## 2: 1 6     <NA>  NA
## 3: 1 5     <NA>  NA
## 4: 2 4        4   7
## 5: 2 3        5   7
## 6: 5 2     <NA>  NA
## 7: 6 1        7   1
```

```r
X[Y, mx:=min(y), by=.EACHI][]
```

```
##    x y matchTOy smy mx
## 1: 1 7     <NA>  NA NA
## 2: 1 6     <NA>  NA NA
## 3: 1 5     <NA>  NA NA
## 4: 2 4        4   7  3
## 5: 2 3        5   7  3
## 6: 5 2     <NA>  NA NA
## 7: 6 1        7   1  1
```

```r
# 输出X中有Y交集的X中的row number
X[Y, which=T] #  which TRUE returns the row numbers of x that i matches to. If NA, returns the row numbers of i that have no match in x. By default FALSE and the rows in x that match are returned.
```

```
## [1] 4 5 7
```

```r
X[list(1,2,6),.N,.EACHI] #wrong 
```

```
##    x N
## 1: 1 3
```

```r
X[list(c(1,2,6)),.N,.EACHI] 
```

```
##    x N
## 1: 1 3
## 2: 2 2
## 3: 6 1
```

```r
X[x %in% c(1,2,6),.N,.EACHI]
```

```
## Error in `[.data.table`(X, x %in% c(1, 2, 6), .N, .EACHI): logical error. i is not data.table, but mult='all' and 'by'=.EACHI
```
