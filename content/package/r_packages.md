+++
author = 'asepsiswu'
title = "r packages install"
date = "2019-10-10"
archives = "2019/10" 
tags = [ "Rstudio" ]
summary = "R 包安装"
+++
# R 包安装
## CRAN和Bioc安装源配置
清华或中科大
```
镜像源配置文件之一是 .Rprofile (linux 下位于 ~/.Rprofile )。

在文末添加如下语句:

options("repos" = c(CRAN="https://mirrors.tuna.tsinghua.edu.cn/CRAN/"))
options(BioC_mirror="https://mirrors.tuna.tsinghua.edu.cn/bioconductor")
或
options(BioC_mirror="https://mirrors.ustc.edu.cn/bioc/")
options("repos" = c(CRAN='https://mirrors.ustc.edu.cn/CRAN/'))

```

## 安装小技巧
```
设置destdir使得避免安装失败,可手工安装
install.packages(pks, destdir="~/Downloads/")
```

##  update package
```
pks = old.packages()[,1]
lapply(old.packages()[,1], install.packages)
```

## install.package的替代
```
BiocManager::install(pkg)
```

## linux系统依赖的库
```
make: gfortran: Command not found
sudo pacman -S gcc-fortran

*** Install PROJ.4 and if necessary set PKG_CPPFLAGS/PKG_LIBS accordingly.
ERROR: configuration failed for package ‘proj4’
sudo pacman -S proj

configure: error: gdal-config not found or not executable.
sudo pacman -S gdal

Configuration failed because libudunits2.so was not found. 
yay -S udunits
```

