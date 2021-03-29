+++
author = 'asepsiswu'
title = "XLConnect 安装"
#date = "2020-12-09"
date = 2020-12-09T11:39:11+08:00
archives = "2020/12" 
tags = [ "import" ]
categories = [ "R" ]
summary = "网络下载失败jar包的情况下,安装相应的jar包"
+++

## 基本命令
```R
install.packages("rJava")
install.packages("XLConnect", dependencies=TRUE)
```
## rJava安装问题

java 版本样 8-11之间, `extra/jdk-openjdk`和`jre11-openjdk`都有点问题

```bash
sudo pacman -S jdk8-openjdk

# 检查java是否符合
sudo R CMD javareconf
```

## XLCONNECT安装问题
loading test 失败， 需要一些依赖的jar文件，网络不好的情况下完蛋

###  先下载相应的jar文件
```bash
wget https://repo1.maven.org/maven2/org/apache/poi/poi/4.1.1/poi-4.1.1.jar
wget https://repo1.maven.org/maven2/org/apache/commons/commons-compress/1.19/commons-compress-1.19.jar
wget https://repo1.maven.org/maven2/org/apache/xmlbeans/xmlbeans/3.1.0/xmlbeans-3.1.0.jar
wget https://repo1.maven.org/maven2/org/apache/commons/commons-collections4/4.4/commons-collections4-4.4.jar
wget https://repo1.maven.org/maven2/org/apache/commons/commons-math3/3.6.1/commons-math3-3.6.1.jar
wget https://repo1.maven.org/maven2/org/apache/commons-codec/commons-codec/1.13/commons-codec-1.13.jar
wget https://repo1.maven.org/maven2/org/apache/poi/ooxml-schemas/1.4/ooxml-schemas-1.4.jar
wget https://repo1.maven.org/maven2/org/apache/poi/poi-ooxml/4.1.1/poi-ooxml-4.1.1.jar
```

###  移动相应文件到制定目录
```bash
tree org
```

```
org
└── apache
    ├── commons
    │   ├── commons-collections4
    │   │   └── 4.4
    │   │       └── commons-collections4-4.4.jar
    │   ├── commons-compress
    │   │   └── 1.19
    │   │       └── commons-compress-1.19.jar
    │   └── commons-math3
    │       └── 3.6.1
    │           └── commons-math3-3.6.1.jar
    ├── commons-codec
    │   └── commons-codec
    │       └── 1.13
    │           └── commons-codec-1.13.jar
    ├── poi
    │   ├── ooxml-schemas
    │   │   └── 1.4
    │   │       └── ooxml-schemas-1.4.jar
    │   ├── poi
    │   │   └── 4.1.1
    │   │       └── poi-4.1.1.jar
    │   └── poi-ooxml
    │       └── 4.1.1
    │           └── poi-ooxml-4.1.1.jar
    └── xmlbeans
        └── xmlbeans
            └── 3.1.0
                └── xmlbeans-3.1.0.jar

21 directories, 8 files
```

###  设置repo

用hugo server建立一个临时网站，将org文件夹移动到content目录下
```R
Sys.setenv("XLCONNECT_JAVA_REPO_URL"='http://localhost:1313/')
install.packages("XLConnect", dependencies=TRUE)
```

## 后记

readxl 不能读取的xls文件依然不能读取

```R
XLConnect::readNamedRegionFromFile('20201030-N-川-1.xls')
```
```
Error: RuntimeException (Java): Found EOFRecord before WindowTwoRecord was encountered
```
