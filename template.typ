#import "@preview/cetz:0.4.2"
#import "@preview/board-n-pieces:0.7.0": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()
#codly(languages: codly-languages)
#codly(display-icon: false)


#set text(
  font: "New Computer Modern Math"
)

#set page(
  numbering: "1"
)

#set heading(
  numbering: "1."
)

#show link: underline

#show raw.where(block: true): block.with(fill: luma(240), inset: 8pt, radius: 4pt)

BASIC TEMPLATE FOR ANY QUESTION : 

== name

\

#link("https://cses.fi/problemset/task/1618")[Question - Trailing Zeros]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1618")[Backup Link]

\

*Hint:*

*Solution:*

*Code:*

```cpp  
// code goes here
```

#pagebreak()

