#let project(
  title: "",
  authors: (),
  abstract: none,
  keywords: (),
  body
) = {
  let song = "FZShuSong-Z01"
  let hei = "FZHei-B01"
  let kai = "FZKai-Z03"
  let xbsong = "FZXiaoBiaoSong-B05"
  let code = "DejaVu Sans Mono"
  // Moidfy the following to change the font.
  let title-font = hei
  let author-font = kai
  let organization-font = kai
  let body-font = song
  let heading-font = xbsong
  let caption-font = kai
  let header-font = kai
  let strong-font = hei
  let emph-font = kai
  let raw-font = code
  
  set document(author: authors.map(author => author.name), title: title)
  set page(numbering: "1", number-align: center, header: align(left)[
    #set text(font: header-font)
    #title
  ])
  set heading(numbering: "1.1")
  set text(font: body-font, lang: "zh", region: "cn")
  set bibliography(style: "gb-7714-2015-numeric")
  
  show heading: it => box(width: 100%)[
    #v(0.50em)
    #set text(font: heading-font)
    #if it.numbering != none { counter(heading).display() }
    #h(0.75em)
    #it.body
]

  show heading.where(
    level: 1
  ): it => box(width: 100%)[
    #v(0.5em)
    #set align(center)
    #set heading(numbering: "一")
    #it
    #v(0.75em)
  ]

  // Title
  align(center)[
    #block(text(font: title-font, weight: 700, 1.75em, title))
    #v(0.5em)
  ]

  // Display the authors list.
  for i in range(calc.ceil(authors.len() / 3)) {
    let end = calc.min((i + 1) * 3, authors.len())
    let is-last = authors.len() == end
    let slice = authors.slice(i * 3, end)
    grid(
      columns: slice.len() * (1fr,),
      gutter: 12pt,
      ..slice.map(author => align(center, {
        text(12pt, author.name, font: author-font)
        if "organization" in author [
          \ #text(font: organization-font)[#emph(author.organization)]
        ]
        if "email" in author [
          \ #link("mailto:" + author.email)
        ]
      }))
    )

    if not is-last {
      v(16pt, weak: true)
    }
  }
  v(2em, weak: true)

  // Main body
  set par(first-line-indent: 2em)
  set enum(indent: 2em)
  set list(indent: 2em)
  set figure(gap: 0.8cm)

  show figure: it => [
    #v(12pt)
    #set text(font: caption-font)
    #it
    #par()[#text(size: 0.0em)[#h(0.0em)]]
    #v(12pt)
  ]

  show image: it => [
    #it
    #par()[#text(size: 0.0em)[#h(0.0em)]]
  ]

  show table: it => [
    #set text(font: body-font)
    #it
  ]
  show strong: set text(font: strong-font)
  show emph: set text(font: emph-font)
  show ref: set text(red)
  show raw.where(block: true): block.with(
    width: 100%,
    fill: luma(240),
    inset: 10pt,
  )

  show raw: set text(font: (raw-font, hei), size: 10pt)
  show link: underline
  show link: set text(blue)

  if abstract != none [
    #v(2pt)
    #h(2em) *摘要：* #abstract

    #if keywords!= () [
      *关键字：* #keywords.join("；")
    ]
    #v(2pt)
  ]

  body
}
#let problem-counter = counter("problem")
#problem-counter.step()

#let problem(body) = {
  problem-counter.step()
  set enum(numbering: "(1)")
  block(
    fill: rgb(241, 241, 255),
    inset: 8pt,
    radius: 2pt,
    width: 100%,
  )[*题目 #problem-counter.display().* #h(0.75em) #body]
}

#let solution(body) = {
  set enum(numbering: "(1)")
  block(
    inset: 8pt,
    width: 100%
  )[*解答.* #h(0.75em) #body]
}
