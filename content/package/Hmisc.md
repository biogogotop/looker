+++
author = 'asepsiswu'
title = "Hmisc describe 描述表多列"
date = 2021-03-16T15:41:59+08:00
archives = "2021/03" 
tags = [ "data manipulate" ]
categories = [ "R" ]
summary = "describe 函数描述 临床信息 各列的情况, 用于后续变量选择"
+++

##  下载示例数据
[https://r.biogogo.top/data/TCGA-BRCA.GDC_phenotype.tsv.gz](https://r.biogogo.top/data/TCGA-BRCA.GDC_phenotype.tsv.gz)
## 下载到本地后读取

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
# download.file('https://r.biogogo.top/data/TCGA-BRCA.GDC_phenotype.tsv.gz',destfile = 'demo.tsv.gz')
# pdata <- fread('demo.tsv.gz',na.strings = '')
```

###  直接远程读取

```r
pdata <- fread('https://r.biogogo.top/data/TCGA-BRCA.GDC_phenotype.tsv.gz', na.strings = '')
# 列太多 不展示
```
### `Hmisc::describe` 描述数据

```r
desp <- Hmisc::describe(pdata)
head(desp)
```

```
## pdata 
## 
##  6  Variables      1284  Observations
## --------------------------------------------------------------------------------
## submitter_id.samples 
##        n  missing distinct 
##     1284        0     1284 
## 
## lowest : TCGA-3C-AAAU-01A TCGA-3C-AALI-01A TCGA-3C-AALJ-01A TCGA-3C-AALK-01A TCGA-4H-AAAK-01A
## highest: TCGA-XX-A899-01A TCGA-XX-A899-11A TCGA-XX-A89A-01A TCGA-Z7-A8R5-01A TCGA-Z7-A8R6-01A
## --------------------------------------------------------------------------------
## additional_pharmaceutical_therapy 
##        n  missing distinct 
##       47     1237        2 
##                       
## Value         NO   YES
## Frequency     20    27
## Proportion 0.426 0.574
## --------------------------------------------------------------------------------
## additional_radiation_therapy 
##        n  missing distinct 
##       47     1237        2 
##                       
## Value         NO   YES
## Frequency     32    15
## Proportion 0.681 0.319
## --------------------------------------------------------------------------------
## additional_surgery_locoregional_procedure 
##        n  missing distinct 
##       53     1231        2 
##                       
## Value         NO   YES
## Frequency     36    17
## Proportion 0.679 0.321
## --------------------------------------------------------------------------------
## additional_surgery_metastatic_procedure 
##        n  missing distinct    value 
##        8     1276        1       NO 
##              
## Value      NO
## Frequency   8
## Proportion  1
## --------------------------------------------------------------------------------
## age_at_initial_pathologic_diagnosis 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##     1282        2       65    0.999    58.29    15.24       38       41 
##      .25      .50      .75      .90      .95 
##       48       58       67       77       80 
## 
## lowest : 26 27 28 29 30, highest: 86 87 88 89 90
## --------------------------------------------------------------------------------
```

```r
## missing 
## 描述数据
```

1. 缺失值严重的列, 超过  1000 （总共1284）

```r
miss_col <- keep(desp, ~ as.numeric(.x$counts['missing'])>=1000  )
names(miss_col)
```

```
##  [1] "additional_pharmaceutical_therapy"                                                                               
##  [2] "additional_radiation_therapy"                                                                                    
##  [3] "additional_surgery_locoregional_procedure"                                                                       
##  [4] "additional_surgery_metastatic_procedure"                                                                         
##  [5] "axillary_lymph_node_stage_other_method_descriptive_text"                                                         
##  [6] "breast_cancer_surgery_margin_status"                                                                             
##  [7] "breast_carcinoma_immunohistochemistry_er_pos_finding_scale"                                                      
##  [8] "breast_carcinoma_immunohistochemistry_progesterone_receptor_pos_finding_scale"                                   
##  [9] "breast_carcinoma_primary_surgical_procedure_name"                                                                
## [10] "breast_neoplasm_other_surgical_procedure_descriptive_text"                                                       
## [11] "days_to_additional_surgery_metastatic_procedure"                                                                 
## [12] "days_to_new_tumor_event_after_initial_treatment"                                                                 
## [13] "her2_neu_and_centromere_17_copy_number_metastatic_breast_carcinoma_analysis_input_total_number_count"            
## [14] "her2_neu_metastatic_breast_carcinoma_copy_analysis_input_total_number"                                           
## [15] "histological_type_other"                                                                                         
## [16] "init_pathology_dx_method_other"                                                                                  
## [17] "metastatic_breast_carcinoma_erbb2_immunohistochemistry_level_result"                                             
## [18] "metastatic_breast_carcinoma_estrogen_receptor_detection_method_text"                                             
## [19] "metastatic_breast_carcinoma_estrogen_receptor_level_cell_percent_category"                                       
## [20] "metastatic_breast_carcinoma_estrogen_receptor_status"                                                            
## [21] "metastatic_breast_carcinoma_fluorescence_in_situ_hybridization_diagnostic_proc_centromere_17_signal_result_range"
## [22] "metastatic_breast_carcinoma_her2_erbb_method_calculation_method_text"                                            
## [23] "metastatic_breast_carcinoma_her2_erbb_pos_finding_cell_percent_category"                                         
## [24] "metastatic_breast_carcinoma_her2_erbb_pos_finding_fluorescence_in_situ_hybridization_calculation_method_text"    
## [25] "metastatic_breast_carcinoma_her2_neu_chromosone_17_signal_ratio_value"                                           
## [26] "metastatic_breast_carcinoma_immunohistochemistry_er_pos_cell_score"                                              
## [27] "metastatic_breast_carcinoma_immunohistochemistry_er_positive_finding_scale_type"                                 
## [28] "metastatic_breast_carcinoma_immunohistochemistry_pr_pos_cell_score"                                              
## [29] "metastatic_breast_carcinoma_immunohistochemistry_progesterone_receptor_positive_finding_scale_type"              
## [30] "metastatic_breast_carcinoma_lab_proc_her2_neu_immunohistochemistry_receptor_status"                              
## [31] "metastatic_breast_carcinoma_lab_proc_her2_neu_in_situ_hybridization_outcome_type"                                
## [32] "metastatic_breast_carcinoma_pos_finding_her2_erbb2_other_measure_scale_text"                                     
## [33] "metastatic_breast_carcinoma_pos_finding_progesterone_receptor_other_measure_scale_text"                          
## [34] "metastatic_breast_carcinoma_progesterone_receptor_detection_method_text"                                         
## [35] "metastatic_breast_carcinoma_progesterone_receptor_level_cell_percent_category"                                   
## [36] "metastatic_breast_carcinoma_progesterone_receptor_status"                                                        
## [37] "metastatic_site_at_diagnosis_other"                                                                              
## [38] "new_neoplasm_event_occurrence_anatomic_site"                                                                     
## [39] "new_neoplasm_event_type"                                                                                         
## [40] "new_neoplasm_occurrence_anatomic_site_text"                                                                      
## [41] "pos_finding_metastatic_breast_carcinoma_estrogen_receptor_other_measuremenet_scale_text"                         
## [42] "dbgap_registration_code"                                                                                         
## [43] "program"                                                                                                         
## [44] "days_to_death.demographic"                                                                                       
## [45] "year_of_death.demographic"                                                                                       
## [46] "days_to_sample_procurement.samples"                                                                              
## [47] "preservation_method.samples"
```

### 2. value 均一值太高的列， 90

```r
# distinct 值为1, 表示相同值
uni_col <- keep(desp, ~.x$counts['distinct'] ==1)
```

###  保留列

```r
drop_col <- c(names(miss_col),names(uni_col))

keep_col <- ! names(desp) %in% drop_col

pdata_sub <- subset(pdata,select =  keep_col)

desp[keep_col]
```

```
## pdata 
## 
##  71  Variables      1284  Observations
## --------------------------------------------------------------------------------
## submitter_id.samples 
##        n  missing distinct 
##     1284        0     1284 
## 
## lowest : TCGA-3C-AAAU-01A TCGA-3C-AALI-01A TCGA-3C-AALJ-01A TCGA-3C-AALK-01A TCGA-4H-AAAK-01A
## highest: TCGA-XX-A899-01A TCGA-XX-A899-11A TCGA-XX-A89A-01A TCGA-Z7-A8R5-01A TCGA-Z7-A8R6-01A
## --------------------------------------------------------------------------------
## age_at_initial_pathologic_diagnosis 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##     1282        2       65    0.999    58.29    15.24       38       41 
##      .25      .50      .75      .90      .95 
##       48       58       67       77       80 
## 
## lowest : 26 27 28 29 30, highest: 86 87 88 89 90
## --------------------------------------------------------------------------------
## axillary_lymph_node_stage_method_type 
##        n  missing distinct 
##      999      285        5 
## 
## lowest : Axillary lymph node dissection alone                No axillary staging                                 Other (specify)                                     Sentinel lymph node biopsy plus axillary dissection Sentinel node biopsy alone                         
## highest: Axillary lymph node dissection alone                No axillary staging                                 Other (specify)                                     Sentinel lymph node biopsy plus axillary dissection Sentinel node biopsy alone                         
## 
## Axillary lymph node dissection alone (360, 0.360), No axillary staging (37,
## 0.037), Other (specify) (22, 0.022), Sentinel lymph node biopsy plus axillary
## dissection (274, 0.274), Sentinel node biopsy alone (306, 0.306)
## --------------------------------------------------------------------------------
## batch_number 
##        n  missing distinct 
##     1284        0       38 
## 
## lowest : 103.79.0 109.89.0 117.79.0 120.77.0 124.81.0
## highest: 80.80.0  80.84.0  85.86.0  93.87.0  96.80.0 
## --------------------------------------------------------------------------------
## bcr_followup_barcode 
##        n  missing distinct 
##     1142      142      999 
## 
## lowest : TCGA-3C-AAAU-F68069 TCGA-3C-AALI-F68057 TCGA-3C-AALJ-F68060 TCGA-3C-AALK-F68063 TCGA-4H-AAAK-F67414
## highest: TCGA-WT-AB44-F66640 TCGA-XX-A899-F67626 TCGA-XX-A89A-F67425 TCGA-Z7-A8R5-F58763 TCGA-Z7-A8R6-F58752
## --------------------------------------------------------------------------------
## bcr_followup_uuid 
##        n  missing distinct 
##     1142      142      999 
## 
## lowest : 0021AB34-8C5F-451E-8B64-DF949CB50034 00555AC3-B1C1-4712-A6CD-9FDF98F9D2B3 00808159-4015-4B79-B29A-1BBE85BF2CF2 00ADA7FD-4CEC-4D7C-A86A-BAFE4B35FEE2 00AF090C-547A-493B-9220-2FEF43822FD0
## highest: FE2AC366-DA1D-44C8-ACF7-B1703E8DAFC4 FEC2BC26-90CA-4ACF-87BF-4F743CBDB5D4 FF988B0B-A019-44FD-8CB3-0DEF979A82D9 FF9E318B-6811-4218-A62F-2D57AA48A597 FFA983CC-57D9-4557-B5BB-BCD3D09CB1CE
## --------------------------------------------------------------------------------
## submitter_id 
##        n  missing distinct 
##     1284        0     1098 
## 
## lowest : TCGA-3C-AAAU TCGA-3C-AALI TCGA-3C-AALJ TCGA-3C-AALK TCGA-4H-AAAK
## highest: TCGA-WT-AB44 TCGA-XX-A899 TCGA-XX-A89A TCGA-Z7-A8R5 TCGA-Z7-A8R6
## --------------------------------------------------------------------------------
## breast_carcinoma_surgical_procedure_name 
##        n  missing distinct 
##     1213       71        4 
##                                                                   
## Value                       Lumpectomy Modified Radical Mastectomy
## Frequency                          278                         376
## Proportion                       0.229                       0.310
##                                                                   
## Value                            Other           Simple Mastectomy
## Frequency                          321                         238
## Proportion                       0.265                       0.196
## --------------------------------------------------------------------------------
## cytokeratin_immunohistochemistry_staining_method_micrometastasis_indicator 
##        n  missing distinct 
##      838      446        2 
##                     
## Value        NO  YES
## Frequency   545  293
## Proportion 0.65 0.35
## --------------------------------------------------------------------------------
## day_of_dcc_upload 
##        n  missing distinct     Info     Mean      Gmd 
##     1284        0        2    0.005    21.99  0.01245 
##                       
## Value         18    22
## Frequency      2  1282
## Proportion 0.002 0.998
## --------------------------------------------------------------------------------
## day_of_form_completion 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##     1142      142       31    0.997    14.25    10.21        1        2 
##      .25      .50      .75      .90      .95 
##        8       14       22       27       29 
## 
## lowest :  1  2  3  4  5, highest: 27 28 29 30 31
## --------------------------------------------------------------------------------
## distant_metastasis_present_ind2 
##        n  missing distinct 
##      500      784        2 
##                       
## Value         NO   YES
## Frequency    481    19
## Proportion 0.962 0.038
## --------------------------------------------------------------------------------
## file_uuid 
##        n  missing distinct 
##     1284        0     1098 
## 
## lowest : 001D776A-5FE9-413B-8B48-924F37DCC30D 004F4BDD-95E5-4BF2-8D2D-905D79154314 00B017EF-F43C-4335-98F6-A3C44F631A92 00C1F779-F1CD-4F67-82D0-2AC6A53169F8 00F71E62-6121-423A-A8F4-44B8FB97E766
## highest: FF03E332-A196-452D-8E5F-3440301F9B41 FF62B6A5-1740-41D2-96BF-DB4099E732B9 FF943261-47BF-4F7A-A30E-C50543467925 FFA6746C-9F8C-4DF8-B673-1631FD13F57F FFAC43F5-5A77-4431-87F6-26AB7480ADC1
## --------------------------------------------------------------------------------
## followup_case_report_form_submission_reason 
##        n  missing distinct 
##      359      925        2 
##                                                                         
## Value          Additional New Tumor Event Scheduled Follow-up Submission
## Frequency                               4                            355
## Proportion                          0.011                          0.989
## --------------------------------------------------------------------------------
## history_of_neoadjuvant_treatment 
##        n  missing distinct 
##     1280        4        2 
##                       
## Value         No   Yes
## Frequency   1266    14
## Proportion 0.989 0.011
## --------------------------------------------------------------------------------
## initial_pathologic_diagnosis_method 
##        n  missing distinct 
##     1181      103        7 
## 
## lowest : Core needle biopsy                          Cytology (e.g. Peritoneal or pleural fluid) Excisional Biopsy                           Fine needle aspiration biopsy               Incisional Biopsy                          
## highest: Excisional Biopsy                           Fine needle aspiration biopsy               Incisional Biopsy                           Other method, specify:                      Tumor resection                            
## 
## Core needle biopsy (714, 0.605), Cytology (e.g. Peritoneal or pleural fluid)
## (29, 0.025), Excisional Biopsy (34, 0.029), Fine needle aspiration biopsy (116,
## 0.098), Incisional Biopsy (17, 0.014), Other method, specify: (66, 0.056),
## Tumor resection (205, 0.174)
## --------------------------------------------------------------------------------
## lost_follow_up 
##        n  missing distinct 
##      700      584        2 
##                       
## Value         NO   YES
## Frequency    633    67
## Proportion 0.904 0.096
## --------------------------------------------------------------------------------
## lymph_node_examined_count 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##     1149      135       42    0.996    10.72    9.607        1        2 
##      .25      .50      .75      .90      .95 
##        3        9       16       24       27 
## 
## lowest :  0  1  2  3  4, highest: 38 39 40 43 44
## --------------------------------------------------------------------------------
## margin_status 
##        n  missing distinct 
##     1182      102        3 
##                                      
## Value         Close Negative Positive
## Frequency        38     1062       82
## Proportion    0.032    0.898    0.069
## --------------------------------------------------------------------------------
## menopause_status 
##        n  missing distinct 
##     1158      126        4 
## 
## --------------------------------------------------------------------------------
## month_of_form_completion 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##     1142      142       12    0.991    6.342    4.215        1        2 
##      .25      .50      .75      .90      .95 
##        3        6       10       12       12 
## 
## lowest :  1  2  3  4  5, highest:  8  9 10 11 12
##                                                                             
## Value          1     2     3     4     5     6     7     8     9    10    11
## Frequency     96   110   168    75    97    63    57   103    49    84   124
## Proportion 0.084 0.096 0.147 0.066 0.085 0.055 0.050 0.090 0.043 0.074 0.109
##                 
## Value         12
## Frequency    116
## Proportion 0.102
## --------------------------------------------------------------------------------
## new_tumor_event_after_initial_treatment 
##        n  missing distinct 
##      358      926        2 
##                     
## Value        NO  YES
## Frequency   308   50
## Proportion 0.86 0.14
## --------------------------------------------------------------------------------
## number_of_lymphnodes_positive_by_he 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##     1107      177       31    0.878    2.396    3.665        0        0 
##      .25      .50      .75      .90      .95 
##        0        1        2        7       12 
## 
## lowest :  0  1  2  3  4, highest: 26 27 28 29 35
## --------------------------------------------------------------------------------
## number_of_lymphnodes_positive_by_ihc 
##        n  missing distinct     Info     Mean      Gmd 
##      384      900        6    0.441   0.2708    0.474 
## 
## lowest : 0 1 2 3 4, highest: 1 2 3 4 8
##                                               
## Value          0     1     2     3     4     8
## Frequency    316    49    11     3     4     1
## Proportion 0.823 0.128 0.029 0.008 0.010 0.003
## --------------------------------------------------------------------------------
## other_dx 
##        n  missing distinct 
##     1281        3        2 
##                       
## Value         No   Yes
## Frequency   1201    80
## Proportion 0.938 0.062
## --------------------------------------------------------------------------------
## pathologic_M 
##        n  missing distinct 
##     1282        2        4 
##                                               
## Value      cM0 (i+)       M0       M1       MX
## Frequency         8     1062       24      188
## Proportion    0.006    0.828    0.019    0.147
## --------------------------------------------------------------------------------
## pathologic_N 
##        n  missing distinct 
##     1282        2       16 
## 
## lowest : N0        N0 (i-)   N0 (i+)   N0 (mol+) N1       
## highest: N3        N3a       N3b       N3c       NX       
## 
## N0 (392, 0.306), N0 (i-) (172, 0.134), N0 (i+) (29, 0.023), N0 (mol+) (2,
## 0.002), N1 (147, 0.115), N1a (195, 0.152), N1b (48, 0.037), N1c (4, 0.003),
## N1mi (45, 0.035), N2 (63, 0.049), N2a (73, 0.057), N3 (29, 0.023), N3a (56,
## 0.044), N3b (3, 0.002), N3c (1, 0.001), NX (23, 0.018)
## --------------------------------------------------------------------------------
## pathologic_T 
##        n  missing distinct 
##     1282        2       13 
## 
## lowest : T1  T1a T1b T1c T2 , highest: T3a T4  T4b T4d TX 
##                                                                             
## Value         T1   T1a   T1b   T1c    T2   T2a   T2b    T3   T3a    T4   T4b
## Frequency     46     2    18   260   743     1     2   157     1     9    36
## Proportion 0.036 0.002 0.014 0.203 0.580 0.001 0.002 0.122 0.001 0.007 0.028
##                       
## Value        T4d    TX
## Frequency      4     3
## Proportion 0.003 0.002
## --------------------------------------------------------------------------------
## patient_id 
##        n  missing distinct 
##     1284        0     1098 
## 
## lowest : A03L A03M A03N A03O A03P, highest: AAT1 AAZ6 AB28 AB41 AB44
## --------------------------------------------------------------------------------
## person_neoplasm_cancer_status 
##        n  missing distinct 
##     1069      215        2 
##                                 
## Value      TUMOR FREE WITH TUMOR
## Frequency         955        114
## Proportion      0.893      0.107
## --------------------------------------------------------------------------------
## postoperative_rx_tx 
##        n  missing distinct 
##     1104      180        2 
##                       
## Value         NO   YES
## Frequency    162   942
## Proportion 0.147 0.853
## --------------------------------------------------------------------------------
## primary_lymph_node_presentation_assessment 
##        n  missing distinct 
##      869      415        2 
##                       
## Value         NO   YES
## Frequency     30   839
## Proportion 0.035 0.965
## --------------------------------------------------------------------------------
## radiation_therapy 
##        n  missing distinct 
##     1115      169        2 
##                       
## Value         NO   YES
## Frequency    490   625
## Proportion 0.439 0.561
## --------------------------------------------------------------------------------
## surgical_procedure_purpose_other_text 
##        n  missing distinct 
##      325      959       76 
## 
## lowest : Bilateral Mastectomy                                                                         Bilateral skin sparing Mastectomy and Bilateral breast reconstruction with tissue expanders. bilateral total mastectomies with right sentinel node biopsy                                 biopsy                                                                                       breast conserving therapy                                                                   
## highest: wide local excision                                                                          Wide local excision                                                                          Wide Local Excision                                                                          Wide local excision and simple mastectomy                                                    Wide re-excisional biopsy                                                                   
## --------------------------------------------------------------------------------
## system_version 
##        n  missing distinct 
##     1108      176        5 
## 
## lowest : 3rd 4th 5th 6th 7th, highest: 3rd 4th 5th 6th 7th
##                                         
## Value        3rd   4th   5th   6th   7th
## Frequency      8    29    95   509   467
## Proportion 0.007 0.026 0.086 0.459 0.421
## --------------------------------------------------------------------------------
## tissue_prospective_collection_indicator 
##        n  missing distinct 
##     1278        6        2 
##                       
## Value         NO   YES
## Frequency    866   412
## Proportion 0.678 0.322
## --------------------------------------------------------------------------------
## tissue_retrospective_collection_indicator 
##        n  missing distinct 
##     1278        6        2 
##                       
## Value         NO   YES
## Frequency    412   866
## Proportion 0.322 0.678
## --------------------------------------------------------------------------------
## tissue_source_site 
##        n  missing distinct 
##     1284        0       40 
## 
## lowest : 3C 4H 5L 5T A1, highest: V7 W8 WT XX Z7
## --------------------------------------------------------------------------------
## year_of_dcc_upload 
##        n  missing distinct     Info     Mean      Gmd 
##     1284        0        2    0.005     2016 0.003113 
##                       
## Value       2015  2016
## Frequency      2  1282
## Proportion 0.002 0.998
## --------------------------------------------------------------------------------
## year_of_form_completion 
##        n  missing distinct     Info     Mean      Gmd 
##     1142      142        6    0.952     2013    1.547 
## 
## lowest : 2010 2011 2012 2013 2014, highest: 2011 2012 2013 2014 2015
##                                               
## Value       2010  2011  2012  2013  2014  2015
## Frequency     68   195   192   276   325    86
## Proportion 0.060 0.171 0.168 0.242 0.285 0.075
## --------------------------------------------------------------------------------
## year_of_initial_pathologic_diagnosis 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##     1280        4       26    0.987     2008    4.429     1998     2001 
##      .25      .50      .75      .90      .95 
##     2006     2009     2010     2012     2013 
## 
## lowest : 1988 1989 1990 1991 1992, highest: 2009 2010 2011 2012 2013
## --------------------------------------------------------------------------------
## pathology_report_file_name 
##        n  missing distinct 
##     1120      164     1104 
## 
## lowest : TCGA-3C-AAAU.0CD23E1B-3FA3-4A43-AE6E-C8E7B51252F8.pdf TCGA-3C-AALI.84E6A935-1A49-4BC1-9669-3DEA161CF6FC.pdf TCGA-3C-AALJ.265E5A9A-64FD-4B86-89BC-5E89F253C118.pdf TCGA-3C-AALK.F43B01E6-E1DB-44B1-8003-93870606346A.pdf TCGA-4H-AAAK.8894688F-7167-48A1-BB1B-FC219B7675C2.pdf
## highest: TCGA-WT-AB44.B7EB0E0B-46C5-43C0-A78D-FB094290765A.pdf TCGA-XX-A899.EA8A0A91-7A83-4EC9-B7A0-0C3300D1FD14.pdf TCGA-XX-A89A.5D85E578-64B4-4238-922E-802B8ED87800.pdf TCGA-Z7-A8R5.7726F7AA-88A8-4DD6-B322-6FC68893E0D2.pdf TCGA-Z7-A8R6.9A5C8EDF-9243-4F55-9036-A400CF3F4CC1.pdf
## --------------------------------------------------------------------------------
## vial_number 
##        n  missing distinct 
##     1283        1        3 
##                             
## Value          A     B     C
## Frequency   1241    41     1
## Proportion 0.967 0.032 0.001
## --------------------------------------------------------------------------------
## age_at_index.demographic 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##     1282        2       65    0.999    58.29    15.24       38       41 
##      .25      .50      .75      .90      .95 
##       48       58       67       77       80 
## 
## lowest : 26 27 28 29 30, highest: 86 87 88 89 90
## --------------------------------------------------------------------------------
## days_to_birth.demographic 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##     1266       18     1044        1   -21521     5551   -29689   -28512 
##      .25      .50      .75      .90      .95 
##   -24838   -21488   -17809   -15162   -13983 
## 
## lowest : -32872 -32871 -32842 -32750 -32583, highest: -10616 -10564  -9873  -9840  -9706
## --------------------------------------------------------------------------------
## ethnicity.demographic 
##        n  missing distinct 
##     1282        2        3 
##                                                                                
## Value          hispanic or latino not hispanic or latino           not reported
## Frequency                      41                   1037                    204
## Proportion                  0.032                  0.809                  0.159
## --------------------------------------------------------------------------------
## gender.demographic 
##        n  missing distinct 
##     1282        2        2 
##                         
## Value      female   male
## Frequency    1269     13
## Proportion   0.99   0.01
## --------------------------------------------------------------------------------
## race.demographic 
##        n  missing distinct 
##     1282        2        5 
## 
## lowest : american indian or alaska native asian                            black or african american        not reported                     white                           
## highest: american indian or alaska native asian                            black or african american        not reported                     white                           
## 
## american indian or alaska native (1, 0.001), asian (62, 0.048), black or
## african american (200, 0.156), not reported (96, 0.075), white (923, 0.720)
## --------------------------------------------------------------------------------
## vital_status.demographic 
##        n  missing distinct 
##     1282        2        2 
##                       
## Value      Alive  Dead
## Frequency   1068   214
## Proportion 0.833 0.167
## --------------------------------------------------------------------------------
## year_of_birth.demographic 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##     1279        5       73    0.999     1949    15.74     1925     1930 
##      .25      .50      .75      .90      .95 
##     1940     1950     1960     1967     1970 
## 
## lowest : 1902 1909 1910 1913 1914, highest: 1979 1980 1981 1983 1984
## --------------------------------------------------------------------------------
## age_at_diagnosis.diagnoses 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##     1266       18     1044        1    21521     5551    13983    15162 
##      .25      .50      .75      .90      .95 
##    17809    21488    24838    28512    29689 
## 
## lowest :  9706  9840  9873 10564 10616, highest: 32583 32750 32842 32871 32872
## --------------------------------------------------------------------------------
## days_to_last_follow_up.diagnoses 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##     1129      155      762        1     1191     1125     30.0    215.8 
##      .25      .50      .75      .90      .95 
##    441.0    791.0   1612.0   2634.6   3247.6 
## 
## lowest :   -7    0    1    2    5, highest: 7777 8008 8391 8556 8605
## --------------------------------------------------------------------------------
## icd_10_code.diagnoses 
##        n  missing distinct 
##     1282        2        7 
## 
## lowest : C50.2   C50.3   C50.4   C50.5   C50.8  
## highest: C50.4   C50.5   C50.8   C50.9   C50.919
##                                                                   
## Value        C50.2   C50.3   C50.4   C50.5   C50.8   C50.9 C50.919
## Frequency        2       6       5       1       3    1264       1
## Proportion   0.002   0.005   0.004   0.001   0.002   0.986   0.001
## --------------------------------------------------------------------------------
## morphology.diagnoses 
##        n  missing distinct 
##     1282        2       22 
## 
## lowest : 8010/3 8013/3 8022/3 8050/3 8090/3, highest: 8523/3 8524/3 8541/3 8575/3 9020/3
## --------------------------------------------------------------------------------
## primary_diagnosis.diagnoses 
##        n  missing distinct 
##     1282        2       22 
## 
## lowest : Adenoid cystic carcinoma      Apocrine adenocarcinoma       Basal cell carcinoma, NOS     Carcinoma, NOS                Cribriform carcinoma, NOS    
## highest: Papillary carcinoma, NOS      Phyllodes tumor, malignant    Pleomorphic carcinoma         Secretory carcinoma of breast Tubular adenocarcinoma       
## --------------------------------------------------------------------------------
## prior_malignancy.diagnoses 
##        n  missing distinct 
##     1282        2        3 
##                                                  
## Value                no not reported          yes
## Frequency          1201            1           80
## Proportion        0.937        0.001        0.062
## --------------------------------------------------------------------------------
## prior_treatment.diagnoses 
##        n  missing distinct 
##     1282        2        3 
##                                                  
## Value                No Not Reported          Yes
## Frequency          1266            2           14
## Proportion        0.988        0.002        0.011
## --------------------------------------------------------------------------------
## site_of_resection_or_biopsy.diagnoses 
##        n  missing distinct 
##     1282        2        6 
## 
## lowest : Breast, NOS                    Lower-inner quadrant of breast Lower-outer quadrant of breast Overlapping lesion of breast   Upper-inner quadrant of breast
## highest: Lower-inner quadrant of breast Lower-outer quadrant of breast Overlapping lesion of breast   Upper-inner quadrant of breast Upper-outer quadrant of breast
## 
## Breast, NOS (1265, 0.987), Lower-inner quadrant of breast (6, 0.005),
## Lower-outer quadrant of breast (1, 0.001), Overlapping lesion of breast (3,
## 0.002), Upper-inner quadrant of breast (2, 0.002), Upper-outer quadrant of
## breast (5, 0.004)
## --------------------------------------------------------------------------------
## synchronous_malignancy.diagnoses 
##        n  missing distinct 
##     1282        2        2 
##                                     
## Value                No Not Reported
## Frequency          1201           81
## Proportion        0.937        0.063
## --------------------------------------------------------------------------------
## tissue_or_organ_of_origin.diagnoses 
##        n  missing distinct 
##     1282        2        6 
## 
## lowest : Breast, NOS                    Lower-inner quadrant of breast Lower-outer quadrant of breast Overlapping lesion of breast   Upper-inner quadrant of breast
## highest: Lower-inner quadrant of breast Lower-outer quadrant of breast Overlapping lesion of breast   Upper-inner quadrant of breast Upper-outer quadrant of breast
## 
## Breast, NOS (1265, 0.987), Lower-inner quadrant of breast (6, 0.005),
## Lower-outer quadrant of breast (1, 0.001), Overlapping lesion of breast (3,
## 0.002), Upper-inner quadrant of breast (2, 0.002), Upper-outer quadrant of
## breast (5, 0.004)
## --------------------------------------------------------------------------------
## tumor_stage.diagnoses 
##        n  missing distinct 
##     1282        2       13 
## 
## lowest : not reported stage i      stage ia     stage ib     stage ii    
## highest: stage iiia   stage iiib   stage iiic   stage iv     stage x     
## 
## not reported (12, 0.009), stage i (114, 0.089), stage ia (94, 0.073), stage ib
## (7, 0.005), stage ii (6, 0.005), stage iia (415, 0.324), stage iib (310,
## 0.242), stage iii (2, 0.002), stage iiia (178, 0.139), stage iiib (32, 0.025),
## stage iiic (77, 0.060), stage iv (22, 0.017), stage x (13, 0.010)
## --------------------------------------------------------------------------------
## year_of_diagnosis.diagnoses 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##     1280        4       26    0.987     2008    4.429     1998     2001 
##      .25      .50      .75      .90      .95 
##     2006     2009     2010     2012     2013 
## 
## lowest : 1988 1989 1990 1991 1992, highest: 2009 2010 2011 2012 2013
## --------------------------------------------------------------------------------
## disease_type 
##        n  missing distinct 
##     1283        1        9 
## 
## lowest : Adenomas and Adenocarcinomas          Adnexal and Skin Appendage Neoplasms  Basal Cell Neoplasms                  Complex Epithelial Neoplasms          Cystic, Mucinous and Serous Neoplasms
## highest: Cystic, Mucinous and Serous Neoplasms Ductal and Lobular Neoplasms          Epithelial Neoplasms, NOS             Fibroepithelial Neoplasms             Squamous Cell Neoplasms              
## --------------------------------------------------------------------------------
## code.tissue_source_site 
##        n  missing distinct 
##     1283        1       40 
## 
## lowest : 3C 4H 5L 5T A1, highest: V7 W8 WT XX Z7
## --------------------------------------------------------------------------------
## name.tissue_source_site 
##        n  missing distinct 
##     1283        1       40 
## 
## lowest : ABS - IUPUI                     ABS - Research Metrics Pakistan Albert Einstein Medical Center  Asterand                        Boston Medical Center          
## highest: University of Miami             University of Minnesota         University of Pittsburgh        University of Sao Paulo         Walter Reed                    
## --------------------------------------------------------------------------------
## days_to_collection.samples 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##     1281        3      751        1     1137     1407       45       64 
##      .25      .50      .75      .90      .95 
##      157      505     1424     3374     4664 
## 
## lowest :   16   21   22   27   28, highest: 7290 7362 7492 7820 7858
## --------------------------------------------------------------------------------
## initial_weight.samples 
##        n  missing distinct     Info     Mean      Gmd      .05      .10 
##     1268       16      126    0.999    311.4    263.1     60.0     80.0 
##      .25      .50      .75      .90      .95 
##    130.0    220.0    400.0    640.0    886.5 
## 
## lowest :    5   10   20   30   40, highest: 1710 1740 1760 1830 2190
## --------------------------------------------------------------------------------
## is_ffpe.samples 
##        n  missing distinct 
##     1283        1        2 
##                       
## Value      FALSE  TRUE
## Frequency   1268    15
## Proportion 0.988 0.012
## --------------------------------------------------------------------------------
## oct_embedded.samples 
##        n  missing distinct 
##     1283        1        3 
##                             
## Value      false    No  true
## Frequency    506     3   774
## Proportion 0.394 0.002 0.603
## --------------------------------------------------------------------------------
## sample_type.samples 
##        n  missing distinct 
##     1283        1        3 
##                                                                       
## Value               Metastatic       Primary Tumor Solid Tissue Normal
## Frequency                    7                1114                 162
## Proportion               0.005               0.868               0.126
## --------------------------------------------------------------------------------
## sample_type_id.samples 
##        n  missing distinct     Info     Mean      Gmd 
##     1283        1        3    0.343     2.29    2.249 
##                             
## Value          1     6    11
## Frequency   1114     7   162
## Proportion 0.868 0.005 0.126
## --------------------------------------------------------------------------------
```
