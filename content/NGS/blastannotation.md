+++
author = 'asepsiswu'
title = "blast 结果注释"
#date = "2020-09-22"
date = 2020-09-22T12:22:00+08:00
archives = "2020/09" 
tags = [ "" ]
summary = "blastn 结果注释基因名"
+++
blastn 结果注释
```R
library(data.table)
seq40 <- fread('~/Downloads/seq40.blast')
colnm <- scan(text = 'query acc.ver, subject acc.ver, % identity, alignment length, mismatches, gap opens, q. start, q.
end, s. start, s. end, evalue, bit score', what = character(),sep = ',')
setnames(seq40,  janitor::make_clean_names(colnm))
seq40[s_start>s_end,`:=`(s_start=s_end,s_end=s_start)]


gtf <- fread('/mnt/NGS/ngs/reference/blastdb/gencode.v35.annotation.gff3',skip = 7,fill=T,sep = '\t')
colnm.gtf <- scan(text = 'seqname  source  feature  start  end  score  strand  frame  attribute',what = character())
setnames(gtf, colnm.gtf)
```

###  data.table merge seq40 with gtf
