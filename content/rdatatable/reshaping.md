+++
author = 'asepsiswu'
title = "reshaping data.table"
date = 2020-06-07
archives = "2020/06" 
tags = [ "data.table" ]
summary = "melt(变长) and cast(变宽) data"
+++

# melt and dcast data
melt --> molten data,long data 

cast --> wide data

melt经常和cast记混，一个小技巧molten boots（长靴，长）用于辅助记忆

[参考网页](https://cran.r-project.org/web/packages/data.table/vignettes/datatable-reshape.html)

## melt data to long


```r
library(data.table)
s1 <- "family_id age_mother dob_child1 dob_child2 dob_child3
1         30 1998-11-26 2000-01-29         NA
2         27 1996-06-22         NA         NA
3         26 2002-07-11 2004-04-05 2007-09-02
4         32 2004-10-10 2009-08-27 2012-07-21
5         29 2000-12-05 2005-02-28         NA"
DT <- fread(s1)
DT
```

```
##    family_id age_mother dob_child1 dob_child2 dob_child3
## 1:         1         30 1998-11-26 2000-01-29       <NA>
## 2:         2         27 1996-06-22       <NA>       <NA>
## 3:         3         26 2002-07-11 2004-04-05 2007-09-02
## 4:         4         32 2004-10-10 2009-08-27 2012-07-21
## 5:         5         29 2000-12-05 2005-02-28       <NA>
```

```r
## dob stands for date of birth.
```

`id.var` => row id,  `measure.vars `=> column variable to melt
两者具备最清楚

```r
DT.m1 <- melt(DT, id.vars = c("family_id", "age_mother"),
                measure.vars = c("dob_child1", "dob_child2", "dob_child3"))
DT.m1
```

```
##     family_id age_mother   variable      value
##  1:         1         30 dob_child1 1998-11-26
##  2:         2         27 dob_child1 1996-06-22
##  3:         3         26 dob_child1 2002-07-11
##  4:         4         32 dob_child1 2004-10-10
##  5:         5         29 dob_child1 2000-12-05
##  6:         1         30 dob_child2 2000-01-29
##  7:         2         27 dob_child2       <NA>
##  8:         3         26 dob_child2 2004-04-05
##  9:         4         32 dob_child2 2009-08-27
## 10:         5         29 dob_child2 2005-02-28
## 11:         1         30 dob_child3       <NA>
## 12:         2         27 dob_child3       <NA>
## 13:         3         26 dob_child3 2007-09-02
## 14:         4         32 dob_child3 2012-07-21
## 15:         5         29 dob_child3       <NA>
```


By default, when one of `id.vars` or `measure.vars` is missing, the rest of the columns are *automatically assigned* to the missing argument.

```r
DT.m1 = melt(DT, measure.vars = c("dob_child1", "dob_child2", "dob_child3"),
               variable.name = "child", value.name = "dob")
DT.m1
```

```
##     family_id age_mother      child        dob
##  1:         1         30 dob_child1 1998-11-26
##  2:         2         27 dob_child1 1996-06-22
##  3:         3         26 dob_child1 2002-07-11
##  4:         4         32 dob_child1 2004-10-10
##  5:         5         29 dob_child1 2000-12-05
##  6:         1         30 dob_child2 2000-01-29
##  7:         2         27 dob_child2       <NA>
##  8:         3         26 dob_child2 2004-04-05
##  9:         4         32 dob_child2 2009-08-27
## 10:         5         29 dob_child2 2005-02-28
## 11:         1         30 dob_child3       <NA>
## 12:         2         27 dob_child3       <NA>
## 13:         3         26 dob_child3 2007-09-02
## 14:         4         32 dob_child3 2012-07-21
## 15:         5         29 dob_child3       <NA>
```


##  `melt` multiple columns simultaneously

```r
s2 <- "family_id age_mother dob_child1 dob_child2 dob_child3 gender_child1 gender_child2 gender_child3
1         30 1998-11-26 2000-01-29         NA             1             2            NA
2         27 1996-06-22         NA         NA             2            NA            NA
3         26 2002-07-11 2004-04-05 2007-09-02             2             2             1
4         32 2004-10-10 2009-08-27 2012-07-21             1             1             1
5         29 2000-12-05 2005-02-28         NA             2             1            NA"
DT <- fread(s2)
DT
```

```
##    family_id age_mother dob_child1 dob_child2 dob_child3 gender_child1
## 1:         1         30 1998-11-26 2000-01-29       <NA>             1
## 2:         2         27 1996-06-22       <NA>       <NA>             2
## 3:         3         26 2002-07-11 2004-04-05 2007-09-02             2
## 4:         4         32 2004-10-10 2009-08-27 2012-07-21             1
## 5:         5         29 2000-12-05 2005-02-28       <NA>             2
##    gender_child2 gender_child3
## 1:             2            NA
## 2:            NA            NA
## 3:             2             1
## 4:             1             1
## 5:             1            NA
```
melt多列时，`measure`变量传递`list`进去即可
### `measure` 直接赋值

```r
colA = paste("dob_child", 1:3, sep = "")
colB = paste("gender_child", 1:3, sep = "")
DT.m2 = melt(DT, measure = list(colA, colB), value.name = c("dob", "gender"))
DT.m2
```

```
##     family_id age_mother variable        dob gender
##  1:         1         30        1 1998-11-26      1
##  2:         2         27        1 1996-06-22      2
##  3:         3         26        1 2002-07-11      2
##  4:         4         32        1 2004-10-10      1
##  5:         5         29        1 2000-12-05      2
##  6:         1         30        2 2000-01-29      2
##  7:         2         27        2       <NA>     NA
##  8:         3         26        2 2004-04-05      2
##  9:         4         32        2 2009-08-27      1
## 10:         5         29        2 2005-02-28      1
## 11:         1         30        3       <NA>     NA
## 12:         2         27        3       <NA>     NA
## 13:         3         26        3 2007-09-02      1
## 14:         4         32        3 2012-07-21      1
## 15:         5         29        3       <NA>     NA
```
注意多产生的variable一列其实对应的是child那列
### `measure` 用patterns分类

```r
DT.m2 = melt(DT, measure = patterns("^dob", "^gender"), value.name = c("dob", "gender"))
DT.m2
```

```
##     family_id age_mother variable        dob gender
##  1:         1         30        1 1998-11-26      1
##  2:         2         27        1 1996-06-22      2
##  3:         3         26        1 2002-07-11      2
##  4:         4         32        1 2004-10-10      1
##  5:         5         29        1 2000-12-05      2
##  6:         1         30        2 2000-01-29      2
##  7:         2         27        2       <NA>     NA
##  8:         3         26        2 2004-04-05      2
##  9:         4         32        2 2009-08-27      1
## 10:         5         29        2 2005-02-28      1
## 11:         1         30        3       <NA>     NA
## 12:         2         27        3       <NA>     NA
## 13:         3         26        3 2007-09-02      1
## 14:         4         32        3 2012-07-21      1
## 15:         5         29        3       <NA>     NA
```

## cast data 变宽
dcast 用`formula`的`LHS`表示`id.var`(row id, 而`RHS`代表`measure.var`,即需要变宽的列

```r
dcast(DT.m1, family_id + age_mother ~ child, value.var = "dob")
```

```
##    family_id age_mother dob_child1 dob_child2 dob_child3
## 1:         1         30 1998-11-26 2000-01-29       <NA>
## 2:         2         27 1996-06-22       <NA>       <NA>
## 3:         3         26 2002-07-11 2004-04-05 2007-09-02
## 4:         4         32 2004-10-10 2009-08-27 2012-07-21
## 5:         5         29 2000-12-05 2005-02-28       <NA>
```

## cast multiple column

```r
## new 'cast' functionality - multiple value.vars
DT.c2 = dcast(DT.m2, family_id + age_mother ~ variable, value.var = c("dob", "gender"))
DT.c2
```

```
##    family_id age_mother      dob_1      dob_2      dob_3 gender_1 gender_2
## 1:         1         30 1998-11-26 2000-01-29       <NA>        1        2
## 2:         2         27 1996-06-22       <NA>       <NA>        2       NA
## 3:         3         26 2002-07-11 2004-04-05 2007-09-02        2        2
## 4:         4         32 2004-10-10 2009-08-27 2012-07-21        1        1
## 5:         5         29 2000-12-05 2005-02-28       <NA>        2        1
##    gender_3
## 1:       NA
## 2:       NA
## 3:        1
## 4:        1
## 5:       NA
```
需要注意的是`formula`里的`variable`变量，对应的是`value.var`的每个序列。
dcast失败往往是缺失这个合适的变量这个引起的
