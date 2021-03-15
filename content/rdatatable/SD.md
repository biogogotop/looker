+++
author = 'asepsiswu'
title = ".SD 用法"
date = 2020-06-07
archives = "2020/06" 
tags = [ "" ]
summary = ".SD 一些简单用法"
+++

## .SD 的定义
.SD is a data.table containing the Subset of x's Data for each group, excluding any columns used in by (or keyby).

x[i,j,by] 其中x是data.table, .SD是x的一部分。

## 示例数据

```r
library(data.table)
DT = data.table(x=rep(c("b","a","c"),each=3), v=c(1,1,1,2,2,1,1,2,2), y=c(1,3,6), a=1:9, b=9:1,key ='x')
DT
```

```
##    x v y a b
## 1: a 2 1 4 6
## 2: a 2 3 5 5
## 3: a 1 6 6 4
## 4: b 1 1 1 9
## 5: b 1 3 2 8
## 6: b 1 6 3 7
## 7: c 1 1 7 3
## 8: c 2 3 8 2
## 9: c 2 6 9 1
```

```r
X = data.table(x=c("c","b"), v=8:7, foo=c(4,2),key="x")
X
```

```
##    x v foo
## 1: b 7   2
## 2: c 8   4
```
## .SD 选择部分column
选择xy变量

```r
#第一种方式
DT[, .SD, .SDcols=1:2]   # select columns 'x' and 'y'
```

```
##    x v
## 1: a 2
## 2: a 2
## 3: a 1
## 4: b 1
## 5: b 1
## 6: b 1
## 7: c 1
## 8: c 2
## 9: c 2
```

```r
#第二种方式
selc = c('x','y')
DT[, .SD, .SDcols=selc]  
```

```
##    x y
## 1: a 1
## 2: a 3
## 3: a 6
## 4: b 1
## 5: b 3
## 6: b 6
## 7: c 1
## 8: c 3
## 9: c 6
```

```r
#第三种方式
DT[, .SD, .SDcols=x:y]   
```

```
##    x v y
## 1: a 2 1
## 2: a 2 3
## 3: a 1 6
## 4: b 1 1
## 5: b 1 3
## 6: b 1 6
## 7: c 1 1
## 8: c 2 3
## 9: c 2 6
```

```r
#第四种方式
DT[, .SD, .SDcols=patterns('x|y')]                 
```

```
##    x y
## 1: a 1
## 2: a 3
## 3: a 6
## 4: b 1
## 5: b 3
## 6: b 6
## 7: c 1
## 8: c 3
## 9: c 6
```

```r
#第五种方式
DT[, .SD, .SDcols=grepl('x|y',names(DT))]         
```

```
##    x y
## 1: a 1
## 2: a 3
## 3: a 6
## 4: b 1
## 5: b 3
## 6: b 6
## 7: c 1
## 8: c 3
## 9: c 6
```

## 选择部分行

```r
DT[, .SD[1]]             # first row of all columns
```

```
##    x v y a b
## 1: a 2 1 4 6
```

```r
DT[, .SD[1], by=x]       # first row of 'y' and 'v' for each group in 'x'
```

```
##    x v y a b
## 1: a 2 1 4 6
## 2: b 1 1 1 9
## 3: c 1 1 7 3
```

## 选择并计算J


```r
# .SD 默认是by除外的变量
DT[, c(.N, lapply(.SD, sum)), by=x]    # get rows *and* sum columns 'v' and 'y' by group
```

```
##    x N v  y  a  b
## 1: a 3 5 10 15 15
## 2: b 3 3 10  6 24
## 3: c 3 5 10 24  6
```

```r
DT[, c(.(y=max(y)), lapply(.SD, min)), by=v, .SDcols=v:b]      # compute 'j' for each 'v'
```

```
##    v y v y a b
## 1: 2 6 2 1 4 1
## 2: 1 6 1 1 1 3
```

## right join
将DT中x为b和c行对应的v值替换为X中值

```r
# .SD 实际上是DT[x %in% c('b','c')]
DT[x %in% c('b','c'), X[.SD, v]]
```

```
## [1] 7 7 7 8 8 8
```

```r
DT[x %in% c('b','c'), X[print(.SD), v]]
```

```
##    x v y a b
## 1: b 1 1 1 9
## 2: b 1 3 2 8
## 3: b 1 6 3 7
## 4: c 1 1 7 3
## 5: c 2 3 8 2
## 6: c 2 6 9 1
```

```
## [1] 7 7 7 8 8 8
```

```r
DT[x %in% c('b','c'), v:= X[.SD, v]][] 
```

```
##    x v y a b
## 1: a 2 1 4 6
## 2: a 2 3 5 5
## 3: a 1 6 6 4
## 4: b 7 1 1 9
## 5: b 7 3 2 8
## 6: b 7 6 3 7
## 7: c 8 1 7 3
## 8: c 8 3 8 2
## 9: c 8 6 9 1
```
备注： 上述的join默认使用on，on='x',其中on默认的值是data.table的key,也就是'x'


