#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()
#codly(languages: codly-languages)
#codly(display-icon: false)


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
*Explanation* : 

A room is just a group of floor squares that are connected—you can move between them up, down, left, or right. Our goal is to count how many separate rooms exist. Here’s the algorithm:

+ Scan each cell in the grid.

+ If you find an unvisited floor cell (.), that means you’ve discovered a new room.

+ Run a DFS from that cell: move to all connected floor cells, marking them as visited.

+ Continue scanning the grid. Every time you start a new DFS, that’s a new room.

At the end, the number of DFS calls equals the number of rooms.

\
*Code :*
  
```cpp 
#include <bits/stdc++.h>
using namespace std;
using ll = long long;
 
int n, m, rooms = 0;
vector<string> grid;
vector<vector<bool>> visited; 
 
/*  Directions for exploring neighbors (right, left, down, up).
    These vectors just store the change in x & y values as we move up, down, left, right
    Example : an increase in y by 1 represents a move to the square toward the right
*/ 
int dx[] = {0, 0, 1, -1};
int dy[] = {1, -1, 0, 0};
 
// return true is square is inside the grid, is not visited and is a floor 
bool isValid(ll x, ll y) {
    return x >= 0 && x < n && y >= 0 && y < m && !visited[x][y] && grid[x][y] == '.';
}
 
// Depth-First Search to explore a room
void dfs(int x, int y) {
    visited[x][y] = true;
    for (int d = 0; d < 4; ++d) {
        int nx = x + dx[d]; 
        int ny = y + dy[d];
 
        if (isValid(nx, ny))
            dfs(nx, ny);
    }
}
 
int main() {
    cin >> n >> m;
    grid.resize(n);
    visited.resize(n, vector<bool>(m, false));
 
    for (int i = 0; i < n; ++i)
        cin >> grid[i]; 
 
    // Traverse each cell of the grid
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < m; ++j) {
 
            // If the cell is an unvisited empty floor, it's part of a new room
            if (!visited[i][j] && grid[i][j] == '.') {
                dfs(i, j);     // Explore the entire room
                rooms++;       // Increment room count
            }
        }
    }
 
    cout << rooms << "\n";
    return 0;
}

```
#pagebreak()


