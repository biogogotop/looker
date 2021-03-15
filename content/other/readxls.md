+++
author = 'asepsiswu'
title = "R读取xls文件的各种尝试"
#date = "2020-12-09"
date = 2020-12-09T12:27:19+08:00
archives = "2020/12" 
tags = [ "" ]
categories = [ "" ]
summary = "readxl, xlsx, gdata和XLConnect"
+++



```r
badxls <-'/mnt/lab/PTG1/Results/tmps/bad.xls'
```
## gdata 失败

```r
gdata.xls <- gdata::read.xls(badxls,3)
```

```
## Warning in read.table(file = file, header = header, sep = sep, quote = quote, :
## line 1 appears to contain embedded nulls
```

```
## Warning in read.table(file = file, header = header, sep = sep, quote = quote, :
## line 2 appears to contain embedded nulls
```

```
## Warning in read.table(file = file, header = header, sep = sep, quote = quote, :
## line 3 appears to contain embedded nulls
```

```
## Warning in read.table(file = file, header = header, sep = sep, quote = quote, :
## line 4 appears to contain embedded nulls
```

```
## Warning in read.table(file = file, header = header, sep = sep, quote = quote, :
## line 5 appears to contain embedded nulls
```

```
## Warning in read.table(file = file, header = header, sep = sep, quote = quote, :
## line 1 appears to contain embedded nulls
```

```
## Warning in scan(file = file, what = what, sep = sep, quote = quote, dec = dec, :
## embedded nul(s) found in input
```

```r
warnings()
head(gdata.xls)
```

```
##       X X.1 X....U
## 1 \001P           
## 2                 
## 3                 
## 4                 
## 5                 
## 6
```

## read_xl 失败

```r
readxl::read_excel(badxls,3)
```

```
## Error: 
##   filepath: /mnt/lab/PTG1/Results/tmps/bad.xls
##   libxls error: Unable to open file
```

## XLConnect 失败

```r
XLConnect::readWorksheetFromFile(badxls,3)
```

```
## Error: .onLoad failed in loadNamespace() for 'rJava', details:
##   call: dyn.load(file, DLLpath = DLLpath, ...)
##   error: unable to load shared object '/mnt/code/R/x86_64-pc-linux-gnu-library/4.0/rJava/libs/rJava.so':
##   libjvm.so: cannot open shared object file: No such file or directory
```
## xlsx


```r
xlsx::read.xlsx(badxls,3)
```

```
## Error: .onLoad failed in loadNamespace() for 'rJava', details:
##   call: dyn.load(file, DLLpath = DLLpath, ...)
##   error: unable to load shared object '/mnt/code/R/x86_64-pc-linux-gnu-library/4.0/rJava/libs/rJava.so':
##   libjvm.so: cannot open shared object file: No such file or directory
```
## openxlsx

```r
openxlsx::read.xlsx(badxls,3)
```

```
## Error in read.xlsx.default(badxls, 3): openxlsx can not read .xls or .xlm files!
```


