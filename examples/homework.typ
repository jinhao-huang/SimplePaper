#import "simplepaper.typ": *

#show: project.with(
  title: "编译原理作业",
  authors: (
    (
      name: "张三",
    ),
  ),
)

#problem[
  下列文法是一个无符号二进制浮点数的文法。试根据该文法，编写一个语法制导定义，描述由 S 生成的二进制数（浮点数）的数值计算。
  $
    S -> L . L \
    L -> L B | B \
    B -> 0 | 1
  $
]

#solution[
  设L具有继承属性side和综合属性m

  L.side表示小数点的左边或右边(1表示左边0表示右边)，L.m二进制串的长度即幂次。

  #table(
    columns: (auto, 1fr),
    inset: 10pt,
    align: center,
    [产生式], [语义规则],
    [$S -> L_1 . L_2$], [
      $
        L_1 . "side" = 1 \
        L_2 . "side" = 0 \
        S . "val" = L . "val"
      $
    ],
    [$S -> L$], [
      $
        L . "side" = 1, \
        S . "val" = L . "val"
      $
    ],
    [$L -> L_1 B$], [
      $
        L_1 . "side" = L . "side" \
        L . m = L_1 . m + 1 \
        L . "val" = L_1 . "side" ? L_1 . "val" * 2 + B . "val" : L_1 . "val" + (B . "val" >> m)
      $
    ],
    [$L -> B$], [
      $
        L . m = 1 \
        L . "val" = L . "side" ? B . "val" : B . "val" \/ 2
      $
    ],
    [$B -> 0$], [
      $
        B . "val" = 0
      $
    ],
    [$B -> 1$], [
      $
        B . "val" = 1
      $
    ]
  )
]

#problem[
  设下列文法生成变量的类型说明：
  $
    D -> "id" L \
    L -> , "id" L | : T \
    T -> "integer" | "real"
  $
  构造一个翻译模式，把每个标识符的类型存入符号表。
]

#solution[
  设 D, L, T 有综合属性 type。

  addtype(id, type)将标识符 id 及其类型 type 填入符号表中。

  翻译模式如下：
  #table(
    columns: (auto, 1fr),
    inset: 10pt,
    align: center,
    [$D -> "id" L$], [${"addtype"("id" . "entry", L . "type")}$],
    [$L -> , "id" L_1$], [${"addtype"("id" . "entry", L_1 . "type" ; L . "type" := L_1 . "type")}$],
    [$L -> :T$], [${L . "type" := T . "type"}$],
    [$T -> "integer"$], [${T . "type" := "integer"}$],
    [$T -> "real"$], [${T . "type" := "real"}$]
  )

]

#problem[
  文法G的产生式如下：
  $
    S -> (L) | a \
    L -> L , S | S
  $
  + 试写出一个语法制导定义，它输出配对括号个数; 
  + 写一个翻译方案，打印每个a的嵌套深度。如((a),a),打印2,1。（思考：如果要求出a出现的次数，怎么办？）
]

#solution[
  1.
  #table(
    columns: (auto, 1fr),
    inset: 10pt,
    align: center,
    [产生式], [语法规则],
    [$S -> (L)$], [$S.h := L.h + 1$],
    [$S -> a$], [$S.h := 0$],
    [$L -> L_1 , S$], [$L.h := L_1.h + S.h$],
    [$L->S$], [$L.h := S.h$],
    [$S' -> S$], [$"print"(S.h)$]
  )

  2.
  $
    S'->{S.d:=0;}S \ 
    S -> ({L.d := S.d + 1} L) \
    S -> a {"print"(S.d)} \
    L -> {L_1.d := L.d} L_1 , {S.d := L.d}S \
    L -> {S.d := L.d} S
  $
]