+++
author = 'asepsiswu'
title = "doocs 优秀的微信markdown编辑器"
#date = "2020-12-14"
date = 2020-12-14T14:09:02+08:00
archives = "2020/12" 
tags = [ "output" ]
categories = [ "misc" ]
summary = "部署微信markdown编辑器doocs"
+++
# 应用doocs/md进行微信公众号写作

## 缘起
微信公众号的自带的编辑器是相当的不友好。粘贴文本后的格式不与上下文一致，调整起来很容易出问题，自带的粘贴选项真是无语。图片插入也是一个超级麻烦的事情。最近碰到一个较好用的写作工具，doocs/md 大大减轻了工作。

## 试用一下
[https://doocs.gitee.io/md/](https://doocs.gitee.io/md/) 点击即食。
优点：

    1. markdown写作，方便
    2. 图片插入方便，右键就可以方便的上传图片。
    3. 可以自定义css。（待深入研究）

## 上传图片格式以外的文件
R语言的代码中往往需要一些示例数据。上传非图片格式的文件的一种方法，文件的末尾加上.png或.jpg等后缀，然后上传即可。上传后会自动去除新的后缀。这样的缺点是本地的文件需要重命名2次。另一种做法就是把这个限制取消掉。

## 本地部署微信markdown编辑器doocs/md
```
在服务器上安装 node 环境；

克隆本项目到服务器：git clone git@github.com:doocs/md.git；

# 取消图片文件格式上传的限制
修改return值 vim src/assets/scripts/util.js +281

项目目录下运行：npm install；

运行打包：npm run build；

dist 文件夹即为打包后的代码；

cp -r dist/* /var/www/html/md/

搭建 http 服务，部署包文件。
```

## 部署遇到一些问题:

1. git clone有时候不成功，直接页面上下载。国内有镜像，github替换为gitee即可

2. npm install速度比较慢，使用淘宝镜像

```
npm config set registry https://registry.npm.taobao.org
```

3. 搭建http服务

```
sudo pacman -S nginx

sudo mkdir -p /usr/local/nginx/logs/
```

添加`pid /usr/local/nginx/logs/nginx.pid;` 到`/etc/nginx/nginx.conf`，解决`open() "/var/run/nginx/nginx.pid" failed (2: No such file or directory）`错误


## 本地使用
本地打开`127.0.0.1/md`即可



