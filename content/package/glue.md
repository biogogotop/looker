+++
author = 'asepsiswu'
title = "glue 简单用法"
date = 2020-06-27
archives = "2020/06" 
tags = [ "tips" ]
summary = "字符串处理工具glue简单用法示例"
+++

## installation 
```r
install.package('glue')
```

## 批量替换
##类似于paste
glue 用{} 执行语句

```r
library(glue)
library(magrittr)
library(data.table)
## 前后的两个变量的长度要求一致
mtcars %>% glue_data("{rownames(.)} has {hp[-1]} hp")
```

```
## Error: Variables must be length 1 or 32
```

```r
mtcars %>% glue_data("{rownames(.)} has {hp} hp")
```

```
## Mazda RX4 has 110 hp
## Mazda RX4 Wag has 110 hp
## Datsun 710 has 93 hp
## Hornet 4 Drive has 110 hp
## Hornet Sportabout has 175 hp
## Valiant has 105 hp
## Duster 360 has 245 hp
## Merc 240D has 62 hp
## Merc 230 has 95 hp
## Merc 280 has 123 hp
## Merc 280C has 123 hp
## Merc 450SE has 180 hp
## Merc 450SL has 180 hp
## Merc 450SLC has 180 hp
## Cadillac Fleetwood has 205 hp
## Lincoln Continental has 215 hp
## Chrysler Imperial has 230 hp
## Fiat 128 has 66 hp
## Honda Civic has 52 hp
## Toyota Corolla has 65 hp
## Toyota Corona has 97 hp
## Dodge Challenger has 150 hp
## AMC Javelin has 150 hp
## Camaro Z28 has 245 hp
## Pontiac Firebird has 175 hp
## Fiat X1-9 has 66 hp
## Porsche 914-2 has 91 hp
## Lotus Europa has 113 hp
## Ford Pantera L has 264 hp
## Ferrari Dino has 175 hp
## Maserati Bora has 335 hp
## Volvo 142E has 109 hp
```


```r
bar <- rep("bar", 5)
glue::glue("foo{bar}")
```

```
## foobar
## foobar
## foobar
## foobar
## foobar
```

### 变量在glue 内部

```r
glue('My name is {name},',
     ' my age next year is {age + 1},',
     ' my anniversary is {format(anniversary, "%A, %B %d, %Y")}.',
     name = "Joe",
     age = 40,
     anniversary = as.Date("2001-10-12"))
```

```
## My name is Joe, my age next year is 41, my anniversary is 星期五, 十月 12, 2001.
```
### glue 用其他的分隔符进行变量eval

```r
one <- "1"
glue("The value of $e^{2\\pi i}$ is $<<one>>$.", .open = "<<", .close = ">>")
```

```
## The value of $e^{2\pi i}$ is $1$.
```

### glue_collapse

```r
glue_collapse(glue("{1:10}"), width = 5)
```

```
## 12...
```

```r
glue_collapse(1:4, ", ", last = " and ")
```

```
## 1, 2, 3 and 4
```
## glue in data.table

```r
mtcars <- as.data.table(mtcars)
mtcars[, glue_data(.SD, "{rownames(mtcars)} has {hp} hp")]
```

```
## 1 has 110 hp
## 2 has 110 hp
## 3 has 93 hp
## 4 has 110 hp
## 5 has 175 hp
## 6 has 105 hp
## 7 has 245 hp
## 8 has 62 hp
## 9 has 95 hp
## 10 has 123 hp
## 11 has 123 hp
## 12 has 180 hp
## 13 has 180 hp
## 14 has 180 hp
## 15 has 205 hp
## 16 has 215 hp
## 17 has 230 hp
## 18 has 66 hp
## 19 has 52 hp
## 20 has 65 hp
## 21 has 97 hp
## 22 has 150 hp
## 23 has 150 hp
## 24 has 245 hp
## 25 has 175 hp
## 26 has 66 hp
## 27 has 91 hp
## 28 has 113 hp
## 29 has 264 hp
## 30 has 175 hp
## 31 has 335 hp
## 32 has 109 hp
```

```r
mtcars[, glue( "{rownames(mtcars)} has {hp} hp", .envir=.SD)]
```

```
## Mazda RX4 has 110 hp
## Mazda RX4 Wag has 110 hp
## Datsun 710 has 93 hp
## Hornet 4 Drive has 110 hp
## Hornet Sportabout has 175 hp
## Valiant has 105 hp
## Duster 360 has 245 hp
## Merc 240D has 62 hp
## Merc 230 has 95 hp
## Merc 280 has 123 hp
## Merc 280C has 123 hp
## Merc 450SE has 180 hp
## Merc 450SL has 180 hp
## Merc 450SLC has 180 hp
## Cadillac Fleetwood has 205 hp
## Lincoln Continental has 215 hp
## Chrysler Imperial has 230 hp
## Fiat 128 has 66 hp
## Honda Civic has 52 hp
## Toyota Corolla has 65 hp
## Toyota Corona has 97 hp
## Dodge Challenger has 150 hp
## AMC Javelin has 150 hp
## Camaro Z28 has 245 hp
## Pontiac Firebird has 175 hp
## Fiat X1-9 has 66 hp
## Porsche 914-2 has 91 hp
## Lotus Europa has 113 hp
## Ford Pantera L has 264 hp
## Ferrari Dino has 175 hp
## Maserati Bora has 335 hp
## Volvo 142E has 109 hp
```

```r
mtcars[, glue( "{rownames(mtcars)} has {hp} hp", hp=hp)]
```

```
## 1 has 110 hp
## 2 has 110 hp
## 3 has 93 hp
## 4 has 110 hp
## 5 has 175 hp
## 6 has 105 hp
## 7 has 245 hp
## 8 has 62 hp
## 9 has 95 hp
## 10 has 123 hp
## 11 has 123 hp
## 12 has 180 hp
## 13 has 180 hp
## 14 has 180 hp
## 15 has 205 hp
## 16 has 215 hp
## 17 has 230 hp
## 18 has 66 hp
## 19 has 52 hp
## 20 has 65 hp
## 21 has 97 hp
## 22 has 150 hp
## 23 has 150 hp
## 24 has 245 hp
## 25 has 175 hp
## 26 has 66 hp
## 27 has 91 hp
## 28 has 113 hp
## 29 has 264 hp
## 30 has 175 hp
## 31 has 335 hp
## 32 has 109 hp
```

```r
mtcars[1:5, glue( "{rownames(mtcars)[1:5]} has {hp} hp", hp=hp[1:5])]
```

```
## 1 has 110 hp
## 2 has 110 hp
## 3 has 93 hp
## 4 has 110 hp
## 5 has 175 hp
```
