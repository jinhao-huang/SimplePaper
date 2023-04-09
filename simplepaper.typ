#let project(title: "", authors: (), body) = {
  let song = "FZShuSong-Z01"
  let hei = "FZHei-B01"
  let kai = "FZKai-Z03"
  let xbsong = "FZXiaoBiaoSong-B05"
  let code = "DejaVu Sans Mono"
  // Moidfy the following to change the font.
  let title-font = hei
  let author-font = kai
  let body-font = song
  let heading-font = xbsong
  let caption-font = kai
  let header-font = kai
  let strong-font = hei
  let emph-font = kai
  let raw-font = code
  
  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center, header: align(left)[
    #set text(font: header-font)
    #title
  ])
  set heading(numbering: "1.1")
  set text(font: body-font, lang: "zh")
  
  show heading: it => box(width: 100%)[
    #v(0.50em)
    #set text(font: heading-font)
    #counter(heading).display()
    #h(0.75em)
    #it.body
]

  show heading.where(
    level: 1
  ): it => box(width: 100%)[
    #v(0.5em)
    #set align(center)
    #it
    #v(0.75em)
  ]

  // Title
  align(center)[
    #block(text(font: title-font, weight: 700, 1.75em, title))
    #v(0.5em)
  ]

  // Author information.
  pad(
    top: 0.5em,
    bottom: 0.5em,
    x: 2em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(center, text(font: author-font, author))),
    ),
  )

  // Main body
  set par(justify: true, first-line-indent: 2em)
  set enum(indent: 2em)
  set figure(gap: 0.8cm)

  show figure: it => [
    #v(12pt)
    #set text(font: caption-font)
    #it
    #v(12pt)
  ]
  show table: it => [
    #set text(font: body-font)
    #it
  ]
  show strong: set text(font: strong-font)
  show emph: set text(font: emph-font)
  show ref: set text(red)
  show raw: set text(font: raw-font)
  show link: underline
  show link: set text(blue)

  body
}