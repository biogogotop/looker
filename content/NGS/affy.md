+++
author = 'asepsiswu'
title = "affymetrix array分析"
#date = "2020-08-19"
date = 2020-08-19T11:28:47+08:00
archives = "2020/08" 
tags = [ "" ]
summary = "brainarray 分析"
+++

## brainarray 
[custom CDF](http://brainarray.mbni.med.umich.edu/Brainarray/Database/CustomCDF/CDF_download.asp)进入ENSG子页面后，下载对应的U-133A和U-133B的custom cdf和 probe
### 133A和133B
```
37	Homo_sapiens	HGU133A	HGU133A_Hs_ENSG	 C P
39	Homo_sapiens	HGU133B	HGU133B_Hs_ENSG  C P
http://mbni.org/customcdf/24.0.0/ensg.download/hgu133ahsensgcdf_24.0.0.tar.gz
http://mbni.org/customcdf/24.0.0/ensg.download/hgu133ahsensgprobe_24.0.0.tar.gz
http://mbni.org/customcdf/24.0.0/ensg.download/hgu133bhsensgcdf_24.0.0.tar.gz
http://mbni.org/customcdf/24.0.0/ensg.download/hgu133bhsensgprobe_24.0.0.tar.gz
```

###  R安装 上述cdf和probe 

## 处理数据 GSE23400
- 下载样本信息
```bash
aria2c --header "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36"  https://www.ncbi.nlm.nih.gov/geo/download/\?acc\=GSE23400\&format\=file
```
- 处理页面信息
```R
library(xml2)
library(affy)
library(purrr)
library(data.table)
html <- read_html('/mnt/TCGA/escc/GSE23400/acc.cgi?acc=GSE23400')
tr <- xml_find_all(html,"//table/tr")
## 分离出 GSE和样本编号
txt <- map(tr, ~ xml_text(xml_children(.x)))
txt2 <- keep(txt,~ grepl('^AE',.x[2]))
# df <- data.table( do.call("rbind",txt2))
dt <- as.data.table(transpose(txt2))

## 1:106为133A
dt[1:106,platform:="133A"]
dt[107:208,platform:="133B"]
dt[, cel:= paste0('/mnt/TCGA/escc/GSE23400/',dt$V1,'.CEL.gz')]
dt[,sample:=substr(V2,1,4)]
dt[,his:=substr(V2,5,5)]
dt
```
- 预处理芯片
注意cdfname要和brainarray注释的一致
```R
aff133A <- ReadAffy(filenames = dt[platform=='133A'][,cel], cdfname = 'HGU133A_Hs_ENSG')
aff133B <- ReadAffy(filenames = dt[platform=='133B'][,cel], cdfname = 'HGU133B_Hs_ENSG')
eset133A <- rma(aff133A)
eset133B <- rma(aff133B)
#exa <- exprs(eset133A)
#exb <- exprs(eset133B)
```
- 差异分析
```R
library(limma)
design133A <- model.matrix(~sample+his, dt[platform=='133A'])
fit <- lmFit(eset133A, design133A)
fit <- eBayes(fit)
topTable(fit, coef="hisT")
deg133A <- topTable(fit, number = Inf ,coef="hisT")

design133B <- model.matrix(~sample+his, dt[platform=='133B'])
fit <- lmFit(eset133B, design133B)
fit <- eBayes(fit)
topTable(fit, coef="hisT")
deg133B <- topTable(fit, number = Inf ,coef="hisT")
save(eset133A,eset133B,deg133A,deg133B,file = "rdata/gse23400.rda")
```
## 非brainarray cdf 处理
- 预处理及差异分析
```R
aff133A <- ReadAffy(filenames = dt[platform=='133A'][,cel] )
aff133B <- ReadAffy(filenames = dt[platform=='133B'][,cel] )
eset133A <- rma(aff133A)
eset133B <- rma(aff133B)
#exa <- exprs(eset133A)
#exb <- exprs(eset133B)

library(limma)
design133A <- model.matrix(~sample+his, dt[platform=='133A'])
fit <- lmFit(eset133A, design133A)
fit <- eBayes(fit)
deg133A <- topTable(fit, number = Inf ,coef="hisT")

design133B <- model.matrix(~sample+his, dt[platform=='133B'])
fit <- lmFit(eset133B, design133B)
fit <- eBayes(fit)
deg133B <- topTable(fit, number = Inf ,coef="hisT")
```
- probe 注释
```R
library(biomaRt)
ensembl <- useEnsembl(biomart = "ensembl",  dataset = "hsapiens_gene_ensembl")
searchAttributes(mart = ensembl, pattern = "133")
probeann133A <- getBM( mart = ensembl, 
  attributes = c( "affy_hg_u133a", "ensembl_gene_id", "external_gene_name"),
  filter = "affy_hg_u133a",
  values = rownames(deg133A),
  uniqueRows=TRUE)

probeann133B <- getBM( mart = ensembl, 
  attributes = c( "affy_hg_u133b", "ensembl_gene_id", "external_gene_name"),
  filter = "affy_hg_u133b",
  values = rownames(deg133B),
  uniqueRows=TRUE)
```
