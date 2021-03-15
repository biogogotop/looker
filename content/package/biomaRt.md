+++
author = 'asepsiswu'
title = "biomaRt 基因ID"
#date = "2020-06-23"
date = 2020-06-23T17:09:57+08:00
archives = "2020/06" 
tags = [ "biomaRt" ]
summary = "基因ID转换"
+++
## biomaRt

```r
library(biomaRt)
```

```
## Loading required package: methods
```

```r
library(data.table)
library(magrittr)
# use ENSEMBL_MART_ENSEMBL BioMart databases 
listMarts()
```

```
##                biomart                version
## 1 ENSEMBL_MART_ENSEMBL      Ensembl Genes 100
## 2   ENSEMBL_MART_MOUSE      Mouse strains 100
## 3     ENSEMBL_MART_SNP  Ensembl Variation 100
## 4 ENSEMBL_MART_FUNCGEN Ensembl Regulation 100
```

```r
# use genes for datasets
listEnsembl()
```

```
##         biomart                version
## 1         genes      Ensembl Genes 100
## 2 mouse_strains      Mouse strains 100
## 3          snps  Ensembl Variation 100
## 4    regulation Ensembl Regulation 100
```
## construct biomaRt

```r
ENSEMBL <- useEnsembl(biomart = "ENSEMBL_MART_ENSEMBL", 
                      dataset = "hsapiens_gene_ensembl")
```


```r
# or shortcut
ensembl <- useEnsembl(biomart = "ensembl", 
                      dataset = "hsapiens_gene_ensembl")

identical(ENSEMBL, ensembl)
```

```
## True
```

```r
str(ensembl)
```

```
## Formal class 'Mart' [package "biomaRt"] with 7 slots
##   ..@ biomart   : chr "ENSEMBL_MART_ENSEMBL"
##   ..@ host      : chr "https://www.ensembl.org:443/biomart/martservice"
##   ..@ vschema   : chr "default"
##   ..@ version   : chr(0) 
##   ..@ dataset   : chr "hsapiens_gene_ensembl"
##   ..@ filters   :'data.frame':	425 obs. of  9 variables:
##   .. ..$ name           : chr [1:425] "chromosome_name" "start" "end" "strand" ...
##   .. ..$ description    : chr [1:425] "Chromosome/scaffold name" "Start" "End" "Strand" ...
##   .. ..$ options        : chr [1:425] "[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,CHR_HG1_PATCH,CHR_HG26_PATCH,CHR_HG28_PATCH,CHR_HG30_"| __truncated__ "[]" "[]" "[]" ...
##   .. ..$ fullDescription: chr [1:425] "" "Determine which base pair on the specified chromosome/scaffold to begin range" "Determine which base pair on the specified chromosome/scaffold to end range" "" ...
##   .. ..$ filters        : chr [1:425] "filters" "filters" "filters" "filters" ...
##   .. ..$ type           : chr [1:425] "text" "text" "text" "text" ...
##   .. ..$ operation      : chr [1:425] "=" ">=" "<=" "=" ...
##   .. ..$ filters8       : chr [1:425] "hsapiens_gene_ensembl__gene__main" "hsapiens_gene_ensembl__gene__main" "hsapiens_gene_ensembl__gene__main" "hsapiens_gene_ensembl__gene__main" ...
##   .. ..$ filters9       : chr [1:425] "name_1059" "seq_region_end_1020" "seq_region_start_1020" "seq_region_strand_1020" ...
##   ..@ attributes:'data.frame':	3059 obs. of  7 variables:
##   .. ..$ name           : chr [1:3059] "ensembl_gene_id" "ensembl_gene_id_version" "ensembl_transcript_id" "ensembl_transcript_id_version" ...
##   .. ..$ description    : chr [1:3059] "Gene stable ID" "Gene stable ID version" "Transcript stable ID" "Transcript stable ID version" ...
##   .. ..$ fullDescription: chr [1:3059] "Stable ID of the Gene" "Versionned stable ID of the Gene" "Stable ID of the Transcript" "Versionned stable ID of the Transcript" ...
##   .. ..$ page           : chr [1:3059] "feature_page" "feature_page" "feature_page" "feature_page" ...
##   .. ..$ attributes5    : chr [1:3059] "html,txt,csv,tsv,xls" "html,txt,csv,tsv,xls" "html,txt,csv,tsv,xls" "html,txt,csv,tsv,xls" ...
##   .. ..$ attributes6    : chr [1:3059] "hsapiens_gene_ensembl__gene__main" "hsapiens_gene_ensembl__gene__main" "hsapiens_gene_ensembl__transcript__main" "hsapiens_gene_ensembl__transcript__main" ...
##   .. ..$ attributes7    : chr [1:3059] "stable_id_1023" "gene__main_stable_id_version" "stable_id_1066" "transcript__main_stable_id_version" ...
```

```r
head(ensembl@filters[,1:2])
```

```
##                 name                            description
## 1    chromosome_name               Chromosome/scaffold name
## 2              start                                  Start
## 3                end                                    End
## 4             strand                                 Strand
## 5 chromosomal_region e.g. 1:100:10000:-1, 1:100000:200000:1
## 6          with_ccds                        With CCDS ID(s)
```

```r
searchFilters(mart = ensembl, pattern = "ensembl.*id")
```

```
##                             name
## 50               ensembl_gene_id
## 51       ensembl_gene_id_version
## 52         ensembl_transcript_id
## 53 ensembl_transcript_id_version
## 54            ensembl_peptide_id
## 55    ensembl_peptide_id_version
## 56               ensembl_exon_id
##                                                       description
## 50                       Gene stable ID(s) [e.g. ENSG00000000003]
## 51       Gene stable ID(s) with version [e.g. ENSG00000000003.15]
## 52                 Transcript stable ID(s) [e.g. ENST00000000233]
## 53 Transcript stable ID(s) with version [e.g. ENST00000000233.10]
## 54                    Protein stable ID(s) [e.g. ENSP00000000233]
## 55     Protein stable ID(s) with version [e.g. ENSP00000000233.5]
## 56                              Exon ID(s) [e.g. ENSE00000000001]
```

```r
searchFilters(mart = ensembl, pattern = "entrezgene|hgnc")
```

```
##                           name
## 14  with_entrezgene_trans_name
## 20                   with_hgnc
## 31             with_entrezgene
## 43        with_hgnc_trans_name
## 70       entrezgene_trans_name
## 76                     hgnc_id
## 77                 hgnc_symbol
## 90        entrezgene_accession
## 91               entrezgene_id
## 103            hgnc_trans_name
##                                                  description
## 14                     With EntrezGene transcript name ID(s)
## 20                                    With HGNC Symbol ID(s)
## 31                With NCBI gene (formerly Entrezgene) ID(s)
## 43                                With Transcript name ID(s)
## 70     EntrezGene transcript name ID(s) [e.g. ARHGAP11B-201]
## 76                                HGNC ID(s) [e.g. HGNC:100]
## 77                                HGNC symbol(s) [e.g. A1BG]
## 90  NCBI gene (formerly Entrezgene) accession(s) [e.g. A1BG]
## 91            NCBI gene (formerly Entrezgene) ID(s) [e.g. 1]
## 103                    Transcript name ID(s) [e.g. A1BG-201]
```

```r
searchFilterValues(mart = ensembl, filter = "chromosome_name", pattern = "^GL")
```

```
##  [1] "GL000009.2" "GL000194.1" "GL000195.1" "GL000205.2" "GL000213.1"
##  [6] "GL000216.2" "GL000218.1" "GL000219.1" "GL000220.1" "GL000225.1"
```

```r
head(ensembl@attributes[,1:2])
```

```
##                            name                  description
## 1               ensembl_gene_id               Gene stable ID
## 2       ensembl_gene_id_version       Gene stable ID version
## 3         ensembl_transcript_id         Transcript stable ID
## 4 ensembl_transcript_id_version Transcript stable ID version
## 5            ensembl_peptide_id            Protein stable ID
## 6    ensembl_peptide_id_version    Protein stable ID version
```

```r
searchAttributes(mart = ensembl, pattern = "entrezgene|hgnc|unipro")
```

```
##                        name                                 description
## 59    entrezgene_trans_name               EntrezGene transcript name ID
## 63                  hgnc_id                                     HGNC ID
## 64              hgnc_symbol                                 HGNC symbol
## 79   entrezgene_description NCBI gene (formerly Entrezgene) description
## 80     entrezgene_accession   NCBI gene (formerly Entrezgene) accession
## 81            entrezgene_id          NCBI gene (formerly Entrezgene) ID
## 93          hgnc_trans_name                          Transcript name ID
## 96        uniprot_gn_symbol                  UniProtKB Gene Name symbol
## 97            uniprot_gn_id                      UniProtKB Gene Name ID
## 98         uniprotswissprot                     UniProtKB/Swiss-Prot ID
## 99          uniprotsptrembl                         UniProtKB/TrEMBL ID
## 3025       uniprotswissprot                     UniProtKB/Swiss-Prot ID
## 3026        uniprotsptrembl                         UniProtKB/TrEMBL ID
##              page
## 59   feature_page
## 63   feature_page
## 64   feature_page
## 79   feature_page
## 80   feature_page
## 81   feature_page
## 93   feature_page
## 96   feature_page
## 97   feature_page
## 98   feature_page
## 99   feature_page
## 3025    sequences
## 3026    sequences
```
## key functions (not recommend)


```r
# keys function applicable to some function
keys(ensembl, keytype="chromosome_name") %>% head()
```

```
## [1] "1" "2" "3" "4" "5" "6"
```

```r
keys(ensembl,  keytype = 'entrezgene_id')
```

```
## character(0)
```

```r
keys(ensembl,  keytype = 'hgnc_symbol')
```

```
## character(0)
```
## getBM

```r
# example
getBM(attributes =c('entrezgene_id', 'hgnc_symbol'),
      filters = 'ensembl_gene_id', 
      values = 'ENSG00000000003', 
      mart = ensembl)
```

```
##   entrezgene_id hgnc_symbol
## 1          7105      TSPAN6
```

```r
getBM(attributes=c('entrezgene_id',  "hgnc_symbol", 'ensembl_gene_id_version', 
                   'band','external_gene_name', 'hgnc_id',
                   'ensembl_transcript_id_version', 'transcript_length'  ),
      filters=c("hgnc_symbol"),
      values=list('TP53'), mart=ensembl)
```

```
##    entrezgene_id hgnc_symbol ensembl_gene_id_version  band external_gene_name
## 1           7157        TP53      ENSG00000141510.17 p13.1               TP53
## 2           7157        TP53      ENSG00000141510.17 p13.1               TP53
## 3           7157        TP53      ENSG00000141510.17 p13.1               TP53
## 4           7157        TP53      ENSG00000141510.17 p13.1               TP53
## 5           7157        TP53      ENSG00000141510.17 p13.1               TP53
## 6           7157        TP53      ENSG00000141510.17 p13.1               TP53
## 7           7157        TP53      ENSG00000141510.17 p13.1               TP53
## 8           7157        TP53      ENSG00000141510.17 p13.1               TP53
## 9           7157        TP53      ENSG00000141510.17 p13.1               TP53
## 10          7157        TP53      ENSG00000141510.17 p13.1               TP53
## 11          7157        TP53      ENSG00000141510.17 p13.1               TP53
## 12          7157        TP53      ENSG00000141510.17 p13.1               TP53
## 13          7157        TP53      ENSG00000141510.17 p13.1               TP53
## 14          7157        TP53      ENSG00000141510.17 p13.1               TP53
## 15          7157        TP53      ENSG00000141510.17 p13.1               TP53
## 16          7157        TP53      ENSG00000141510.17 p13.1               TP53
## 17          7157        TP53      ENSG00000141510.17 p13.1               TP53
## 18          7157        TP53      ENSG00000141510.17 p13.1               TP53
## 19          7157        TP53      ENSG00000141510.17 p13.1               TP53
## 20          7157        TP53      ENSG00000141510.17 p13.1               TP53
## 21          7157        TP53      ENSG00000141510.17 p13.1               TP53
## 22          7157        TP53      ENSG00000141510.17 p13.1               TP53
## 23          7157        TP53      ENSG00000141510.17 p13.1               TP53
## 24          7157        TP53      ENSG00000141510.17 p13.1               TP53
## 25          7157        TP53      ENSG00000141510.17 p13.1               TP53
## 26          7157        TP53      ENSG00000141510.17 p13.1               TP53
## 27          7157        TP53      ENSG00000141510.17 p13.1               TP53
## 28          7157        TP53      ENSG00000141510.17 p13.1               TP53
## 29          7157        TP53      ENSG00000141510.17 p13.1               TP53
##       hgnc_id ensembl_transcript_id_version transcript_length
## 1  HGNC:11998             ENST00000413465.6              1018
## 2  HGNC:11998             ENST00000635293.1              1883
## 3  HGNC:11998             ENST00000359597.8              1152
## 4  HGNC:11998             ENST00000504290.5              2331
## 5  HGNC:11998             ENST00000510385.5              2404
## 6  HGNC:11998             ENST00000504937.5              2271
## 7  HGNC:11998             ENST00000619186.4              2271
## 8  HGNC:11998             ENST00000618944.4              2404
## 9  HGNC:11998             ENST00000610623.4              2331
## 10 HGNC:11998             ENST00000610292.4              2639
## 11 HGNC:11998             ENST00000269305.8              2579
## 12 HGNC:11998             ENST00000620739.4              2579
## 13 HGNC:11998             ENST00000455263.6              2580
## 14 HGNC:11998             ENST00000420246.6              2653
## 15 HGNC:11998             ENST00000622645.4              2653
## 16 HGNC:11998             ENST00000610538.4              2580
## 17 HGNC:11998             ENST00000445888.6              2506
## 18 HGNC:11998             ENST00000619485.4              2506
## 19 HGNC:11998             ENST00000576024.1               175
## 20 HGNC:11998             ENST00000509690.5               729
## 21 HGNC:11998             ENST00000514944.5               546
## 22 HGNC:11998             ENST00000574684.1               104
## 23 HGNC:11998             ENST00000505014.5              1261
## 24 HGNC:11998             ENST00000508793.5               634
## 25 HGNC:11998             ENST00000604348.5               568
## 26 HGNC:11998             ENST00000503591.1               565
## 27 HGNC:11998             ENST00000571370.1              1112
## 28 HGNC:11998             ENST00000617185.4              2724
## 29 HGNC:11998             ENST00000615910.4              1149
```

```r
#  Attributes from multiple attribute pages are not allowed
getBM(attributes=c('entrezgene_id',  "hgnc_symbol", 'ensembl_gene_id_version', 
                   'band','external_gene_name', 'ensembl_transcript_id_version', 
                   'transcript_length',  'external_gene_name',
                   'transcript_gencode_basic', 'transcript_version','cds_length'),
      filters=c("hgnc_symbol"),
      values=list('TP53'), mart=ensembl)
```

```
## Error in .processResults(postRes, mart = mart, sep = sep, fullXmlQuery = fullXmlQuery, : Query ERROR: caught BioMart::Exception::Usage: Attributes from multiple attribute pages are not allowed
```

```r
# coffee time to fetch data
GeneId <- getBM(attributes=c('entrezgene_id',  "hgnc_symbol",  "hgnc_id", 
                                 'ensembl_gene_id_version', 'band' ),
      filters=c("chromosome_name"),
      values=list(c(1:22,'X','Y')), mart=ensembl)

head(GeneId)
```

```
##   entrezgene_id hgnc_symbol    hgnc_id ensembl_gene_id_version   band
## 1            NA     SNORA77 HGNC:32663       ENSG00000221643.1  q32.1
## 2            NA  RNU6-1265P HGNC:48228       ENSG00000252151.1 p36.21
## 3            NA                              ENSG00000206779.1  p35.3
## 4            NA                              ENSG00000252682.1  q21.3
## 5            NA   RNU6-880P HGNC:47843       ENSG00000207256.1  p34.2
## 6            NA   RNU6-828P HGNC:47791       ENSG00000201746.1 p36.22
```

```r
# write.csv(GeneId,file = '/mnt/TCGA/rrefdb/GeneIdFromBiomaRt.csv')
```
## hgnc gene alias

```r
## curated gene name https://www.genenames.org/download/custom/
genename.url <-
    'https://www.genenames.org/cgi-bin/download/custom?col=gd_hgnc_id&col=gd_app_sym&col=gd_app_name&col=gd_status&col=gd_prev_sym&col=gd_aliases&col=gd_pub_chrom_map&col=gd_pub_acc_ids&col=gd_pub_refseq_ids&col=gd_pub_eg_id&col=gd_pub_ensembl_id&col=gd_name_aliases&status=Approved&status=Entry%20Withdrawn&hgnc_dbtag=on&order_by=gd_pub_ensembl_id&format=text&submit=submit'
# hgnc <- fread(genename.url)
# bash wget 'https://www.genenames.org/cgi-bin/download/custom?col=gd_hgnc_id&col=gd_app_sym&col=gd_app_name&col=gd_status&col=gd_prev_sym&col=gd_aliases&col=gd_pub_chrom_map&col=gd_pub_acc_ids&col=gd_pub_refseq_ids&col=gd_pub_eg_id&col=gd_pub_ensembl_id&col=gd_name_aliases&status=Approved&status=Entry%20Withdrawn&hgnc_dbtag=on&order_by=gd_pub_ensembl_id&format=text&submit=submit' -O HGNC.genename
hgnc <- fread('/mnt/TCGA/rrefdb/hgnc.genealias')
```

```
## Warning in fread("/mnt/TCGA/rrefdb/hgnc.genealias"): Found and resolved improper
## quoting out-of-sample. First healed line 757: <<HGNC:35127 PEG3-AS1 PEG3
## antisense RNA 1 Approved PEG3AS, PEG3-AS APEG3, NCRNA00155 19q13.43 NR_023847
## "antisense PEG3 transcript", "non-protein coding RNA 155" 100169890 >>. If the
## fields are not quoted (e.g. field separator does not appear within any field),
## try quote="" to avoid this warning.
```

```r
setnames(hgnc, gsub(" ",'_',names(hgnc)) )
hgnc[Approved_symbol=='TP53']
```

```
##       HGNC_ID Approved_symbol     Approved_name   Status Previous_symbols
## 1: HGNC:11998            TP53 tumor protein p53 Approved                 
##    Alias_symbols Chromosome Accession_numbers RefSeq_IDs          Alias_names
## 1:     p53, LFS1    17p13.1          AF307851  NM_000546 Li-Fraumeni syndrome
##    NCBI_Gene_ID Ensembl_gene_ID
## 1:         7157 ENSG00000141510
```

## merge GeneID and hgnc alias


```r
# with some duplicate id
GeneID <- merge(GeneId,hgnc,by.x = 'hgnc_id',by.y = 'HGNC_ID',all = T)
```
## useEnsembl 连接错误
[SSL certificate problem: unable to get local issuer certificate #122](https://github.com/jeroen/curl/issues/122)
```R
# curl::curl_fetch_memory(url, handle = handle) : SSL certificate problem: unable to get local issuer certificate
Sys.setenv(LIBCURL_BUILD="winssl")
devtools::install_github('jeroen/curl')
```
依然报错， 重启后好了。也许与curl无关，可能是网络的原因。
ubuntu 18.04 LTS不存在这个问题

<!-- Sys.setenv("http_proxy" = "http://my.proxy.org:9999") -->
<!-- options(RCurlOptions = list(proxy="uscache.kcc.com:80",proxyuserpwd="------:-------")) -->
