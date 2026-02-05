#import "@preview/cetz:0.4.2"
#import "@preview/cetz:0.4.2"
#import "@preview/board-n-pieces:0.7.0": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#set page(
  width: 8.5in,
  height: 11in,
  margin: 0pt,
  fill: black,
)

#set text(fill: white)

// Pixelated/retro font styling
#let pixel-text(content, size: 24pt, color: rgb("#00FFFF")) = {
  text(
    size: size,
    weight: "bold",
    font: "Courier New",
    fill: color,
    content
  )
}
#import "@preview/cetz:0.2.2"

// Main cover
#align(center + horizon)[
  #cetz.canvas({
    import cetz.draw: *
    
    // Draw neon grid background
    for i in range(-10, 11, 2) {
      line(
        (i, -15),
        (i, 15),
        stroke: (paint: rgb(0, 255, 255, 30), thickness: 0.5pt)
      )
    }
  })
]
    for i in range(-15, 16, 2) {
      line(
        (-10, i),
        (10, i),
        stroke: (paint: rgb(0, 255, 255, 30), thickness: 0.5pt)
      )
    }
    
    // Neon glowing circles
    circle(
      (-6, 8),
      radius: 1.5,
      stroke: (paint: rgb(255, 0, 255), thickness: 2pt),
      fill: none
    )
    
    circle(
      (6, -8),
      radius: 1.2,
      stroke: (paint: rgb(0, 255, 0), thickness: 2pt),
      fill: none
    )
    
    circle(
      (7, 9),
      radius: 0.8,
      stroke: (paint: rgb(255, 255, 0), thickness: 2pt),
      fill: none
    )
    
    // Draw connecting lines between circles (circuit style)
    line(
      (-6, 8),
      (0, 4),
      (6, -8),
      stroke: (paint: rgb(255, 0, 255, 100), thickness: 1.5pt)
    )
    
    // Neon triangles
    line(
      (-8, -6),
      (-5, -9),
      (-10, -9),
      (-8, -6),
      stroke: (paint: rgb(0, 255, 255), thickness: 2pt),
      fill: rgb(0, 255, 255, 20)
    )
    
    line(
      (5, 5),
      (8, 3),
      (6, 2),
      (5, 5),
      stroke: (paint: rgb(255, 0, 255), thickness: 2pt),
      fill: rgb(255, 0, 255, 20)
    )
    
    // Pixelated rectangles
    rect(
      (-9, 2),
      (-7, 4),
      stroke: (paint: rgb(0, 255, 0), thickness: 2pt),
      fill: rgb(0, 255, 0, 30)
    )
    
    rect(
      (7, -2),
      (9, -4),
      stroke: (paint: rgb(255, 255, 0), thickness: 2pt),
      fill: rgb(255, 255, 0, 30)
    )
  })
]

// Title and subtitle overlay
#place(
  top + center,
  dy: 25%,
  [
    #block(
      width: 100%,
      [
        #align(center)[
          // Main title with neon glow effect
          #text(
            size: 72pt,
            weight: "black",
            font: "Courier New",
            fill: rgb(0, 255, 255),
            tracking: 3pt,
            [THE CODE]
          )
          
          #v(-0.5em)
          
          #text(
            size: 64pt,
            weight: "black",
            font: "Courier New",
            fill: rgb(255, 0, 255),
            tracking: 3pt,
            [BOOK]
          )
          
          #v(1em)
          
          // Pixelated divider
          #box(
            width: 60%,
            height: 4pt,
            fill: gradient.linear(
              rgb(0, 255, 255),
              rgb(255, 0, 255),
              rgb(255, 255, 0),
            )
          )
          
          #v(1.5em)
          
          // Subtitle
          #text(
            size: 24pt,
            weight: "bold",
            font: "Courier New",
            fill: rgb(0, 255, 0),
            tracking: 2pt,
            [MASTER THE ART OF PROGRAMMING]
          )
          
          #v(0.5em)
          
          // Binary code decoration
          #text(
            size: 14pt,
            font: "Courier New",
            fill: rgb(0, 255, 255, 150),
            [01001000 01000101 01001100 01001100 01001111]
          )
        ]
      ]
    )
  ]
)

// Bottom text
#place(
  bottom + center,
  dy: -8%,
  [
    #align(center)[
      #text(
        size: 18pt,
        weight: "bold",
        font: "Courier New",
        fill: rgb(255, 0, 255),
        tracking: 1pt,
        [EDITION 2026]
      )
      
      #v(0.5em)
      
      #box(
        width: 40%,
        height: 2pt,
        fill: gradient.linear(
          rgb(255, 0, 255),
          rgb(0, 255, 255),
        )
      )
      
      #v(0.5em)
      
      #text(
        size: 16pt,
        font: "Courier New",
        fill: rgb(255, 255, 0),
        [>>> EXECUTE_YOUR_POTENTIAL()]
      )
    ]
  ]
)
