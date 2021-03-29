+++
author = 'asepsiswu'
title = "convert list of vectors to data.frame"
date = 2021-03-23T16:54:18+08:00
archives = "2021/03" 
tags = [ "transform","data.table" ]
categories = [ "R" ]
summary = "将list of vector 转化为data.frame"
+++

最优选择 `rbindlist(lapply(listvector,as.data.frame.list), idcol='rowname')`

其次 `do.call(rbind, listvector)`, 缺失会自动填补

不太建议用 `dplyr::bind_rows`, 会丢失`list`的`name`



```r
library(knitr)
library(purrr)
library(data.table)
lv1 <- lv2 <- lv3 <- asplit(mtcars[1:4,1:4],1)
lv2[[2]] <- c('mpg'=21,'cyl'=6)
lv3[[2]] <- c('21','6')
lv3  
```



|               |x                       |
|:--------------|:-----------------------|
|Mazda RX4      |21, 6, 160, 110         |
|Mazda RX4 Wag  |21, 6                   |
|Datsun 710     |22.8, 4.0, 108.0, 93.0  |
|Hornet 4 Drive |21.4, 6.0, 258.0, 110.0 |
---
### `rbindlist`

```r
map(lv1, as.data.frame.list) %>% rbindlist(idcol = 'rowname') 
```



|rowname        |  mpg| cyl| disp|  hp|
|:--------------|----:|---:|----:|---:|
|Mazda RX4      | 21.0|   6|  160| 110|
|Mazda RX4 Wag  | 21.0|   6|  160| 110|
|Datsun 710     | 22.8|   4|  108|  93|
|Hornet 4 Drive | 21.4|   6|  258| 110|

```r
map(lv2, as.data.frame.list) %>% rbindlist(fill = T) 
```



|  mpg| cyl| disp|  hp|
|----:|---:|----:|---:|
| 21.0|   6|  160| 110|
| 21.0|   6|   NA|  NA|
| 22.8|   4|  108|  93|
| 21.4|   6|  258| 110|

```r
map(lv3, as.data.frame.list) %>% rbindlist(fill = T) 
```



|  mpg| cyl| disp|  hp|X.21. |X.6. |
|----:|---:|----:|---:|:-----|:----|
| 21.0|   6|  160| 110|NA    |NA   |
|   NA|  NA|   NA|  NA|21    |6    |
| 22.8|   4|  108|  93|NA    |NA   |
| 21.4|   6|  258| 110|NA    |NA   |
###  `do.call`

```r
do.call(rbind,lv1 ) 
```



|               |  mpg| cyl| disp|  hp|
|:--------------|----:|---:|----:|---:|
|Mazda RX4      | 21.0|   6|  160| 110|
|Mazda RX4 Wag  | 21.0|   6|  160| 110|
|Datsun 710     | 22.8|   4|  108|  93|
|Hornet 4 Drive | 21.4|   6|  258| 110|

```r
do.call(rbind,lv2) 
```



|               |  mpg| cyl| disp|  hp|
|:--------------|----:|---:|----:|---:|
|Mazda RX4      | 21.0|   6|  160| 110|
|Mazda RX4 Wag  | 21.0|   6|   21|   6|
|Datsun 710     | 22.8|   4|  108|  93|
|Hornet 4 Drive | 21.4|   6|  258| 110|

```r
do.call(rbind,lv3) 
```



|               |mpg  |cyl |disp |hp  |
|:--------------|:----|:---|:----|:---|
|Mazda RX4      |21   |6   |160  |110 |
|Mazda RX4 Wag  |21   |6   |21   |6   |
|Datsun 710     |22.8 |4   |108  |93  |
|Hornet 4 Drive |21.4 |6   |258  |110 |


### `bind_rows`

```r
dplyr::bind_rows(lv1,.id='rowname') 
```



|rowname |  mpg| cyl| disp|  hp|
|:-------|----:|---:|----:|---:|
|1       | 21.0|   6|  160| 110|
|2       | 21.0|   6|  160| 110|
|3       | 22.8|   4|  108|  93|
|4       | 21.4|   6|  258| 110|

```r
dplyr::bind_rows(lv2) 
```



|  mpg| cyl| disp|  hp|
|----:|---:|----:|---:|
| 21.0|   6|  160| 110|
| 21.0|   6|   NA|  NA|
| 22.8|   4|  108|  93|
| 21.4|   6|  258| 110|

```r
dplyr::bind_rows(lv3) 
```

```
## Error: Argument 2 must have names.
```
