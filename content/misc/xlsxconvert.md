+++
author = 'asepsiswu'
title = "xls convert to xls"
#date = "2020-12-09"
date = 2020-12-09T12:14:02+08:00
archives = "2020/12" 
tags = [ "xls",'xlsx','import' ]
categories = [ "misc" ]
summary = "readxl 的libxls读取错误解决方法"
+++
## xls转化起因

```R
read_xls('bad.xls')
Error: 
  filepath: bad.xls
  libxls error: Unable to open file
```

## 最佳实践
```bash
sudo pacman -S gnumeric
ssconvert bad1.xls good1.xlsx
```

批量转化
```bash
ls *xls | xargs -i ssconvert {} {}.xlsx
```

## 失败尝试

打开后3个sheet变1个sheet 而且乱码

```bash
sudo pacman -S libreoffice
libreoffice --convert-to xlsx  bad.xls
```

```bash
soffice --headless --convert-to xls --outdir converted *xls
```
