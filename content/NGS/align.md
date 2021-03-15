+++
author = 'asepsiswu'
title = "map to genome"
#date = "2020-06-10"
date = 2020-06-10T13:14:11+08:00
archives = "2020/06" 
tags = [ "hisat2" ]
summary = "RNAseq mapping with hisat2"
+++

## hisat2 installation

``` bash
# URL: http://daehwankimlab.github.io/hisat2/download/#version-hisat2-220
cd /mnt/NGS/RNAseq-Analysis/tools/

aria2c https://cloud.biohpc.swmed.edu/index.php/s/hisat2-220-Linux_x86_64/download

mkdir ~/.local/bin/ngs
cd ~/.local/bin/ngs
unzip /mnt/NGS/RNAseq-Analysis/tools/hisat2-2.2.0-Linux_x86_64.zip

PATH=$PATH:~/.local/bin/ngs/hisat2-2.2.0/
```

## download fasta
from README file 'Homo\_sapiens.GRCh38.dna\_rm.primary\_assembly.fa.gz' is best for sequence search
``` bash
# download fasta.gz
# URL: ftp://ftp.ensembl.org/pub/release-100/fasta/homo_sapiens/dna/

aria2c ftp://ftp.ensembl.org/pub/release-100/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna_rm.primary_assembly.fa.gz

# download CHECKSUM
wget ftp://ftp.ensembl.org/pub/release-100/fasta/homo_sapiens/dna/CHECKSUMS

## check data integrity
sum Homo_sapiens.GRCh38.dna_rm.primary_assembly.fa.gz 
# output
# 64999 471534

gunzip -dk Homo_sapiens.GRCh38.dna_rm.primary_assembly.fa.gz
```

## hisat2 build index

``` bash
mkdir /mnt/NGS/RNAseq-Analysis/index
cd /mnt/NGS/RNAseq-Analysis/index
hisat2-build -p 10  /mnt/NGS/RNAseq-Analysis/genome/Ensembl/Homo_sapiens/GRCh38_release100/Homo_sapiens.GRCh38.dna_rm.primary_assembly.fa Homo_sapiens.GRCh38_release100
ls -lh
---------output--------------------
total 2.3G
drwxr-xr-x 2 asepsiswu asepsiswu 4.0K  6月 10 11:01 .
drwxr-xr-x 6 asepsiswu asepsiswu 4.0K  6月 10 10:57 ..
-rw-r--r-- 1 asepsiswu asepsiswu 494M  6月 10 11:01 Homo_sapiens.GRCh38_release100.1.ht2
-rw-r--r-- 1 asepsiswu asepsiswu 328M  6月 10 11:01 Homo_sapiens.GRCh38_release100.2.ht2
-rw-r--r-- 1 asepsiswu asepsiswu  40M  6月 10 10:56 Homo_sapiens.GRCh38_release100.3.ht2
-rw-r--r-- 1 asepsiswu asepsiswu 328M  6月 10 10:56 Homo_sapiens.GRCh38_release100.4.ht2
-rw-r--r-- 1 asepsiswu asepsiswu 819M  6月 10 11:02 Homo_sapiens.GRCh38_release100.5.ht2
-rw-r--r-- 1 asepsiswu asepsiswu 334M  6月 10 11:02 Homo_sapiens.GRCh38_release100.6.ht2
-rw-r--r-- 1 asepsiswu asepsiswu   12  6月 10 10:56 Homo_sapiens.GRCh38_release100.7.ht2
-rw-r--r-- 1 asepsiswu asepsiswu    8  6月 10 10:56 Homo_sapiens.GRCh38_release100.8.ht2
```
## hisat2 mapping
```bash
hisat2 -p 12 -x /mnt/NGS/RNAseq-Analysis/index/Homo_sapiens.GRCh38_release100 \
-1 ${i}1.fq.gz -2 ${i}2.fq.gz -S ${i}.align.hisat2.sam \
2 > ${i}.align.hisat2.log
```

##  samtools sort 
```bash
# installation
aria2c https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2

tar xf samtools-1.10.tar.bz2
cd samtools*
./configure --prefix=/home/user/.local/bin/ngs
make 
make install
PATH=$PAHT:~/.local/bin/ngs/bin
```
```bash
# sam to bam
samtools sort -@ 12 -o align.hisat2.sorted.bam align.hisat2.sam

# 对bam建索引
samtools index align.hisat2.sorted.bam align.hisat2.sorted.bam.bai
```

