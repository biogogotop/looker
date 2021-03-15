+++
author = 'asepsiswu'
title = "TCGA SNV 查询"
#date = "2020-08-06"
date = 2020-08-06T14:06:28+08:00
archives = "2020/08" 
tags = [ "TCGA" ]
summary = "TCGA SNV 数据下载 查询"
+++
## Download TCGA-ESCA SNV maf file
[TCGA-ESCA](https://portal.gdc.cancer.gov/projects/TCGA-ESCA)

filter:
  
- Data Category
   simple nucleotide variation
- Access
   open

Download manifest

- gdc\_manifest\_20200806\_030553.txt

### Download gdc tools
(gdc-transfer)[https://gdc.cancer.gov/access-data/gdc-data-transfer-tool]

```bash
# 2020-08-06
wget https://gdc.cancer.gov/files/public/file/gdc-client_v1.6.0_Ubuntu_x64-py3.7.zip
unzip gdc-client_v1.6.0_Ubuntu_x64-py3.7.zip
unzip gdc-client_v1.6.0_Ubuntu_x64.zip 
mv gdc-client ~/.local/bin
```


### Download maf files
```bash
gdc-client download -m gdc_manifest_20200806_030553.txt
```

## analyze maf file

### read and rbind maf files

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
maf_dir <- '/mnt/TCGA/portal.gdc.cancer.gov/TCGA-ESCA/escaSNV'
maf_file <- list.files(maf_dir,pattern =  'maf.gz$',recursive = T,full.names = T)
maf_protocol  <- basename(maf_file) %>% stringr::str_extract(.,"(?<=TCGA.ESCA.)[a-z]+")

### read and rbind maf files
maf <- lapply(maf_file, fread)
maf <- map2(maf,maf_protocol, ~ .x[,protocol:=.y])
maf2 <- rbindlist(maf)

head(maf2)
```

```
##    Hugo_Symbol Entrez_Gene_Id Center NCBI_Build Chromosome Start_Position
## 1:        RERE            473  WUGSC     GRCh38       chr1        8354636
## 2:      VPS13D          55187  WUGSC     GRCh38       chr1       12506961
## 3:       CSMD2         114784  WUGSC     GRCh38       chr1       33546076
## 4:     C1orf94          84970  WUGSC     GRCh38       chr1       34197540
## 5:        FAF1          11124  WUGSC     GRCh38       chr1       50535439
## 6:   SLC25A3P1         163742  WUGSC     GRCh38       chr1       53439045
##    End_Position Strand Variant_Classification Variant_Type Reference_Allele
## 1:      8354636      +                  3'UTR          SNP                T
## 2:     12506961      +      Missense_Mutation          SNP                A
## 3:     33546076      +      Missense_Mutation          SNP                C
## 4:     34197540      +      Nonsense_Mutation          SNP                T
## 5:     50535439      +      Missense_Mutation          SNP                T
## 6:     53439045      +                    RNA          SNP                A
##    Tumor_Seq_Allele1 Tumor_Seq_Allele2    dbSNP_RS    dbSNP_Val_Status
## 1:                 T                 A rs551430946 by1000G;byFrequency
## 2:                 A                 T       novel                    
## 3:                 C                 G       novel                    
## 4:                 T                 A       novel                    
## 5:                 T                 A       novel                    
## 6:                 A                 C       novel                    
##            Tumor_Sample_Barcode  Matched_Norm_Sample_Barcode
## 1: TCGA-IC-A6RE-01A-11D-A33E-09 TCGA-IC-A6RE-10A-01D-A33H-09
## 2: TCGA-IC-A6RE-01A-11D-A33E-09 TCGA-IC-A6RE-10A-01D-A33H-09
## 3: TCGA-IC-A6RE-01A-11D-A33E-09 TCGA-IC-A6RE-10A-01D-A33H-09
## 4: TCGA-IC-A6RE-01A-11D-A33E-09 TCGA-IC-A6RE-10A-01D-A33H-09
## 5: TCGA-IC-A6RE-01A-11D-A33E-09 TCGA-IC-A6RE-10A-01D-A33H-09
## 6: TCGA-IC-A6RE-01A-11D-A33E-09 TCGA-IC-A6RE-10A-01D-A33H-09
##    Match_Norm_Seq_Allele1 Match_Norm_Seq_Allele2 Tumor_Validation_Allele1
## 1:                     NA                     NA                       NA
## 2:                     NA                     NA                       NA
## 3:                     NA                     NA                       NA
## 4:                     NA                     NA                       NA
## 5:                     NA                     NA                       NA
## 6:                     NA                     NA                       NA
##    Tumor_Validation_Allele2 Match_Norm_Validation_Allele1
## 1:                       NA                            NA
## 2:                       NA                            NA
## 3:                       NA                            NA
## 4:                       NA                            NA
## 5:                       NA                            NA
## 6:                       NA                            NA
##    Match_Norm_Validation_Allele2 Verification_Status Validation_Status
## 1:                            NA                  NA                NA
## 2:                            NA                  NA                NA
## 3:                            NA                  NA                NA
## 4:                            NA                  NA                NA
## 5:                            NA                  NA                NA
## 6:                            NA                  NA                NA
##    Mutation_Status Sequencing_Phase Sequence_Source Validation_Method Score
## 1:         Somatic               NA              NA                NA    NA
## 2:         Somatic               NA              NA                NA    NA
## 3:         Somatic               NA              NA                NA    NA
## 4:         Somatic               NA              NA                NA    NA
## 5:         Somatic               NA              NA                NA    NA
## 6:         Somatic               NA              NA                NA    NA
##    BAM_File           Sequencer                    Tumor_Sample_UUID
## 1:       NA Illumina HiSeq 2000 409bc915-0434-4e4b-b96b-61465c83580a
## 2:       NA Illumina HiSeq 2000 409bc915-0434-4e4b-b96b-61465c83580a
## 3:       NA Illumina HiSeq 2000 409bc915-0434-4e4b-b96b-61465c83580a
## 4:       NA Illumina HiSeq 2000 409bc915-0434-4e4b-b96b-61465c83580a
## 5:       NA Illumina HiSeq 2000 409bc915-0434-4e4b-b96b-61465c83580a
## 6:       NA Illumina HiSeq 2000 409bc915-0434-4e4b-b96b-61465c83580a
##                Matched_Norm_Sample_UUID      HGVSc        HGVSp HGVSp_Short
## 1: f93260cb-2f87-479b-a13f-1b58e222ed2a  c.*451A>T                         
## 2: f93260cb-2f87-479b-a13f-1b58e222ed2a c.12903A>T p.Glu4301Asp    p.E4301D
## 3: f93260cb-2f87-479b-a13f-1b58e222ed2a  c.8629G>C p.Ala2877Pro    p.A2877P
## 4: f93260cb-2f87-479b-a13f-1b58e222ed2a   c.636T>A  p.Cys212Ter     p.C212*
## 5: f93260cb-2f87-479b-a13f-1b58e222ed2a  c.1424A>T  p.Glu475Val     p.E475V
## 6: f93260cb-2f87-479b-a13f-1b58e222ed2a   n.521T>G                         
##      Transcript_ID Exon_Number t_depth t_ref_count t_alt_count n_depth
## 1: ENST00000337907       24/24      21          16           5      28
## 2: ENST00000620676       69/70      56          43          13     101
## 3: ENST00000241312       56/70      31          23           8      46
## 4: ENST00000488417         2/7      21          16           5      36
## 5: ENST00000396153       15/19      65          42          23     112
## 6: ENST00000566100         1/1      11           6           5      12
##    n_ref_count n_alt_count
## 1:          NA          NA
## 2:          NA          NA
## 3:          NA          NA
## 4:          NA          NA
## 5:          NA          NA
## 6:          NA          NA
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   all_effects
## 1:                                                                                                                             RERE,3_prime_UTR_variant,,ENST00000337907,NM_012102.3,c.*451A>T,MODIFIER,YES,,,-1;RERE,3_prime_UTR_variant,,ENST00000377464,,c.*451A>T,MODIFIER,,,,-1;RERE,3_prime_UTR_variant,,ENST00000400908,NM_001042681.1,c.*451A>T,MODIFIER,,,,-1;RERE,3_prime_UTR_variant,,ENST00000476556,NM_001042682.1,c.*451A>T,MODIFIER,,,,-1;RERE,3_prime_UTR_variant,,ENST00000400907,,c.*451A>T,MODIFIER,,,,-1;RERE,downstream_gene_variant,,ENST00000505225,,,MODIFIER,,,,-1;RERE,intron_variant,,ENST00000467350,,n.140+307A>T,MODIFIER,,,,-1
## 2: VPS13D,missense_variant,p.E4301D,ENST00000620676,NM_015378.2,c.12903A>T,MODERATE,YES,,probably_damaging(0.953),1;VPS13D,missense_variant,p.E4276D,ENST00000613099,NM_018156.2,c.12828A>T,MODERATE,,tolerated(0.13),probably_damaging(0.995),1;VPS13D,missense_variant,p.E3123D,ENST00000011700,,c.9368A>T,MODERATE,,tolerated(0.11),probably_damaging(0.986),1;VPS13D,5_prime_UTR_variant,,ENST00000543766,,c.-130A>T,MODIFIER,,,,1;SNORA59A,upstream_gene_variant,,ENST00000459326,,,MODIFIER,YES,,,1;VPS13D,non_coding_transcript_exon_variant,,ENST00000543710,,n.2389A>T,MODIFIER,,,,1;VPS13D,downstream_gene_variant,,ENST00000473099,,,MODIFIER,,,,1
## 3:                                                                                                                                                                                                          CSMD2,missense_variant,p.A3021P,ENST00000373381,NM_001281956.1,c.9061G>C,MODERATE,YES,tolerated(0.46),benign(0.005),-1;CSMD2,missense_variant,p.A2981P,ENST00000619121,,c.8941G>C,MODERATE,,tolerated(0.46),benign(0.005),-1;CSMD2,missense_variant,p.A2877P,ENST00000373388,NM_052896.4,c.8629G>C,MODERATE,,tolerated(0.8),benign(0.013),-1;CSMD2,missense_variant,p.A2877P,ENST00000241312,,c.8629G>C,MODERATE,,tolerated(0.8),benign(0.013),-1
## 4:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  C1orf94,stop_gained,p.C212*,ENST00000488417,NM_001134734.1,c.636T>A,HIGH,YES,,,1;C1orf94,stop_gained,p.C22*,ENST00000373374,NM_032884.4,c.66T>A,HIGH,,,,1
## 5:                                                                                                                                                                                                                                                                FAF1,missense_variant,p.E475V,ENST00000396153,NM_007051.2,c.1424A>T,MODERATE,YES,deleterious(0),probably_damaging(0.986),-1;FAF1,missense_variant,p.E315V,ENST00000371778,,c.944A>T,MODERATE,,deleterious(0),unknown(0),-1;FAF1,downstream_gene_variant,,ENST00000472808,,,MODIFIER,,,,-1;FAF1,missense_variant,p.E281V,ENST00000494400,,c.842A>T,MODERATE,,deleterious(0),benign(0.226),-1
## 6:                                                                                                                                                                                                                      SLC25A3P1,non_coding_transcript_exon_variant,,ENST00000566100,,n.521T>G,MODIFIER,YES,,,-1;SLC25A3P1,non_coding_transcript_exon_variant,,ENST00000569142,,n.250T>G,MODIFIER,,,,-1;SLC25A3P1,non_coding_transcript_exon_variant,,ENST00000562700,,n.147T>G,MODIFIER,,,,-1;SLC25A3P1,intron_variant,,ENST00000563752,,n.201+730T>G,MODIFIER,,,,-1;SLC25A3P1,non_coding_transcript_exon_variant,,ENST00000443844,,n.257T>G,MODIFIER,,,,-1
##    Allele            Gene         Feature Feature_type
## 1:      A ENSG00000142599 ENST00000337907   Transcript
## 2:      T ENSG00000048707 ENST00000620676   Transcript
## 3:      G ENSG00000121904 ENST00000241312   Transcript
## 4:      A ENSG00000142698 ENST00000488417   Transcript
## 5:      A ENSG00000185104 ENST00000396153   Transcript
## 6:      C ENSG00000236253 ENST00000566100   Transcript
##                       One_Consequence
## 1:                3_prime_UTR_variant
## 2:                   missense_variant
## 3:                   missense_variant
## 4:                        stop_gained
## 5:                   missense_variant
## 6: non_coding_transcript_exon_variant
##                                                         Consequence
## 1:                                              3_prime_UTR_variant
## 2:                                                 missense_variant
## 3:                          missense_variant;NMD_transcript_variant
## 4:                                                      stop_gained
## 5:                                                 missense_variant
## 6: non_coding_transcript_exon_variant;non_coding_transcript_variant
##    cDNA_position CDS_position Protein_position Amino_acids  Codons
## 1:     5787/8026       -/4701           -/1566                    
## 2:   13033/16320  12903/13167        4301/4388         E/D gaA/gaT
## 3:    8658/13108   8629/10464        2877/3487         A/P Gcc/Ccc
## 4:      756/2287     636/1797          212/598         C/* tgT/tgA
## 5:     1876/6817    1424/1953          475/650         E/V gAg/gTg
## 6:      521/2531                                                  
##    Existing_variation ALLELE_NUM DISTANCE TRANSCRIPT_STRAND    SYMBOL
## 1:        rs551430946          1       NA                -1      RERE
## 2:                             1       NA                 1    VPS13D
## 3:                             1       NA                -1     CSMD2
## 4:                             1       NA                 1   C1orf94
## 5:                             1       NA                -1      FAF1
## 6:                             1       NA                -1 SLC25A3P1
##    SYMBOL_SOURCE    HGNC_ID                 BIOTYPE CANONICAL        CCDS
## 1:          HGNC  HGNC:9965          protein_coding       YES    CCDS95.1
## 2:          HGNC HGNC:23595          protein_coding       YES CCDS30588.1
## 3:          HGNC HGNC:19290 nonsense_mediated_decay             CCDS380.1
## 4:          HGNC HGNC:28250          protein_coding       YES CCDS44108.1
## 5:          HGNC  HGNC:3578          protein_coding       YES   CCDS554.1
## 6:          HGNC HGNC:26869    processed_transcript       YES            
##               ENSP SWISSPROT     TREMBL       UNIPARC         RefSeq
## 1: ENSP00000338629    Q9P2R6 A0A024R4E9 UPI00001419CC    NM_012102.3
## 2: ENSP00000478104    Q5THJ4            UPI0000451CA9    NM_015378.2
## 3: ENSP00000241312    Q7Z408            UPI00004561AB               
## 4: ENSP00000435634    Q6P1W5            UPI0000D4BFB0 NM_001134734.1
## 5: ENSP00000379457    Q9UNN5                             NM_007051.2
## 6:                                                                  
##              SIFT                 PolyPhen  EXON INTRON
## 1:                                         24/24       
## 2:                probably_damaging(0.953) 69/70       
## 3: tolerated(0.8)            benign(0.013) 56/70       
## 4:                                           2/7       
## 5: deleterious(0) probably_damaging(0.986) 15/19       
## 6:                                           1/1       
##                                                                                            DOMAINS
## 1:                                                                                                
## 2:                                                                                                
## 3: Pfam_domain:PF00084;PROSITE_profiles:PS50923;SMART_domains:SM00032;Superfamily_domains:SSF57535
## 4:                                                                                                
## 5:                                                                           SMART_domains:SM00594
## 6:                                                                                                
##      GMAF AFR_MAF AMR_MAF ASN_MAF EAS_MAF EUR_MAF SAS_MAF AA_MAF EA_MAF
## 1: 0.0421  0.0855  0.0259      NA   0.005  0.0199  0.0562     NA     NA
## 2:     NA      NA      NA      NA      NA      NA      NA     NA     NA
## 3:     NA      NA      NA      NA      NA      NA      NA     NA     NA
## 4:     NA      NA      NA      NA      NA      NA      NA     NA     NA
## 5:     NA      NA      NA      NA      NA      NA      NA     NA     NA
## 6:     NA      NA      NA      NA      NA      NA      NA     NA     NA
##    CLIN_SIG SOMATIC PUBMED MOTIF_NAME MOTIF_POS HIGH_INF_POS MOTIF_SCORE_CHANGE
## 1:                                 NA        NA           NA                 NA
## 2:                                 NA        NA           NA                 NA
## 3:                                 NA        NA           NA                 NA
## 4:                                 NA        NA           NA                 NA
## 5:                                 NA        NA           NA                 NA
## 6:                                 NA        NA           NA                 NA
##      IMPACT PICK VARIANT_CLASS TSL HGVS_OFFSET PHENO MINIMISED ExAC_AF
## 1: MODIFIER    1           SNV   1          NA               1      NA
## 2: MODERATE    1           SNV   1          NA               1      NA
## 3: MODERATE   NA           SNV   1          NA               1      NA
## 4:     HIGH    1           SNV   1          NA               1      NA
## 5: MODERATE    1           SNV   1          NA               1      NA
## 6: MODIFIER    1           SNV  NA          NA               1      NA
##    ExAC_AF_Adj ExAC_AF_AFR ExAC_AF_AMR ExAC_AF_EAS ExAC_AF_FIN ExAC_AF_NFE
## 1:          NA          NA          NA          NA          NA          NA
## 2:          NA          NA          NA          NA          NA          NA
## 3:          NA          NA          NA          NA          NA          NA
## 4:          NA          NA          NA          NA          NA          NA
## 5:          NA          NA          NA          NA          NA          NA
## 6:          NA          NA          NA          NA          NA          NA
##    ExAC_AF_OTH ExAC_AF_SAS GENE_PHENO FILTER     CONTEXT
## 1:          NA          NA         NA   PASS TTTTTTAAAAA
## 2:          NA          NA         NA   PASS CTAGAAGTCAA
## 3:          NA          NA         NA   PASS ATTGGCTTGAC
## 4:          NA          NA         NA   PASS CTGTGTGCCGC
## 5:          NA          NA         NA   PASS TTAACTCATCT
## 6:          NA          NA         NA   PASS GAAGAAGCCCT
##                              src_vcf_id                       tumor_bam_uuid
## 1: ec18b05e-0ab4-41d9-a183-43addb7be0ec a4631639-9972-40d5-9a71-ef8926b208a1
## 2: ec18b05e-0ab4-41d9-a183-43addb7be0ec a4631639-9972-40d5-9a71-ef8926b208a1
## 3: ec18b05e-0ab4-41d9-a183-43addb7be0ec a4631639-9972-40d5-9a71-ef8926b208a1
## 4: ec18b05e-0ab4-41d9-a183-43addb7be0ec a4631639-9972-40d5-9a71-ef8926b208a1
## 5: ec18b05e-0ab4-41d9-a183-43addb7be0ec a4631639-9972-40d5-9a71-ef8926b208a1
## 6: ec18b05e-0ab4-41d9-a183-43addb7be0ec a4631639-9972-40d5-9a71-ef8926b208a1
##                         normal_bam_uuid                              case_id
## 1: 8ac60993-f255-4d1c-b577-fa0af6a13876 64aa95b2-ccf7-4bfa-8d4f-98de09f03e71
## 2: 8ac60993-f255-4d1c-b577-fa0af6a13876 64aa95b2-ccf7-4bfa-8d4f-98de09f03e71
## 3: 8ac60993-f255-4d1c-b577-fa0af6a13876 64aa95b2-ccf7-4bfa-8d4f-98de09f03e71
## 4: 8ac60993-f255-4d1c-b577-fa0af6a13876 64aa95b2-ccf7-4bfa-8d4f-98de09f03e71
## 5: 8ac60993-f255-4d1c-b577-fa0af6a13876 64aa95b2-ccf7-4bfa-8d4f-98de09f03e71
## 6: 8ac60993-f255-4d1c-b577-fa0af6a13876 64aa95b2-ccf7-4bfa-8d4f-98de09f03e71
##    GDC_FILTER COSMIC MC3_Overlap GDC_Validation_Status      protocol
## 1:                          TRUE               Unknown somaticsniper
## 2:                          TRUE               Unknown somaticsniper
## 3:                          TRUE               Unknown somaticsniper
## 4:                          TRUE               Unknown somaticsniper
## 5:                          TRUE               Unknown somaticsniper
## 6:                          TRUE               Unknown somaticsniper
```
### example select TP53

```r
# copy and select element of vector
dput(names(maf2))
```

```
## c("Hugo_Symbol", "Entrez_Gene_Id", "Center", "NCBI_Build", "Chromosome", 
## "Start_Position", "End_Position", "Strand", "Variant_Classification", 
## "Variant_Type", "Reference_Allele", "Tumor_Seq_Allele1", "Tumor_Seq_Allele2", 
## "dbSNP_RS", "dbSNP_Val_Status", "Tumor_Sample_Barcode", "Matched_Norm_Sample_Barcode", 
## "Match_Norm_Seq_Allele1", "Match_Norm_Seq_Allele2", "Tumor_Validation_Allele1", 
## "Tumor_Validation_Allele2", "Match_Norm_Validation_Allele1", 
## "Match_Norm_Validation_Allele2", "Verification_Status", "Validation_Status", 
## "Mutation_Status", "Sequencing_Phase", "Sequence_Source", "Validation_Method", 
## "Score", "BAM_File", "Sequencer", "Tumor_Sample_UUID", "Matched_Norm_Sample_UUID", 
## "HGVSc", "HGVSp", "HGVSp_Short", "Transcript_ID", "Exon_Number", 
## "t_depth", "t_ref_count", "t_alt_count", "n_depth", "n_ref_count", 
## "n_alt_count", "all_effects", "Allele", "Gene", "Feature", "Feature_type", 
## "One_Consequence", "Consequence", "cDNA_position", "CDS_position", 
## "Protein_position", "Amino_acids", "Codons", "Existing_variation", 
## "ALLELE_NUM", "DISTANCE", "TRANSCRIPT_STRAND", "SYMBOL", "SYMBOL_SOURCE", 
## "HGNC_ID", "BIOTYPE", "CANONICAL", "CCDS", "ENSP", "SWISSPROT", 
## "TREMBL", "UNIPARC", "RefSeq", "SIFT", "PolyPhen", "EXON", "INTRON", 
## "DOMAINS", "GMAF", "AFR_MAF", "AMR_MAF", "ASN_MAF", "EAS_MAF", 
## "EUR_MAF", "SAS_MAF", "AA_MAF", "EA_MAF", "CLIN_SIG", "SOMATIC", 
## "PUBMED", "MOTIF_NAME", "MOTIF_POS", "HIGH_INF_POS", "MOTIF_SCORE_CHANGE", 
## "IMPACT", "PICK", "VARIANT_CLASS", "TSL", "HGVS_OFFSET", "PHENO", 
## "MINIMISED", "ExAC_AF", "ExAC_AF_Adj", "ExAC_AF_AFR", "ExAC_AF_AMR", 
## "ExAC_AF_EAS", "ExAC_AF_FIN", "ExAC_AF_NFE", "ExAC_AF_OTH", "ExAC_AF_SAS", 
## "GENE_PHENO", "FILTER", "CONTEXT", "src_vcf_id", "tumor_bam_uuid", 
## "normal_bam_uuid", "case_id", "GDC_FILTER", "COSMIC", "MC3_Overlap", 
## "GDC_Validation_Status", "protocol")
```

```r
selcol <- c("Hugo_Symbol", "Entrez_Gene_Id", "Variant_Classification", 
  "Tumor_Sample_Barcode",
  "Mutation_Status",
  "HGVSc",  "HGVSp_Short", "Transcript_ID", 
  "Gene",
  "CANONICAL", "CCDS", 
  "RefSeq", "SIFT", "PolyPhen", 
  "protocol")

(TP53 <- maf2[Hugo_Symbol=='TP53',..selcol])
```

```
##      Hugo_Symbol Entrez_Gene_Id Variant_Classification
##   1:        TP53           7157      Missense_Mutation
##   2:        TP53           7157      Missense_Mutation
##   3:        TP53           7157      Missense_Mutation
##   4:        TP53           7157            Splice_Site
##   5:        TP53           7157      Missense_Mutation
##  ---                                                  
## 620:        TP53           7157      Nonsense_Mutation
## 621:        TP53           7157      Missense_Mutation
## 622:        TP53           7157            Splice_Site
## 623:        TP53           7157            Splice_Site
## 624:        TP53           7157      Nonsense_Mutation
##              Tumor_Sample_Barcode Mutation_Status      HGVSc   HGVSp_Short
##   1: TCGA-IC-A6RE-01A-11D-A33E-09         Somatic   c.839G>A       p.R280K
##   2: TCGA-VR-AA7D-01A-11D-A403-09         Somatic   c.451C>T       p.P151S
##   3: TCGA-LN-A7HV-01A-21D-A351-09         Somatic   c.832C>G       p.P278A
##   4: TCGA-L5-A4OM-01A-11D-A27G-09         Somatic c.559+1G>A p.X187_splice
##   5: TCGA-L5-A43J-01A-12D-A247-09         Somatic   c.844C>T       p.R282W
##  ---                                                                      
## 620: TCGA-VR-AA4G-01A-11D-A37C-09         Somatic   c.281C>A        p.S94*
## 621: TCGA-L5-A8NK-01A-21D-A37C-09         Somatic   c.589G>T       p.V197L
## 622: TCGA-VR-A8EW-01A-11D-A36J-09         Somatic c.376-2A>G p.X126_splice
## 623: TCGA-IG-A625-01A-11D-A31U-09         Somatic c.672+1G>T p.X224_splice
## 624: TCGA-LN-A9FQ-01A-31D-A387-09         Somatic   c.916C>T       p.R306*
##        Transcript_ID            Gene CANONICAL        CCDS
##   1: ENST00000269305 ENSG00000141510       YES CCDS11118.1
##   2: ENST00000269305 ENSG00000141510       YES CCDS11118.1
##   3: ENST00000269305 ENSG00000141510       YES CCDS11118.1
##   4: ENST00000269305 ENSG00000141510       YES CCDS11118.1
##   5: ENST00000269305 ENSG00000141510       YES CCDS11118.1
##  ---                                                      
## 620: ENST00000269305 ENSG00000141510       YES CCDS11118.1
## 621: ENST00000269305 ENSG00000141510       YES CCDS11118.1
## 622: ENST00000269305 ENSG00000141510       YES CCDS11118.1
## 623: ENST00000269305 ENSG00000141510       YES CCDS11118.1
## 624: ENST00000269305 ENSG00000141510       YES CCDS11118.1
##                          RefSeq              SIFT                 PolyPhen
##   1: NM_000546.5;NM_001126112.2 deleterious(0.04)  possibly_damaging(0.83)
##   2: NM_000546.5;NM_001126112.2 deleterious(0.01) possibly_damaging(0.876)
##   3: NM_000546.5;NM_001126112.2 deleterious(0.01)     probably_damaging(1)
##   4: NM_000546.5;NM_001126112.2                                           
##   5: NM_000546.5;NM_001126112.2    deleterious(0) probably_damaging(0.997)
##  ---                                                                      
## 620: NM_000546.5;NM_001126112.2                                           
## 621: NM_000546.5;NM_001126112.2 deleterious(0.03) probably_damaging(0.999)
## 622: NM_000546.5;NM_001126112.2                                           
## 623: NM_000546.5;NM_001126112.2                                           
## 624: NM_000546.5;NM_001126112.2                                           
##           protocol
##   1: somaticsniper
##   2: somaticsniper
##   3: somaticsniper
##   4: somaticsniper
##   5: somaticsniper
##  ---              
## 620:          muse
## 621:          muse
## 622:          muse
## 623:          muse
## 624:          muse
```

```r
TP53[,.N,.(Hugo_Symbol,protocol)]
```

```
##    Hugo_Symbol      protocol   N
## 1:        TP53 somaticsniper 140
## 2:        TP53        mutect 173
## 3:        TP53       varscan 175
## 4:        TP53          muse 136
```

## note purrr map2用法

```R
~ .x .y becomes function(.x, .y), e.g.
map2(l, p, ~.x + .y) becomes
map2(l, p, function(l,p) l+p)
```



