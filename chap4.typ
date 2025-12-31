#import "@preview/cetz:0.4.2"
#import "@preview/board-n-pieces:0.7.0": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()
#codly(languages: codly-languages)
#codly(display-icon: false)

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

= Graph Algorithms

\

== Counting Rooms

\
#link("https://cses.fi/problemset/task/1192")[Question - Labyrinth]
#h(0.5cm)
#link("https://web.archive.org/web/20250708150420/https://cses.fi/problemset/task/1192/")[Backup Link]

\
*Explanation* :

A room is just a group of floor squares that are connected. You can move between them up, down, left, or right. Our goal is to count how many separate rooms exist. 
Here’s the algorithm:

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

// Movement in 4 directions: right, left, down, up
int dx[] = {0, 0, 1, -1};
int dy[] = {1, -1, 0, 0};

// Check if a cell is inside the grid, unvisited, and is floor
bool isValid(ll x, ll y) {
    return x >= 0 && x < n && y >= 0 && y < m && !visited[x][y] && grid[x][y] == '.';
}

// DFS to mark all connected floor cells of one room
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

    // Read the grid
    for (int i = 0; i < n; ++i)
        cin >> grid[i];

    // Traverse all cells to find unvisited rooms
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < m; ++j) {
            if (!visited[i][j] && grid[i][j] == '.') {
                dfs(i, j);   // Explore the full room
                rooms++;     // Count one room
            }
        }
    }

    cout << rooms << "\n";
    return 0;
}
```
#pagebreak()

== Labyrinth

\
#link("https://cses.fi/problemset/task/1193")[Question - Labyrinth]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1193")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Building Roads

\
#link("https://cses.fi/problemset/task/1666")[Question - Building Roads]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1666")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Message Route

\
#link("https://cses.fi/problemset/task/1667")[Question - Message Route]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1667")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Building Teams

\
#link("https://cses.fi/problemset/task/1668")[Question - Building Teams]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1668")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Round Trip

\
#link("https://cses.fi/problemset/task/1669")[Question - Round Trip]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1669")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Monsters

\
#link("https://cses.fi/problemset/task/1194")[Question - Monsters]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1194")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Shortest Routes I

\
#link("https://cses.fi/problemset/task/1671")[Question - Shortest Routes I]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1671")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Shortest Routes II

\
#link("https://cses.fi/problemset/task/1672")[Question - Shortest Routes II]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1672")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== High Score

\
#link("https://cses.fi/problemset/task/1673")[Question - High Score]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1673")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Flight Discount

\
#link("https://cses.fi/problemset/task/1195")[Question - Flight Discount]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1195")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Cycle Finding

\
#link("https://cses.fi/problemset/task/1197")[Question - Cycle Finding]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1197")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Flight Routes

\
#link("https://cses.fi/problemset/task/1196")[Question - Flight Routes]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1196")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Round Trip II

\
#link("https://cses.fi/problemset/task/1678")[Question - Round Trip II]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1678")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Course Schedule

\
#link("https://cses.fi/problemset/task/1679")[Question - Course Schedule]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1679")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Longest Flight Route

\
#link("https://cses.fi/problemset/task/1680")[Question - Longest Flight Route]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1680")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Game Routes

\
#link("https://cses.fi/problemset/task/1681")[Question - Game Routes]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1681")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Investigation

\
#link("https://cses.fi/problemset/task/1202")[Question - Investigation]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1202")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Planets Queries I

\
#link("https://cses.fi/problemset/task/1750")[Question - Planets Queries I]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1750")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Planets Queries II

\
#link("https://cses.fi/problemset/task/1160")[Question - Planets Queries II]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1160")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Planets Cycles

\
#link("https://cses.fi/problemset/task/1751")[Question - Planets Cycles]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1751")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Road Reparation

\
#link("https://cses.fi/problemset/task/1675")[Question - Road Reparation]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1675")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Road Construction

\
#link("https://cses.fi/problemset/task/1676")[Question - Road Construction]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1676")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Flight Routes Check

\
#link("https://cses.fi/problemset/task/1682")[Question - Flight Routes Check]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1682")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Planets and Kingdoms

\
#link("https://cses.fi/problemset/task/1683")[Question - Planets and Kingdoms]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1683")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Giant Pizza

\
#link("https://cses.fi/problemset/task/1684")[Question - Giant Pizza]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1684")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Coin Collector

\
#link("https://cses.fi/problemset/task/1686")[Question - Coin Collector]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1686")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Mail Delivery

\
#link("https://cses.fi/problemset/task/1691")[Question - Mail Delivery]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1691")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== De Bruijn Sequence

\
#link("https://cses.fi/problemset/task/1692")[Question - De Bruijn Sequence]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1692")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Teleporters Path

\
#link("https://cses.fi/problemset/task/1693")[Question - Teleporters Path]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1693")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Hamiltonian Flights

\
#link("https://cses.fi/problemset/task/1690")[Question - Hamiltonian Flights]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1690")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Knight's Tour

\
#link("https://cses.fi/problemset/task/1689")[Question - Knight's Tour]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1689")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Download Speed

\
#link("https://cses.fi/problemset/task/1694")[Question - Download Speed]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1694")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Police Chase

\
#link("https://cses.fi/problemset/task/1695")[Question - Police Chase]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1695")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== School Dance

\
#link("https://cses.fi/problemset/task/1696")[Question - School Dance]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1696")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Distinct Routes

\
#link("https://cses.fi/problemset/task/1711")[Question - Distinct Routes]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1711")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()