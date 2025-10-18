#set text(
  font: "New Computer Modern Math"
)
#set heading(numbering: "1.")
#outline()
#pagebreak()

= Graph Algorithms
#show raw.where(block: true): block.with(fill: luma(240), inset: 8pt, radius: 4pt)
== Counting Rooms

\
#link("https://cses.fi/problemset/task/1617")[
  Question -  https://cses.fi/problemset/task/1617
]
#h(0.5cm)   
#link("https://web.archive.org/web/20250422114946/https://www.cses.fi/problemset/task/1617/")[
  Backup Link  
]

\
*Intuitive Explanation* : 

A room is just a group of floor squares that are connected—you can move between them up, down, left, or right. Our goal is to count how many separate rooms exist. Here’s the algorithm:

+ Scan each cell in the grid.

+ If you find an unvisited floor cell (.), that means you’ve discovered a new room.

+ Run a DFS from that cell: move to all connected floor cells, marking them as visited.

+ Continue scanning the grid. Every time you start a new DFS, that’s a new room.

At the end, the number of DFS calls equals the number of rooms.

\
*Code :*
  
```cpp 
#include <iostream>
#include <vector>
using namespace std;
 
const int MOD = 1e9 + 7; // modulus to avoid large numbers
 
int main() {
    int n;
    cin >> n;
 
    // dp[i] = number of ways to get sum i using dice
    vector<int> dp(n + 1, 0);
    dp[0] = 1; // base case: one way to form sum 0 (choose nothing)
 
    // Fill dp for all sums from 1 to n
    for (int i = 1; i <= n; ++i) {
        // Consider the last dice roll (values 1 to 6)
        for (int j = 1; j <= 6; ++j) {
            if (i - j >= 0) {
                // Add ways of forming (i - j) since we can extend with roll j
                dp[i] = (dp[i] + dp[i - j]) % MOD;
            }
        }
    }
 
    // Output number of ways to form sum n
    cout << dp[n] << endl;
    return 0;
}


```
#pagebreak()


