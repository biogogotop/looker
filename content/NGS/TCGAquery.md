+++
author = 'asepsiswu'
title = "TCGA 查找表达数据"
date = 2020-07-11
archives = "2020/07" 
tags = [ "data.table" ]
summary = "transpose 转置数据并查找miRNA exp"
+++

## load TCGA sample data
###  phenodata

```{.r .bg-danger}
library(data.table)
phenodata <- fread('https://r.biogogo.top/data/TCGA-BRCA.GDC_phenotype.tsv.gz')
names(phenodata)
```

```{.bg-warning}
##   [1] "submitter_id.samples"                                                                                            
##   [2] "additional_pharmaceutical_therapy"                                                                               
##   [3] "additional_radiation_therapy"                                                                                    
##   [4] "additional_surgery_locoregional_procedure"                                                                       
##   [5] "additional_surgery_metastatic_procedure"                                                                         
##   [6] "age_at_initial_pathologic_diagnosis"                                                                             
##   [7] "axillary_lymph_node_stage_method_type"                                                                           
##   [8] "axillary_lymph_node_stage_other_method_descriptive_text"                                                         
##   [9] "batch_number"                                                                                                    
##  [10] "bcr"                                                                                                             
##  [11] "bcr_followup_barcode"                                                                                            
##  [12] "bcr_followup_uuid"                                                                                               
##  [13] "submitter_id"                                                                                                    
##  [14] "breast_cancer_surgery_margin_status"                                                                             
##  [15] "breast_carcinoma_immunohistochemistry_er_pos_finding_scale"                                                      
##  [16] "breast_carcinoma_immunohistochemistry_progesterone_receptor_pos_finding_scale"                                   
##  [17] "breast_carcinoma_primary_surgical_procedure_name"                                                                
##  [18] "breast_carcinoma_surgical_procedure_name"                                                                        
##  [19] "breast_neoplasm_other_surgical_procedure_descriptive_text"                                                       
##  [20] "cytokeratin_immunohistochemistry_staining_method_micrometastasis_indicator"                                      
##  [21] "day_of_dcc_upload"                                                                                               
##  [22] "day_of_form_completion"                                                                                          
##  [23] "days_to_additional_surgery_metastatic_procedure"                                                                 
##  [24] "days_to_initial_pathologic_diagnosis"                                                                            
##  [25] "days_to_new_tumor_event_after_initial_treatment"                                                                 
##  [26] "distant_metastasis_present_ind2"                                                                                 
##  [27] "file_uuid"                                                                                                       
##  [28] "followup_case_report_form_submission_reason"                                                                     
##  [29] "her2_neu_and_centromere_17_copy_number_metastatic_breast_carcinoma_analysis_input_total_number_count"            
##  [30] "her2_neu_metastatic_breast_carcinoma_copy_analysis_input_total_number"                                           
##  [31] "histological_type_other"                                                                                         
##  [32] "history_of_neoadjuvant_treatment"                                                                                
##  [33] "informed_consent_verified"                                                                                       
##  [34] "init_pathology_dx_method_other"                                                                                  
##  [35] "initial_pathologic_diagnosis_method"                                                                             
##  [36] "lost_follow_up"                                                                                                  
##  [37] "lymph_node_examined_count"                                                                                       
##  [38] "margin_status"                                                                                                   
##  [39] "menopause_status"                                                                                                
##  [40] "metastatic_breast_carcinoma_erbb2_immunohistochemistry_level_result"                                             
##  [41] "metastatic_breast_carcinoma_estrogen_receptor_detection_method_text"                                             
##  [42] "metastatic_breast_carcinoma_estrogen_receptor_level_cell_percent_category"                                       
##  [43] "metastatic_breast_carcinoma_estrogen_receptor_status"                                                            
##  [44] "metastatic_breast_carcinoma_fluorescence_in_situ_hybridization_diagnostic_proc_centromere_17_signal_result_range"
##  [45] "metastatic_breast_carcinoma_her2_erbb_method_calculation_method_text"                                            
##  [46] "metastatic_breast_carcinoma_her2_erbb_pos_finding_cell_percent_category"                                         
##  [47] "metastatic_breast_carcinoma_her2_erbb_pos_finding_fluorescence_in_situ_hybridization_calculation_method_text"    
##  [48] "metastatic_breast_carcinoma_her2_neu_chromosone_17_signal_ratio_value"                                           
##  [49] "metastatic_breast_carcinoma_immunohistochemistry_er_pos_cell_score"                                              
##  [50] "metastatic_breast_carcinoma_immunohistochemistry_er_positive_finding_scale_type"                                 
##  [51] "metastatic_breast_carcinoma_immunohistochemistry_pr_pos_cell_score"                                              
##  [52] "metastatic_breast_carcinoma_immunohistochemistry_progesterone_receptor_positive_finding_scale_type"              
##  [53] "metastatic_breast_carcinoma_lab_proc_her2_neu_immunohistochemistry_receptor_status"                              
##  [54] "metastatic_breast_carcinoma_lab_proc_her2_neu_in_situ_hybridization_outcome_type"                                
##  [55] "metastatic_breast_carcinoma_pos_finding_her2_erbb2_other_measure_scale_text"                                     
##  [56] "metastatic_breast_carcinoma_pos_finding_progesterone_receptor_other_measure_scale_text"                          
##  [57] "metastatic_breast_carcinoma_progesterone_receptor_detection_method_text"                                         
##  [58] "metastatic_breast_carcinoma_progesterone_receptor_level_cell_percent_category"                                   
##  [59] "metastatic_breast_carcinoma_progesterone_receptor_status"                                                        
##  [60] "metastatic_site_at_diagnosis_other"                                                                              
##  [61] "month_of_dcc_upload"                                                                                             
##  [62] "month_of_form_completion"                                                                                        
##  [63] "new_neoplasm_event_occurrence_anatomic_site"                                                                     
##  [64] "new_neoplasm_event_type"                                                                                         
##  [65] "new_neoplasm_occurrence_anatomic_site_text"                                                                      
##  [66] "new_tumor_event_after_initial_treatment"                                                                         
##  [67] "number_of_lymphnodes_positive_by_he"                                                                             
##  [68] "number_of_lymphnodes_positive_by_ihc"                                                                            
##  [69] "other_dx"                                                                                                        
##  [70] "pathologic_M"                                                                                                    
##  [71] "pathologic_N"                                                                                                    
##  [72] "pathologic_T"                                                                                                    
##  [73] "patient_id"                                                                                                      
##  [74] "person_neoplasm_cancer_status"                                                                                   
##  [75] "pos_finding_metastatic_breast_carcinoma_estrogen_receptor_other_measuremenet_scale_text"                         
##  [76] "postoperative_rx_tx"                                                                                             
##  [77] "primary_lymph_node_presentation_assessment"                                                                      
##  [78] "radiation_therapy"                                                                                               
##  [79] "surgical_procedure_purpose_other_text"                                                                           
##  [80] "system_version"                                                                                                  
##  [81] "tissue_prospective_collection_indicator"                                                                         
##  [82] "tissue_retrospective_collection_indicator"                                                                       
##  [83] "tissue_source_site"                                                                                              
##  [84] "withdrawn"                                                                                                       
##  [85] "year_of_dcc_upload"                                                                                              
##  [86] "year_of_form_completion"                                                                                         
##  [87] "year_of_initial_pathologic_diagnosis"                                                                            
##  [88] "days_to_index"                                                                                                   
##  [89] "dbgap_registration_code"                                                                                         
##  [90] "disease_code"                                                                                                    
##  [91] "pathology_report_file_name"                                                                                      
##  [92] "program"                                                                                                         
##  [93] "project_code"                                                                                                    
##  [94] "vial_number"                                                                                                     
##  [95] "age_at_index.demographic"                                                                                        
##  [96] "days_to_birth.demographic"                                                                                       
##  [97] "days_to_death.demographic"                                                                                       
##  [98] "ethnicity.demographic"                                                                                           
##  [99] "gender.demographic"                                                                                              
## [100] "race.demographic"                                                                                                
## [101] "vital_status.demographic"                                                                                        
## [102] "year_of_birth.demographic"                                                                                       
## [103] "year_of_death.demographic"                                                                                       
## [104] "age_at_diagnosis.diagnoses"                                                                                      
## [105] "classification_of_tumor.diagnoses"                                                                               
## [106] "days_to_diagnosis.diagnoses"                                                                                     
## [107] "days_to_last_follow_up.diagnoses"                                                                                
## [108] "icd_10_code.diagnoses"                                                                                           
## [109] "last_known_disease_status.diagnoses"                                                                             
## [110] "morphology.diagnoses"                                                                                            
## [111] "primary_diagnosis.diagnoses"                                                                                     
## [112] "prior_malignancy.diagnoses"                                                                                      
## [113] "prior_treatment.diagnoses"                                                                                       
## [114] "progression_or_recurrence.diagnoses"                                                                             
## [115] "site_of_resection_or_biopsy.diagnoses"                                                                           
## [116] "synchronous_malignancy.diagnoses"                                                                                
## [117] "tissue_or_organ_of_origin.diagnoses"                                                                             
## [118] "tumor_grade.diagnoses"                                                                                           
## [119] "tumor_stage.diagnoses"                                                                                           
## [120] "year_of_diagnosis.diagnoses"                                                                                     
## [121] "disease_type"                                                                                                    
## [122] "alcohol_history.exposures"                                                                                       
## [123] "primary_site"                                                                                                    
## [124] "name.project"                                                                                                    
## [125] "project_id.project"                                                                                              
## [126] "releasable.project"                                                                                              
## [127] "bcr_id.tissue_source_site"                                                                                       
## [128] "code.tissue_source_site"                                                                                         
## [129] "name.tissue_source_site"                                                                                         
## [130] "project.tissue_source_site"                                                                                      
## [131] "days_to_collection.samples"                                                                                      
## [132] "days_to_sample_procurement.samples"                                                                              
## [133] "initial_weight.samples"                                                                                          
## [134] "is_ffpe.samples"                                                                                                 
## [135] "oct_embedded.samples"                                                                                            
## [136] "preservation_method.samples"                                                                                     
## [137] "sample_type.samples"                                                                                             
## [138] "sample_type_id.samples"                                                                                          
## [139] "state.samples"                                                                                                   
## [140] "tissue_type.samples"
```

```{.r .bg-danger}
phenodata[,OS.status:=ifelse(is.na(days_to_death.demographic),"alive","dead")]
phenodata[is.na(days_to_death.demographic), days_to_death.demographic:=days_to_last_follow_up.diagnoses]
phenodata2 <- phenodata[,.(submitter_id.samples,OS.status,days_to_death.demographic)]
```
### expression data

```{.r .bg-danger}
mirna <- fread('https://r.biogogo.top/data/TCGA-BRCA.mirna.tsv.100.gz')
head(mirna)
```

```{.bg-warning}
##        miRNA_ID TCGA-E9-A1NI-01A TCGA-A1-A0SP-01A TCGA-LL-A5YP-01A
## 1: hsa-let-7a-1        12.686183        12.891305        12.887718
## 2: hsa-let-7a-2        12.662222        12.869347        12.879000
## 3: hsa-let-7a-3        12.702090        12.888348        12.900761
## 4:   hsa-let-7b        13.954108        15.019690        13.485065
## 5:   hsa-let-7c        10.343736        10.822866        10.325324
## 6:   hsa-let-7d         9.295373         9.947921         9.747751
##    TCGA-E2-A14T-01A TCGA-AR-A24O-01A TCGA-A8-A09K-01A TCGA-OL-A5RY-01A
## 1:        14.108360        13.461873        12.265034        12.998680
## 2:        14.118814        13.476615        12.241975        13.005067
## 3:        14.155944        13.488667        12.290275        12.997857
## 4:        13.811893        15.261777        13.809151        13.627295
## 5:        11.047247        12.039291         9.057759        11.581334
## 6:         7.606842         8.730956         8.647390         8.367291
##    TCGA-E9-A24A-01A TCGA-E9-A1RB-01A TCGA-A2-A0CP-01A TCGA-A8-A07S-01A
## 1:        13.383760        12.845777        12.974924        13.708517
## 2:        13.380326        12.844904        13.013343        13.706447
## 3:        13.388873        12.853264        13.009295        13.702742
## 4:        14.974551        14.759085        14.286339        15.477804
## 5:        10.195591         9.996306        11.989837        10.281567
## 6:         9.733231         7.707329         7.977783         9.197688
##    TCGA-AO-A12H-01A TCGA-BH-A203-11A TCGA-D8-A1X9-01A TCGA-AO-A12D-01A
## 1:        14.222694        13.633270        13.064446        12.674832
## 2:        14.206168        13.628545        13.048648        12.651099
## 3:        14.217494        13.635442        13.058672        12.672266
## 4:        16.219528        14.599291        15.323550        13.793995
## 5:         9.084168        12.866876         9.379656        10.994470
## 6:         8.863030         8.413022         7.517660         9.269932
##    TCGA-5L-AAT0-01A TCGA-AO-A12C-01A TCGA-V7-A7HQ-01A TCGA-A2-A1FZ-01A
## 1:        13.721248        13.226101        13.473741        13.167321
## 2:        13.734770        13.211291        13.484277        13.174919
## 3:        13.738012        13.221875        13.490294        13.185172
## 4:        14.562673        14.762223        13.594895        15.111708
## 5:        11.085103        11.192695        10.587571        11.767310
## 6:         7.674249         8.209502         8.586615         9.421022
##    TCGA-AR-A251-01A TCGA-BH-A0B9-01A TCGA-EW-A1PF-01A TCGA-OK-A5Q2-01A
## 1:         12.19081        12.436579        12.507906        13.576495
## 2:         12.18233        12.440135        12.510198        13.576846
## 3:         12.19773        12.447885        12.515281        13.574861
## 4:         12.89520        13.860219        13.680424        14.446982
## 5:         11.73669        11.472662        10.790297        11.368793
## 6:         10.48291         8.087969         8.433904         7.956165
##    TCGA-AN-A041-01A TCGA-AC-A23H-11A TCGA-E2-A1LL-01A TCGA-AC-A2QJ-01A
## 1:        13.455533        13.171069        12.576520        13.383394
## 2:        13.454361        13.166423        12.593630        13.373677
## 3:        13.488866        13.162318        12.604195        13.397793
## 4:        15.680864        14.801637        13.929401        14.448205
## 5:        11.134537        12.679092        10.371799        12.960395
## 6:         8.876858         8.899031         8.440389         8.826711
##    TCGA-A8-A08O-01A TCGA-XX-A899-01A TCGA-D8-A1XK-01A TCGA-AC-A5XS-01A
## 1:        13.568355        14.450172         11.98183        13.083247
## 2:        13.562039        14.443222         12.00010        13.079388
## 3:        13.581550        14.448529         12.02679        13.089285
## 4:        16.670700        14.325436         13.94566        12.793437
## 5:        11.708865        12.321549         10.63521        10.460960
## 6:         8.493987         7.685415         10.17346         8.504579
##    TCGA-BH-A18L-01A TCGA-AO-A125-01A TCGA-PE-A5DD-01A TCGA-AN-A04D-01A
## 1:         14.07600        14.454823        12.710956         13.35984
## 2:         14.07455        14.435422        12.678020         13.35426
## 3:         14.08984        14.451307        12.696671         13.36779
## 4:         15.15709        16.639674        12.994168         14.33081
## 5:         10.74892         7.700752         9.574274         12.85251
## 6:         10.06170         8.720836         8.308389         11.35225
##    TCGA-4H-AAAK-01A TCGA-BH-A0DG-01A TCGA-BH-A1FM-01A TCGA-AO-A129-01A
## 1:        13.831441        13.394417        13.149281        13.518322
## 2:        13.830614        13.388114        13.148964        13.487011
## 3:        13.839637        13.375795        13.194104        13.492199
## 4:        14.433812        14.671904        14.547192        14.424307
## 5:        11.662663        11.416359         9.828253        11.476722
## 6:         8.475744         8.887903         9.328791         9.966007
##    TCGA-A8-A07C-01A TCGA-AR-A24Q-01A TCGA-BH-A18T-01A TCGA-AR-A0U4-01A
## 1:        13.257621        13.757952        13.067625        11.998200
## 2:        13.262883        13.749770        13.063466        12.003058
## 3:        13.275138        13.780671        13.058974        12.041344
## 4:        13.502899        15.423654        14.077489        14.290079
## 5:        10.456259        11.876309         9.375883         9.696678
## 6:         9.842652         9.958456         9.570577         9.717320
##    TCGA-E9-A1N6-11A TCGA-A7-A13D-01A TCGA-D8-A1JG-01B TCGA-E2-A570-01A
## 1:        14.149058        12.644136        13.395309        13.474239
## 2:        14.151108        12.654220        13.398158        13.477644
## 3:        14.155530        12.672663        13.404375        13.484109
## 4:        15.320090        15.012644        13.687863        14.616837
## 5:        13.432845        10.113135        11.449015        11.497222
## 6:         8.791523         9.476736         9.599139         8.459784
##    TCGA-BH-A0BW-11A TCGA-E2-A1BC-01A TCGA-E2-A1IG-01A TCGA-E9-A1N4-11A
## 1:        13.502724        13.904604        13.897419        13.331669
## 2:        13.510705        13.897027        13.897748        13.323963
## 3:        13.519025        13.917199        13.912840        13.327346
## 4:        15.171142        14.850094        15.608975        15.151123
## 5:        12.550726        11.827816        10.430627        12.744465
## 6:         9.086644         9.024437         8.753018         8.542963
##    TCGA-A7-A3IZ-01A TCGA-BH-A0BV-11A TCGA-AN-A0AK-01A TCGA-A2-A1G4-01A
## 1:        15.354706        13.296142        13.053792        14.520446
## 2:        15.349161        13.282397        13.070659        14.521752
## 3:        15.358233        13.309294        13.095203        14.517585
## 4:        15.883276        15.682274        15.332362        15.184473
## 5:         9.898436        13.111067         9.335893        10.324078
## 6:         8.217629         9.126253         9.852983         9.924004
##    TCGA-A8-A06Z-01A TCGA-BH-A0HU-01A TCGA-A2-A04X-01A TCGA-E2-A15S-01A
## 1:        12.126594         12.33890        12.668052         14.70912
## 2:        12.114484         12.28682        12.632600         14.70216
## 3:        12.174458         12.29175        12.630557         14.71617
## 4:        14.126675         13.74058        14.591142         15.34796
## 5:         9.443969         10.08022         9.492920         10.49342
## 6:         9.384700         10.56668         8.826497          9.55503
##    TCGA-B6-A0IB-01A TCGA-BH-A18R-11A TCGA-LL-A6FQ-01A TCGA-C8-A273-01A
## 1:         12.94342        13.794448        12.679410        13.930389
## 2:         12.91309        13.811172        12.670455        13.929174
## 3:         12.94498        13.795017        12.684793        13.935921
## 4:         15.66380        14.775060        13.181054        13.765558
## 5:         11.47691        12.943996         9.441495        10.237603
## 6:          9.58203         8.173289         7.599152         8.406994
##    TCGA-OL-A5RV-01A TCGA-AC-A2FM-01A TCGA-A2-A25A-01A TCGA-BH-A0BQ-11A
## 1:        13.410823        14.949447        13.948126         13.47398
## 2:        13.407334        14.946736        13.950415         13.47073
## 3:        13.425678        14.952736        13.944707         13.47656
## 4:        14.257773        15.769250        13.706808         15.71188
## 5:        11.486177        11.380129        12.127568         13.14331
## 6:         7.955195         9.071345         8.119045         10.10485
##    TCGA-BH-A0DP-01A TCGA-A2-A25E-01A TCGA-B6-A2IU-01A TCGA-BH-A18P-01A
## 1:        13.555091         12.53313        14.231937        14.254071
## 2:        13.562451         12.49228        14.237397        14.260318
## 3:        13.564075         12.55529        14.248455        14.267861
## 4:        17.223741         13.90301        14.960456        16.039580
## 5:        11.979591         10.35098        11.933337        10.742284
## 6:         8.173095         11.14975         8.203294         9.683122
##    TCGA-D8-A27T-01A TCGA-A2-A0SW-01A TCGA-E2-A107-01A TCGA-BH-A1FM-11B
## 1:         14.73715        11.895878        13.944917        13.302101
## 2:         14.73885        11.844286        13.925747        13.300960
## 3:         14.73472        11.904725        13.928893        13.318095
## 4:         15.62378        13.392344        15.072990        15.406909
## 5:         11.84655         9.008764        12.450313        13.143343
## 6:          8.33214         8.656958         8.468868         8.800224
##    TCGA-BH-A0BJ-11A TCGA-E2-A1B6-01A TCGA-D8-A1XW-01A TCGA-A7-A0DC-01A
## 1:        13.045987        13.701712        13.663783        13.641627
## 2:        13.025129        13.709611        13.653956        13.631638
## 3:        13.045913        13.720637        13.665206        13.642129
## 4:        15.534402        14.582151        15.208466        15.396751
## 5:        13.136181        12.117159        11.998354         9.097653
## 6:         8.743745         9.786537         9.699897         8.839819
##    TCGA-EW-A6SD-01A TCGA-AN-A0G0-01A TCGA-A7-A0DC-11A TCGA-AN-A03X-01A
## 1:        11.655222         12.69951         12.99380        13.202266
## 2:        11.657765         12.70449         12.98627        13.178644
## 3:        11.679792         12.71755         12.99876        13.234535
## 4:        10.816794         15.05494         15.55560        15.651935
## 5:         8.330351         10.92582         12.63082        12.512187
## 6:         6.349707         10.38620          8.95928         8.935318
##    TCGA-LD-A7W6-01A TCGA-A8-A099-01A TCGA-E2-A14Z-01A TCGA-AR-A5QP-01A
## 1:        13.052137        12.813130        13.380763        13.005606
## 2:        13.035708        12.788434        13.371711        13.004066
## 3:        13.043614        12.802884        13.410418        13.018006
## 4:        13.887562        15.961373        13.569699        13.036453
## 5:        10.359675         8.944274        10.704577        11.539874
## 6:         7.866024         8.167855         8.482397         8.481356
##    TCGA-AC-A62X-01A TCGA-BH-A42V-01A TCGA-B6-A0RS-01A TCGA-A2-A04R-01A
## 1:         12.71945        13.953502        12.467329        12.856138
## 2:         12.71255        13.953132        12.438976        12.859981
## 3:         12.73575        13.956419        12.469955        12.846426
## 4:         12.98811        14.058904        14.429511        14.890818
## 5:         11.47524        11.663107        11.432733        10.469417
## 6:         10.00022         7.937461         9.437126         8.405198
##    TCGA-A8-A090-01A TCGA-BH-A0DZ-01A TCGA-B6-A1KC-01B TCGA-C8-A135-01A
## 1:        11.946181        12.387344        13.854649        12.680621
## 2:        11.908343        12.391839        13.860289        12.688345
## 3:        11.969177        12.417934        13.871269        12.688926
## 4:        14.511387        15.614446        15.285572        14.147961
## 5:         9.245177        10.808460         8.990267        11.695160
## 6:         8.213718         9.777551         7.085958         9.703098
##    TCGA-AR-A24R-01A TCGA-LD-A66U-01A TCGA-D8-A1J8-01A TCGA-A2-A0ER-01A
## 1:         13.15971        13.134711        12.682704        14.097343
## 2:         13.15056        13.138139        12.685255        14.067662
## 3:         13.16157        13.143939        12.691057        14.098052
## 4:         13.58213        14.006181        13.501002        15.388345
## 5:         10.30195        11.554292         8.531546        10.888291
## 6:         10.05695         7.597906         9.669500         9.060569
##    TCGA-E9-A1ND-01A TCGA-A7-A5ZX-01A TCGA-A2-A1G1-01A TCGA-A2-A0SU-01A
## 1:        12.494431        13.608148        13.840166        12.929461
## 2:        12.489338        13.605555        13.861388        12.931975
## 3:        12.527477        13.616549        13.869334        12.939063
## 4:        13.646411        14.369306        13.543027        15.379029
## 5:        10.914155        11.767276         9.882165        11.326221
## 6:         9.520724         7.698323         9.566887         8.744995
##    TCGA-BH-A18S-01A TCGA-E2-A1LB-01A TCGA-E9-A1RD-01A TCGA-OL-A6VQ-01A
## 1:        13.878967        12.528825        12.851901         13.96568
## 2:        13.886565        12.521564        12.861203         13.96362
## 3:        13.891092        12.521332        12.855725         13.96631
## 4:        14.970506        14.079735        14.219022         14.69118
## 5:         9.635784         9.834147        10.267555         12.12886
## 6:         9.044917         9.021107         6.976283          7.39787
##    TCGA-AQ-A1H3-01A TCGA-A2-A259-01A TCGA-AR-A2LQ-01A TCGA-WT-AB44-01A
## 1:        14.534476        13.251623        14.519802        13.777752
## 2:        14.521508        13.267234        14.521664        13.783326
## 3:        14.536518        13.251779        14.522178        13.784518
## 4:        15.135864        14.895808        14.923566        14.506834
## 5:        11.753951        11.723923        13.591555        11.911217
## 6:         8.912145         9.534526         7.943301         8.534268
##    TCGA-B6-A0IN-01A TCGA-AO-A03L-01A TCGA-A8-A086-01A TCGA-AC-A3BB-01A
## 1:        12.884210         12.40569        13.079742        14.209815
## 2:        12.882560         12.40019        13.076989        14.198384
## 3:        12.948877         12.38601        13.100854        14.206890
## 4:        14.749213         15.47174        15.133954        14.626653
## 5:        10.171865         11.35433        11.201127        12.260498
## 6:         9.550593         10.32871         9.722585         9.099857
##    TCGA-AC-A2QI-01A TCGA-BH-A1F5-01A TCGA-AC-A3HN-01A TCGA-BH-A1FG-01A
## 1:        15.280370        13.096235        13.725511        13.183756
## 2:        15.275438        13.119505        13.724774        13.180216
## 3:        15.277678        13.108068        13.736791        13.188843
## 4:        16.525923        14.118111        13.651957        14.050705
## 5:        11.600285        10.052559        11.962086        10.014759
## 6:         8.282494         8.905349         7.285547         7.303241
##    TCGA-A8-A06P-01A TCGA-A2-A4RW-01A TCGA-BH-A0DV-01A TCGA-UL-AAZ6-01A
## 1:        13.029674        12.247994        14.943789        11.801359
## 2:        13.054940        12.249885        14.929809        11.819151
## 3:        13.061961        12.263586        14.946114        11.813245
## 4:        14.458219        12.376184        16.131589        11.377078
## 5:        10.897508        10.417513        13.036479         7.035698
## 6:         8.795112         7.890246         9.337553         8.977600
##    TCGA-AR-A255-01A TCGA-LL-A50Y-01A TCGA-AR-A24Z-01A TCGA-A1-A0SO-01A
## 1:        12.852270        13.101092        12.696386         11.73567
## 2:        12.847096        13.106947        12.683543         11.72821
## 3:        12.861243        13.128118        12.724134         11.76944
## 4:        13.814876        14.543622        14.081775         12.78696
## 5:        11.053298         9.702720         8.099349         11.57935
## 6:         9.389997         8.368206         9.794260         10.19517
##    TCGA-A2-A3XS-01A TCGA-D8-A1X6-01A TCGA-BH-A0HF-01A TCGA-A7-A3J0-01A
## 1:        12.412478        13.962374        13.128827        13.978766
## 2:        12.409695        13.958255        13.137168        13.974134
## 3:        12.428292        13.978733        13.143422        13.983110
## 4:        13.630673        15.454405        15.716304        15.139139
## 5:        11.754616         9.420011        12.024004         8.210248
## 6:         9.079969         9.781452         8.493992         8.169074
##    TCGA-AC-A23C-01A TCGA-BH-A18J-11A TCGA-E9-A1RI-01A TCGA-AR-A1AX-01A
## 1:        13.234807        13.523938        13.488737        13.215362
## 2:        13.226841        13.537538        13.475723        13.206933
## 3:        13.228383        13.553609        13.506449        13.219092
## 4:        14.594027        15.449304        14.768283        14.298824
## 5:        11.455920        13.048869        12.025740        12.092416
## 6:         9.269316         9.211833         9.471052         7.858868
##    TCGA-D8-A1XO-01A TCGA-E9-A1R2-01A TCGA-A8-A094-01A TCGA-D8-A27M-01A
## 1:        12.923924        12.871377         12.36361        14.052679
## 2:        12.907633        12.832962         12.34635        14.054182
## 3:        12.926739        12.870295         12.34915        14.060216
## 4:        13.968197        14.105723         13.68169        14.903635
## 5:        11.017274        10.112165         10.77016        10.781851
## 6:         9.512086         8.816712         10.01639         9.329798
##    TCGA-OL-A5RZ-01A TCGA-E2-A1L7-11A TCGA-BH-A0DX-01A TCGA-EW-A1IY-01A
## 1:        10.786378        13.111839        13.819153        12.906602
## 2:        10.754252        13.127929        13.815860        12.919159
## 3:        10.783744        13.148839        13.833992        12.933276
## 4:        11.270041        15.074600        15.913130        15.158316
## 5:         8.186726        12.860253        12.439757        10.912811
## 6:         8.902407         8.675762         9.228535         8.906671
##    TCGA-A2-A04N-01A TCGA-AR-A1AR-01A TCGA-BH-A1FN-01A TCGA-BH-A0BV-01A
## 1:        11.729430         13.47225        13.624043         11.06370
## 2:        11.711106         13.45510        13.631646         11.05232
## 3:        11.754830         13.48036        13.649965         11.05871
## 4:        13.283720         14.45048        15.752630         12.73582
## 5:         9.882908         11.73837        10.344289         10.27592
## 6:         6.878439         10.34950         9.192993          8.84663
##    TCGA-EW-A1J5-01A TCGA-AO-A0JE-01A TCGA-LD-A7W5-01A TCGA-BH-A18V-01A
## 1:        14.237845        12.500040        12.733807         13.54009
## 2:        14.215555        12.536529        12.732703         13.52237
## 3:        14.254436        12.533467        12.740596         13.54824
## 4:        14.935775        15.071836        14.653362         15.29813
## 5:        10.006466        10.923742        10.653262         10.01819
## 6:         8.999168         9.924485         8.427282         10.74585
##    TCGA-B6-A409-01A TCGA-A2-A1G0-01A TCGA-GM-A2DN-01A TCGA-A2-A0CO-01A
## 1:        12.920025        15.163861        13.360446        14.178415
## 2:        12.909024        15.170660        13.359037        14.168246
## 3:        12.921526        15.173087        13.353229        14.180462
## 4:        13.335767        15.988070        14.436659        15.977747
## 5:        10.940760        11.984349        11.274015        11.589952
## 6:         9.149438         8.256518         8.525014         7.475653
##    TCGA-AC-A3QP-01A TCGA-BH-A0DL-01A TCGA-D8-A1JS-01A TCGA-E9-A1RB-11A
## 1:        13.009245        13.006238        14.965943        13.317327
## 2:        13.004717        12.998620        14.967537        13.315194
## 3:        13.007006        13.029055        14.977978        13.314582
## 4:        13.914163        13.904657        16.479027        14.829372
## 5:        11.600385         9.807763         8.477213        11.501425
## 6:         7.735479         9.974889         9.084302         9.922598
##    TCGA-A7-A26J-01A TCGA-A7-A13H-01A TCGA-E9-A22A-01A TCGA-AO-A126-01A
## 1:        13.119276        13.237265        12.169757        14.569389
## 2:        13.119943        13.231537        12.189676        14.554101
## 3:        13.141499        13.238190        12.180972        14.564056
## 4:        14.129896        14.344345        13.427419        15.672555
## 5:        11.160647        11.300520        10.172397        12.148739
## 6:         9.081833         8.151626         7.679101         9.725661
##    TCGA-BH-A6R8-01A TCGA-A7-A0DB-01C TCGA-AC-A3TM-01A TCGA-E2-A1LH-01A
## 1:        12.936481        13.741114        13.757806        13.436885
## 2:        12.937955        13.759176        13.757484        13.436809
## 3:        12.925279        13.751022        13.764841        13.443833
## 4:        12.545133        15.262128        15.449036        14.167469
## 5:        10.161423        11.792913        11.216786        10.289054
## 6:         8.287397         9.487055         8.124465         8.154106
##    TCGA-AR-A0TQ-01A TCGA-GM-A2DH-01A TCGA-B6-A0RI-01A TCGA-AR-A24N-01A
## 1:        12.614747        13.754224        13.317400        13.441583
## 2:        12.605410        13.752929        13.299185        13.438394
## 3:        12.598910        13.764028        13.321417        13.464112
## 4:        14.486725        14.796841        16.096401        14.766536
## 5:        10.867263        10.477803        10.462035        10.928928
## 6:         8.912532         9.743574         9.222223         9.627553
##    TCGA-A8-A06Q-01A TCGA-C8-A12M-01A TCGA-D8-A1JU-01A TCGA-BH-A0BZ-11A
## 1:        13.516626        13.840224        14.351576        14.258036
## 2:        13.507201        13.835577        14.365452        14.266917
## 3:        13.529849        13.821298        14.351770        14.282286
## 4:        14.373639        15.088798        15.482922        15.113827
## 5:         8.276553         8.610051        12.764494        13.122209
## 6:         9.226757         8.485688         8.885444         8.915808
##    TCGA-E2-A1LI-01A TCGA-AC-A8OR-01A TCGA-BH-A0HA-01A TCGA-AO-A1KR-01A
## 1:        11.849838        13.841874        14.157721         12.70522
## 2:        11.851614        13.838746        14.153566         12.70920
## 3:        11.866596        13.848860        14.166382         12.74200
## 4:        12.668498        14.899242        14.709408         14.79970
## 5:        10.312633         7.973891        11.445888         11.95160
## 6:         9.951145         9.193158         9.724346         10.18544
##    TCGA-3C-AALK-01A TCGA-E2-A15G-01A TCGA-E2-A1IH-01A TCGA-XX-A89A-01A
## 1:        13.550832        13.258044        14.495346        14.037893
## 2:        13.560693        13.222523        14.497876        14.032322
## 3:        13.567933        13.219345        14.505380        14.042707
## 4:        14.662512        15.407072        15.145491        14.131883
## 5:        11.497175        10.507735        12.124132        12.605961
## 6:         8.396544         8.673318         8.805836         8.568195
##    TCGA-BH-A0E0-01A TCGA-A7-A0D9-01A TCGA-E9-A1RH-01A TCGA-A8-A085-01A
## 1:         12.46579        12.693954        12.951003        12.029176
## 2:         12.44111        12.727807        12.914614        12.015333
## 3:         12.53073        12.775643        12.929243        12.039070
## 4:         14.81619        15.029843        14.521992        13.508710
## 5:         10.78997        10.578311        10.037147         8.984093
## 6:         10.24035         9.867563         9.434758         7.630986
##    TCGA-E9-A1N3-01A TCGA-BH-A1EW-11B TCGA-D8-A13Y-01A TCGA-AC-A7VC-01A
## 1:        12.616617        14.481444        13.154562        12.529918
## 2:        12.607699        14.482144        13.145462        12.533769
## 3:        12.637147        14.482899        13.179345        12.552868
## 4:        13.815862        15.219224        13.974835        12.985187
## 5:         9.325165        13.022942        10.877947        10.158925
## 6:         9.416627         8.268207         9.345798         9.091282
##    TCGA-AC-A6IV-01A TCGA-E2-A576-01A TCGA-BH-A0GY-01A TCGA-S3-AA14-01A
## 1:        13.786918         13.21167        12.164744        13.830803
## 2:        13.796593         13.21672        12.185131        13.825569
## 3:        13.794421         13.21765        12.160889        13.833535
## 4:        14.300130         12.84503        13.940082        14.326631
## 5:        11.764122         10.01110        10.830078        11.659508
## 6:         8.177507          8.43277         9.146294         7.896388
##    TCGA-AR-A2LL-01A TCGA-BH-A208-01A TCGA-A8-A09E-01A TCGA-AN-A0FY-01A
## 1:        13.827498        12.718381        12.990603         13.11066
## 2:        13.838890        12.719505        12.994470         13.09209
## 3:        13.834370        12.725279        12.996054         13.08494
## 4:        14.628289        14.003561        15.894292         14.39820
## 5:        10.287323        12.235210        10.401358         10.65554
## 6:         8.389025         8.925259         8.199263         10.34958
##    TCGA-EW-A1PE-01A TCGA-B6-A0RM-01A TCGA-E2-A1B1-01A TCGA-BH-A0C0-01A
## 1:        13.595113        13.319918        13.563254        12.548033
## 2:        13.611306        13.284260        13.548641        12.524701
## 3:        13.602888        13.318271        13.572047        12.546562
## 4:        15.931263        15.512969        14.373651        14.476057
## 5:        10.402042         9.858275        12.231829         9.295809
## 6:         8.291262         8.567709         8.047007         9.544388
##    TCGA-A7-A26I-01B TCGA-AO-A0JJ-01A TCGA-AR-A2LH-01A TCGA-S3-AA12-01A
## 1:        12.082291        13.769115        14.577831        13.375429
## 2:        12.077397        13.768141        14.563016        13.366017
## 3:        12.100398        13.777400        14.571077        13.372811
## 4:        13.187825        17.055491        13.555098        13.928146
## 5:        10.575332        11.892962        12.258963         8.519234
## 6:         9.928557         8.382449         9.429147        10.116041
##    TCGA-E2-A158-11A TCGA-AC-A3OD-01A TCGA-AR-A0TS-01A TCGA-BH-A0AV-01A
## 1:        13.188904        12.759037         13.00056         13.58379
## 2:        13.190669        12.760131         12.99137         13.59133
## 3:        13.190081        12.775789         13.03547         13.58931
## 4:        14.332249        13.779970         14.30123         14.50523
## 5:        12.162369        10.838847         10.85398         10.12747
## 6:         8.649928         7.895182         10.00719          9.31804
##    TCGA-A8-A07B-01A TCGA-LL-A73Z-01A TCGA-5L-AAT1-01A TCGA-BH-A0B3-11B
## 1:        13.072335        13.617072        13.865815        13.091788
## 2:        13.045576        13.610417        13.861453        13.091057
## 3:        13.108404        13.619596        13.867042        13.091514
## 4:        15.038956        14.265832        14.606950        15.365576
## 5:        10.590488        12.210788        11.237808        13.094345
## 6:         9.665028         8.472285         8.316985         8.502577
##    TCGA-D8-A147-01A TCGA-AR-A0TT-01A TCGA-B6-A0WT-01A TCGA-EW-A6SB-01A
## 1:         13.56376        12.088992        12.870171        12.754729
## 2:         13.54636        12.088573        12.856210        12.741954
## 3:         13.55635        12.084379        12.865110        12.751472
## 4:         14.67459        13.986313        14.722479        12.377802
## 5:         10.39822         9.608179        11.154549        10.539198
## 6:         10.98834         9.602325         8.262687         8.837935
##    TCGA-AC-A2FB-01A TCGA-AC-A62V-01A TCGA-D8-A1XQ-01A TCGA-BH-A0DD-01A
## 1:        14.378985        13.004636        13.132060        13.361479
## 2:        14.373822        13.004444        13.137589        13.400026
## 3:        14.395555        13.018486        13.150169        13.386233
## 4:        15.440638        13.863445        14.231564        14.491855
## 5:        12.055462         9.908218         9.264001        10.258345
## 6:         8.838575         8.236680        10.621220         9.533146
##    TCGA-E2-A15M-11A TCGA-Z7-A8R6-01A TCGA-OL-A5DA-01A TCGA-WT-AB41-01A
## 1:        13.573896        13.777318        13.597458        13.454092
## 2:        13.569236        13.771454        13.605459        13.446520
## 3:        13.572046        13.776738        13.601733        13.461772
## 4:        15.114611        14.106154        14.202023        13.901638
## 5:        12.757941        10.259103        11.009916        11.211866
## 6:         8.592914         9.646638         7.568347         9.129619
##    TCGA-E2-A1LA-01A TCGA-E2-A1L9-01A TCGA-E9-A3QA-01A TCGA-BH-A0DO-11A
## 1:        13.622006         14.39131        13.387842        14.280831
## 2:        13.634697         14.39049        13.387987        14.288981
## 3:        13.645904         14.39283        13.404200        14.288615
## 4:        15.205021         15.29187        14.313785        15.223131
## 5:        10.210783         11.06024        10.141946        13.292646
## 6:         9.013331         10.07693         9.450131         8.641591
##    TCGA-A8-A0AB-01A TCGA-LL-A73Y-01A TCGA-D8-A1XU-01A TCGA-EW-A1P1-01A
## 1:        13.382676        13.816293        12.308109         13.08450
## 2:        13.401802        13.815892        12.289904         13.09319
## 3:        13.403009        13.816238        12.330932         13.09943
## 4:        14.279951        14.355997        13.424865         14.68878
## 5:         9.737155        11.032927        11.063129         12.76818
## 6:         7.958042         9.122544         9.331244          8.98057
##    TCGA-AN-A0FJ-01A TCGA-D8-A1XL-01A TCGA-BH-A0DK-01A TCGA-B6-A0IJ-01A
## 1:        12.249221        12.364576        12.850030        12.139860
## 2:        12.276458        12.363006        12.864483        12.136362
## 3:        12.288772        12.392413        12.852018        12.169258
## 4:        14.782649        13.599719        15.277398        13.959878
## 5:        10.917392         8.341387        10.535436         9.153174
## 6:         9.853289         8.582246         9.207643         9.731506
##    TCGA-LL-A7SZ-01A TCGA-E2-A9RU-01A TCGA-GI-A2C9-11A TCGA-LD-A74U-01A
## 1:        13.288863        12.616893        14.264706        13.995708
## 2:        13.295318        12.621715        14.271630        14.003930
## 3:        13.295389        12.655763        14.272821        14.003444
## 4:        13.620578        13.594871        15.382197        14.708633
## 5:         9.610624         9.298477        13.725717        11.759712
## 6:         8.419874         8.784120         8.978993         7.532571
##    TCGA-AO-A128-01A TCGA-A7-A0CE-11A TCGA-B6-A0I6-01A TCGA-BH-A1ET-01A
## 1:        14.026287        13.213937         12.83798        13.784485
## 2:        14.024281        13.197151         12.83781        13.787482
## 3:        14.031941        13.212964         12.83858        13.791776
## 4:        15.745599        15.195746         14.90608        14.863966
## 5:        12.999844        13.208910         10.77994        11.460619
## 6:         8.190566         7.955601         10.33485         8.566963
##    TCGA-A2-A04V-01A TCGA-A7-A2KD-01A TCGA-A7-A0CE-01A TCGA-D8-A1JE-01A
## 1:        13.107813        13.271025         13.58529        14.370335
## 2:        13.109839        13.283733         13.62624        14.358463
## 3:        13.136332        13.276130         13.61443        14.374119
## 4:        14.544838        14.235478         15.47517        15.602781
## 5:         9.059985        11.050185         12.18821        11.173393
## 6:         9.145198         9.090102         10.15731         9.257273
##    TCGA-AO-A0JG-01A TCGA-LL-A442-01A TCGA-EW-A1J1-01A TCGA-A2-A0YM-01A
## 1:        12.597744        13.410514        12.911024        11.476354
## 2:        12.578176        13.401102        12.907303        11.424665
## 3:        12.590086        13.414393        12.927030        11.449747
## 4:        14.352324        14.652467        15.171880        12.704791
## 5:        10.677582         7.781947         8.229086        10.663387
## 6:         8.478082         8.959440         9.172341         9.390414
##    TCGA-A8-A0A4-01A TCGA-AR-A24X-01A TCGA-C8-A132-01A TCGA-AR-A2LE-01A
## 1:        12.420788        13.767216        13.237880        13.814360
## 2:        12.345544        13.768529        13.251600        13.821669
## 3:        12.408127        13.777889        13.259444        13.830704
## 4:        13.911439        15.279951        14.822772        15.092642
## 5:        11.063834        11.414970        11.328846         9.762642
## 6:         8.849273         9.056768         9.839114         8.357216
##    TCGA-AN-A049-01A TCGA-C8-A12X-01A TCGA-E2-A1IN-01A TCGA-BH-A0HQ-01A
## 1:         11.57190        13.415075        14.040562        12.448383
## 2:         11.56911        13.410781        14.047233        12.430279
## 3:         11.60845        13.426820        14.054304        12.462545
## 4:         13.04034        14.968262        14.726171        14.776082
## 5:         10.36069         8.555621        11.846594        11.252451
## 6:         10.29451         9.333309         8.858546         7.920895
##    TCGA-E2-A1IO-01A TCGA-AQ-A54N-01A TCGA-A8-A07I-01A TCGA-B6-A1KI-01A
## 1:         12.54564        13.233610        12.273527        12.805480
## 2:         12.53729        13.227759        12.269751        12.799875
## 3:         12.53410        13.229738        12.277050        12.809332
## 4:         14.41681        13.674380        14.628008        13.948451
## 5:         11.94088        12.431978         9.474585        10.934523
## 6:          8.99909         9.145387         9.526134         8.594022
##    TCGA-B6-A0RH-01A TCGA-A8-A06R-01A TCGA-E2-A1IG-11A TCGA-PL-A8LV-01A
## 1:        13.436657        11.930636        13.146019        13.055348
## 2:        13.432501        11.953946        13.131173        13.046915
## 3:        13.446562        11.985654        13.142124        13.068890
## 4:        15.398780        13.378110        14.545954        13.071202
## 5:        11.033783         9.216956        12.869355        10.136929
## 6:         9.758793         8.696174         8.643171         9.928297
##    TCGA-BH-A0C3-11A TCGA-BH-A0BR-01A TCGA-A2-A3XZ-01A TCGA-A2-A0EN-01A
## 1:        14.602133        12.739535        12.252685        12.563069
## 2:        14.602982        12.759816        12.249956        12.550192
## 3:        14.598707        12.760771        12.255635        12.582631
## 4:        15.205108        14.974353        12.966161        14.033874
## 5:        13.047493        11.765891        10.900504        11.156260
## 6:         8.898251         9.471987         7.348119         8.384351
##    TCGA-OL-A5D7-01A TCGA-AC-A8OS-01A TCGA-BH-A0DS-01A TCGA-A8-A09I-01A
## 1:        12.265780        13.652984        12.631020        12.316821
## 2:        12.267726        13.656133        12.666936        12.266724
## 3:        12.333323        13.661201        12.693824        12.300077
## 4:        12.869994        14.412207        15.188523        13.695501
## 5:         9.405915        12.410355        10.983677         8.760934
## 6:        10.259829         7.674629         9.673474         8.399314
##    TCGA-GM-A3XL-01A TCGA-W8-A86G-01A TCGA-BH-A0DH-01A TCGA-BH-A0H5-11A
## 1:        13.273361         14.05830        12.939731        14.208662
## 2:        13.269470         14.06527        12.936022        14.212402
## 3:        13.297324         14.07179        12.965173        14.209006
## 4:        15.286415         15.13949        15.386701        15.227173
## 5:        10.896812         12.38809         9.947816        13.277830
## 6:         9.820105          8.40636         8.257606         9.058165
##    TCGA-OL-A5RX-01A TCGA-BH-A42U-01A TCGA-E2-A15F-01A TCGA-E2-A15T-01A
## 1:        13.621037        13.769454        13.679882        14.608977
## 2:        13.621722        13.766486        13.661747        14.606810
## 3:        13.623904        13.760255        13.685244        14.622777
## 4:        14.463639        14.395608        13.908983        16.638614
## 5:        11.795408        12.441250        11.904006         9.855820
## 6:         8.718793         8.087423         8.167669         9.967349
##    TCGA-Z7-A8R5-01A TCGA-B6-A0I1-01A TCGA-A7-A6VV-01A TCGA-EW-A1PA-01A
## 1:        13.385409         13.04530        13.821494         13.27203
## 2:        13.377161         13.04614        13.823140         13.27093
## 3:        13.389024         13.06148        13.824798         13.27952
## 4:        14.315530         14.13941        15.080731         13.58480
## 5:        11.968667         13.34055        10.510624         11.73168
## 6:         8.216236          9.85535         9.123218          7.93020
##    TCGA-BH-A0BF-01A TCGA-A2-A0EY-01A TCGA-E2-A1B0-01A TCGA-BH-A1EU-01A
## 1:        12.464849        12.728491         13.20641        14.360673
## 2:        12.520084        12.771711         13.20563        14.357219
## 3:        12.524336        12.745267         13.21410        14.356111
## 4:        13.799717        14.468818         13.91298        14.793007
## 5:        10.584210        11.190816         11.04842        12.321569
## 6:         8.773276         9.676236          8.55372         9.161382
##    TCGA-AC-A23H-01A TCGA-EW-A1P4-01A TCGA-E2-A10E-01A TCGA-EW-A1P0-01A
## 1:        12.823878         13.08139        14.473895         13.25464
## 2:        12.802444         13.07966        14.462376         13.26360
## 3:        12.846443         13.10615        14.457828         13.24675
## 4:        15.175854         14.37722        16.336327         15.93289
## 5:         9.200932         11.55793        10.772389          8.74817
## 6:         9.932302         10.64943         8.801113         10.02070
##    TCGA-GM-A3XG-01A TCGA-A2-A25B-01A TCGA-LL-A6FR-01A TCGA-AR-A5QM-01A
## 1:        13.524741         12.84457        12.926693        12.574115
## 2:        13.517800         12.85424        12.923947        12.562277
## 3:        13.524620         12.88225        12.935993        12.585858
## 4:        14.445149         14.60749        13.617570        12.707562
## 5:        12.039322         10.19333        10.444849        10.884539
## 6:         7.891552         10.69956         9.065746         7.816924
##    TCGA-A2-A0EW-01A TCGA-BH-A0BS-01A TCGA-BH-A18Q-11A TCGA-EW-A1P5-01A
## 1:         13.36641        14.009927        13.828439        13.232832
## 2:         13.34884        13.995583        13.833002        13.259739
## 3:         13.37817        14.001907        13.833924        13.256969
## 4:         15.01384        14.851715        14.812771        15.271958
## 5:         12.30597        11.056992        13.357415        10.093172
## 6:          8.54802         8.922109         8.640927         8.980323
##    TCGA-AO-A1KT-01A TCGA-E2-A14O-01A TCGA-AN-A0AR-01A TCGA-BH-A18Q-01A
## 1:        14.134069         13.45912         12.41651        13.089062
## 2:        14.122230         13.46237         12.43318        13.128400
## 3:        14.136201         13.46568         12.43772        13.106919
## 4:        14.253411         14.34991         14.26732        13.986054
## 5:        11.504383         10.22769         11.35244         9.971785
## 6:         9.449777          9.08952         10.45268         9.412038
##    TCGA-A2-A0CS-01A TCGA-AR-A1AS-01A TCGA-B6-A0WX-01A TCGA-E2-A1IE-01A
## 1:        13.682025        14.038468        11.888138        14.740922
## 2:        13.681565        14.052153        11.881799        14.739180
## 3:        13.677169        14.045474        11.911465        14.750111
## 4:        15.444711        15.401422        13.511157        14.760123
## 5:        11.006428         9.479867        13.372891        10.678792
## 6:         9.257458         9.097761         8.996132         9.140058
##    TCGA-BH-A0BW-01A TCGA-AN-A0FL-01A TCGA-D8-A27N-01A TCGA-B6-A0I9-01A
## 1:         12.67385         13.14136        13.259181        12.651022
## 2:         12.73069         13.12188        13.231419        12.667890
## 3:         12.75703         13.17031        13.262993        12.676387
## 4:         14.54703         13.81259        14.716800        14.622339
## 5:         11.50414         12.76304        10.760387         9.988651
## 6:         10.33611         10.80232         8.977683         9.121947
##    TCGA-A8-A09R-01A TCGA-B6-A0RE-01A TCGA-A2-A0YC-01A TCGA-E9-A249-01A
## 1:        13.267310        12.165035        13.507731        13.507586
## 2:        13.292303        12.124561        13.528411        13.493166
## 3:        13.283613        12.162391        13.569994        13.486902
## 4:        13.209854        14.979773        15.563514        14.933335
## 5:        10.348762        10.970570        10.015490         9.787784
## 6:         7.882296         9.338603         8.665054         9.419629
##    TCGA-AC-A5XU-01A TCGA-AO-A03O-01A TCGA-AO-A124-01A TCGA-BH-A1EV-11A
## 1:        13.052044        12.557588        12.719455        14.500360
## 2:        13.042651        12.553796        12.736234        14.493562
## 3:        13.046354        12.628923        12.705580        14.496919
## 4:        13.845107        12.625777        13.411190        15.322324
## 5:         9.797704         9.020206        10.762162        13.536791
## 6:         9.145402         7.491556         9.871915         8.132158
##    TCGA-BH-A0GZ-01A TCGA-A1-A0SH-01A TCGA-E2-A10A-01A TCGA-AC-A3EH-01A
## 1:        12.809725        12.962609        13.418331         12.98252
## 2:        12.780055        12.971607        13.403841         12.95879
## 3:        12.787146        12.983236        13.427883         12.98462
## 4:        15.232569        15.481879        15.239927         13.55874
## 5:        11.402469        12.813933         8.990976         11.72953
## 6:         8.310162         9.307462         9.853675          9.64505
##    TCGA-C8-A26W-01A TCGA-D8-A143-01A TCGA-AO-A03R-01A TCGA-BH-A0DQ-11A
## 1:        14.720111        13.817433         14.63756        13.411869
## 2:        14.713917        13.811219         14.62025        13.400492
## 3:        14.729068        13.834160         14.63499        13.424649
## 4:        14.814835        15.305119         16.10565        15.891892
## 5:        11.804061        10.025316         11.79177        13.471827
## 6:         9.065283         8.964044          9.81912         8.220701
##    TCGA-A2-A0YH-01A TCGA-AO-A0JB-01A TCGA-A8-A0AD-01A TCGA-GM-A2DI-01A
## 1:        12.068898        13.185871        13.912704        14.821519
## 2:        12.087201        13.199934        13.878438        14.822566
## 3:        12.101504        13.191604        13.891661        14.835039
## 4:        13.437342        15.519531        17.008678        15.839392
## 5:        11.172107        11.094943        11.233733        12.438523
## 6:         9.050033         9.557499         9.994783         8.595118
##    TCGA-BH-A0B3-01A TCGA-LQ-A4E4-01A TCGA-PL-A8LY-01A TCGA-BH-A1FU-01A
## 1:        12.819992        13.259415        13.647593        12.883631
## 2:        12.846663        13.233727        13.659519        12.875570
## 3:        12.876767        13.256191        13.663536        12.909243
## 4:        15.757853        13.445743        14.613415        13.991612
## 5:        11.047533         9.974822        12.845933        12.187140
## 6:         9.861934         7.756482         8.290351         9.051271
##    TCGA-A8-A09D-01A TCGA-A7-A5ZV-01A TCGA-LL-A5YL-01A TCGA-A7-A4SD-01A
## 1:         13.02297         12.56871         12.70694         12.47423
## 2:         13.01993         12.54287         12.71851         12.45044
## 3:         13.02074         12.56516         12.72938         12.51679
## 4:         14.77299         13.02401         13.27375         13.35537
## 5:         11.36425         12.81312         11.42333         11.77501
## 6:         10.18620         10.39335          7.88068          8.55274
##    TCGA-A7-A4SC-01A TCGA-A8-A076-01A TCGA-GM-A2DM-01A TCGA-BH-A0DO-01B
## 1:         13.20687        11.757681        14.568213        14.052709
## 2:         13.21273        11.708303        14.567984        14.056697
## 3:         13.22645        11.761100        14.577532        14.067760
## 4:         13.56841        13.517511        15.806765        15.151174
## 5:         11.10574         9.272988         8.223151        12.169273
## 6:          7.39705         9.914680         9.266505         8.122789
##    TCGA-HN-A2OB-01A TCGA-D8-A1XG-01A TCGA-A2-A4S0-01A TCGA-BH-A0H9-01A
## 1:        13.324321        13.699665        13.950533        13.041539
## 2:        13.319088        13.674345        13.938452        13.034659
## 3:        13.325388        13.685860        13.957365        13.030596
## 4:        14.485438        14.622846        15.331912        16.515190
## 5:        11.920939         9.309569         8.222549        11.584525
## 6:         7.466859         8.431318         8.367499         8.697457
##    TCGA-A2-A3KD-01A TCGA-A2-A0SY-01A TCGA-AN-A0AL-01A TCGA-LD-A9QF-01A
## 1:        14.194339        12.978297        12.966285        13.681249
## 2:        14.196954        12.970484        12.939252        13.675815
## 3:        14.197517        12.994781        13.017408        13.688952
## 4:        14.704235        15.722313        15.313496        14.121177
## 5:        11.716305        11.069845         9.741692        12.817657
## 6:         8.152062         7.574068        10.430793         8.388327
##    TCGA-A2-A0ES-01A TCGA-BH-A1FE-06A TCGA-AN-A0XL-01A TCGA-C8-A1HN-01A
## 1:        13.069443        13.879603        13.052639        13.954177
## 2:        13.057971        13.868072        13.041521        13.952242
## 3:        13.072073        13.860133        13.051797        13.966496
## 4:        15.119886        14.606794        13.939694        15.131465
## 5:        12.551834        12.965710        11.556911         9.229793
## 6:         9.169144         8.794678         8.536743         9.348273
##    TCGA-E2-A15K-11A TCGA-B6-A0RU-01A TCGA-B6-A400-01A TCGA-GM-A2DB-01A
## 1:        13.914144        13.121864        13.394120         12.90352
## 2:        13.933478        13.106835        13.391308         12.88941
## 3:        13.926560        13.110310        13.384075         12.89204
## 4:        15.041308        14.902080        14.741632         13.56033
## 5:        12.822863        12.493196         9.903762         11.11347
## 6:         8.784145         9.419106         9.451772          8.41050
##    TCGA-AC-A2FK-01A TCGA-D8-A140-01A TCGA-A7-A0CD-01A TCGA-D8-A1JF-01A
## 1:        13.964373         13.73986        12.871879        13.613298
## 2:        13.970051         13.74396        12.870939        13.582011
## 3:        13.968016         13.75602        12.896584        13.608723
## 4:        14.555184         16.12424        14.935364        13.390453
## 5:        12.685828         10.22075         9.644680        11.305340
## 6:         9.095796          8.73223         7.849328         9.404862
##    TCGA-BH-A208-11A TCGA-A2-A4S1-01A TCGA-5T-A9QA-01A TCGA-AC-A2QH-01A
## 1:        13.757155        13.645494        14.140454        14.013654
## 2:        13.749631        13.653060        14.133916        14.009475
## 3:        13.759616        13.668908        14.148726        14.012187
## 4:        14.968415        14.227248        15.091107        13.608790
## 5:        13.050158        11.753693         8.805488        13.222811
## 6:         9.842137         9.139365         8.946251         8.360158
##    TCGA-AR-A2LK-01A TCGA-AR-A1AH-01A TCGA-AR-A254-01A TCGA-A7-A3RF-01A
## 1:        13.592928        13.150569        12.993335        14.282130
## 2:        13.595343        13.148508        12.974962        14.266512
## 3:        13.588227        13.173124        13.001272        14.284803
## 4:        14.038715        12.954861        14.726400        13.615346
## 5:         9.887184        10.700715         9.595818         8.178036
## 6:         8.519536         8.525715         9.702038         7.345761
##    TCGA-S3-A6ZF-01A TCGA-A8-A07G-01A TCGA-A8-A07J-01A TCGA-C8-A12O-01A
## 1:        13.798942        12.889066        12.745731        13.014030
## 2:        13.806251        12.878653        12.729832        12.997122
## 3:        13.813077        12.895838        12.723167        13.019518
## 4:        13.747819        15.020030        15.482315        13.771593
## 5:        10.034502        12.420892        12.025736        10.939039
## 6:         8.372146         8.945492         8.592572         8.427029
##    TCGA-A8-A075-01A TCGA-A7-A13G-11A TCGA-B6-A1KC-01A TCGA-AR-A1AW-01A
## 1:        12.112634        12.407443        13.578674         13.55863
## 2:        12.085995        12.384765        13.568388         13.58059
## 3:        12.151100        12.400513        13.598218         13.56122
## 4:        12.848860        13.737010        15.106358         13.60509
## 5:         9.551038        11.579877         9.789035         10.06707
## 6:         8.117512         9.347354         8.891905         10.10510
##    TCGA-GI-A2C9-01A TCGA-EW-A1J2-01A TCGA-E9-A1NG-01A TCGA-AO-A0J3-01A
## 1:        13.808433        14.016318        13.024733        11.636195
## 2:        13.798512        14.009149        13.019516        11.657230
## 3:        13.824483        14.026719        13.027125        11.660654
## 4:        15.026576        14.719216        14.303354        12.850490
## 5:        10.656225        11.375105        10.497142         7.612279
## 6:         9.327548         9.202463         9.641205         9.372448
##    TCGA-E9-A1R3-01A TCGA-AC-A6NO-01A TCGA-GM-A2DO-01A TCGA-BH-A1F0-11B
## 1:        13.510844         14.28881        14.386116        13.676698
## 2:        13.522013         14.28304        14.394687        13.679689
## 3:        13.510562         14.28752        14.398910        13.693072
## 4:        15.077224         14.87475        14.004710        14.513405
## 5:        10.242814         10.89691        10.492184        12.766245
## 6:         7.437167          8.94897         8.956987         8.281054
##    TCGA-BH-A18H-01A TCGA-BH-A1FU-11A TCGA-AR-A0U3-01A TCGA-BH-A18K-11A
## 1:        13.405612        13.648853        12.148357        13.710060
## 2:        13.382023        13.654035        12.121849        13.704376
## 3:        13.384687        13.662331        12.159012        13.731253
## 4:        13.668729        14.940233        13.260427        15.395249
## 5:        10.729411        13.035406         9.092479        13.031919
## 6:         8.868544         8.237933         7.942491         9.401684
##    TCGA-E9-A1R0-01A TCGA-A8-A09B-01A TCGA-E9-A1N5-11A TCGA-E9-A3Q9-01A
## 1:        14.465353         13.10500        13.595474        13.825728
## 2:        14.457752         13.09016        13.597836        13.813455
## 3:        14.478268         13.09209        13.598219        13.836510
## 4:        15.967633         15.64306        14.665616        15.974762
## 5:        11.978370         11.28016        13.017996        10.485298
## 6:         8.773733          8.80989         9.892916         8.252527
##    TCGA-BH-A0HX-01A TCGA-AC-A3W7-01A TCGA-AR-A1AU-01A TCGA-A2-A0EU-01A
## 1:        13.127534        13.034693        14.085881        13.224707
## 2:        13.136437        13.031921        14.072483        13.214811
## 3:        13.139027        13.041875        14.084798        13.223974
## 4:        15.616659        14.608185        15.182920        15.777022
## 5:        10.595048        11.286926        12.041088        10.796625
## 6:         8.333636         8.378517         8.683163         7.355713
##    TCGA-AQ-A1H2-01A TCGA-BH-A0DQ-01A TCGA-AO-A0JM-01A TCGA-E2-A15J-01A
## 1:        14.616416         12.78939        12.744152        14.205192
## 2:        14.612834         12.80020        12.747911        14.199054
## 3:        14.642967         12.82158        12.785766        14.209779
## 4:        15.853546         14.44615        15.893396        15.487820
## 5:         9.275844         11.34104         9.767110        10.068174
## 6:        10.025646          8.68565         9.726492         9.577288
##    TCGA-A7-A26F-01A TCGA-E9-A22B-01A TCGA-BH-A1FN-11A TCGA-A2-A3XT-01A
## 1:        12.857221        12.701360        13.479485        12.763421
## 2:        12.862991        12.693661        13.496268        12.752575
## 3:        12.863951        12.714327        13.499564        12.778221
## 4:        13.957818        13.861886        14.999706        14.640375
## 5:        11.397682        10.256078        13.468872         9.806701
## 6:         9.466887         9.140757         8.192389         8.916635
##    TCGA-AR-A0TY-01A TCGA-A2-A0YG-01A TCGA-B6-A0WZ-01A TCGA-E2-A1IJ-01A
## 1:        13.551397        11.786096        12.560411         12.82242
## 2:        13.553265        11.792240        12.567922         12.82999
## 3:        13.558608        11.780268        12.558658         12.82908
## 4:        15.097353        13.678750        14.380226         14.19439
## 5:        11.340025         9.989811        11.208360         11.77617
## 6:         9.091539         8.574366         8.846751          8.30879
##    TCGA-AC-A23G-01A TCGA-GM-A2DA-01A TCGA-AO-A12E-01A TCGA-AR-A250-01A
## 1:        14.167507        13.741971        13.649585        13.299732
## 2:        14.173234        13.742685        13.644002        13.293981
## 3:        14.181232        13.746950        13.673878        13.292186
## 4:        14.827341        13.717039        14.948852        14.387826
## 5:        12.177892        12.028928        12.043774        10.565632
## 6:         7.992378         7.916998         8.258926         9.340182
##    TCGA-D8-A1XC-01A TCGA-AO-A12G-01A TCGA-A7-A3IY-01A TCGA-B6-A401-01A
## 1:        13.541413        14.227780        13.046839        13.220446
## 2:        13.532053        14.211660        13.059150        13.223278
## 3:        13.547878        14.231018        13.059027        13.220830
## 4:        15.291591        15.948276        14.798134        14.613192
## 5:         7.745755        10.797403        10.472938        10.907655
## 6:         8.500277         9.143506         9.015189         8.090989
##    TCGA-BH-A1EY-01A TCGA-A8-A079-01A TCGA-E2-A572-01A TCGA-BH-A0C1-01B
## 1:        12.906646         13.42530        13.982113        13.726653
## 2:        12.891250         13.41294        13.983264        13.751652
## 3:        12.921581         13.48052        13.994772        13.738882
## 4:        14.358975         14.89513        14.322531        13.566085
## 5:        11.080879         10.18419        11.344678        11.699204
## 6:         9.719228         10.45738         8.138518         8.237434
##    TCGA-BH-A1EV-01A TCGA-AR-A0TV-01A TCGA-A7-A13G-01B TCGA-A8-A07E-01A
## 1:        13.633211        13.049890        13.808303        12.537589
## 2:        13.636784        13.044112        13.816999        12.526886
## 3:        13.641146        13.041511        13.824910        12.590178
## 4:        13.694035        15.298717        15.406502        14.730991
## 5:        11.098943         9.220456        10.114883        11.116481
## 6:         8.721502         9.017846         9.129281         8.981185
##    TCGA-E9-A1N9-01A TCGA-BH-A0H3-01A TCGA-AR-A1AY-01A TCGA-A2-A0D4-01A
## 1:         12.68212        14.449965        13.368652         13.38640
## 2:         12.68939        14.455582        13.355737         13.36727
## 3:         12.70758        14.458787        13.387634         13.39663
## 4:         13.63672        15.449461        14.669056         14.47098
## 5:         10.68560        12.461608        12.202603         11.23175
## 6:          9.97760         9.052264         9.517079         10.20280
##    TCGA-E9-A5UO-01A TCGA-GM-A2DL-01A TCGA-EW-A1PD-01A TCGA-A1-A0SI-01A
## 1:        13.212236        13.759712        12.945021        12.844490
## 2:        13.214041        13.761503        12.955479        12.836598
## 3:        13.233329        13.764046        12.962389        12.836003
## 4:        14.140162        14.206045        13.805800        14.810301
## 5:         6.680266        11.596558        11.843308        11.511602
## 6:         8.150290         8.524783         9.110693         8.340513
##    TCGA-BH-A0DZ-11A TCGA-A2-A0CV-01A TCGA-E2-A15E-06A TCGA-AO-A12B-01A
## 1:        13.354306        13.780127        13.504397        14.586900
## 2:        13.336746        13.785213        13.531881        14.570509
## 3:        13.350373        13.784367        13.533944        14.587238
## 4:        15.860608        15.258472        14.855930        15.566071
## 5:        13.692552        12.271354         9.677198         8.409560
## 6:         8.730039         9.142117         8.035709         7.868056
##    TCGA-E2-A15H-01A TCGA-EW-A6S9-01A TCGA-AO-A1KO-01A TCGA-C8-A131-01A
## 1:        12.769781        13.215751        14.548110        13.099186
## 2:        12.760095        13.210117        14.546870        13.084656
## 3:        12.758886        13.233587        14.555737        13.106466
## 4:        13.776725        14.114718        15.623482        14.748117
## 5:        10.719633        10.166878        13.527626        11.168005
## 6:         9.130503         8.610071         9.491113         9.941565
##    TCGA-BH-A1EN-01A TCGA-BH-A0BC-11A TCGA-E9-A247-01A TCGA-D8-A1JN-01A
## 1:        13.783635        13.890715        12.410004         11.96170
## 2:        13.752262        13.882255        12.396513         11.94872
## 3:        13.792013        13.884260        12.404203         11.96713
## 4:        12.329093        16.051099        14.311778         13.50534
## 5:        11.178882        13.898559        10.194750         10.10554
## 6:         8.411503         8.135504         9.860518          7.94385
##    TCGA-E2-A1BD-01A TCGA-A2-A0EO-01A TCGA-BH-A18M-11A TCGA-E2-A105-01A
## 1:        14.026616        13.073552        13.731807         14.36922
## 2:        14.033012        13.071606        13.734714         14.37142
## 3:        14.030702        13.101982        13.737549         14.38561
## 4:        15.234393        14.969877        15.048411         15.22030
## 5:        12.028588        11.632472        13.234958         10.43641
## 6:         8.751864         8.345639         8.656455          8.78385
##    TCGA-D8-A1JK-01A TCGA-E9-A1N9-11A TCGA-AO-A12F-01A TCGA-C8-A26V-01A
## 1:        11.988584         13.18820         13.31293        13.844533
## 2:        11.992293         13.20414         13.28468        13.837597
## 3:        11.982597         13.21394         13.35816        13.881305
## 4:        12.870944         14.62837         14.55615        14.250669
## 5:        10.749234         12.58391         10.33418        11.222284
## 6:         8.601889          8.49170         10.71379         9.991507
##    TCGA-AQ-A54O-01A TCGA-D8-A1JP-01A TCGA-EW-A1PB-01A TCGA-PL-A8LZ-01A
## 1:        12.838449        11.964324        12.270414        12.887021
## 2:        12.826599        11.946869        12.261762        12.882188
## 3:        12.832453        11.955055        12.289692        12.877285
## 4:        13.841119        13.833327        13.752578        13.483959
## 5:        10.804626        10.720747        13.197416        10.946991
## 6:         8.316781         9.800516         9.434854         9.001397
##    TCGA-E9-A6HE-01A TCGA-D8-A1X7-01A TCGA-AO-A0JD-01A TCGA-D8-A1X5-01A
## 1:        13.180866        13.632495         12.83620        12.818815
## 2:        13.159786        13.624425         12.82570        12.815690
## 3:        13.188930        13.662873         12.84172        12.857188
## 4:        13.489992        15.430143         15.62371        14.325022
## 5:        10.619838        10.436218         11.13202         9.501208
## 6:         9.075784         9.733251          9.29616        10.042521
##    TCGA-E9-A22E-01A TCGA-E2-A14P-01A TCGA-AC-A23E-01A TCGA-BH-A0E2-01A
## 1:         12.48618        12.703746        12.687035        14.982890
## 2:         12.48982        12.726543        12.688377        14.984585
## 3:         12.49698        12.737409        12.704088        14.989217
## 4:         13.71085        13.719426        14.824513        17.067336
## 5:         10.87575        11.538876        11.215472        11.136072
## 6:         10.29190         9.034521         9.366609         8.647142
##    TCGA-A2-A1FV-01A TCGA-AN-A0XO-01A TCGA-A7-A425-01A TCGA-PE-A5DE-01A
## 1:        15.891614        12.729754        12.854222        12.800125
## 2:        15.895721        12.679987        12.843458        12.781915
## 3:        15.900539        12.714788        12.853272        12.806234
## 4:        12.903660        14.470440        12.747099        13.771686
## 5:        11.251755        11.238713        11.380518         9.555901
## 6:         7.314382         8.999192         8.050027         8.321762
##    TCGA-EW-A1IX-01A TCGA-AQ-A04L-01B TCGA-E2-A14S-01A TCGA-B6-A40C-01A
## 1:        13.325407        12.324643        14.906595        13.226161
## 2:        13.308491        12.332371        14.896041        13.220554
## 3:        13.319997        12.304053        14.911368        13.225025
## 4:        14.690562        14.594302        15.589743        14.199370
## 5:        12.346915         9.289758        10.312293        10.486577
## 6:         8.910132         7.716117         9.113651         8.601872
##    TCGA-OL-A5RU-01A TCGA-D8-A73X-01A TCGA-B6-A1KN-01A TCGA-LL-A9Q3-01A
## 1:        13.565339        14.297811        13.105468        12.891429
## 2:        13.555854        14.289038        13.053622        12.888881
## 3:        13.567780        14.297196        13.074282        12.898072
## 4:        14.110207        15.184599        13.872351        12.918461
## 5:        11.278619        11.791525        10.521585         9.765840
## 6:         8.118492         7.703185         9.665702         7.923329
##    TCGA-A8-A08B-01A TCGA-A1-A0SG-01A TCGA-BH-A0H0-01A TCGA-D8-A1XR-01A
## 1:        12.358182        13.492755        14.182988        13.427819
## 2:        12.337990        13.499633        14.175967        13.406816
## 3:        12.398148        13.493858        14.180986        13.434898
## 4:        14.684737        15.304859        17.099237        15.268289
## 5:         9.519960        11.017995        11.358740         8.954778
## 6:         8.935226         9.430333         8.909539         9.699509
##    TCGA-BH-A1FE-01A TCGA-AO-A0JF-01A TCGA-A8-A07W-01A TCGA-C8-A133-01A
## 1:        13.936737         12.89410        12.904009        13.337481
## 2:        13.932938         12.90483        12.935348        13.340230
## 3:        13.931551         12.90898        12.955030        13.357401
## 4:        14.270116         15.43563        14.243205        15.516950
## 5:        12.380180         11.68977        10.262343         7.920855
## 6:         8.715087          7.83182         9.919282         8.831785
##    TCGA-A2-A0CZ-01A TCGA-A2-A0EV-01A TCGA-A8-A08L-01A TCGA-C8-A8HR-01A
## 1:        12.410588        12.956854         13.21266        13.694890
## 2:        12.370537        12.954630         13.22240        13.675321
## 3:        12.417752        12.978811         13.25266        13.691443
## 4:        13.620623        14.242230         15.24800        13.950099
## 5:        11.506990        10.994977         11.13215        12.172049
## 6:         8.095042         8.739645         10.43809         8.402272
##    TCGA-AR-A2LN-01A TCGA-E9-A1QZ-01A TCGA-BH-A8FY-01A TCGA-AR-A1AL-01A
## 1:        14.933582         13.26041        15.180896        14.892702
## 2:        14.933264         13.27109        15.181630        14.887232
## 3:        14.928754         13.27699        15.184430        14.889516
## 4:        15.461324         14.34790        15.926335        15.539844
## 5:        13.219971         12.14101         9.974259        12.629702
## 6:         8.205706          9.03208         8.779685         8.410324
##    TCGA-D8-A1Y2-01A TCGA-BH-A0BS-11A TCGA-AO-A0J8-01A TCGA-E2-A14Q-01A
## 1:        12.479235         14.50312        12.924320        13.525726
## 2:        12.449498         14.50865        12.884996        13.538050
## 3:        12.469857         14.51427        12.943317        13.530444
## 4:        13.699135         16.03517        15.796643        14.389281
## 5:         9.718366         13.56804        10.398906        11.769841
## 6:         7.968501          9.25129         9.563661         8.428858
##    TCGA-A2-A04T-01A TCGA-A8-A0A6-01A TCGA-AN-A0AJ-01A TCGA-D8-A1XJ-01A
## 1:         13.33289        13.369152        12.641419         13.29386
## 2:         13.32086        13.366622        12.630631         13.29501
## 3:         13.38337        13.375412        12.632625         13.29398
## 4:         14.07745        16.511816        14.468239         14.86750
## 5:         11.06647        11.536781         8.703417         10.69348
## 6:         11.64135         8.741956        10.644357          7.89171
##    TCGA-BH-A5IZ-01A TCGA-A2-A0EP-01A TCGA-BH-A18K-01A TCGA-A7-A3J1-01A
## 1:        12.885852        13.430575        12.234678         13.71706
## 2:        12.872809        13.417035        12.224619         13.70612
## 3:        12.881131        13.434251        12.263336         13.71311
## 4:        14.074639        14.671545        13.262748         14.85219
## 5:         9.525102        11.803282        10.723087         11.47013
## 6:         9.066519         8.484898         9.385496          7.57149
##    TCGA-E9-A244-01A TCGA-A8-A0A2-01A TCGA-AN-A0AM-01A TCGA-AR-A1AO-01A
## 1:         12.56885        12.702499        11.985552        13.293235
## 2:         12.56091        12.684953        12.010885        13.271791
## 3:         12.60372        12.710090        12.025393        13.287418
## 4:         14.44299        13.959678        13.306689        14.001747
## 5:         10.77040        10.876194        10.189553        12.347331
## 6:          9.49567         9.109973         9.048087         9.292988
##    TCGA-EW-A1J6-01A TCGA-EW-A1IZ-01A TCGA-AC-A2FG-01A TCGA-A8-A09Z-01A
## 1:        12.375243         12.41325        13.564555        12.833927
## 2:        12.360287         12.39093        13.562212        12.804517
## 3:        12.387562         12.41022        13.577440        12.849277
## 4:        13.400994         13.01766        15.604410        15.372419
## 5:         9.318635         10.04893        11.944580         7.790821
## 6:         9.355828          8.82183         7.990158         8.994420
##    TCGA-A2-A3XW-01A TCGA-A8-A0A9-01A TCGA-BH-A0DT-01A TCGA-AR-A1AJ-01A
## 1:        14.002985        13.605576        13.878599        12.919964
## 2:        13.995723        13.594395        13.873616        12.925685
## 3:        14.004296        13.596603        13.893389        12.938361
## 4:        14.803396        15.803129        15.208979        14.053798
## 5:        12.986922        10.627787        11.610722        11.132650
## 6:         8.364555         9.478201         8.963015         9.963595
##    TCGA-A2-A4RY-01A TCGA-D8-A27F-01A TCGA-E9-A1RI-11A TCGA-D8-A27E-01A
## 1:        13.910696        14.737402         13.49892        14.486707
## 2:        13.917956        14.740478         13.51405        14.490195
## 3:        13.912495        14.745255         13.51944        14.498920
## 4:        14.237583        15.761610         14.88376        15.526985
## 5:        12.148290        10.479272         12.87869         9.624617
## 6:         7.947786         9.374715          9.24860         8.999344
##    TCGA-C8-A138-01A TCGA-EW-A423-01A TCGA-AC-A5EH-01A TCGA-B6-A402-01A
## 1:        13.146619        12.095510         12.49180        13.376025
## 2:        13.135308        12.095255         12.48484        13.353519
## 3:        13.146304        12.109884         12.50859        13.363110
## 4:        14.834054        13.006222         13.12108        14.876703
## 5:        10.839433         9.092317         11.17658        10.418126
## 6:         9.419721         8.646750          8.98398         9.514366
##    TCGA-AR-A2LR-01A TCGA-D8-A1JL-01A TCGA-BH-A0C3-01A TCGA-A2-A1G6-01A
## 1:        14.724446         14.03982        13.129676        13.425634
## 2:        14.724186         14.03459        13.114172        13.435496
## 3:        14.734682         14.04817        13.134116        13.441702
## 4:        14.664513         14.26865        14.696665        15.223937
## 5:        12.543793         12.01742        12.138044        12.950943
## 6:         9.703037         10.19368         8.787294         8.848919
##    TCGA-EW-A3U0-01A TCGA-A2-A4S2-01A TCGA-D8-A1XV-01A TCGA-E9-A1N6-01A
## 1:        12.731157        13.297731        13.734612        12.943312
## 2:        12.731626        13.289315        13.735386        12.914696
## 3:        12.728811        13.307274        13.738664        12.956010
## 4:        13.241856        14.552705        12.353762        14.496030
## 5:        11.109180        10.373704         8.198588        10.806083
## 6:         9.056227         8.634223         7.221814         9.918143
##    TCGA-AN-A0FT-01A TCGA-BH-A0W4-01A TCGA-E2-A15K-01A TCGA-A7-A0CG-01A
## 1:        12.027683        12.541903         13.43862        13.004113
## 2:        12.030180        12.554007         13.43769        13.006505
## 3:        12.076485        12.574225         13.46634        13.018725
## 4:        12.502103        14.634863         14.31629        14.557949
## 5:        10.136300        11.199663         10.09592        12.354893
## 6:         8.237219         7.983963          9.55296         8.538699
##    TCGA-B6-A0IG-01A TCGA-BH-A0HI-01A TCGA-BH-A0B6-01A TCGA-BH-A201-01A
## 1:        12.064661        12.760644        14.546011         13.44553
## 2:        12.077312        12.751820        14.537908         13.44515
## 3:        12.109364        12.779196        14.546541         13.45257
## 4:        13.615370        14.822583        15.762241         14.61413
## 5:        10.763924        10.593026        11.649006         12.32110
## 6:         9.790842         8.716887         8.714256          9.24419
##    TCGA-A2-A3XU-01A TCGA-A1-A0SN-01A TCGA-A8-A08A-01A TCGA-A2-A0YI-01A
## 1:         13.35669        12.262034        13.464937        13.777960
## 2:         13.35085        12.256707        13.463675        13.775352
## 3:         13.38817        12.267846        13.445886        13.789554
## 4:         14.36024        13.549394        15.543185        14.765287
## 5:         15.87066        10.405983        10.836216        12.124606
## 6:         10.14238         8.219828         9.858508         8.975513
##    TCGA-AR-A1AN-01A TCGA-AR-A2LM-01A TCGA-AR-A5QQ-01A TCGA-AR-A0TR-01A
## 1:        13.984009        14.870869        12.655546        12.957340
## 2:        13.988798        14.861502        12.629845        12.942168
## 3:        13.994221        14.861260        12.649320        12.952659
## 4:        15.188861        15.746956        12.922711        14.514080
## 5:        11.968757        12.415872         9.413112         7.463173
## 6:         9.544022         8.469365         8.769528         9.217367
##    TCGA-BH-A1FC-01A TCGA-A2-A0D1-01A TCGA-D8-A1XA-01A TCGA-EW-A1P7-01A
## 1:         13.60002        12.290943        12.708846        13.134731
## 2:         13.61486        12.299641        12.713532        13.133576
## 3:         13.59959        12.332240        12.702259        13.143009
## 4:         12.61784        13.711375        14.674601        14.848024
## 5:          9.53865        10.497376        10.188369        11.573925
## 6:         11.71660         9.554395         9.178801         9.691003
##    TCGA-AR-A1AP-01A TCGA-E2-A150-01A TCGA-C8-A12P-01A TCGA-AR-A1AV-01A
## 1:        12.943027         12.92436        12.951173        13.517367
## 2:        12.946255         12.93444        12.977151        13.512822
## 3:        12.909741         12.94685        12.959350        13.516719
## 4:        14.981376         13.42948        13.347596        13.627543
## 5:        11.365463         11.86676        10.918692         9.715541
## 6:         8.440383         10.37272         8.417469         9.201305
##    TCGA-A2-A0T1-01A TCGA-E2-A153-11A TCGA-BH-A0B7-11A TCGA-OL-A6VR-01A
## 1:        12.550677        13.578727        14.139513        14.415594
## 2:        12.556734        13.594326        14.142287        14.410695
## 3:        12.569404        13.589513        14.129493        14.416930
## 4:        14.636357        14.785444        15.800602        14.817516
## 5:        11.273146        13.047596        13.484063        11.477439
## 6:         8.613287         8.457478         9.363491         7.615457
##    TCGA-AO-A0J4-01A TCGA-BH-A0BG-01A TCGA-AO-A1KP-01A TCGA-LL-A441-01A
## 1:        13.053227         13.65160        14.139201        13.476675
## 2:        13.021136         13.64838        14.141098        13.456904
## 3:        13.013341         13.65442        14.148734        13.478709
## 4:        15.453350         15.12815        14.611139        13.449364
## 5:         9.770424         10.42614        11.214825        12.077885
## 6:         9.735956         10.62257         9.873794         9.687959
##    TCGA-E2-A1IU-01A TCGA-A7-A6VY-01A TCGA-E2-A1II-01A TCGA-OL-A5D8-01A
## 1:        13.491395        13.312191        11.827456        12.816642
## 2:        13.477266        13.314224        11.812174        12.814794
## 3:        13.494145        13.302070        11.825820        12.857550
## 4:        15.133589        13.693494        12.856627        13.849562
## 5:        10.989764        10.945026         9.610432         8.920759
## 6:         8.224348         9.079848         9.871764         9.055406
##    TCGA-BH-A0RX-01A TCGA-A8-A08X-01A TCGA-AC-A2QH-01B TCGA-E2-A56Z-01A
## 1:        12.474253        11.901380        12.720421        12.675340
## 2:        12.446337        11.915737        12.722000        12.666759
## 3:        12.485871        11.926100        12.739900        12.666265
## 4:        13.927923        14.448936        12.649981        13.319504
## 5:        11.429129        10.647914        11.388181         8.502415
## 6:         9.380043         8.598305         9.361146         7.926870
##    TCGA-E9-A1NH-01A TCGA-BH-A0BT-11A TCGA-AC-A4ZE-01A TCGA-A8-A07Z-01A
## 1:        13.314809        14.617332        15.392805        12.990938
## 2:        13.287426        14.620559        15.387926        12.991475
## 3:        13.320616        14.624064        15.388876        12.972004
## 4:        14.934238        15.756663        15.855197        16.237764
## 5:        10.753633        13.230945        10.074559         9.344280
## 6:         9.327947         8.242893         9.056454         8.780465
##    TCGA-OL-A66P-01A TCGA-E2-A1LE-01A TCGA-AC-A3W5-01A TCGA-BH-A0H7-11A
## 1:        12.662134        13.330254        12.634346        13.443120
## 2:        12.668792        13.334750        12.622768        13.449290
## 3:        12.666763        13.328642        12.645232        13.462480
## 4:        13.182837        13.137349        13.721460        16.008811
## 5:        11.067893        11.740443        11.326288        13.602417
## 6:         8.592522         8.507909         9.093449         8.634423
##    TCGA-D8-A1JJ-01A TCGA-BH-A0HB-01A TCGA-BH-A18L-11A TCGA-A2-A0EQ-01A
## 1:        12.747516        12.573019        13.663741         13.05575
## 2:        12.747801        12.555045        13.658337         13.02276
## 3:        12.763569        12.592695        13.670054         13.08350
## 4:        13.919679        14.777930        15.061691         14.45075
## 5:        10.461279        10.901720        13.122197         10.73593
## 6:         9.488112         9.977019         8.940513         10.09993
##    TCGA-A8-A081-01A TCGA-B6-A3ZX-01A TCGA-OL-A66H-01A TCGA-A2-A0T0-01A
## 1:        11.797004        13.996605        13.726734        12.629347
## 2:        11.745686        14.001858        13.720650        12.607499
## 3:        11.782583        13.997730        13.737121        12.634821
## 4:        12.535125        14.836421        14.682907        14.855128
## 5:         9.209801         9.824773         9.366281         9.550644
## 6:         7.941779         9.571459         8.333184         9.477709
##    TCGA-A7-A0DB-11A TCGA-AN-A04C-01A TCGA-E2-A573-01A TCGA-AN-A0XS-01A
## 1:        13.029908        12.413538        12.768675        12.905784
## 2:        13.018275        12.393639        12.777726        12.904706
## 3:        13.031576        12.384546        12.782075        12.919716
## 4:        15.075781        13.808837        13.294560        14.937017
## 5:        12.540597        11.306657        10.718334        10.278168
## 6:         9.911951         9.766715         9.595749         8.503949
##    TCGA-D8-A3Z6-01A TCGA-EW-A3E8-01B TCGA-C8-A137-01A TCGA-A8-A06Y-01A
## 1:        13.602353        13.847558        14.011928        12.093220
## 2:        13.606218        13.835124        14.009030        12.092948
## 3:        13.613555        13.846488        14.021097        12.076487
## 4:        14.956033        14.473476        15.293706        13.755579
## 5:        11.291145        11.423429        11.477547         8.053867
## 6:         8.724408         7.552245         8.670271         8.214940
##    TCGA-E2-A1B4-01A TCGA-EW-A2FS-01A TCGA-S3-A6ZG-01A TCGA-BH-A209-11A
## 1:        15.086711        13.167383        13.861328        12.769304
## 2:        15.097745        13.161156        13.856836        12.767898
## 3:        15.093364        13.177788        13.861782        12.776641
## 4:        15.608129        14.584811        14.511505        14.196979
## 5:        12.046510        11.030554        10.262840        12.359201
## 6:         8.411728         9.500434         7.406031         9.120449
##    TCGA-BH-A0DK-11A TCGA-EW-A1P8-01A TCGA-E2-A156-01A TCGA-AC-A3YJ-01A
## 1:        13.066465         12.63381        14.307726        14.100800
## 2:        13.074951         12.59657        14.304563        14.097468
## 3:        13.080943         12.64280        14.317231        14.112605
## 4:        15.382720         13.65574        15.782323        15.002643
## 5:        12.722401         11.33548         8.589226         9.748500
## 6:         8.492376         10.56806         8.921353         8.941836
##    TCGA-A7-A26I-01A TCGA-AN-A0FS-01A TCGA-A2-A0T4-01A TCGA-B6-A0IM-01A
## 1:        12.282627        13.772510         12.94026        13.541617
## 2:        12.266608        13.754763         12.93750        13.541290
## 3:        12.297059        13.777723         12.91790        13.534494
## 4:        14.166638        15.695224         15.40910        15.912561
## 5:        11.404748        11.934720         12.30864         9.520323
## 6:         9.737403         8.677131          8.52468         8.887351
##    TCGA-C8-A1HK-01A TCGA-D8-A27K-01A TCGA-E9-A2JT-01A TCGA-A2-A0ST-01A
## 1:        11.684876        14.818566        14.759457        12.485727
## 2:        11.691592        14.803489        14.763083        12.433817
## 3:        11.729776        14.806587        14.755881        12.444780
## 4:        12.002845        15.941903        14.286105        14.212311
## 5:        10.113968        11.955757        11.953163        11.877300
## 6:         7.804293         8.754791         8.252816         9.304462
##    TCGA-BH-A1EN-11A TCGA-GM-A2DK-01A TCGA-AR-A1AK-01A TCGA-A7-A0DC-01B
## 1:         12.90133        13.932122        13.707495        13.224302
## 2:         12.90067        13.932899        13.703797        13.224197
## 3:         12.88947        13.942127        13.701863        13.246394
## 4:         14.64488        14.276670        14.536732        14.358833
## 5:         12.67945        11.779824        11.740837         8.835464
## 6:          9.00342         8.612479         8.768321         9.317488
##    TCGA-E2-A15R-01A TCGA-E9-A22D-01A TCGA-BH-A0DV-11A TCGA-E2-A153-01A
## 1:        13.498005        12.646041        14.661375        13.589713
## 2:        13.484103        12.643753        14.652037        13.571880
## 3:        13.506195        12.655848        14.665885        13.593498
## 4:        14.652597        13.409603        15.601347        15.184422
## 5:        10.709519         8.900253        13.135505        11.490020
## 6:         9.467193        10.343593         8.617367         9.261292
##    TCGA-BH-A0BT-01A TCGA-E9-A54Y-01A TCGA-BH-A2L8-01A TCGA-BH-A0HN-01A
## 1:        14.296035        12.911741        14.492231        14.798156
## 2:        14.288357        12.897803        14.489640        14.792497
## 3:        14.310880        12.919810        14.490647        14.798814
## 4:        13.701108        13.046412        14.762507        15.137793
## 5:        11.675755         8.119493        11.966086        10.031647
## 6:         8.270739         8.738127         8.338461         9.168096
##    TCGA-AO-A03T-01A TCGA-E2-A1IK-01A TCGA-A8-A09C-01A TCGA-E2-A10C-01A
## 1:        13.575520        13.245953        12.786928        13.195819
## 2:        13.550073        13.238660        12.814991        13.193010
## 3:        13.592415        13.243089        12.817485        13.201362
## 4:        15.074677        14.857793        14.460760        14.686534
## 5:        12.440507        11.281414        10.212282         9.047869
## 6:         9.543486         8.119312         9.170441         8.874494
##    TCGA-A8-A095-01A TCGA-A7-A0DB-01A TCGA-BH-A18J-01A TCGA-OL-A66I-01A
## 1:        12.977573        13.549373        13.282198        12.664705
## 2:        12.975806        13.542364        13.260615        12.668194
## 3:        12.994833        13.552881        13.281061        12.670582
## 4:        15.867699        15.280517        14.374758        13.076953
## 5:        11.388057        11.999023        10.976338        10.304956
## 6:         8.006276         9.073011         9.338904         9.554442
##    TCGA-AC-A3TN-01A TCGA-A7-A13E-01A TCGA-BH-A0W5-01A TCGA-GM-A2DD-01A
## 1:        13.715408        13.269076        12.589272         13.53361
## 2:        13.722542        13.243554        12.576427         13.51791
## 3:        13.723811        13.255875        12.607011         13.53173
## 4:        15.738965        14.682033        14.520482         13.76366
## 5:        11.041151        11.995855        11.501142         12.14539
## 6:         8.523463         9.845467         8.193482          9.21662
##    TCGA-BH-A1F8-11B TCGA-E2-A1IL-01A TCGA-EW-A2FR-01A TCGA-3C-AAAU-01A
## 1:        12.640670        13.233608        12.561512        13.514627
## 2:        12.694007        13.236053        12.551526        13.504685
## 3:        12.675205        13.238495        12.561670        13.530334
## 4:        14.594399        14.324834        13.555179        14.562495
## 5:        12.623011        11.076946        11.266698         7.978139
## 6:         9.006856         9.030344         8.364671         8.680035
##    TCGA-AR-A24W-01A TCGA-B6-A0IO-01A TCGA-BH-A0C0-11A TCGA-AN-A0FZ-01A
## 1:        14.064291        12.731216        13.431114        12.939456
## 2:        14.050757        12.726283        13.424636        12.901893
## 3:        14.061863        12.752813        13.449517        12.956319
## 4:        15.690484        15.564534        15.868086        14.267101
## 5:        12.562116        10.433963        13.460665         9.528948
## 6:         8.949862         8.818242         8.660387         9.979239
##    TCGA-AR-A1AT-01A TCGA-BH-A1FD-11B TCGA-A8-A07P-01A TCGA-A8-A083-01A
## 1:        13.332048        12.046421         12.18216        13.356376
## 2:        13.339395        12.039633         12.18059        13.351715
## 3:        13.348703        12.108904         12.21884        13.385857
## 4:        15.285899        14.078366         14.08567        16.476570
## 5:        10.435194        11.904184          9.20620         9.301687
## 6:         8.742347         8.279688          7.93487         9.262491
##    TCGA-BH-A18N-01A TCGA-E9-A1RC-01A TCGA-D8-A27I-01A TCGA-A2-A04Y-01A
## 1:        13.470291        13.044523        14.101435        13.008730
## 2:        13.456587        13.040967        14.098653        13.010961
## 3:        13.457288        13.065317        14.093538        13.020616
## 4:        15.048692        15.079631        14.099680        15.459013
## 5:        10.209081         9.894075        12.498473        11.274460
## 6:         8.690972        10.310686         8.722268         9.384992
##    TCGA-PE-A5DC-01A TCGA-D8-A4Z1-01A TCGA-A7-A26E-01A TCGA-E2-A1AZ-01A
## 1:        13.320191        13.937202        13.679105        12.666225
## 2:        13.293344        13.924976        13.674316        12.680116
## 3:        13.300285        13.919604        13.689238        12.703487
## 4:        13.659333        14.195501        15.096729        13.494483
## 5:        10.625982        12.431240        12.057905        12.313111
## 6:         8.634567         7.283794         8.585723         8.515563
##    TCGA-A8-A0A1-01A TCGA-E9-A1NF-11A TCGA-D8-A1J9-01A TCGA-BH-A1EO-01A
## 1:        13.289399        13.216175         13.45939        14.253513
## 2:        13.283352        13.208650         13.45716        14.239459
## 3:        13.289769        13.223481         13.46843        14.256338
## 4:        15.942161        14.872334         15.13435        14.803187
## 5:        11.369112        12.639856         11.27190        11.092929
## 6:         8.933609         9.475782         10.12013         8.139711
##    TCGA-BH-A28O-01A TCGA-B6-A0I2-01A TCGA-E9-A5UP-01A TCGA-A2-A0T5-01A
## 1:        14.116695         12.93834        13.128395        13.231742
## 2:        14.124715         12.92967        13.123657        13.214410
## 3:        14.127512         12.95612        13.130830        13.200105
## 4:        15.065068         15.16669        13.539292        16.222893
## 5:        13.102239         12.25087         7.273359        11.492400
## 6:         7.931802         10.31539         8.318794         9.175693
##    TCGA-A7-A0DA-01A TCGA-BH-A1FJ-11B TCGA-B6-A0IC-01A TCGA-A2-A0CT-01A
## 1:         12.78138        13.132216        13.753576        12.963904
## 2:         12.77126        13.109469        13.749123        12.969242
## 3:         12.80419        13.145287        13.770924        12.984002
## 4:         14.85306        15.256718        16.634456        14.981333
## 5:         11.36531        13.316301         8.358371        11.717469
## 6:         10.36428         9.205174        10.095890         8.237546
##    TCGA-BH-A5J0-01A TCGA-A2-A0CY-01A TCGA-E9-A245-01A TCGA-LL-A440-01A
## 1:        12.926271        12.645155        15.101291        13.340414
## 2:        12.920561        12.646266        15.099729        13.339683
## 3:        12.929002        12.694118        15.106912        13.344189
## 4:        13.455381        14.158864        15.665713        13.553029
## 5:        10.670788         8.562153        11.062082        12.289478
## 6:         8.148167         9.165966         7.949483         7.940142
##    TCGA-A1-A0SB-01A TCGA-OL-A66N-01A TCGA-AR-A24P-01A TCGA-E9-A248-01A
## 1:         14.03037        14.288996        13.372163        12.751567
## 2:         14.03306        14.288635        13.383276        12.761135
## 3:         14.04444        14.290538        13.397352        12.770091
## 4:         16.50293        15.035805        14.530839        13.541315
## 5:         13.39646        12.049846        11.643419        11.479784
## 6:         10.45497         7.087798         9.541365         9.870431
##    TCGA-C8-A1HG-01A TCGA-AO-A03N-01B TCGA-A8-A08J-01A TCGA-A7-A4SA-01A
## 1:        14.456324        13.617731        11.396849        12.491314
## 2:        14.446564        13.621391        11.419658        12.472917
## 3:        14.448825        13.604898        11.421452        12.488943
## 4:        15.173729        15.545053        13.260371        12.374915
## 5:         9.958229        11.414549         9.363029        10.216625
## 6:         9.879520         9.477674         8.547205         7.759296
##    TCGA-A2-A0T3-01A TCGA-AC-A2FM-11B TCGA-A8-A09T-01A TCGA-AN-A04A-01A
## 1:        12.511637         13.66278        12.972255        12.474897
## 2:        12.509436         13.66652        12.962907        12.461635
## 3:        12.526082         13.67515        12.996136        12.507920
## 4:        13.956581         16.90158        15.494927        14.052517
## 5:        11.028896         13.92108        11.577847        10.272201
## 6:         9.181424         11.42561         9.360572         7.987224
##    TCGA-E9-A1RG-01A TCGA-JL-A3YW-01A TCGA-E2-A154-01A TCGA-B6-A0I8-01A
## 1:        12.375157         12.86781        13.013390        11.609565
## 2:        12.362457         12.85989        13.028045        11.630017
## 3:        12.384508         12.87762        13.023757        11.640795
## 4:        13.298691         13.34230        13.698281        12.596765
## 5:         9.852299         10.16639        11.448748        11.418855
## 6:         9.229531          8.40364         9.382539         8.485151
##    TCGA-A2-A04U-01A TCGA-BH-A0EE-01A TCGA-BH-A0H5-01A TCGA-EW-A1IW-01A
## 1:        13.249776         12.31046        13.487558        12.806998
## 2:        13.247731         12.31245        13.487598        12.790473
## 3:        13.245801         12.30897        13.482916        12.788200
## 4:        13.991182         13.57315        14.800521        14.168986
## 5:         9.836266         11.88547        11.605292        11.899301
## 6:        10.451685         10.40758         9.174104         7.902474
##    TCGA-BH-A1EU-11A TCGA-AR-A5QN-01A TCGA-E9-A243-01A TCGA-C8-A134-01A
## 1:        14.239473        12.829287         13.13490         13.58440
## 2:        14.239216        12.828999         13.16809         13.56949
## 3:        14.235671        12.832847         13.15793         13.59530
## 4:        15.403708        12.569418         13.87029         14.38420
## 5:        13.223954        10.959009         11.20789         10.98572
## 6:         8.386486         8.831493         10.07797         10.15523
##    TCGA-BH-A1FC-11A TCGA-D8-A1Y1-01A TCGA-AO-A12A-01A TCGA-E2-A108-01A
## 1:         13.41262         13.05705        13.031089         13.81544
## 2:         13.41198         13.07408        13.024638         13.81590
## 3:         13.41137         13.07292        13.054853         13.80592
## 4:         14.42177         14.75423        15.194874         14.99315
## 5:         12.72647         10.90424        11.486128         12.37872
## 6:          8.21674         10.24929         9.349182          8.04775
##    TCGA-AN-A0XV-01A TCGA-BH-A0E1-01A TCGA-AN-A0FN-01A TCGA-E2-A14U-01A
## 1:        12.675384        14.220341        12.951295        13.598394
## 2:        12.703311        14.241427        12.967446        13.603159
## 3:        12.661048        14.229936        12.984139        13.602355
## 4:        14.247480        17.941439        15.062609        15.045599
## 5:        11.517668        11.464245        12.025220        12.415317
## 6:         8.283662         9.556693         8.780406         8.397339
##    TCGA-BH-A0HL-01A TCGA-E9-A229-01A TCGA-A8-A08T-01A TCGA-E9-A1RF-01A
## 1:        14.510168        12.494040        13.376777        12.404729
## 2:        14.500514        12.490786        13.375875        12.390338
## 3:        14.506136        12.507653        13.365532        12.411643
## 4:        15.504773        13.989209        16.815608        13.759461
## 5:         8.486341        11.660243        10.628865         9.623155
## 6:         8.478299         9.679802         9.438748         9.976310
##    TCGA-E2-A15P-01A TCGA-C8-A3M8-01A TCGA-LL-A5YO-01A TCGA-OL-A66L-01A
## 1:        13.701193        12.907175        12.481149        13.277421
## 2:        13.701746        12.897358        12.470865        13.267978
## 3:        13.709460        12.927019        12.471251        13.272368
## 4:        15.015832        12.829096        12.612155        12.882307
## 5:        11.848985        10.212533        11.066213        11.828703
## 6:         7.692336         8.131175         9.374284         8.202235
##    TCGA-OL-A66K-01A TCGA-E2-A1LG-01A TCGA-E2-A1LS-01A TCGA-A7-A426-01A
## 1:        12.891225        14.004544        13.201740        12.783663
## 2:        12.890943        14.005439        13.194221        12.754226
## 3:        12.885251        13.985451        13.191695        12.775441
## 4:        14.080216        14.370829        15.141007        13.640639
## 5:        11.321958         9.737599        12.250080        11.414379
## 6:         8.053083         9.102064         9.948551         6.966273
##    TCGA-BH-A0B7-01A TCGA-E2-A574-01A TCGA-D8-A27L-01A TCGA-AC-A2FF-01A
## 1:        12.212688         12.94527        14.234610        13.712358
## 2:        12.215591         12.93400        14.239405        13.715853
## 3:        12.212688         12.94954        14.238296        13.721368
## 4:        13.814649         13.38966        14.711308        15.059866
## 5:        12.435697         11.49223        11.863943        12.940280
## 6:         9.273605         10.00329         8.048387         8.330982
##    TCGA-GM-A2D9-01A TCGA-C8-A1HM-01A TCGA-A2-A0EM-01A TCGA-A8-A09A-01A
## 1:        14.961372        13.316973        13.517807        12.751667
## 2:        14.959733        13.302647        13.510865        12.721273
## 3:        14.957427        13.327581        13.519213        12.763774
## 4:        16.034837        14.656317        15.224578        14.093627
## 5:        11.767017         7.618331        11.360646        11.755327
## 6:         8.055426         9.976238         8.956312         9.466847
##    TCGA-E9-A1NA-11A TCGA-C8-A1HJ-01A TCGA-OL-A6VO-01A TCGA-BH-A0EI-01A
## 1:        13.546746         13.26445        13.584262        14.471074
## 2:        13.554419         13.26222        13.585145        14.480235
## 3:        13.552386         13.27237        13.591136        14.483763
## 4:        15.512574         14.40944        13.612603        15.763684
## 5:        13.291578         11.14886        10.081424        12.252290
## 6:         8.677614         10.69448         9.989783         8.888611
##    TCGA-A8-A093-01A TCGA-A8-A092-01A TCGA-AC-A3W6-01A TCGA-BH-A0BA-01A
## 1:        13.634667         12.51884        13.620816        13.108024
## 2:        13.629949         12.50660        13.611512        13.103591
## 3:        13.654992         12.54610        13.628293        13.106600
## 4:        15.765403         14.44521        14.851974        15.815955
## 5:        11.265741         10.85515        11.608899        11.477789
## 6:         9.026069          9.52549         7.800379         7.779014
##    TCGA-EW-A1OX-01A TCGA-A2-A0CR-01A TCGA-D8-A1JD-01A TCGA-C8-A26X-01A
## 1:        13.113044        12.775692        14.030839        13.451513
## 2:        13.086584        12.764369        14.031630        13.433871
## 3:        13.113388        12.767309        14.041307        13.436794
## 4:        15.876024        13.907148        14.326140        14.158529
## 5:         7.413315        11.377493        11.811101        10.384601
## 6:         7.878304         7.572892         9.540541         8.257061
##    TCGA-E9-A1RC-11A TCGA-EW-A1J3-01A TCGA-A7-A4SF-01A TCGA-E2-A10B-01A
## 1:        12.930168        14.694657        12.017234        13.614368
## 2:        12.926378        14.676687        12.006714        13.602062
## 3:        12.949005        14.686326        12.036470        13.608441
## 4:        13.791757        15.929883        12.143705        15.608130
## 5:        11.996313        11.228221         8.907110        11.351039
## 6:         9.707349         8.962082         8.295407         8.845929
##    TCGA-BH-A1FR-01A TCGA-AN-A0FW-01A TCGA-B6-A0WW-01A TCGA-HN-A2NL-01A
## 1:        14.164297        12.982319         12.35803         14.26736
## 2:        14.152015        12.971371         12.29208         14.26126
## 3:        14.177500        12.967450         12.34727         14.26909
## 4:        15.136246        14.277595         14.26204         14.91181
## 5:        10.242373        11.282029         10.06267         10.62230
## 6:         9.237632         8.900081          8.73588         10.37732
##    TCGA-A2-A04P-01A TCGA-BH-A0W3-01A TCGA-BH-A0B5-01A TCGA-PL-A8LX-01A
## 1:         13.14129        12.914847        13.330000        13.658846
## 2:         13.12191        12.875696        13.323383        13.662634
## 3:         13.14550        12.904551        13.330851        13.669342
## 4:         14.06291        14.165174        14.696882        14.773528
## 5:         12.68660         9.876171        11.374067         8.015789
## 6:         10.83885         9.044976         8.329552         8.229425
##    TCGA-BH-A0B0-01A TCGA-AC-A2FO-01A TCGA-AN-A0XN-01A TCGA-AN-A0XW-01A
## 1:        13.630255        14.002185        12.148376        12.102581
## 2:        13.629329        13.997961        12.129919        12.125942
## 3:        13.653011        14.020723        12.149547        12.135463
## 4:        15.919486        14.782724        13.604996        14.584273
## 5:        11.929949        12.810954        10.293738        11.038024
## 6:         9.317133         9.291779         9.644432         8.008306
##    TCGA-C8-A1HF-01A TCGA-AR-A2LO-01A TCGA-AC-A6IX-01A TCGA-A2-A25C-01A
## 1:        14.524318         13.95623        13.640213         12.87593
## 2:        14.512661         13.96209        13.638902         12.88223
## 3:        14.515377         13.96433        13.632930         12.92136
## 4:        15.655651         13.49220        13.501916         14.83404
## 5:        11.017125         11.86739        12.037706         11.53490
## 6:         9.851616          7.82945         8.299079         10.39720
##    TCGA-BH-A0AZ-01A TCGA-E9-A227-01A TCGA-A2-A0D2-01A TCGA-D8-A1XM-01A
## 1:        13.930229        13.606518         12.54827         13.39340
## 2:        13.933822        13.590978         12.55349         13.37194
## 3:        13.932453        13.608201         12.55306         13.38445
## 4:        15.157109        15.176852         13.47011         14.76673
## 5:        11.993766        10.590665         11.91049         11.44552
## 6:         8.568473         8.781391         10.43997          7.49432
##    TCGA-D8-A1Y3-01A TCGA-E2-A106-01A TCGA-E2-A3DX-01A TCGA-EW-A1PC-01B
## 1:        12.141936        14.023635        14.073529         12.39016
## 2:        12.139781        14.023680        14.070924         12.39263
## 3:        12.181789        14.036700        14.080663         12.43187
## 4:        12.444971        15.328531        15.278130         13.66119
## 5:         8.814255        11.094303        12.606156         10.20322
## 6:        10.294523         9.257971         7.511041         10.58231
##    TCGA-AR-A0TP-01A TCGA-A7-A26F-01B TCGA-A2-A1FW-01A TCGA-E2-A15A-06A
## 1:         13.05571        13.017584        14.918506        13.578121
## 2:         13.05590        13.011791        14.920253        13.562071
## 3:         13.07136        13.026726        14.927070        13.566793
## 4:         16.16380        13.758301        15.775380        14.507897
## 5:         10.79391        10.917846        10.929388         8.706003
## 6:         10.07698         9.288283         9.126074         9.426711
##    TCGA-E9-A1R5-01A TCGA-A2-A0T2-01A TCGA-A7-A26H-01A TCGA-GM-A2DC-01A
## 1:        13.082830        12.169760        13.130672         14.65905
## 2:        13.085936        12.139766        13.103418         14.65744
## 3:        13.062749        12.194255        13.125720         14.66809
## 4:        14.110589        14.156666        14.678210         15.99782
## 5:        10.872449        12.615714        10.653397         11.42947
## 6:         9.267644         9.681468         7.334316          8.32910
##    TCGA-A8-A09G-01A TCGA-AO-A0J9-01A TCGA-E2-A14Y-01A TCGA-3C-AALI-01A
## 1:        11.664092        12.728368        13.295752        13.328474
## 2:        11.587871        12.731517        13.305842        13.330931
## 3:        11.675947        12.746731        13.321482        13.339006
## 4:        13.617432        14.755090        14.396290        14.510022
## 5:        10.804690        11.383231        10.536768         9.554742
## 6:         7.906143         8.867166         9.539331         9.018468
##    TCGA-S3-A6ZH-01A TCGA-E2-A159-01A TCGA-E2-A155-01A TCGA-A8-A082-01A
## 1:         14.36292         11.84768        13.934445        13.109901
## 2:         14.36995         11.84751        13.934515        13.113202
## 3:         14.37337         11.92104        13.950362        13.107947
## 4:         14.23745         13.61082        14.871314        15.445662
## 5:         10.75464         10.76011         8.835315         9.404200
## 6:          7.89732         10.68106         9.692131         9.721382
##    TCGA-E2-A14R-01A TCGA-D8-A141-01A TCGA-BH-A204-01A TCGA-E2-A109-01A
## 1:        13.942001        13.919628        13.684360        14.150834
## 2:        13.924222        13.915397        13.680539        14.151537
## 3:        13.968972        13.928243        13.691792        14.142807
## 4:        15.434634        15.243297        14.439010        15.782111
## 5:         7.958480        11.352586         8.271554        10.506790
## 6:         9.868567         9.406495        10.087503         9.446037
##    TCGA-A2-A0T7-01A TCGA-D8-A1XT-01A TCGA-D8-A146-01A TCGA-A2-A3XY-01A
## 1:        13.041015         12.46438        12.815167        13.371947
## 2:        13.039586         12.46356        12.816051        13.378506
## 3:        13.066887         12.48414        12.855016        13.385204
## 4:        14.650907         13.60595        14.730158        14.314193
## 5:        11.880349         10.52877        11.169628        11.432751
## 6:         8.165118         10.25811         8.859833         8.612537
##    TCGA-BH-A1ES-01A TCGA-A2-A0YK-01A TCGA-E9-A22H-01A TCGA-AR-A1AQ-01A
## 1:        13.726576        12.956137         13.07254         12.76484
## 2:        13.720052        12.970334         13.06450         12.67812
## 3:        13.735841        12.947552         13.09806         12.72488
## 4:        15.082566        14.887154         15.35407         14.21373
## 5:        10.903483        11.895842         10.00491         11.29882
## 6:         9.592845         7.792211         10.02382         10.22534
##    TCGA-E2-A1L8-01A TCGA-BH-A0B8-01A TCGA-JL-A3YX-01A TCGA-S3-AA17-01A
## 1:        14.424665        14.096226        12.911220        13.774387
## 2:        14.414859        14.093793        12.907652        13.759162
## 3:        14.429674        14.093903        12.917171        13.768827
## 4:        15.246999        13.222903        14.160393        13.367552
## 5:        11.186317        10.199748        11.246271         8.777142
## 6:         9.415028         7.510917         7.939297         8.888088
##    TCGA-BH-A0B5-11A TCGA-E2-A15M-01A TCGA-AN-A0AT-01A TCGA-A7-A0CH-01A
## 1:        13.580761        13.102478        13.449615        13.742649
## 2:        13.582150        13.095546        13.448541        13.725169
## 3:        13.599177        13.100015        13.462793        13.751095
## 4:        14.135999        13.846049        13.789318        15.905762
## 5:        12.345211        11.006828         9.829854        11.034815
## 6:         9.385188         8.898325        10.497104         9.133794
##    TCGA-AR-A0TZ-01A TCGA-E2-A15I-01A TCGA-BH-A0B4-01A TCGA-E2-A15K-06A
## 1:        12.471335        14.056884        12.414886        14.111930
## 2:        12.454346        14.052668        12.397643        14.102912
## 3:        12.471437        14.066863        12.458484        14.114479
## 4:        13.975531        14.696520        13.959043        15.732238
## 5:        10.094764        10.912193        11.370784         7.222202
## 6:         8.845348         8.711179         9.605159         8.844854
##    TCGA-BH-A0WA-01A TCGA-A2-A0ET-01A TCGA-OL-A5RW-01A TCGA-A7-A13D-01B
## 1:         12.64410        13.048863         12.75025         12.88024
## 2:         12.64640        13.024759         12.76511         12.89301
## 3:         12.66327        13.024215         12.77422         12.90216
## 4:         14.67630        14.665689         14.11684         15.17417
## 5:         10.54065         8.400456         10.26477         10.54849
## 6:         10.01836         8.709598         10.60611         10.31325
##    TCGA-A2-A0CQ-01A TCGA-AN-A0FD-01A TCGA-BH-A0H7-01A TCGA-A2-A0YL-01A
## 1:        13.591946        12.535594        13.277746         12.51709
## 2:        13.569417        12.500496        13.268221         12.49481
## 3:        13.631521        12.531037        13.289990         12.52027
## 4:        16.013266        13.831362        15.671155         15.00219
## 5:        10.099255        10.764181        11.799848         11.21713
## 6:         9.703878         8.740945         9.690492          7.82705
##    TCGA-A2-A0D0-01A TCGA-AO-A0JC-01A TCGA-BH-A1EW-01A TCGA-AO-A03M-01B
## 1:         12.95937         13.49900        14.013743        13.332648
## 2:         12.94346         13.48283        14.016938        13.305551
## 3:         12.95443         13.49860        14.031051        13.331194
## 4:         15.78721         15.67966        14.490317        14.619672
## 5:         10.25190         10.21429        12.172356        10.642940
## 6:         10.85337          9.52436         7.953629         9.218713
##    TCGA-B6-A0RP-01A TCGA-EW-A6SC-01A TCGA-BH-A0AZ-11A TCGA-BH-A18I-01A
## 1:        12.659803         13.54700        14.571132        14.109883
## 2:        12.657997         13.54782        14.561327        14.124790
## 3:        12.652889         13.54975        14.582439        14.118747
## 4:        15.265488         14.29676        15.450838        15.290829
## 5:        10.784790         11.30312        13.414504        11.548819
## 6:         8.758152          8.52496         9.452148         8.814396
##    TCGA-E2-A1LK-01A TCGA-A2-A0CU-01A TCGA-E2-A14N-01A TCGA-A8-A07L-01A
## 1:        13.023517        12.982559        13.477703         12.70700
## 2:        13.033752        12.947125        13.460950         12.67054
## 3:        13.052376        12.992206        13.477650         12.72968
## 4:        14.901603        14.237693        14.657884         14.10263
## 5:        12.498390        10.845684        12.220040         11.37162
## 6:         9.870289         9.056997         9.987353         10.46700
##    TCGA-GM-A3XN-01A TCGA-E9-A1NG-11A TCGA-BH-A6R9-01A TCGA-EW-A1PG-01A
## 1:        13.246541         12.76887        13.306450        13.153867
## 2:        13.248330         12.77287        13.300545        13.172824
## 3:        13.256064         12.78901        13.293538        13.182828
## 4:        14.705808         14.09385        13.943469        14.820839
## 5:        11.917525         12.08212        10.971304        12.032788
## 6:         8.392955          9.47687         8.367121         8.399314
##    TCGA-AN-A03Y-01A TCGA-BH-A0DL-11A TCGA-B6-A0RT-01A TCGA-A2-A25D-01A
## 1:        13.784092        13.989158        12.688225        13.324952
## 2:        13.776785        13.987579        12.638333        13.314621
## 3:        13.775438        13.983227        12.655713        13.332015
## 4:        15.013005        15.059806        14.995996        13.575962
## 5:         9.884812        13.167580        11.611232        10.640959
## 6:         9.145111         8.631297         9.519322         9.015284
##    TCGA-A7-A56D-01A TCGA-D8-A73W-01A TCGA-GM-A3NY-01A TCGA-AO-A0J5-01A
## 1:         12.54432        13.288748         13.25029        13.222696
## 2:         12.54632        13.295314         13.24008        13.220689
## 3:         12.55277        13.296448         13.26530        13.223491
## 4:         13.38870        14.939913         14.99788        15.584460
## 5:         10.55049         8.911975         11.26769        12.298663
## 6:          8.12231         8.358710          8.91063         8.660888
##    TCGA-E9-A1R7-11A TCGA-D8-A27V-01A TCGA-AC-A3OD-01B TCGA-A7-A0CJ-01A
## 1:        12.516933        13.859356        13.890313        11.498031
## 2:        12.523587        13.860749        13.879163        11.478686
## 3:        12.562456        13.862029        13.888528        11.508266
## 4:        14.273581        15.727570        14.398904        13.747186
## 5:        12.255070        11.232498        11.078312        10.979834
## 6:         9.524247         9.348216         9.948172         9.631936
##    TCGA-A8-A07U-01A TCGA-D8-A1XS-01A TCGA-B6-A0IP-01A TCGA-LL-A5YM-01A
## 1:         12.33580        13.280317        13.164728        12.824364
## 2:         12.33787        13.276939        13.171852        12.820979
## 3:         12.38153        13.298556        13.179930        12.834921
## 4:         13.44882        14.219745        16.036739        13.482611
## 5:         11.31144         9.985929        11.185896         9.761861
## 6:          8.69395         8.720472         8.508522         8.676695
##    TCGA-E2-A15E-01A TCGA-D8-A27G-01A TCGA-BH-A1EX-01A TCGA-A2-A0EX-01A
## 1:        13.630036        14.029787        13.821782         12.85666
## 2:        13.633115        14.034716        13.811983         12.85688
## 3:        13.650106        14.032310        13.830844         12.86352
## 4:        14.339155        15.096121        13.913373         14.29410
## 5:        11.702283        11.970727        10.284172         12.38878
## 6:         8.335996         8.671571         9.270978          8.55708
##    TCGA-A7-A4SB-01A TCGA-EW-A1OV-01A TCGA-AN-A0FV-01A TCGA-A2-A4S3-01A
## 1:        13.736627        12.211597         12.84791        11.832549
## 2:        13.724427        12.213697         12.85707        11.776863
## 3:        13.739222        12.264513         12.84497        11.846409
## 4:        13.612309        12.232095         13.39615        11.860493
## 5:        10.112816         9.095980         10.48749         9.900482
## 6:         6.584379         8.227445          8.49426         8.156900
##    TCGA-BH-A1FB-11A TCGA-E9-A5FL-01A TCGA-D8-A73U-01A TCGA-A7-A0D9-11A
## 1:        13.488442        12.427334         13.27583        12.701710
## 2:        13.465576        12.439649         13.27823        12.713454
## 3:        13.487740        12.430015         13.27990        12.705891
## 4:        14.994825        12.972102         14.36702        15.347089
## 5:        12.715388        11.328248         11.07080        12.531233
## 6:         8.839997         8.349513          7.62425         9.499096
##    TCGA-A1-A0SK-01A TCGA-BH-A0BJ-01A TCGA-D8-A1XY-01A TCGA-LL-A8F5-01A
## 1:        12.207688        12.734550        13.502197        13.895238
## 2:        12.228700        12.737233        13.484629        13.900685
## 3:        12.232114        12.716534        13.507668        13.891580
## 4:        14.494925        15.171300        14.230057        15.356343
## 5:         9.579606        11.643696        11.868438        10.892767
## 6:        10.404319         7.980779         9.411769         8.548221
##    TCGA-E9-A1R6-01A TCGA-BH-A1FL-01A TCGA-BH-A18S-11A TCGA-B6-A40B-01A
## 1:        12.955923        14.592438         13.60330        13.285408
## 2:        12.941267        14.608445         13.60418        13.288811
## 3:        12.958738        14.592335         13.60768        13.285371
## 4:        14.098811        15.429900         14.86647        13.336451
## 5:         9.798884        10.367456         12.71973        11.432831
## 6:         8.607250         9.069078          8.49258         8.974531
##    TCGA-E9-A1RE-01A TCGA-D8-A3Z5-01A TCGA-C8-A12Q-01A TCGA-D8-A145-01A
## 1:         12.95249         13.42748        13.346962        13.502586
## 2:         12.95153         13.42190        13.344979        13.503075
## 3:         12.95829         13.44508        13.357784        13.513735
## 4:         12.95960         14.42150        15.550217        14.391404
## 5:          9.54960         11.28766        11.059002        12.925516
## 6:         10.08460          8.92027         8.901746         8.367268
##    TCGA-A8-A09Q-01A TCGA-C8-A1HE-01A TCGA-A1-A0SE-01A TCGA-GI-A2C8-01A
## 1:        13.035504        14.707440        13.034042        13.465105
## 2:        13.016939        14.699309        13.017645        13.461134
## 3:        13.024365        14.719003        13.036697        13.466442
## 4:        14.308665        15.787822        15.423974        13.589855
## 5:         8.997503        10.796558        12.028745        11.693725
## 6:         9.077275         9.238622         8.700684         8.546165
##    TCGA-B6-A0X7-01A TCGA-A8-A0A7-01A TCGA-BH-A18G-01A TCGA-BH-A0H6-01A
## 1:        12.870978        12.336651         13.67375        13.281246
## 2:        12.873687        12.343496         13.64997        13.273334
## 3:        12.894158        12.320642         13.68917        13.312243
## 4:        13.501602        14.108755         14.86850        15.462941
## 5:         8.400527        11.850731         11.70324        11.488474
## 6:         9.089674         8.777849         10.25265         9.093434
##    TCGA-A2-A0CM-01A TCGA-AR-A0U2-01A TCGA-OL-A66O-01A TCGA-E9-A228-01A
## 1:         12.53809        12.945815        13.771388        12.485145
## 2:         12.51701        12.911442        13.756606        12.458159
## 3:         12.53435        12.956945        13.762032        12.469936
## 4:         13.41842        12.727841        15.193989        12.990127
## 5:         10.09035         9.979619        11.285402         8.793568
## 6:         10.33711         7.755479         8.738783        10.193660
##    TCGA-A8-A09M-01A TCGA-A2-A3KC-01A TCGA-AQ-A7U7-01A TCGA-AO-A1KS-01A
## 1:        12.337736        14.147188        12.595282         12.72840
## 2:        12.359940        14.140622        12.596542         12.72821
## 3:        12.370644        14.146798        12.609535         12.74749
## 4:        14.281523        14.093459        13.483368         13.73213
## 5:         9.018314        11.889960        11.299802         10.08886
## 6:         9.783789         7.866959         8.607579          9.12951
##    TCGA-D8-A1XB-01A TCGA-C8-A26Y-01A TCGA-E2-A1LS-11A TCGA-E2-A1LB-11A
## 1:        13.121688        13.154465        12.927044        13.379680
## 2:        13.109005        13.159452        12.923221        13.373592
## 3:        13.136025        13.158558        12.928439        13.388713
## 4:        14.916531        13.434475        14.129129        15.319732
## 5:        11.517789        10.451220        12.156193        12.957703
## 6:         8.779835         9.597529         7.769497         9.345789
##    TCGA-C8-A12W-01A TCGA-AR-A24L-01A TCGA-BH-A0BC-01A TCGA-A8-A06O-01A
## 1:        13.567804        13.116718        12.735827        12.813228
## 2:        13.568467        13.116598        12.712864        12.818173
## 3:        13.585353        13.090030        12.708038        12.863523
## 4:        14.390363        13.993979        14.461251        14.523995
## 5:        11.051647        11.263400        11.333199        10.354203
## 6:         8.924479         8.927246         8.828679         8.898059
##    TCGA-C8-A12Z-01A TCGA-A8-A09X-01A TCGA-AC-A8OP-01A TCGA-E9-A22G-01A
## 1:        12.873887        12.183710        12.989382         13.00803
## 2:        12.861498        12.221741        12.994395         13.00772
## 3:        12.885668        12.183710        12.998233         13.00561
## 4:        14.074545        13.620895        12.559363         14.56741
## 5:        10.744450        11.075458        10.698376         10.52200
## 6:         9.060229         9.715027         7.260366         10.46352
##    TCGA-GM-A5PX-01A TCGA-A2-A4RX-01A TCGA-BH-A0HK-11A TCGA-D8-A1JC-01A
## 1:        13.483729        13.021533        13.096136        12.254231
## 2:        13.475695        13.042635        13.090982        12.250531
## 3:        13.484413        13.021209        13.101035        12.290232
## 4:        14.662274        14.204623        15.996065        13.355324
## 5:        11.196338        10.414062        13.031217        10.892230
## 6:         7.217513         8.818536         8.092294         9.732871
##    TCGA-A8-A07R-01A TCGA-BH-A204-11A TCGA-AR-A24U-01A TCGA-B6-A0X0-01A
## 1:         12.95289         12.41774        13.036046         13.52205
## 2:         12.93139         12.42471        13.015154         13.51717
## 3:         12.96490         12.44775        13.016251         13.53230
## 4:         14.27663         13.48222        14.076303         16.04452
## 5:         11.32172         11.84343        10.607031         10.76594
## 6:         10.88390          9.26895         9.135807          8.94274
##    TCGA-BH-A0C7-01B TCGA-BH-A0EA-01A TCGA-GM-A3NW-01A TCGA-BH-A0HA-11A
## 1:        13.168932        13.937630        14.256316        14.963895
## 2:        13.178437        13.917721        14.254487        14.967838
## 3:        13.195547        13.901209        14.263626        14.962892
## 4:        15.019680        16.152357        15.230438        15.862450
## 5:        11.202959        12.068566        11.322943        13.613759
## 6:         9.077134         8.959489         7.741428         9.096247
##    TCGA-A1-A0SQ-01A TCGA-A8-A09N-01A TCGA-AC-A3QQ-01B TCGA-E2-A1BC-11A
## 1:        14.279784        13.052540        13.946470        14.006395
## 2:        14.276728        13.007222        13.943662        13.999507
## 3:        14.284973        13.064023        13.957890        14.005691
## 4:        17.168295        14.866579        14.965163        14.611237
## 5:         9.709766        10.768265        11.377161        12.094438
## 6:         9.222535         9.295261         8.669771         9.171299
##    TCGA-BH-A18V-06A TCGA-AC-A2BM-01A TCGA-E2-A14V-01A TCGA-C8-A27A-01A
## 1:         13.44579        13.828102        13.209697        13.290378
## 2:         13.45327        13.823440        13.189024        13.288303
## 3:         13.46078        13.825988        13.188740        13.298438
## 4:         14.61023        15.524300        14.686617        14.257445
## 5:          8.82221        10.667818        11.882436        10.355304
## 6:         10.44413         8.391946         8.504099         9.901764
##    TCGA-E9-A1R4-01A TCGA-D8-A1JB-01A TCGA-C8-A12V-01A TCGA-AC-A2FE-01A
## 1:        12.820685        13.914880        12.668314        14.192773
## 2:        12.819201        13.904248        12.673089        14.192190
## 3:        12.846248        13.909609        12.684172        14.197146
## 4:        13.016559        14.630746        14.089289        14.453694
## 5:         9.929362        12.022134        11.098500        12.388308
## 6:         9.434763         9.044828         9.753274         8.577786
##    TCGA-D8-A1Y0-01A TCGA-C8-A275-01A TCGA-S3-AA10-01A TCGA-B6-A1KF-01A
## 1:        12.626941         13.82915        13.027489         12.56584
## 2:        12.633297         13.81949        13.005047         12.55507
## 3:        12.637895         13.84005        13.004066         12.55528
## 4:        13.355021         13.94576        13.511644         14.04399
## 5:        10.919452         11.06717         8.778163         14.01730
## 6:         9.941817         10.05755         9.159615         10.20979
##    TCGA-AO-A0J7-01A TCGA-EW-A2FV-01A TCGA-AR-A252-01A TCGA-AN-A0XR-01A
## 1:        10.776701        13.402645        13.253485        12.845367
## 2:        10.735572        13.398867        13.253530        12.832051
## 3:        10.791742        13.406202        13.252091        12.826238
## 4:        11.970708        14.846888        14.719261        14.953465
## 5:         9.460805        11.245983        11.390377         9.262793
## 6:         7.606482         9.154845         9.271455         9.391754
##    TCGA-E2-A14X-01A TCGA-BH-A1FR-11B TCGA-BH-A0W7-01A TCGA-AC-A2B8-01A
## 1:        13.412834        12.757841        13.935082        13.657467
## 2:        13.409076        12.754174        13.918664        13.650841
## 3:        13.417069        12.796061        13.918087        13.658898
## 4:        14.456838        14.245138        14.938727        14.825189
## 5:        11.385978        12.521544        11.412789        11.924518
## 6:         9.618836         8.542588         9.139387         9.043512
##    TCGA-AO-A0JL-01A TCGA-BH-A0BZ-01A TCGA-D8-A27W-01A TCGA-B6-A0RO-01A
## 1:         13.00053        14.272364        14.157133        13.015850
## 2:         12.96240        14.278874        14.160705        13.019852
## 3:         13.01110        14.278148        14.169120        13.038037
## 4:         15.70162        15.209070        15.207417        15.881879
## 5:         13.02462        13.520610        10.709716        11.681996
## 6:         10.00977         8.859343         8.668552         8.454274
##    TCGA-BH-A0DE-01A TCGA-BH-A202-01A TCGA-B6-A0X5-01A TCGA-BH-A18R-01A
## 1:         13.37796        13.063099        12.771435        12.882460
## 2:         13.37491        13.044810        12.789096        12.907580
## 3:         13.37626        13.071905        12.790026        12.892281
## 4:         14.36719        13.755212        14.249296        13.265901
## 5:         11.96469        10.475284         9.105304        11.206371
## 6:          8.92356         9.799212         8.882850         9.114889
##    TCGA-BH-A18U-11A TCGA-B6-A0RV-01A TCGA-AC-A7VB-01A TCGA-D8-A27P-01A
## 1:         14.18017        12.937023        12.607886        15.273235
## 2:         14.17021        12.946350        12.610023        15.274152
## 3:         14.19905        12.932336        12.618099        15.280485
## 4:         15.44608        15.523106        12.916162        16.147728
## 5:         10.55473        12.479209         9.020026        11.649124
## 6:          8.88074         8.812216         9.586923         8.041102
##    TCGA-E9-A3X8-01A TCGA-BH-A0E1-11A TCGA-BH-A42T-01A TCGA-AN-A046-01A
## 1:        13.576946        13.561373        12.987381         13.48352
## 2:        13.579177        13.577343        12.997442         13.46005
## 3:        13.582783        13.563278        13.016911         13.47263
## 4:        14.108345        16.077596        13.289858         15.20854
## 5:        12.475068        13.468628         9.657322         10.67375
## 6:         7.357619         8.870266         7.897884          9.41417
##    TCGA-A2-A0SX-01A TCGA-BH-A0AY-01A TCGA-A8-A06N-01A TCGA-BH-A8G0-01A
## 1:        12.463077        12.689563        13.474321        13.375502
## 2:        12.413678        12.682208        13.474521        13.378768
## 3:        12.447350        12.715649        13.471325        13.390684
## 4:        14.599733        14.500784        15.126750        14.335890
## 5:        11.450316        11.342134         8.293360        12.084050
## 6:         9.710141         8.738602         7.741677         7.547264
##    TCGA-BH-A0HP-01A TCGA-BH-A18U-01A TCGA-AN-A0AS-01A TCGA-BH-A1F2-01A
## 1:        12.961002        12.995628        12.605508        13.409573
## 2:        12.931068        12.950426        12.604235        13.401344
## 3:        12.978669        13.018949        12.616442        13.393067
## 4:        14.729015        13.322818        14.831977        14.332265
## 5:        11.554634        10.130421        10.220014        11.422410
## 6:         8.362103         8.932779         9.286129         9.116818
##    TCGA-BH-A18M-01A TCGA-C8-A12L-01A TCGA-AC-A6IX-06A TCGA-BH-A1FH-01A
## 1:        13.883975        12.836714        14.038365        12.472690
## 2:        13.880696        12.830429        14.037955        12.468557
## 3:        13.895214        12.874713        14.047831        12.480335
## 4:        14.867253        14.637015        13.842313        14.105128
## 5:        12.638982         8.776675        11.370614        12.168240
## 6:         8.736262        10.109039         8.223862         7.560981
##    TCGA-AR-A24V-01A TCGA-AC-A62Y-01A TCGA-D8-A1JH-01A TCGA-AN-A0XU-01A
## 1:         13.48623        12.900251        14.261617        12.321286
## 2:         13.50386        12.890235        14.261472        12.344844
## 3:         13.49264        12.907197        14.270446        12.368024
## 4:         14.93510        14.195869        15.002662        14.479769
## 5:         11.58227         9.904800        12.239267        11.233442
## 6:          8.92380         8.839497         9.097817         9.108846
##    TCGA-BH-A0BL-01A TCGA-EW-A1P6-01A TCGA-AC-A2BK-01A TCGA-AO-A0JI-01A
## 1:        13.201623        11.778243         13.33742        14.104916
## 2:        13.177033        11.752416         13.31859        14.084258
## 3:        13.200953        11.797216         13.33680        14.099369
## 4:        14.370288        12.519487         13.81377        16.104103
## 5:        12.033654        10.692053         10.71952        11.792773
## 6:         9.225931         9.254466         10.51690         8.467168
##    TCGA-E9-A1RD-11A TCGA-B6-A0IA-01A TCGA-E2-A1L7-01A TCGA-BH-A18F-01A
## 1:        12.757376         13.91473        13.423510        13.830421
## 2:        12.741633         13.91871        13.417664        13.819447
## 3:        12.757664         13.93372        13.442373        13.822218
## 4:        14.478669         16.53235        13.166270        14.880344
## 5:        12.276278         11.11587         9.756577        11.959279
## 6:         7.507533          9.80853         8.870116         9.619121
##    TCGA-C8-A1HI-01A TCGA-BH-A0BD-01A TCGA-A8-A06U-01A TCGA-BH-A0E7-01A
## 1:        13.263951        13.217563        13.277470        13.245597
## 2:        13.247779        13.202479        13.259307        13.241255
## 3:        13.270085        13.203934        13.285520        13.266399
## 4:        13.844852        14.896743        15.359792        15.383978
## 5:        10.904361        10.736826         9.387031         9.245176
## 6:         9.067461         8.786298        10.143182         8.687482
##    TCGA-A8-A08S-01A TCGA-C8-A278-01A TCGA-B6-A0IK-01A TCGA-C8-A1HO-01A
## 1:        13.824996        12.086621        12.420987        14.631899
## 2:        13.824895        12.095754        12.427166        14.636048
## 3:        13.858617        12.112032        12.442113        14.637007
## 4:        15.740360        12.898917        14.452730        15.842601
## 5:        10.013461         9.855557        11.108320        11.662569
## 6:         9.671849        10.085262         8.086735         9.994387
##    TCGA-E9-A1NF-01A TCGA-AO-A0J6-01A TCGA-A2-A04Q-01A TCGA-BH-A0DI-01A
## 1:        13.075359         12.14818         12.21325        13.057017
## 2:        13.093942         12.11059         12.22277        13.060908
## 3:        13.090401         12.15842         12.27319        13.074532
## 4:        14.484564         13.38729         13.71374        14.499333
## 5:        11.029622         13.06485         11.42536        11.973194
## 6:         9.611744         10.96342          9.81930         8.754721
##    TCGA-BH-A1FJ-01A TCGA-UU-A93S-01A TCGA-EW-A2FW-01A TCGA-BH-A209-01A
## 1:        13.676702        13.229199        14.528327        11.828316
## 2:        13.658875        13.225125        14.524084        11.810673
## 3:        13.656645        13.237178        14.541751        11.843145
## 4:        15.774433        13.484910        16.541848        12.700770
## 5:         8.958327        10.803536        10.814601         8.662327
## 6:         9.102923         8.396688         9.562134        10.537872
##    TCGA-OL-A5S0-01A TCGA-E2-A15D-01A TCGA-D8-A27H-01A TCGA-AC-A3QQ-01A
## 1:        13.084340        13.285355        14.788441        13.221580
## 2:        13.072849        13.275700        14.789034        13.214731
## 3:        13.089191        13.304198        14.790594        13.219259
## 4:        12.770475        15.533047        15.931267        14.995451
## 5:        10.733563        11.842709        10.816813        11.311622
## 6:         7.853987         9.196204         9.931605         7.692323
##    TCGA-BH-A1F6-01A TCGA-A1-A0SD-01A TCGA-A7-A26J-01B TCGA-AO-A03V-01A
## 1:         12.13011        14.030390         13.28825        13.728848
## 2:         12.11340        14.018248         13.28547        13.721129
## 3:         12.13631        14.024003         13.29508        13.739947
## 4:         12.61666        15.632852         14.66176        15.934877
## 5:         10.08659        11.397605         11.81250        11.180289
## 6:          9.47147         9.059588         10.25138         8.529958
##    TCGA-AQ-A04J-01A TCGA-S3-AA0Z-01A TCGA-E2-A15O-01A TCGA-BH-A0HO-01A
## 1:        12.794353        14.210528        13.717650        13.218905
## 2:        12.764668        14.201817        13.721800        13.216753
## 3:        12.780446        14.209879        13.726457        13.217291
## 4:        14.020666        14.525064        14.371569        15.778253
## 5:        11.670529        11.818962         8.858466        10.209790
## 6:         9.721993         9.652188         9.194468         9.682158
##    TCGA-A7-A6VW-01A TCGA-BH-A0HY-01A TCGA-3C-AALJ-01A TCGA-BH-AB28-01A
## 1:        12.663305        13.023462        13.432159        13.456296
## 2:        12.673834        13.010179        13.418758        13.458328
## 3:        12.666229        12.999593        13.441694        13.469608
## 4:        13.134171        15.534289        13.415155        14.203923
## 5:        11.237602        11.402137         9.243957        10.810044
## 6:         9.546438         9.318697         9.297123         8.054497
##    TCGA-EW-A1PH-01A TCGA-A8-A08H-01A TCGA-B6-A0WV-01A TCGA-D8-A1XF-01A
## 1:        12.062745        12.418652        12.786322        14.107815
## 2:        12.000652        12.464290        12.783056        14.093958
## 3:        12.077225        12.454850        12.817519        14.115274
## 4:        12.986857        14.780600        14.852329        15.980184
## 5:        12.402134        12.113066        11.157054         9.873023
## 6:         8.524387         8.666898         8.799655         9.850204
##    TCGA-BH-A0BQ-01A TCGA-E9-A1RF-11A TCGA-E2-A158-01A TCGA-A8-A08I-01A
## 1:        13.959263         12.96180         13.26039        12.233362
## 2:        13.959991         12.94106         13.26761        12.228253
## 3:        13.978181         12.96983         13.26856        12.263205
## 4:        15.205448         14.18560         13.56519        14.634447
## 5:        11.664756         12.07709         11.19572         8.221153
## 6:         8.777786          9.47241         11.12355         9.276949
##    TCGA-B6-A0X4-01A TCGA-E9-A2JS-01A TCGA-A8-A096-01A TCGA-A7-A26G-01A
## 1:        13.140011        12.399968        13.242357        12.956023
## 2:        13.153704        12.393816        13.240086        12.970523
## 3:        13.163992        12.406842        13.272405        12.987258
## 4:        15.434898        12.929330        15.535267        14.464410
## 5:         8.774610         9.621239        10.304489        11.773059
## 6:         8.858083         9.547154         9.098516         9.682699
##    TCGA-BH-A1F6-11B TCGA-B6-A0WY-01A TCGA-A8-A084-01A TCGA-E2-A15I-11A
## 1:        13.414782        12.857914        13.277653        14.222169
## 2:        13.429123        12.830296        13.256867        14.235060
## 3:        13.448405        12.868304        13.298384        14.245196
## 4:        14.337362        14.386545        15.989587        14.695525
## 5:        12.794788        11.937145         9.861389        12.904018
## 6:         8.185738         8.882822         9.239141         9.600375
##    TCGA-BH-A1ES-06A TCGA-EW-A1OW-01A TCGA-D8-A1XD-01A TCGA-E9-A54X-01A
## 1:        12.555551        13.375963        12.878778        12.943539
## 2:        12.562053        13.377485        12.867523        12.940343
## 3:        12.577954        13.384566        12.871591        12.978906
## 4:        13.158707        14.279612        14.230154        13.821683
## 5:        10.205919        10.939543        11.006952         8.835254
## 6:         8.512659         8.664414         8.967775         8.756444
##    TCGA-B6-A0RG-01A TCGA-A8-A097-01A TCGA-BH-A1FH-11B TCGA-E9-A5FK-01A
## 1:        13.961201        12.252461        13.861788        12.933891
## 2:        13.939437        12.243226        13.875593        12.935741
## 3:        13.975208        12.259382        13.861329        12.941029
## 4:        16.620499        13.354114        15.040771        13.174772
## 5:        10.845930        10.841069        13.253430        11.283470
## 6:         9.129962         8.034884         8.363628         7.402442
##    TCGA-BH-A1FG-11B TCGA-C8-A8HQ-01A TCGA-A8-A08G-01A TCGA-BH-A0BP-01A
## 1:        13.105139        14.358163         13.60897        13.422617
## 2:        13.103612        14.346089         13.62365        13.420739
## 3:        13.093073        14.355620         13.64001        13.427327
## 4:        14.730305        14.966588         16.15021        15.648392
## 5:        12.470541        10.402739         10.50391        11.802645
## 6:         8.591297         8.435742          9.41157         8.920004
##    TCGA-B6-A0RL-01A TCGA-A2-A0CK-01A TCGA-B6-A0IE-01A TCGA-E9-A1N4-01A
## 1:        12.673175        13.911277        12.260135        13.421358
## 2:        12.672229        13.907863        12.251233        13.408204
## 3:        12.704856        13.922364        12.280251        13.411559
## 4:        14.344549        15.487500        14.365437        15.112097
## 5:         9.870094        11.525336        11.251044        10.178313
## 6:         9.900298         8.073096         9.490416         6.327666
##    TCGA-D8-A1XZ-01A TCGA-OL-A66J-01A TCGA-BH-A18N-11A TCGA-EW-A424-01A
## 1:         13.59564         13.72025         13.46748         12.89170
## 2:         13.60137         13.71636         13.45850         12.87153
## 3:         13.59964         13.74926         13.47792         12.88557
## 4:         14.79074         14.52389         14.77410         13.50187
## 5:         10.06522         11.71113         12.78484         11.04354
## 6:         10.25036          8.98484          8.35435          7.45831
##    TCGA-E9-A1R7-01A TCGA-AR-A24H-01A TCGA-A8-A06T-01A TCGA-C8-A1HL-01A
## 1:        13.398646        12.142466        12.373427        13.628186
## 2:        13.389031        12.107441        12.349951        13.605865
## 3:        13.401992        12.183483        12.337405        13.621474
## 4:        13.724905        11.928640        14.513071        13.950526
## 5:        10.919537         7.736336        10.031425         9.172744
## 6:         9.255936         8.997564         8.967457         9.499438
##    TCGA-D8-A1X8-01A TCGA-BH-A0DG-11A TCGA-AN-A0FK-01A TCGA-B6-A0RQ-01A
## 1:        13.949336        14.305583        13.553221        13.943808
## 2:        13.941549        14.308860        13.526349        13.928122
## 3:        13.951631        14.319184        13.577891        13.944171
## 4:        15.611733        15.277717        14.556945        15.252604
## 5:        11.416407        13.199967        10.261945        12.754273
## 6:         7.135807         8.527103         9.286961         8.125118
##    TCGA-D8-A13Z-01A TCGA-OL-A5D6-01A TCGA-A8-A091-01A TCGA-AC-A5EI-01A
## 1:        13.061186        12.924377        13.633534        13.797701
## 2:        13.060072        12.909429        13.618589        13.815640
## 3:        13.066530        12.919656        13.648783        13.814947
## 4:        14.216673        13.459285        16.317768        14.806694
## 5:        11.141529        10.758428        10.392420        13.325673
## 6:         9.591317         8.332616         8.711292         9.626271
##    TCGA-A7-A4SE-01A TCGA-E2-A15L-01A TCGA-BH-A1F2-11A TCGA-E9-A1ND-11A
## 1:        12.554697        13.580108        13.105822        13.796563
## 2:        12.538052        13.566287        13.101605        13.790122
## 3:        12.588647        13.580830        13.121028        13.809875
## 4:        13.811092        15.649050        14.323886        15.584919
## 5:        11.126234        10.284644        12.638113        13.357957
## 6:         9.213231         8.739493         8.260015         9.766868
##    TCGA-C8-A26Z-01A TCGA-C8-A12Y-01A TCGA-A7-A13F-01A TCGA-BH-A28Q-01A
## 1:        13.926944        13.540228        14.245473        14.877213
## 2:        13.907825        13.549338        14.240205        14.876641
## 3:        13.906943        13.588523        14.248909        14.875347
## 4:        15.031341        14.473952        15.290727        15.671479
## 5:        10.595126        10.212216        10.216882        11.599671
## 6:         8.467269         8.927321         9.189537         8.123597
##    TCGA-GM-A5PV-01A TCGA-A2-A25F-01A TCGA-A7-A13E-11A TCGA-B6-A408-01A
## 1:        13.575603         12.65714        13.732913        12.753250
## 2:        13.575911         12.68851        13.727539        12.740750
## 3:        13.577165         12.67465        13.755159        12.757379
## 4:        14.389698         15.46253        14.887001        14.022664
## 5:        11.646752         11.81392        12.729206         9.010843
## 6:         7.633147         10.80162         9.122178         8.165524
##    TCGA-A7-A13E-01B TCGA-B6-A0IH-01A TCGA-A2-A0D3-01A TCGA-E9-A1RH-11A
## 1:        13.850808        12.998462        14.355641        13.342414
## 2:        13.864602        12.994564        14.356464        13.335598
## 3:        13.854333        13.018873        14.362705        13.357922
## 4:        15.122455        14.786250        15.768565        14.540007
## 5:        12.100405        12.468640        10.750879        13.004428
## 6:         9.812631         8.619504         9.444151         8.987806
##    TCGA-AN-A0XP-01A TCGA-AO-A1KQ-01A TCGA-AR-A256-01A TCGA-E9-A1N5-01A
## 1:        12.797936        12.804332         12.93358        12.762557
## 2:        12.798842        12.801355         12.95266        12.754031
## 3:        12.805816        12.856284         12.96382        12.772535
## 4:        15.347228        12.995073         14.11521        14.276391
## 5:        10.172354        10.108047          9.41747         9.863183
## 6:         8.459685         8.889759         10.87743         8.409095
##    TCGA-C8-A9FZ-01A TCGA-GM-A4E0-01A TCGA-C8-A3M7-01A TCGA-A2-A04W-01A
## 1:        13.584138        12.731130        13.126215        12.327013
## 2:        13.570287        12.712740        13.124085        12.327817
## 3:        13.587646        12.706368        13.133234        12.357711
## 4:        13.549863        13.214212        14.124192        13.679741
## 5:         8.547944        11.897169        12.096756        11.910488
## 6:         9.473024         8.396297         7.393406         8.759104
##    TCGA-E9-A295-01A TCGA-AR-A1AM-01A TCGA-BH-A1F0-01A TCGA-EW-A1OZ-01A
## 1:        14.422810        13.136097        13.470909        12.790847
## 2:        14.415276        13.134208        13.483926        12.790288
## 3:        14.434513        13.136460        13.474955        12.792707
## 4:        14.745938        14.294484        14.218832        12.470969
## 5:        11.214063        11.919884        12.032132         9.543036
## 6:         8.019993         8.199024         9.717057         8.004229
##    TCGA-A1-A0SF-01A TCGA-A1-A0SJ-01A TCGA-A8-A08Z-01A TCGA-A2-A1FX-01A
## 1:        12.784891        13.091325        12.727746         13.73980
## 2:        12.786417        13.071205        12.735195         13.73190
## 3:        12.795264        13.101082        12.762265         13.73332
## 4:        14.333694        15.589285        15.087040         14.62223
## 5:        11.943461        11.400662        10.914264         10.56332
## 6:         8.215924         8.613253         9.520046          7.52375
##    TCGA-A8-A07F-01A TCGA-BH-A8FZ-01A TCGA-A2-A0CL-01A TCGA-E9-A226-01A
## 1:        12.838022        13.327597        13.023521        12.606183
## 2:        12.820916        13.329539        12.999008        12.601622
## 3:        12.852503        13.331111        13.045014        12.593468
## 4:        13.915977        13.877458        13.864640        13.632952
## 5:        11.273228        11.172441        10.911595        10.673664
## 6:         9.049044         7.181147         8.858105         6.976643
##    TCGA-OL-A97C-01A TCGA-BH-A1ET-11B TCGA-BH-A0E6-01A TCGA-BH-A0HW-01A
## 1:        14.049523        14.034962        12.113747        14.457868
## 2:        14.048623        14.035516        12.092929        14.453612
## 3:        14.050768        14.046453        12.103376        14.460090
## 4:        14.770164        15.052834        13.175222        16.018077
## 5:        11.948070        13.278984        10.948163         8.262257
## 6:         9.244796         8.484173         8.835249         9.680740
##    TCGA-E2-A1B5-01A TCGA-C8-A12K-01A TCGA-S3-AA15-01A TCGA-BH-A0BM-01A
## 1:        13.662556        14.205641        12.809357        14.129426
## 2:        13.660415        14.190544        12.816623        14.133193
## 3:        13.645393        14.196059        12.817909        14.137061
## 4:        13.884577        15.708058        13.507199        17.496033
## 5:        11.437890         9.207199        11.187251        12.738896
## 6:         8.973356        10.499289         8.749519         8.461877
##    TCGA-B6-A0IQ-01A TCGA-C8-A12U-01A TCGA-C8-A8HP-01A TCGA-A2-A3XV-01A
## 1:        12.336119        13.713015        12.623492        13.667665
## 2:        12.361836        13.711619        12.612868        13.657899
## 3:        12.351064        13.717195        12.632526        13.652310
## 4:        13.787629        14.538189        12.693004        13.824665
## 5:        12.675313         8.407050        10.291457        10.790535
## 6:         9.645239         9.284881         8.035204         9.173102
##    TCGA-BH-A0AW-01A TCGA-AN-A0FF-01A TCGA-AR-A24M-01A TCGA-AN-A0XT-01A
## 1:        12.383681        12.978142         13.35451        12.502359
## 2:        12.378952        12.976431         13.37001        12.490933
## 3:        12.364872        13.023472         13.36408        12.527076
## 4:        15.065234        14.151472         15.47675        14.735410
## 5:        10.980129        10.339131         11.08453        10.713607
## 6:         9.393992         9.672987          8.56405         7.246266
##    TCGA-A7-A13G-01A TCGA-BH-A0DP-11A TCGA-E2-A2P6-01A TCGA-C8-A130-01A
## 1:        14.999943        13.265832        14.308602        12.889147
## 2:        15.001658        13.263837        14.301530        12.897070
## 3:        15.010245        13.266274        14.316972        12.886023
## 4:        15.982184        15.906980        15.896784        13.242694
## 5:        10.535409        12.274258        10.252583        10.339209
## 6:         9.079523         9.127504         8.531632         8.736426
##    TCGA-C8-A274-01A TCGA-AC-A2FB-11A TCGA-AO-A0JA-01A TCGA-LL-A5YN-01A
## 1:        13.643188        14.226997        12.584749        12.616308
## 2:        13.633251        14.224277        12.600503        12.607328
## 3:        13.638353        14.228868        12.636978        12.619532
## 4:        13.434716        15.197791        15.223717        12.236440
## 5:         8.933821        13.408414        10.785940        10.208541
## 6:         8.912841         9.017877         8.937021         8.506158
##    TCGA-LL-A740-01A TCGA-LL-A6FP-01A TCGA-A7-A26E-01B TCGA-A7-A6VX-01A
## 1:        13.040204        12.173690         14.05306         14.01980
## 2:        13.026207        12.190383         14.05421         14.02388
## 3:        13.025712        12.196144         14.07932         14.03379
## 4:        13.194292        11.434120         15.51881         14.33844
## 5:        11.248530         8.272718         12.03106          9.96430
## 6:         8.518163         7.903606         10.04173          9.39776
##    TCGA-AC-A6IW-01A TCGA-E2-A152-01A TCGA-BH-A0AU-11A TCGA-A2-A3XX-01A
## 1:        13.123269         13.33822        14.452309        12.783007
## 2:        13.104204         13.33230        14.451231        12.795081
## 3:        13.123997         13.34009        14.459256        12.802072
## 4:        13.315689         14.24666        15.647834        13.527315
## 5:         9.485720         11.05031        13.673064        11.218664
## 6:         9.183425          9.55390         9.296342         9.283246
##    TCGA-E9-A1NA-01A TCGA-EW-A1OY-01A TCGA-BH-A0AU-01A TCGA-B6-A0WS-01A
## 1:        12.645294        13.126805        13.920647        13.269624
## 2:        12.623734        13.101252        13.910162        13.253796
## 3:        12.655556        13.135615        13.931211        13.276900
## 4:        14.362861        14.552526        16.218744        14.601372
## 5:        10.289542         9.897708        11.711653        11.272884
## 6:         9.031744         8.942927         8.529014         8.744374
##    TCGA-B6-A0I5-01A TCGA-BH-A1FB-01A TCGA-GM-A2DF-01A TCGA-AQ-A04H-01B
## 1:        13.547371        13.417836        13.192730        13.210764
## 2:        13.535199        13.413058        13.203774        13.218077
## 3:        13.572541        13.425504        13.221500        13.228003
## 4:        15.341942        14.471613        13.567920        13.702665
## 5:        11.156965        12.084698         9.681775         9.013852
## 6:         9.906765         8.313581         9.111498         8.944252
##    TCGA-D8-A1JI-01A TCGA-BH-A0E9-01B TCGA-E2-A15C-01A TCGA-AR-A24S-01A
## 1:        12.441328        14.278546        13.791229        13.106416
## 2:        12.422297        14.280727        13.778067        13.103019
## 3:        12.468043        14.283129        13.793379        13.109035
## 4:        13.425407        15.645183        15.245153        13.972620
## 5:         7.773855        12.563450        10.978652        10.687326
## 6:         8.162723         8.613657         8.726415         9.702147
##    TCGA-BH-A0B1-01A TCGA-AN-A0FX-01A TCGA-A2-A0YD-01A TCGA-E9-A1NE-01A
## 1:        12.801018        12.876106        12.553825        13.174333
## 2:        12.782850        12.893609        12.540596        13.169054
## 3:        12.815878        12.886902        12.536082        13.173015
## 4:        15.854220        14.207401        15.023196        14.040506
## 5:        11.946387        11.551980        11.241727        11.557920
## 6:         8.659956         8.994408         8.601846         9.909594
##    TCGA-D8-A1JA-01A TCGA-S3-AA11-01A TCGA-A2-A0YT-01A TCGA-AC-A3YI-01A
## 1:        11.561218        14.061243        12.646975        13.598479
## 2:        11.568295        14.063507        12.641212        13.604223
## 3:        11.592935        14.067805        12.701530        13.614692
## 4:        12.231784        14.821623        14.424663        14.565181
## 5:         8.268267        10.734880        10.149351        12.973012
## 6:         7.130259         7.955926         8.649628         8.059719
##    TCGA-BH-A0B2-01A TCGA-LL-A7T0-01A TCGA-AC-A8OQ-01A TCGA-C8-A12N-01A
## 1:        13.901837        12.897176        13.289214        14.010698
## 2:        13.894713        12.901813        13.296916        13.999597
## 3:        13.903547        12.932319        13.288917        14.033745
## 4:        15.284490        13.086475        14.450364        15.827608
## 5:        11.874897         9.561303        11.093828        11.235809
## 6:         8.515136         8.421632         8.982812         8.918766
##    TCGA-AO-A03U-01B TCGA-C8-A12T-01A TCGA-AO-A0J2-01A TCGA-D8-A27R-01A
## 1:        14.253410        13.056146        12.829524        14.016100
## 2:        14.241489        13.079225        12.833507        14.019502
## 3:        14.264757        13.081261        12.847773        14.044110
## 4:        15.459423        14.561120        15.342343        14.058945
## 5:        11.604133        10.722746         9.246112        11.828253
## 6:         9.528674         9.138859        10.079703         8.577173
##    TCGA-AR-A0TX-01A TCGA-A2-A0CW-01A TCGA-E2-A10F-01A TCGA-AR-A1AI-01A
## 1:        12.521443        13.002531        13.395906         12.56600
## 2:        12.530978        13.000689        13.406236         12.56746
## 3:        12.542082        13.006994        13.418211         12.57185
## 4:        14.376111        13.144742        15.400359         14.26211
## 5:        11.888879        10.487615        11.345031         11.31023
## 6:         8.913846         9.135581         9.126251         10.26972
##    TCGA-GI-A2C8-11A TCGA-A2-A0YF-01A TCGA-BH-A0AY-11A TCGA-E9-A1N8-01A
## 1:        12.440854        11.845620         13.14759         12.91962
## 2:        12.429789        11.871953         13.14745         12.94005
## 3:        12.459519        11.900230         13.17119         12.94009
## 4:        12.795480        12.409321         15.56701         14.39311
## 5:        10.796413        10.098755         13.32606         11.21911
## 6:         9.519319         9.285222          8.66866         10.20951
##    TCGA-E2-A2P5-01A TCGA-BH-A18P-11A TCGA-A8-A08R-01A TCGA-E2-A15A-01A
## 1:        13.373804        13.311640        13.170526        13.721022
## 2:        13.371204        13.336174        13.156237        13.697301
## 3:        13.401773        13.335758        13.200909        13.745192
## 4:        14.060495        14.957679        14.483773        14.327279
## 5:        11.611123        12.839784         9.838323         9.654780
## 6:         9.197757         9.020073        10.987934         9.187921
##    TCGA-BH-A1FE-11B TCGA-BH-A1EO-11A TCGA-D8-A1JT-01A TCGA-D8-A142-01A
## 1:        13.232883        14.081462        13.228501        12.933745
## 2:        13.234114        14.097708        13.220601        12.943863
## 3:        13.229096        14.095860        13.234932        12.924352
## 4:        15.009904        14.462801        14.261492        14.700948
## 5:        12.708788        12.907511         8.458101        11.554737
## 6:         8.898666         9.055555         9.855317         9.794118
##    TCGA-A2-A3Y0-01A TCGA-AQ-A0Y5-01A TCGA-EW-A6SA-01A TCGA-BH-A0HK-01A
## 1:         13.04809        12.968838        14.380173        12.929929
## 2:         13.02961        12.972606        14.372743        12.936345
## 3:         13.04687        12.972485        14.383692        12.938080
## 4:         13.45438        14.497080        14.581639        15.578813
## 5:         10.78116        11.869264         8.714335         9.492717
## 6:          9.49316         7.239808         8.481106         7.882021
##    TCGA-A1-A0SM-01A TCGA-MS-A51U-01A TCGA-AR-A24K-01A TCGA-E2-A1IF-01A
## 1:        13.126299        13.444998        12.452021         13.10602
## 2:        13.131248        13.450829        12.439945         13.11564
## 3:        13.176328        13.445504        12.471512         13.12347
## 4:        16.019204        14.478040        14.621371         14.68543
## 5:        10.793825        11.692796         9.490376         12.26724
## 6:         8.211482         8.399981         6.521073          8.89119
##    TCGA-E2-A1LH-11A TCGA-E2-A14W-01A TCGA-BH-A1F8-01A TCGA-E9-A1RA-01A
## 1:        13.899852        12.933047        12.162017        13.082273
## 2:        13.895473        12.921891        12.144813        13.072621
## 3:        13.890264        12.956874        12.158948        13.076617
## 4:        15.481603        13.600547        13.540893        14.978343
## 5:        13.196421        10.996854        10.839351        11.088403
## 6:         8.121885         8.751572         8.858932         9.149253
##    TCGA-AR-A24T-01A TCGA-C8-A27B-01A TCGA-A8-A07O-01A TCGA-BH-A0DD-11A
## 1:        13.069171        14.035368         12.97451        13.936641
## 2:        13.066953        14.030865         12.96219        13.907630
## 3:        13.062061        14.027294         13.00234        13.934032
## 4:        14.625653        14.468414         13.75979        15.380450
## 5:        11.839315         7.921068          9.79483        13.331059
## 6:         7.952149        11.138569         10.99563         9.914756
##    TCGA-AR-A2LJ-01A TCGA-E2-A1L6-01A TCGA-BH-A0DT-11A TCGA-A2-A0SV-01A
## 1:        14.180528        12.978411        14.018583        12.404741
## 2:        14.172306        12.960026        14.003807        12.380744
## 3:        14.171021        12.967357        14.035824        12.439656
## 4:        15.369600        14.674505        14.873317        14.013927
## 5:        12.644305        11.401806        13.281604         9.512755
## 6:         8.795508         8.890906         8.626026         9.382202
##    TCGA-BH-A0BO-01A TCGA-B6-A0RN-01A TCGA-EW-A1P3-01A TCGA-A7-A13F-11A
## 1:        13.441146        13.168463        12.648896        14.119837
## 2:        13.449313        13.154539        12.662858        14.135787
## 3:        13.443056        13.196045        12.676500        14.147772
## 4:        15.261052        16.636407        14.392788        14.788002
## 5:        12.257532        11.504708        10.826527        13.046762
## 6:         7.995741         8.606173         8.159075         9.704698
##    TCGA-A2-A0T6-01A TCGA-A7-A5ZW-01A TCGA-BH-A203-01A
## 1:        12.751446        13.497555        13.377192
## 2:        12.752993        13.505774        13.359864
## 3:        12.762161        13.497234        13.375518
## 4:        14.928173        14.451789        14.947434
## 5:        11.080933        12.224227        10.234638
## 6:         8.058076         7.395225         7.735103
```

```{.r .bg-danger}
# 99 miRNA 1203 sample row X col 99*1203
dim(mirna)
```

```{.bg-warning}
## [1]   99 1203
```

```{.r .bg-danger}
str(mirna)
```

```{.bg-warning}
## Classes 'data.table' and 'data.frame':	99 obs. of  1203 variables:
##  $ miRNA_ID        : chr  "hsa-let-7a-1" "hsa-let-7a-2" "hsa-let-7a-3" "hsa-let-7b" ...
##  $ TCGA-E9-A1NI-01A: num  12.7 12.7 12.7 14 10.3 ...
##  $ TCGA-A1-A0SP-01A: num  12.9 12.9 12.9 15 10.8 ...
##  $ TCGA-LL-A5YP-01A: num  12.9 12.9 12.9 13.5 10.3 ...
##  $ TCGA-E2-A14T-01A: num  14.1 14.1 14.2 13.8 11 ...
##  $ TCGA-AR-A24O-01A: num  13.5 13.5 13.5 15.3 12 ...
##  $ TCGA-A8-A09K-01A: num  12.27 12.24 12.29 13.81 9.06 ...
##  $ TCGA-OL-A5RY-01A: num  13 13 13 13.6 11.6 ...
##  $ TCGA-E9-A24A-01A: num  13.4 13.4 13.4 15 10.2 ...
##  $ TCGA-E9-A1RB-01A: num  12.8 12.8 12.9 14.8 10 ...
##  $ TCGA-A2-A0CP-01A: num  13 13 13 14.3 12 ...
##  $ TCGA-A8-A07S-01A: num  13.7 13.7 13.7 15.5 10.3 ...
##  $ TCGA-AO-A12H-01A: num  14.22 14.21 14.22 16.22 9.08 ...
##  $ TCGA-BH-A203-11A: num  13.6 13.6 13.6 14.6 12.9 ...
##  $ TCGA-D8-A1X9-01A: num  13.06 13.05 13.06 15.32 9.38 ...
##  $ TCGA-AO-A12D-01A: num  12.7 12.7 12.7 13.8 11 ...
##  $ TCGA-5L-AAT0-01A: num  13.7 13.7 13.7 14.6 11.1 ...
##  $ TCGA-AO-A12C-01A: num  13.2 13.2 13.2 14.8 11.2 ...
##  $ TCGA-V7-A7HQ-01A: num  13.5 13.5 13.5 13.6 10.6 ...
##  $ TCGA-A2-A1FZ-01A: num  13.2 13.2 13.2 15.1 11.8 ...
##  $ TCGA-AR-A251-01A: num  12.2 12.2 12.2 12.9 11.7 ...
##  $ TCGA-BH-A0B9-01A: num  12.4 12.4 12.4 13.9 11.5 ...
##  $ TCGA-EW-A1PF-01A: num  12.5 12.5 12.5 13.7 10.8 ...
##  $ TCGA-OK-A5Q2-01A: num  13.6 13.6 13.6 14.4 11.4 ...
##  $ TCGA-AN-A041-01A: num  13.5 13.5 13.5 15.7 11.1 ...
##  $ TCGA-AC-A23H-11A: num  13.2 13.2 13.2 14.8 12.7 ...
##  $ TCGA-E2-A1LL-01A: num  12.6 12.6 12.6 13.9 10.4 ...
##  $ TCGA-AC-A2QJ-01A: num  13.4 13.4 13.4 14.4 13 ...
##  $ TCGA-A8-A08O-01A: num  13.6 13.6 13.6 16.7 11.7 ...
##  $ TCGA-XX-A899-01A: num  14.5 14.4 14.4 14.3 12.3 ...
##  $ TCGA-D8-A1XK-01A: num  12 12 12 13.9 10.6 ...
##  $ TCGA-AC-A5XS-01A: num  13.1 13.1 13.1 12.8 10.5 ...
##  $ TCGA-BH-A18L-01A: num  14.1 14.1 14.1 15.2 10.7 ...
##  $ TCGA-AO-A125-01A: num  14.5 14.4 14.5 16.6 7.7 ...
##  $ TCGA-PE-A5DD-01A: num  12.71 12.68 12.7 12.99 9.57 ...
##  $ TCGA-AN-A04D-01A: num  13.4 13.4 13.4 14.3 12.9 ...
##  $ TCGA-4H-AAAK-01A: num  13.8 13.8 13.8 14.4 11.7 ...
##  $ TCGA-BH-A0DG-01A: num  13.4 13.4 13.4 14.7 11.4 ...
##  $ TCGA-BH-A1FM-01A: num  13.15 13.15 13.19 14.55 9.83 ...
##  $ TCGA-AO-A129-01A: num  13.5 13.5 13.5 14.4 11.5 ...
##  $ TCGA-A8-A07C-01A: num  13.3 13.3 13.3 13.5 10.5 ...
##  $ TCGA-AR-A24Q-01A: num  13.8 13.7 13.8 15.4 11.9 ...
##  $ TCGA-BH-A18T-01A: num  13.07 13.06 13.06 14.08 9.38 ...
##  $ TCGA-AR-A0U4-01A: num  12 12 12 14.3 9.7 ...
##  $ TCGA-E9-A1N6-11A: num  14.1 14.2 14.2 15.3 13.4 ...
##  $ TCGA-A7-A13D-01A: num  12.6 12.7 12.7 15 10.1 ...
##  $ TCGA-D8-A1JG-01B: num  13.4 13.4 13.4 13.7 11.4 ...
##  $ TCGA-E2-A570-01A: num  13.5 13.5 13.5 14.6 11.5 ...
##  $ TCGA-BH-A0BW-11A: num  13.5 13.5 13.5 15.2 12.6 ...
##  $ TCGA-E2-A1BC-01A: num  13.9 13.9 13.9 14.9 11.8 ...
##  $ TCGA-E2-A1IG-01A: num  13.9 13.9 13.9 15.6 10.4 ...
##  $ TCGA-E9-A1N4-11A: num  13.3 13.3 13.3 15.2 12.7 ...
##  $ TCGA-A7-A3IZ-01A: num  15.4 15.3 15.4 15.9 9.9 ...
##  $ TCGA-BH-A0BV-11A: num  13.3 13.3 13.3 15.7 13.1 ...
##  $ TCGA-AN-A0AK-01A: num  13.05 13.07 13.1 15.33 9.34 ...
##  $ TCGA-A2-A1G4-01A: num  14.5 14.5 14.5 15.2 10.3 ...
##  $ TCGA-A8-A06Z-01A: num  12.13 12.11 12.17 14.13 9.44 ...
##  $ TCGA-BH-A0HU-01A: num  12.3 12.3 12.3 13.7 10.1 ...
##  $ TCGA-A2-A04X-01A: num  12.67 12.63 12.63 14.59 9.49 ...
##  $ TCGA-E2-A15S-01A: num  14.7 14.7 14.7 15.3 10.5 ...
##  $ TCGA-B6-A0IB-01A: num  12.9 12.9 12.9 15.7 11.5 ...
##  $ TCGA-BH-A18R-11A: num  13.8 13.8 13.8 14.8 12.9 ...
##  $ TCGA-LL-A6FQ-01A: num  12.68 12.67 12.68 13.18 9.44 ...
##  $ TCGA-C8-A273-01A: num  13.9 13.9 13.9 13.8 10.2 ...
##  $ TCGA-OL-A5RV-01A: num  13.4 13.4 13.4 14.3 11.5 ...
##  $ TCGA-AC-A2FM-01A: num  14.9 14.9 15 15.8 11.4 ...
##  $ TCGA-A2-A25A-01A: num  13.9 14 13.9 13.7 12.1 ...
##  $ TCGA-BH-A0BQ-11A: num  13.5 13.5 13.5 15.7 13.1 ...
##  $ TCGA-BH-A0DP-01A: num  13.6 13.6 13.6 17.2 12 ...
##  $ TCGA-A2-A25E-01A: num  12.5 12.5 12.6 13.9 10.4 ...
##  $ TCGA-B6-A2IU-01A: num  14.2 14.2 14.2 15 11.9 ...
##  $ TCGA-BH-A18P-01A: num  14.3 14.3 14.3 16 10.7 ...
##  $ TCGA-D8-A27T-01A: num  14.7 14.7 14.7 15.6 11.8 ...
##  $ TCGA-A2-A0SW-01A: num  11.9 11.84 11.9 13.39 9.01 ...
##  $ TCGA-E2-A107-01A: num  13.9 13.9 13.9 15.1 12.5 ...
##  $ TCGA-BH-A1FM-11B: num  13.3 13.3 13.3 15.4 13.1 ...
##  $ TCGA-BH-A0BJ-11A: num  13 13 13 15.5 13.1 ...
##  $ TCGA-E2-A1B6-01A: num  13.7 13.7 13.7 14.6 12.1 ...
##  $ TCGA-D8-A1XW-01A: num  13.7 13.7 13.7 15.2 12 ...
##  $ TCGA-A7-A0DC-01A: num  13.6 13.6 13.6 15.4 9.1 ...
##  $ TCGA-EW-A6SD-01A: num  11.66 11.66 11.68 10.82 8.33 ...
##  $ TCGA-AN-A0G0-01A: num  12.7 12.7 12.7 15.1 10.9 ...
##  $ TCGA-A7-A0DC-11A: num  13 13 13 15.6 12.6 ...
##  $ TCGA-AN-A03X-01A: num  13.2 13.2 13.2 15.7 12.5 ...
##  $ TCGA-LD-A7W6-01A: num  13.1 13 13 13.9 10.4 ...
##  $ TCGA-A8-A099-01A: num  12.81 12.79 12.8 15.96 8.94 ...
##  $ TCGA-E2-A14Z-01A: num  13.4 13.4 13.4 13.6 10.7 ...
##  $ TCGA-AR-A5QP-01A: num  13 13 13 13 11.5 ...
##  $ TCGA-AC-A62X-01A: num  12.7 12.7 12.7 13 11.5 ...
##  $ TCGA-BH-A42V-01A: num  14 14 14 14.1 11.7 ...
##  $ TCGA-B6-A0RS-01A: num  12.5 12.4 12.5 14.4 11.4 ...
##  $ TCGA-A2-A04R-01A: num  12.9 12.9 12.8 14.9 10.5 ...
##  $ TCGA-A8-A090-01A: num  11.95 11.91 11.97 14.51 9.25 ...
##  $ TCGA-BH-A0DZ-01A: num  12.4 12.4 12.4 15.6 10.8 ...
##  $ TCGA-B6-A1KC-01B: num  13.85 13.86 13.87 15.29 8.99 ...
##  $ TCGA-C8-A135-01A: num  12.7 12.7 12.7 14.1 11.7 ...
##  $ TCGA-AR-A24R-01A: num  13.2 13.2 13.2 13.6 10.3 ...
##  $ TCGA-LD-A66U-01A: num  13.1 13.1 13.1 14 11.6 ...
##  $ TCGA-D8-A1J8-01A: num  12.68 12.69 12.69 13.5 8.53 ...
##   [list output truncated]
##  - attr(*, ".internal.selfref")=<externalptr>
```

### search miRNA

```{.r .bg-danger}
mirnax <- mirna[grepl('mir-107|1253',miRNA_ID)]
```

## 转置数据，首列为SampleID， 剩余列未各种基因
### bad approach 

```{.r .bg-danger}
# 错误， 数字转为字符类型
head(t(mirnax))
```

```{.bg-warning}
##                  [,1]          [,2]          
## miRNA_ID         "hsa-mir-107" "hsa-mir-1253"
## TCGA-E9-A1NI-01A "5.842113"    "0.000000"    
## TCGA-A1-A0SP-01A "5.919422"    "0.000000"    
## TCGA-LL-A5YP-01A "6.395778"    "0.000000"    
## TCGA-E2-A14T-01A "6.217118"    "0.000000"    
## TCGA-AR-A24O-01A "5.144443"    "0.000000"
```

```{.r .bg-danger}
mirna2 <- as.data.frame( t(mirnax[,-1]))
colnames(mirna2) <- mirnax$miRNA_ID
head(mirna2)
```

```{.bg-warning}
##                  hsa-mir-107 hsa-mir-1253
## TCGA-E9-A1NI-01A    5.842113            0
## TCGA-A1-A0SP-01A    5.919422            0
## TCGA-LL-A5YP-01A    6.395778            0
## TCGA-E2-A14T-01A    6.217118            0
## TCGA-AR-A24O-01A    5.144443            0
## TCGA-A8-A09K-01A    5.753795            0
```

### best approach 

```{.r .bg-danger}
miRNA <- transpose(mirnax,make.names = 'miRNA_ID',keep.names = 'sampleid')
str(miRNA)
```

```{.bg-warning}
## Classes 'data.table' and 'data.frame':	1202 obs. of  3 variables:
##  $ sampleid    : chr  "TCGA-E9-A1NI-01A" "TCGA-A1-A0SP-01A" "TCGA-LL-A5YP-01A" "TCGA-E2-A14T-01A" ...
##  $ hsa-mir-107 : num  5.84 5.92 6.4 6.22 5.14 ...
##  $ hsa-mir-1253: num  0 0 0 0 0 0 0 0 0 0 ...
##  - attr(*, ".internal.selfref")=<externalptr>
```

```{.r .bg-danger}
head(miRNA)
```

```{.bg-warning}
##            sampleid hsa-mir-107 hsa-mir-1253
## 1: TCGA-E9-A1NI-01A    5.842113            0
## 2: TCGA-A1-A0SP-01A    5.919422            0
## 3: TCGA-LL-A5YP-01A    6.395778            0
## 4: TCGA-E2-A14T-01A    6.217118            0
## 5: TCGA-AR-A24O-01A    5.144443            0
## 6: TCGA-A8-A09K-01A    5.753795            0
```


## merge phenodata

```{.r .bg-danger}
miRNA2 <- merge(miRNA,phenodata2,by.x='sampleid',by.y = 'submitter_id.samples',all.x = T)
head(miRNA2)
```

```{.bg-warning}
##            sampleid hsa-mir-107 hsa-mir-1253 OS.status
## 1: TCGA-3C-AAAU-01A    6.673102            0     alive
## 2: TCGA-3C-AALI-01A    5.821315            0     alive
## 3: TCGA-3C-AALJ-01A    7.155562            0     alive
## 4: TCGA-3C-AALK-01A    6.169444            0     alive
## 5: TCGA-4H-AAAK-01A    5.537350            0     alive
## 6: TCGA-5L-AAT0-01A    6.078621            0     alive
##    days_to_death.demographic
## 1:                      4047
## 2:                      4005
## 3:                      1474
## 4:                      1448
## 5:                       348
## 6:                      1477
```




