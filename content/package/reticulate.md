+++
author = 'asepsiswu'
title = "reticulate R 使用python获取股票信息 "
#date = "2020-12-01"
date = 2020-12-01T16:12:53+08:00
archives = "2020/12" 
tags = [ "" ]
categories = [ "" ]
summary = "R 环境中使用python"
+++

## 配置python环境
(证券宝)[http://baostock.com/baostock/index.php/%E9%A6%96%E9%A1%B5]
```python
pip install --user baostock -i https://pypi.tuna.tsinghua.edu.cn/simple/ --trusted-host pypi.tuna.tsinghua.edu.cn
```
##安装R 包
```R
install.package('reticulate')
```

## 示例
###  Rstudio 中设置python

```r
library(purrr)
library(data.table)
```

```
## 
## Attaching package: 'data.table'
```

```
## The following object is masked from 'package:purrr':
## 
##     transpose
```

```r
library(reticulate)
use_python('/usr/bin/python')
# ?import
# import baostock as bs
bs <- import('baostock')
bs$login()
```

```
## <baostock.data.resultset.ResultData>
```

```r
# bs$logout()
```
###  提取行业数据

```r
stock_industry <- bs$query_stock_industry()
stock_industry.data <- stock_industry$data
stock_industry.dt <- rbindlist(map(stock_industry.data,as.list) )
setnames(stock_industry.dt,c('updateDate',      'code', 'code_name',    'industry',     'industryClassification'))
stock_industry.dt <- stock_industry.dt[!code %like% '^\\w\\w.300']# 去除创业板
stock_industry.dt
```

```
##       updateDate      code code_name industry industryClassification
##    1: 2020-11-30 sh.600000  浦发银行     银行           申万一级行业
##    2: 2020-11-30 sh.600001  邯郸钢铁                    申万一级行业
##    3: 2020-11-30 sh.600002  齐鲁石化                    申万一级行业
##    4: 2020-11-30 sh.600003  ST东北高                    申万一级行业
##    5: 2020-11-30 sh.600004  白云机场 交通运输           申万一级行业
##   ---                                                               
## 3322: 2020-11-30 sz.003016  欣贺股份 纺织服装           申万一级行业
## 3323: 2020-11-30 sz.003017  大洋生物     化工           申万一级行业
## 3324: 2020-11-30 sz.003018  金富科技 轻工制造           申万一级行业
## 3325: 2020-11-30 sz.003019  宸展光电     电子           申万一级行业
## 3326: 2020-11-30 sz.003816  中国广核 公用事业           申万一级行业
```

```r
stock_industry.dt$industry %>% table()
```

```
## .
##          交通运输 休闲服务     传媒 公用事业 农林牧渔     化工 医药生物 
##      117      116       31      122      151       72      289      265 
## 商业贸易 国防军工 家用电器 建筑材料 建筑装饰   房地产 有色金属 机械设备 
##       94       57       55       63      112      129      115      268 
##     汽车     电子 电气设备 纺织服装     综合   计算机 轻工制造     通信 
##      162      205      151       79       30      135      129       65 
##     采掘     钢铁     银行 非银金融 食品饮料 
##       63       34       37       81       99
```

###  提取中石化信息

```r
zsh  <- bs$query_history_k_data_plus("sh.600028","date,code,open,high,low,close,preclose,volume,amount,turn,pctChg",'2018-01-01',as.character(Sys.Date()))$get_data()
head(zsh)
```

```
##         date      code   open   high    low  close preclose    volume
## 1 2018-01-02 sh.600028 6.1600 6.4700 6.1600 6.3700   6.1300 367565296
## 2 2018-01-03 sh.600028 6.3600 6.5200 6.3400 6.4700   6.3700 243152488
## 3 2018-01-04 sh.600028 6.5600 7.0800 6.5600 6.9000   6.4700 510094816
## 4 2018-01-05 sh.600028 6.9000 7.1800 6.8500 7.0600   6.9000 426639408
## 5 2018-01-08 sh.600028 7.0200 7.1400 6.9800 7.0500   7.0600 334920720
## 6 2018-01-09 sh.600028 7.0700 7.1100 6.9300 7.0000   7.0500 271378720
##            amount     turn    pctChg
## 1 2335727277.0000 0.384652  3.915168
## 2 1565879199.0000 0.254456  1.569857
## 3 3459262630.0000 0.533808  6.646064
## 4 2998758893.0000 0.446473  2.318838
## 5 2364425490.0000 0.350490 -0.141640
## 6 1897963573.0000 0.283994 -0.709223
```
