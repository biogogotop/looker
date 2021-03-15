+++
author = 'asepsiswu'
title = "rma合并hgu133A 133A2 133plus2"
#date = "2020-09-15"
date = 2020-09-15T15:27:27+08:00
archives = "2020/09" 
tags = [ "" ]
summary = "rma合并hgu133平台数据"
+++
## 代码如下
```R
## 准备数据

dt[, cel:= paste0('/mnt/TCGA/escc/GSE44021mRNA/',dt$V1,'_',dt$V2,'.CEL.gz')]
dt[,sample:=stri_extract_first_regex(V2,'E\\d+')]
dt[,his:=stri_extract_last_regex(V2,'[TN]')]

## 读取CEL文件
aff133A  <- affy::ReadAffy(filenames = dt[platform=='133A'][,cel])#, cdfname = 'HGU133A_Hs_ENSG')
aff133A2 <- affy::ReadAffy(filenames = dt[platform=='133A_2'][,cel])#, cdfname = 'HGU133A2_Hs_ENSG')
aff133P2 <- affy::ReadAffy(filenames = dt[platform=='U133Plus_2'][,cel])#, cdfname = 'HGU133Plus2_Hs_ENSG')


## 共同的probe id
probe133A  <- affy::probeNames(aff133A)
probe133A2 <- affy::probeNames(aff133A2)
probe133P2 <- affy::probeNames(aff133P2)

common133  <- purrr::reduce(list(probe133A,probe133A2,probe133P2),intersect)
subsetList <- probe133A[probe133A %in% common133]

## 共同的pm值
subset133A  <- affy::pm(aff133A,common133)
subset133A2 <- affy::pm(aff133A2,common133)
subset133P2 <- affy::pm(aff133P2,common133)
Pm133 = cbind(subset133A,subset133A2,subset133P2) #this will go into the .call function

## rma 合并
  verbose = TRUE
  background = TRUE
  normalize = TRUE
  bgversion = 2
  ngenes = length(unique(subsetList))
  pNList = split(0:(length(subsetList) - 1), subsetList)

  exprs133 <- .Call("rma_c_complete", Pm133, 
                 pNList, ngenes, normalize, background, bgversion, 
                 verbose, PACKAGE = "affy")

## 构建新的EexpressinSet
  pheno133 = combine(phenoData(aff133A), phenoData(aff133A2),phenoData(aff133P2))
  annot133 =  'hgu133mix'
  protocol133 = combine(protocolData(aff133A), protocolData(aff133A2),protocolData(aff133P2))
  experiment133 = experimentData(aff133A)
  
  eset133 = new("ExpressionSet", phenoData = pheno133, annotation = annot133, 
                      protocolData = protocol133, experimentData = experiment133, 
                      exprs = exprs133)


## 差异分析
library(limma)
design133 <- model.matrix(~sample+his, dt)
fit <- lmFit(eset133, design133)
fit <- eBayes(fit)
DE133 <- topTable(fit, number = Inf ,coef="hisT")
DE133 <- data.table(DE133,keep.rownames = 'probe.id')

## brainarray 注释
annot <- fread(cmd = 'unzip -p ~/Downloads/HGU133A2_Hs_ENSG_24.0.0.zip HGU133A2_Hs_ENSG_mapping.txt')
annot <- annot[,.(brain.ensembl.id=`Probe Set Name`,probe.id=`Affy Probe Set Name`)] %>%unique()
annot[,brain.ensembl.id:=stringr::str_extract(brain.ensembl.id,'ENSG\\d+')]
DE133[annot,brain.ensembl.id:=brain.ensembl.id,on='probe.id']

## annotation with probe sequence 
HG133seq <- fread(cmd = 'unzip -p /mnt/code/lang+/R/GEOESCC/HG-U133_Plus_2.probe_tab.zip')
setnames(HG133seq,c(1,5),c('affy.probe.id','probe.seq'))
HG133seq2 <- HG133seq[,.(ProbeSequence=paste( probe.seq,collapse = ' ' )),affy.probe.id]
DE133[HG133seq2,ProbeSequence:=ProbeSequence,on="probe.id==affy.probe.id"]

```

## brainarray 未注释 
建议直接用 ProbeSequence blast 
```R
## biomart注释
library(biomaRt)
ensembl <- useEnsembl(biomart = "ensembl",  dataset = "hsapiens_gene_ensembl")

ensemblGene <- getBM( mart = ensembl, 
                         attributes = c(  "ensembl_gene_id", "external_gene_name"),
                         uniqueRows=TRUE) %>% data.table()

DE133[ensemblGene, geneSymbol:= external_gene_name, on='brain.ensembl.id==ensembl_gene_id']

```

## brainarray 和 affmetrix cdf区别
```R
searchAttributes(mart = ensembl, pattern = "133")


DE133.probe.id <- getBM( mart = ensembl, 
                       attributes = c( "affy_hg_u133a_2", "ensembl_gene_id", "external_gene_name"),
                       filter = "affy_hg_u133a_2",
                       values = DE133$probe.id,
                       uniqueRows=TRUE)

DE133[DE133.probe.id,`:=`(affy.ensembl.id=ensembl_gene_id),on='probe.id==affy_hg_u133a_2']

DE133[affy.ensembl.id!= brain.ensembl.id]

## 其实1个probe对应多个ENSG基因
hgu133plus2probe <- getBM( mart = ensembl, 
                         attributes = c( "affy_hg_u133_plus_2", "ensembl_gene_id", "external_gene_name"),
                         uniqueRows=TRUE) %>% data.table()
```
