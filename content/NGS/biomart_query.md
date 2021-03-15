+++
author = 'asepsiswu'
title = "biomart query on ensembl.org"
#date = "2020-09-24"
date = 2020-09-24T15:23:50+08:00
archives = "2020/09" 
tags = [ "" ]
summary = "wget with biomart"
+++

## BioMart RESTful access (Perl and wget)
详见
[https://m.ensembl.org/info/data/biomart/biomart_restful.html](https://m.ensembl.org/info/data/biomart/biomart_restful.html)
```
wget -O result.txt 'http://www.ensembl.org/biomart/martservice?query=<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE Query><Query  virtualSchemaName = "default" formatter = "TSV" header = "0" uniqueRows = "0" count = "" datasetConfigVersion = "0.6" ><Dataset name = "hsapiens_gene_ensembl" interface = "default" ><Filter name = "ensembl_gene_id" value = "ENSG00000139618"/><Attribute name = "ensembl_gene_id" /><Attribute name = "ensembl_transcript_id" /><Attribute name = "hgnc_symbol" /><Attribute name = "uniprotswissprot" /></Dataset></Query>'
```

