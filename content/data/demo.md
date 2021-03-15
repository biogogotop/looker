+++
author = 'asepsiswu'
title = "R 相关demo数据"
date = 2020-07-11
archives = "2020/07" 
tags = [ "demo" ]
summary = "demo 数据汇总"
+++

## xenahubs
### dataset: stem loop expression - miRNA Expression Quantification
source:
[TCGA-BRCA.mirna.tsv](https://gdc.xenahubs.net/download/TCGA-BRCA.mirna.tsv.gz)

TCGA-BRCA.mirna.tsv.100:
[demolink](https://r.biogogo.top/data/TCGA-BRCA.mirna.tsv.100.gz)
```bash
zcat TCGA-BRCA.mirna.tsv.gz  | head -n 100 > TCGA-BRCA.mirna.tsv.100
gzip  TCGA-BRCA.mirna.tsv.100
```

