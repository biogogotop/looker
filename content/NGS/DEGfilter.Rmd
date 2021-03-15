+++
author = 'asepsiswu'
title = "差异基因分析之filter "
date = 2020-10-10T09:31:33+08:00
archives = "2020/10" 
tags = [ "" ]
summary = "差异基因分析之filter"
+++

## filtering after normalization
总体方针 [limma usersguide](./../usersguide.pdf)

1. two-color
   
   Control probes that don't correspond to genes are removed before the differential expression analysis but after background correction and normalization


1. single-channel

   Keep probes that are expressed above background on at least k arrays, where k is the smallest number of replicates assigned to any of the treatment combinations. Such filtering is done before the linear modelling and empirical Bayes steps but after normalization.

   If background control probes are not available, an alternative single-channel approach is to filter probes based on their average log-expression values (AveExpr) as computed by lmFit and stored as Amean. A histogram of the Amean values and a sigma vs Amean plot may help identify a cutoff below which Amean values can be filtered
    ```R
    fit <- lmFit(y, design)
    hist(fit$Amean)
    plotSA(fit)
    keep <- fit$Amean > CutOff
    fit2 <- eBayes(fit[keep,], trend=TRUE)
    plotSA(fit2)
    ```

   - Illumina

    Filter out probes that are not expressed according to a detection p-values of 5%
    ```R
    k <- 3
    y <- neqc(x)
    expressed <- rowSums(y$other$Detection < 0.05) >= k
    y <- y[expressed,]
    plotMDS(y,labels=targets$CellType)
    ```
   - Agilent

     filter out control probes as indicated by the ControlType column 

     filter out probes with no Symbol

     We keep probes that are above background on at least k arrays
    ```R
    k <- 4
    y <- backgroundCorrect(x, method="normexp")
    Control <- y$genes$ControlType==1L
    NoSymbol <- is.na(y$genes$Symbol)
    IsExpr <- rowSums(y$other$gIsWellAboveBG > 0) >= k
    yfilt <- y[!Control & !NoSymbol & IsExpr, ]
    yfilt$genes <- yfilt$genes[,c("ProbeName","Symbol","EntrezID")]
    ```
   - Affymetrix

    It is not necessary to give retain all the probes on the array for eBayes().  The only requirement is that eBayes() sees all the probes which are under consideration for differential expression.  So filtering out consistently non-expressed probes before linear modelling is generally a good idea.      


1. RNA-seq

    filter out genes or exons that are never detected or have very small counts. An effective method is to keep genes or exons that have a worthwhile count, say 5–10 or more, in at least k arrays.

