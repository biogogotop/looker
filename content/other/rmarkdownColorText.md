+++
author = 'asepsiswu'
title = "Rmarkdown 文本着色 "
date = 2020-06-26
archives = "2020/06" 
tags = [ "Rmarkdown" ]
summary = "Rmarkdown写作中文本高亮着色"
+++



## 利用html语言标记
### ultisnips 补全
neovim中通过ultisnips进行补全
```bash
pacman -S vim-youcompleteme-git
pacman -S neovim
pacman -S vim-ultisnips # vim-plugins
```

### ultisnips 设置
通过ultisnips进行补全，添加html语法着色

<span style="color:red"> 添加以下内容到 ~/.config/nvim/UltiSnips/markdown.snippets </span>
```
snippet color "html style color"
<span style="color:$1">$2</span>
endsnippet
```

## knitr opts_chunk 设置
<span style="color:red">rstudio中可行，而在hugo中不可以</span>，主意的原因是后者markup引擎对pandoc的支持差
```r
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_chunk$set(class.source = "bg-danger")
knitr::opts_chunk$set(class.output = "bg-warning")
# knitr::opts_chunk$set(comment =  "")
if(require(fansi)){
  options(crayon.enabled = TRUE)
  old.hooks <- fansi::set_knit_hooks(knitr::knit_hooks)
}
```
### 例子

```{.r .bg-danger}
print(letters[1:4])
```

```{.bg-warning}
[1] "a" "b" "c" "d"
```

```{.r .bg-danger}
writeLines(crayon::blue(letters[1:4]))
```

<PRE class="fansi fansi-output"><CODE><span style='color: #0000BB;'>a</span><span>
</span><span style='color: #0000BB;'>b</span><span>
</span><span style='color: #0000BB;'>c</span><span>
</span><span style='color: #0000BB;'>d</span><span>
</span></CODE></PRE>

```{.r .bg-danger}
crayon::blue(letters[1:4])
```

```{.bg-warning}
[1] "\033[34ma\033[39m" "\033[34mb\033[39m" "\033[34mc\033[39m"
[4] "\033[34md\033[39m"
```
## hugo config.toml 设置
syntax highlight 设置为xcode样式，hugo 0.60以上需要设置unsafe=true以支持html语句
[Configure Markup](https://gohugo.io/getting-started/configuration-markup)
```toml
[markup]
  [markup.goldmark]
    [markup.goldmark.renderer]
      unsafe = true
  [markup.highlight]
    style = "xcode"
```

## highlight.js 和css
利用highlight.js 和css进行代码着色，譬如code里的comment语句着色

需要进一步完成
