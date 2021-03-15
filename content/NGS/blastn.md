+++
author = 'asepsiswu'
title = "blastn 本地搭建"
#date = "2020-09-22"
date = 2020-09-22T12:32:00+08:00
archives = "2020/09" 
tags = [ "" ]
summary = "blastn  with gencode"
+++

##  downloading
1. blast+
   Download and install BLAST+. Installers and source code are available from
[ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/](ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/). Download the databases you need,(see database section
below), or create your own. Start searching.

2. gencode
[gencode](https://www.gencodegenes.org/human/) 下载gtf3和fasta

[gencodev35 gtf3](ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_35/gencode.v35.annotation.gff3.gz)

[gencodev35 GRCh38.p13 fasta](ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_35/GRCh38.p13.genome.fa.gz)

## makeblastdb
makeblastdb -in GRCh38.p13.genome.fa -dbtype nucl -out GRCh38.p13.genome

## blastn
```bash
blastn -query ~/Downloads/xx.fa -out seq40.blast -db blastdb/gencode/GRCh38.p13.genome \
-outfmt 6 -task blastn -evalue 1e-5 -num_threads 10 -word_size 40
```

## blastn 解释
[blast option](https://www.ncbi.nlm.nih.gov/books/NBK279684/#appendices.Options_for_the_commandline_a)

```
word_size	blastn	integer	11	Length of initial exact match.
outfmt          string  0       alignment view options:
                                    0 = pairwise,
                                    1 = query-anchored showing identities,
                                    2 = query-anchored no identities,
                                    3 = flat query-anchored, show identities,
                                    4 = flat query-anchored, no identities,
                                    5 = XML Blast output,
                                    6 = tabular,
```

### xx.fa文件内容
```
>19956_CB_005343
ATACAGATTTGAGCTATCAGACCAACAAACCTTCCCCCTGAAAAGTGAGCAGCAACGTAA
>3147_Y8-New
ACTTCCTGACACTTATTGGCCATAATGTTTGAAGGGAGAATTATTTCGGGTCCTCTATC
>29199_CB_004922
GGTGGGAGGAAGCAAAAGACTCTGTACCTATTTTGTATGTGTATAATAATTTGAGATGTT
>68858_CB_014783
GGCCAAAAAGTTCACAGTCAAATGGGGAGGGGTATTCTTCATGCAGGAGACCCCAGGCCC
>5991_CB_007199
CGAATGAATCATCTGTTCATGCATGCTCTACTTTGATATTATAACCTATGTCACATGTGT
>9905_CB_010336
CGTGCCCTTCACTTTGTCATCAGCGAGTATAACAAGGCCACTGAAGATGAGTACTACAGA
>5497_UCSC_4660_2070
CTATCCTCCAAAGCCATTGTAAATGTGTGTACAGTGTGTATAAACCTTCTTCTTCTTTTT
>68457_CB_025092
CAAAGATGCGTTCAAATAGTGCTCTAAGAGTTTTGTTCAGTGGCTCACTTCGGCTAAAAT
>57728_UCSC_5753_1818
CTATCCTCCAAAGCCATTGTAAATGTGTGTACAGTGTGTATAAACCTTCTTCTTCTTTTT
>48486_CB_011395
ACATGTGCAGTCACTGGTGTCACCCTGGATAGGCAAGGGATAACTCTTCTAACACAAAAT
```
