+++
author = 'asepsiswu'
title = "forcats 包用法"
#date = "2020-06-15"
date = 2020-06-15T13:54:07+08:00
archives = "2020/06" 
tags = [ "forcats" ]
summary = "forcats 用于factor"
+++
## installation
```R
install.package('forcats')
```

## examples
### default

```r
library(forcats)
data(mtcars)
```

```
## Warning in data(mtcars): data set 'mtcars' not found
```

```r
str(mtcars)
```

```
## 'data.frame':	32 obs. of  11 variables:
##  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
##  $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
##  $ disp: num  160 160 108 258 360 ...
##  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
##  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
##  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
##  $ qsec: num  16.5 17 18.6 19.4 17 ...
##  $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
##  $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
##  $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
##  $ carb: num  4 4 1 1 2 1 4 2 2 4 ...
```

```r
fact0 <- factor(mtcars$cyl)
fact0
```

```
##  [1] 6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4
## Levels: 4 6 8
```
### fct_count

```r
fct_count(fact0)
```

```
## # A tibble: 3 x 2
##   f         n
##   <fct> <int>
## 1 4        11
## 2 6         7
## 3 8        14
```

```r
fct_count(fact0,prop=T)
```

```
## # A tibble: 3 x 3
##   f         n     p
##   <fct> <int> <dbl>
## 1 4        11 0.344
## 2 6         7 0.219
## 3 8        14 0.438
```

```r
# If sort = TRUE, sort the result so that the most common values float to the top.
fct_count(fact0,sort = T, prop=T)
```

```
## # A tibble: 3 x 3
##   f         n     p
##   <fct> <int> <dbl>
## 1 8        14 0.438
## 2 4        11 0.344
## 3 6         7 0.219
```

###  fct_unique 

```r
fct_unique(fact0)
```

```
## [1] 4 6 8
## Levels: 4 6 8
```

###  fct_relevel

```r
fct_relevel(fact0, c('8','6','4'))
```

```
##  [1] 6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4
## Levels: 8 6 4
```

```r
# Reorder factor levels based on the appearance in data
fct_inorder(fact0) 
```

```
##  [1] 6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4
## Levels: 6 4 8
```

```r
# Reorder factor levels based on the frequency
fct_infreq(fact0)
```

```
##  [1] 6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4
## Levels: 8 4 6
```

```r
fct_rev(fact0)
```

```
##  [1] 6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4
## Levels: 8 6 4
```

### Reorder factor levels based on the relationship with other variables

```r
# 根据mtcars$mpg的分组后计算得到的(max/min/mean/median)结果排序,对fact0排序
fct_reorder(fact0, mtcars$mpg,max)
```

```
##  [1] 6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4
## Levels: 8 6 4
```

```r
fct_reorder(fact0, mtcars$mpg,min)
```

```
##  [1] 6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4
## Levels: 8 6 4
```

```r
fct_reorder(fact0, mtcars$mpg,mean)
```

```
##  [1] 6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4
## Levels: 8 6 4
```

```r
fct_reorder(fact0, mtcars$mpg,median)
```

```
##  [1] 6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4
## Levels: 8 6 4
```

```r
fct_reorder(fact0, mtcars$mpg,sd)
```

```
##  [1] 6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4
## Levels: 6 8 4
```

### Changing values of factor levels in R

```r
fct_collapse(fact0, `46`= c('4','6'))
```

```
##  [1] 46 46 46 46 8  46 8  46 46 46 46 8  8  8  8  8  8  46 46 46 46 8  8  8  8 
## [26] 46 46 46 8  46 8  46
## Levels: 46 8
```

```r
fct_collapse(fact0, "46"= c('4','6'))
```

```
##  [1] 46 46 46 46 8  46 8  46 46 46 46 8  8  8  8  8  8  46 46 46 46 8  8  8  8 
## [26] 46 46 46 8  46 8  46
## Levels: 46 8
```

```r
fct_collapse(fact0, "468"= c('4','6','8'))
```

```
##  [1] 468 468 468 468 468 468 468 468 468 468 468 468 468 468 468 468 468 468 468
## [20] 468 468 468 468 468 468 468 468 468 468 468 468 468
## Levels: 468
```

```r
fct_collapse(fact0, "44"='4','666'='6' )
```

```
##  [1] 666 666 44  666 8   666 8   44  44  666 666 8   8   8   8   8   8   44  44 
## [20] 44  44  8   8   8   8   44  44  44  8   666 8   44 
## Levels: 44 666 8
```

```r
fct_recode(fact0, cyl4 = "4", cyl6 = "6", cly8 = "8") 
```

```
##  [1] cyl6 cyl6 cyl4 cyl6 cly8 cyl6 cly8 cyl4 cyl4 cyl6 cyl6 cly8 cly8 cly8 cly8
## [16] cly8 cly8 cyl4 cyl4 cyl4 cyl4 cly8 cly8 cly8 cly8 cyl4 cyl4 cyl4 cly8 cyl6
## [31] cly8 cyl4
## Levels: cyl4 cyl6 cly8
```

```r
fct_other(fact0,keep='8')
```

```
##  [1] Other Other Other Other 8     Other 8     Other Other Other Other 8    
## [13] 8     8     8     8     8     Other Other Other Other 8     8     8    
## [25] 8     Other Other Other 8     Other 8     Other
## Levels: 8 Other
```

```r
fct_other(fact0,drop='8')
```

```
##  [1] 6     6     4     6     Other 6     Other 4     4     6     6     Other
## [13] Other Other Other Other Other 4     4     4     4     Other Other Other
## [25] Other 4     4     4     Other 6     Other 4    
## Levels: 4 6 Other
```

```r
x <- factor(rep(LETTERS[1:9], times = c(40, 10, 5, 27, 1, 1, 1, 1, 1)))
x %>% table()
```

```
## .
##  A  B  C  D  E  F  G  H  I 
## 40 10  5 27  1  1  1  1  1
```

```r
x %>% fct_lump_n(3) %>% table()
```

```
## .
##     A     B     D Other 
##    40    10    27    10
```

```r
x %>% fct_lump_prop(0.10) %>% table()
```

```
## .
##     A     B     D Other 
##    40    10    27    10
```

```r
x %>% fct_lump_min(5) %>% table()
```

```
## .
##     A     B     C     D Other 
##    40    10     5    27     5
```
