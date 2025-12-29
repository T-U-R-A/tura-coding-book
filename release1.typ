#import "@preview/cetz:0.4.2"
#import "@preview/board-n-pieces:0.7.0": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()
#codly(languages: codly-languages)
#codly(display-icon: false)

#set page(margin: 0pt) 
   #page(
    background: image(
     "Cover.jpeg",
     width: 21.1cm, 
     height: 29.8cm, 
     fit: "cover"
   ),
   place(
     center, 
     block(
       width: 50%, 
       text(white, 2em, "")
     )
   )
 )
#set page(margin: auto)
#set text(
  font: "New Computer Modern Math",
)
#set page(
  numbering: "1",
)
#set heading(
  numbering: "1.",
)
#show raw.where(block: true): block.with(fill: luma(240), inset: 8pt, radius: 4pt)

#show link: underline

#outline()
#pagebreak()

#align(
  center+horizon, 
  text(50pt)[
    T.U.R.A.
  ],
)
#align(
  center+horizon, 
  text(20pt)[
    By Taksh Kothari and Apurva Bhat
  ],
)
#align(
  center+horizon, 
  text(17pt)[
    Mentored by Vinit Ajgaonkar
  ],
)




