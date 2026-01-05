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
#pagebreak()

#set heading(
  numbering: "1.",
)
#show raw.where(block: true): block.with(fill: luma(240), inset: 8pt, radius: 4pt)

#show link: underline

#outline()
#pagebreak()

= Preface

This is a book meant for competitive programming. We wrote this book because we felt that other resources while good, lacked the ability to explain more complex topics well. Editorial written to questions that we used to practice were also not written well for the most complex problem. Sometimes even if an editorial is written well, we'd first spend hours trying to solve the question before looking up the solution and then realise we needed some well known concept. To solve this frustration and give you, the reader, the ability to solve as many questions on your own. We first go through all the concepts required to solve a bunch of questions and then provide hints and solutions to the questions.

We're using the CSES Problem Set as our question bank and you can go and create an account there and start solving. Depending on how much programming and c++ you know, you can first skim through the concepts required for the section of the CSES Problem Set that you're working on and make sure you know them well enough. If you do get stuck despite knowing the concepts, there are hints to give you a little help and the full solution, well written and easy to understand there for you. 

This book does expect some basic knowledge about programming in at least 1 programming language even if that language isn't c++. If you are completely new to programmer, we have linked a resource in the first section where you can learn the basics.

We hope this will help you become a better competitive programmer.

#align(right)[
  Taksh Kothari and Apurva Bhat.
]
