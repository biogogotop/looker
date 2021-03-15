+++
author = 'asepsiswu'
title = "geo数据下载"
date = 2020-08-28T16:35:50+08:00
archives = "2020/08" 
tags = [ "" ]
summary = "GEO数据下载"
+++

## vps远程下载GEO数据 
以GSE53622为例,用wget下载
```bash
wget --header "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36" 'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE53622&format=file'

```
或者设置.wgetrc后下载
```bash
echo "header = User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36"  >> ~/.wgetrc

wget 'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE53622&format=file'
```

## split 大文件
```bash
split -d -b 500M GSE53622_raw.tar GSE53622_part_
# server md5sum
md5sum GSE53622_part_*
```

## 用奶牛快传中转
```bash
# 下载 cowtransfer-uploader
curl -sL https://git.io/cowtransfer | sh
# 上传 12 线程
./cowtransfer-uploader -p 12 GSE53622_part_* >> cowurl
```

## 下载到本地 
[https://cowtransfer.com/](https://cowtransfer.com/)
打开6位数字
或者通过http地址 cowtransfer下载
```bash
cat cowurl | grep http | cut -d ' ' -f2 | tr '\n' '  # > urls
cowtransfer-uploader urls
```

## 合并文件 
注意 cowtransfer-uploader 下载会出现数据错误，需要md5sum核对。
错误的数据用网页打开后，aria2c 下载
```bash
# local md5sum
md5sum GSE53622_part_*
cat GSE53622_part_* > GSE53622_raw.tar
```

## 解压文件
```bash
tar xf GSE53622_raw.tar
```
