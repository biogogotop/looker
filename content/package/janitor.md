+++
author = 'asepsiswu'
title = "janitor 包"
#date = "2020-09-03"
date = 2020-09-03T10:20:29+08:00
archives = "2020/09" 
tags = [ "" ]
summary = "janitor clean_name可用 和get_dups"
+++
## janitor 

```r
library(janitor)
library(data.table)
head(iris)
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
```

```r
dt <- data.table(iris)
dt[, "x y z":='x y z']
```
## clean_name 将colname修改

```r
iris %>% clean_names() %>% head()
```

```
##   sepal_length sepal_width petal_length petal_width species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
```

## data.table 中使用clean_name

```r
dt2 <- dt %>% clean_names()
dt3 <- dt[,clean_names(.SD)]
identical(dt2,dt3)
```

```
## [1] TRUE
```

```r
dt2
```

```
##      sepal_length sepal_width petal_length petal_width   species x_y_z
##   1:          5.1         3.5          1.4         0.2    setosa x y z
##   2:          4.9         3.0          1.4         0.2    setosa x y z
##   3:          4.7         3.2          1.3         0.2    setosa x y z
##   4:          4.6         3.1          1.5         0.2    setosa x y z
##   5:          5.0         3.6          1.4         0.2    setosa x y z
##  ---                                                                  
## 146:          6.7         3.0          5.2         2.3 virginica x y z
## 147:          6.3         2.5          5.0         1.9 virginica x y z
## 148:          6.5         3.0          5.2         2.0 virginica x y z
## 149:          6.2         3.4          5.4         2.3 virginica x y z
## 150:          5.9         3.0          5.1         1.8 virginica x y z
```
## get_dupes 查重
速度较慢

```r
get_dupes(dt[,1:3])
```

```
## No variable names specified - using all columns.
```

```
##     Sepal.Length Sepal.Width Petal.Length dupe_count
##  1:          4.8         3.0          1.4          2
##  2:          4.8         3.0          1.4          2
##  3:          4.9         3.1          1.5          2
##  4:          4.9         3.1          1.5          2
##  5:          5.1         3.5          1.4          2
##  6:          5.1         3.5          1.4          2
##  7:          5.8         2.7          5.1          2
##  8:          5.8         2.7          5.1          2
##  9:          6.4         2.8          5.6          2
## 10:          6.4         2.8          5.6          2
## 11:          6.7         3.3          5.7          2
## 12:          6.7         3.3          5.7          2
```

## tabyl: table function with data.frame 

```r
tabyl(mtcars,cyl, gear) %>% adorn_totals()
```

```
##    cyl  3  4 5
##      4  1  8 2
##      6  2  4 1
##      8 12  0 2
##  Total 15 12 5
```

```r
tabyl(dt2, species, x_y_z) %>% adorn_title ()
```

```
##             x_y_z
##     species x y z
##      setosa    50
##  versicolor    50
##   virginica    50
```

