#import "@preview/numblex:0.1.0": numblex, circle_numbers

#let font = (main: "Cambria", mono: "SimHei", cjk: "SimHei")

#let problem_counter = counter("problem")
#let prob-solution_counter = counter("prob-solution")

#let prob_block(body) = {
  v(-0.5em)
  block(fill: rgb(230, 255, 255), width: 100%, inset: 8pt, radius: 4pt, stroke: rgb(0, 191, 255), body)
}

#let speci_block(title, body) = {
  v(-0.5em)
  block(
    fill: rgb("#497BDF"),
    width: 100%,
    inset: (left: 8pt, top: 4pt, bottom: 4pt),
    radius: (top: 4pt, bottom: 0pt),
    stroke: rgb("#C3D7FF"),
  )[
    #set heading(numbering: none)
     
    #set text(fill: white)
     
    ==== #title
  ]
  v(-12pt)
  block(fill: rgb("#fcfdff"), width: 100%, inset: 8pt, radius: (top: 0pt, bottom: 4pt), stroke: rgb("#1f84c7"))[
    // #v(0.5em)
    #body
  ]
}

#let speci_block2(title, body) = {
  v(-0.5em)
  block(
    fill: rgb("#808080"),
    width: 100%,
    inset: (left: 8pt, top: 4pt, bottom: 4pt),
    radius: (top: 4pt, bottom: 0pt),
    stroke: rgb("#C3D7FF"),
  )[
    #set heading(numbering: none)
     
    #set text(fill: white)
     
    ==== #title
  ]
  v(-12pt)
  block(fill: rgb("#fcfdff"), width: 100%, inset: 8pt, radius: (top: 0pt, bottom: 4pt), stroke: rgb("#1f84c7"))[
    // #v(0.5em)
    #body
  ]
}

#let info(body) = {
  v(-0.5em)
  block(
    fill: rgb("#3399FF"),
    width: 100%,
    inset: (left: 8pt, top: 4pt, bottom: 4pt),
    radius: (top: 4pt, bottom: 0pt),
    stroke: rgb("#3333FF"),
  )[
    #set heading(numbering: none)
     
    #set text(fill: white)
     
    ==== Information
  ]
  v(-12pt)
  block(fill: rgb("#fcfdff"), width: 100%, inset: 8pt, radius: (top: 0pt, bottom: 4pt), stroke: rgb("#1f84c7"))[
    // #v(0.5em)
    #body
  ]
}

#let prob(text, body) = {
  [
    #set heading(numbering: none)
    === #text
  ]
  v(0.5em)
  if body == [] {
    v(0.5em)
  } else {
    prob_block(body)
  }
}

#let cprob(text, body) = {
  [
    #set heading(numbering: none)
    #problem_counter.step()
    === 问题 #problem_counter.display()：#text
  ]
  v(0.5em)
  if body == [] {
    v(0.5em)
  } else {
    prob_block(body)
  }
}

#let cqa(title, body) = {
  [
    #set heading(numbering: none)
    #prob-solution_counter.step()
    === 问题 #prob-solution_counter.display()：#title
  ]
  v(0.5em)
  if body == [] {
    v(0.5em)
  } else {
    speci_block2([解决方式], body)
  }
}

// Some math operators
#let prox = [#math.op("prox")]
#let proj = [#math.op("proj")]
#let argmin = [#math.arg] + [#math.min]

#let assignment_class(size: 10.5pt, title, author, course_id, professor_name, semester, due_time, id, body) = {

  set text(font: (font.main, font.cjk), size: size, lang: "zh", region: "cn")

  //set par(justify: true)
  //show: columns.with(2, gutter: 1.3em)
  //show: rest => columns(2, rest)
  show heading.where(level: 1): it => [
    #it
    #v(0.2em)
  ] 
   
  set heading(numbering: numblex("一、", "1.", (numbering: "(1).", depth: 2), (numbering: circle_numbers, depth: 4)))
  set raw(tab-size: 4)
  show link: underline
   
  set list(indent: 6pt)
  set enum(indent: 6pt)
   
  set bibliography(title: [参考], style: "ieee")
   
  set document(title: title, author: author)
  set page(paper: "a4", header: locate(loc => if (counter(page).at(loc).first() == 1) { none } else {
    [
      #h(1fr)
      *#author* | *#title*
    ]
  }), footer: locate(loc => {
    let page_number = counter(page).at(loc).first()
    let total_pages = counter(page).final(loc).last()
    align(center)[
      #set text(size: 8pt)
      #page_number / #total_pages
    ]
  }))
   
  line(length: 100%)
  align(left, text(17pt)[
    *#course_id* | *#title*
  ])
   
  let left_text = [
    *#author* #id
  ]
  let mid_text = [*Instructor: #professor_name*] + [, *#semester* ]
  let right_text = [| *截止时间：*#due_time]
   
  if due_time == none or due_time == "" {
    right_text = []
  }
   
   
  left_text
  h(1fr)
  mid_text
  right_text
   
   
   
  line(length: 100%)
   
  set raw(tab-size: 4)
   
  show raw: set text(font: (font.mono, font.cjk))
  // Display inline code in a small box
  // that retains the correct baseline.
  show raw.where(block: false): box.with(fill: luma(240), inset: (x: 3pt, y: 0pt), outset: (y: 3pt), radius: 2pt)
   
  // Display block code in a larger block
  // with more padding.
  // and with line numbers.
  // Thank you @Andrew15-5 for the idea and the code!
  // https://github.com/typst/typst/issues/344#issuecomment-2041231063
  let style-number(number) = text(gray)[#number]
  show raw.where(block: true): it => block(
    fill: luma(240),
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )[#grid(columns: (1em, 1fr), align: (right, left), column-gutter: 0.7em, row-gutter: 0.6em, ..it.lines
    .enumerate()
    .map(((i, line)) => (style-number(i + 1), line))
    .flatten())]
  body
}