#import "simplepaper.typ": *

#show: project.with(
  title: "SimplePaper 模版使用说明",
  authors: (
    (
      name: "张三",
      organization: [Typst Group],
      email: "zs@typst.app"
    ),
    (
      name: "李四",
      organization: [Rust Group],
      email: "ls@typst.app"
    ),
  ),
  abstract: "本文详细描述了 SimplePaper 模版的使用方法。",
  keywords: (
    "Typst",
    "模板",
    "使用说明",
  ),
)

= 模版简介

SimplePaper#cite(<SimplePaper>) 是 Typst 的模版，用于生成简单的论文。

= 使用说明

使用前确保已经安装了对应的字体！详细字体列表参考 #link("https://github.com/1bitbool/SimplePaper/tree/main")[README] 或模板文件。

= 使用示例 <example>

== 特殊标记 <bug1>

你可以 Typst 的语法对文本进行特殊标记，模板设定了几种语法的样式：*突出*、_强调_、引用@example。


== 图片

图片标题默认设置了方正楷体，效果如@img 如果你想要使用其他字体，你可以自行修改模版。

#figure(image("sample.svg"),
  caption: [
    示例图片
  ],
)<img>

图片后的文字。

== 表格

#figure(
  table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr),
    inset: 10pt,
    align: horizon,
    [], [周一], [周二],[周三],[周四],[周五],
    "早上", "编译原理", "操作系统", "计算机网络", "操作系统", "计算机网络",
    "下午", "数据挖掘", "计算机网络", "操作系统", "计算机网络", "分布式系统"
  ),
  caption: "示例表格"
)

表格后的文字。

== 代码

我们为代码添加了如下简单的样式。

```c
#include <stdio.h>
int main()
{
   // printf() 中字符串需要引号
   printf("Hello, World!");
   return 0;
}
```

代码后的文字。

== 列表

下面是有序列表的示例：

+ 第一项
+ 第二项
+ 第三项

列表后的文字。

下面是无序列表的示例：

- 第一项
- 第二项
- 第三项

无序列表后的文字。

#bibliography("ref.bib")