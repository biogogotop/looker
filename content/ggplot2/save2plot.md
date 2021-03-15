+++
author = 'asepsiswu'
title = "跨平台保存plot的几种方法"
date = 2020-06-06
archives = "2020/06" 
tags = [ "graphics" ]
summary = '选用 grDevices::cairo_pdf 和 grDevices::png(…, type = "cairo_png")'
+++

# 跨平台保存plot的几种方法
参考网页
[Saving R Graphics across OSs](https://gist.github.com/csgillespie/eaa334e7455d3bb2fe967f5dc8614853)
结论： 选用 grDevices::cairo\_pdf 和 grDevices::png(…, type = "cairo\_png")
## pdf 
```r
pdf("figure1.pdf")
print(plot1)
dev.off()
```
```r
Cairo::CairoPDF("CairoPDF.pdf")
print(plot1)
dev.off()
```

```r
grDevices::cairo_pdf("cairo_pdf.pdf")
print(plot1)
dev.off()
```


## PNG device
```r
res = 300
png("default.png", 
    width = 8 * res, height = 6 * res, res = res)
print(plot1)
dev.off()
```

```r
png("cairo.png", type = "cairo",
    width = 8 * res, height = 6 * res, res = res)
print(plot1)
dev.off()
```

```r
png("cairo_png.png", type = "cairo-png",
    width = 8 * res, height = 6 * res, res = res)
print(plot1)
dev.off()
```

```r
ragg::agg_png("ragg.png",
              width = 8 * res, height = 6 * res, res = res)
print(plot1)
dev.off()
```
