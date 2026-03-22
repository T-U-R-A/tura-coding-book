#import "@preview/cetz:0.3.4": canvas, draw
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

_This chapter covers graph algorithm problems. For foundational concepts, see the Concepts section: *What is a Graph?* for graph representations, *DFS* for Depth-First Search, *BFS* for Breadth-First Search, *Dijkstra's Algorithm* for weighted shortest paths, and *DSU* for Disjoint Set Union._

\

== Counting Rooms

\
#link("https://cses.fi/problemset/task/1192")[Question - Labyrinth]
#h(0.5cm)
#link("https://web.archive.org/web/20250708150420/https://cses.fi/problemset/task/1192/")[Backup Link]

\
*Explanation* :

_Concepts used: *DFS* (Depth-First Search) - see Concepts_

A room is just a group of floor squares that are connected. You can move between them up, down, left, or right. Our goal is to count how many separate rooms exist.
Here's the algorithm:

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

_Concepts used: *BFS* (Breadth-First Search) - see Concepts_

Given a grid map where `.` represents floor and `#` represents walls, we need to find the shortest path from cell `A` (start) to cell `B` (end). If a path exists, we must also output the actual path using directions: L (left), R (right), U (up), D (down).

Why BFS Works:
BFS explores cells layer by layer based on distance from the source. Since all moves have equal cost (1 step), the first time we reach the destination is guaranteed to be via the shortest path. This is the key property that makes BFS optimal for unweighted shortest paths.

Algorithm:
1. Find positions of A and B in the grid
2. Start BFS from A, marking cells as visited
3. For each cell, try all 4 directions
4. Track the parent of each cell to reconstruct the path
5. When B is reached, backtrack through parents to build the path string

#figure(
  canvas({
    import draw: *

    content((4, 6), [Example: Find path from A to B])

    // Draw grid 5x5
    let grid_data = (
      (".", ".", "#", ".", "."),
      (".", "#", ".", ".", "."),
      ("A", ".", ".", "#", "B"),
      (".", "#", ".", ".", "."),
      (".", ".", ".", ".", ".")
    )

    for i in range(5) {
      for j in range(5) {
        let cell = grid_data.at(i).at(j)
        let fill_color = if cell == "#" { black } else if cell == "A" { rgb("#90EE90") } else if cell == "B" { rgb("#FFB6C1") } else { white }
        rect((0.5 + j * 0.7, 5 - i * 0.7), (1.2 + j * 0.7, 5.7 - i * 0.7), fill: fill_color, stroke: 0.5pt)
        if cell != "#" and cell != "." {
          content((0.85 + j * 0.7, 5.35 - i * 0.7), text(size: 10pt, weight: "bold")[#cell])
        }
      }
    }

    // Show BFS levels
    content((5.5, 5.35), text(fill: blue, size: 9pt)[Level 0: A])
    content((5.5, 4.95), text(fill: blue, size: 9pt)[Level 1: neighbors of A])
    content((5.5, 4.55), text(fill: blue, size: 9pt)[Level 2: ...])
    content((5.5, 4.15), text(fill: blue, size: 9pt)[...])

    // Draw path with arrows
    line((1.2, 3.65), (1.55, 3.65), stroke: (paint: red, thickness: 1.5pt), mark: (end: ">"))
    line((1.55, 3.65), (1.9, 3.65), stroke: (paint: red, thickness: 1.5pt), mark: (end: ">"))
    line((2.25, 3.65), (2.6, 3.65), stroke: (paint: red, thickness: 1.5pt), mark: (end: ">"))
    line((2.95, 3.65), (2.95, 4.0), stroke: (paint: red, thickness: 1.5pt), mark: (end: ">"))
    line((2.95, 4.35), (3.3, 4.35), stroke: (paint: red, thickness: 1.5pt), mark: (end: ">"))
    line((3.65, 4.35), (3.65, 3.95), stroke: (paint: red, thickness: 1.5pt), mark: (end: ">"))
    line((3.65, 3.65), (4.0, 3.65), stroke: (paint: red, thickness: 1.5pt), mark: (end: ">"))

    content((4, 1.8), text(fill: red)[Path: RRRURDRD (length 8)])
    content((4, 1.3), [BFS guarantees this is the shortest!])
  })
)

BFS Exploration Order:
```
Step 0: Start at A (2,0)
        Queue: [(2,0)]

Step 1: Process (2,0), add neighbors
        Visit: (1,0), (2,1), (3,0)
        Queue: [(1,0), (2,1), (3,0)]

Step 2: Process neighbors, expand further
        Each level = 1 more step from start

Step N: First time we see B = shortest path found!
```

Key Implementation Details:
- Use a parent array to store where each cell was reached from
- Store both the parent position and the direction taken
- After reaching B, backtrack from B to A using parents
- Reverse the path string since we built it backwards

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int n, m;
vector<string> grid;
vector<vector<bool>> visited;
vector<vector<pair<int,int>>> parent;
vector<vector<char>> dir;

int dx[] = {0, 0, 1, -1};
int dy[] = {1, -1, 0, 0};
char dc[] = {'R', 'L', 'D', 'U'};

bool isValid(int x, int y) {
    return x >= 0 && x < n && y >= 0 && y < m &&
           !visited[x][y] && grid[x][y] != '#';
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> m;
    grid.resize(n);
    visited.resize(n, vector<bool>(m, false));
    parent.resize(n, vector<pair<int,int>>(m, {-1, -1}));
    dir.resize(n, vector<char>(m, ' '));

    int ax, ay, bx, by;
    for (int i = 0; i < n; i++) {
        cin >> grid[i];
        for (int j = 0; j < m; j++) {
            if (grid[i][j] == 'A') { ax = i; ay = j; }
            if (grid[i][j] == 'B') { bx = i; by = j; }
        }
    }

    // BFS
    queue<pair<int,int>> q;
    q.push({ax, ay});
    visited[ax][ay] = true;

    while (!q.empty()) {
        auto [x, y] = q.front();
        q.pop();

        if (x == bx && y == by) {
            // Reconstruct path
            string path = "";
            int cx = bx, cy = by;
            while (cx != ax || cy != ay) {
                path += dir[cx][cy];
                auto [px, py] = parent[cx][cy];
                cx = px; cy = py;
            }
            reverse(path.begin(), path.end());
            cout << "YES\n" << path.length() << "\n" << path << "\n";
            return 0;
        }

        for (int d = 0; d < 4; d++) {
            int nx = x + dx[d];
            int ny = y + dy[d];
            if (isValid(nx, ny)) {
                visited[nx][ny] = true;
                parent[nx][ny] = {x, y};
                dir[nx][ny] = dc[d];
                q.push({nx, ny});
            }
        }
    }

    cout << "NO\n";
    return 0;
}
```
#pagebreak()

== Building Roads

\
#link("https://cses.fi/problemset/task/1666")[Question - Building Roads]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1666")[Backup Link]

\
*Explanation* :

_Concepts used: *DFS* (for finding connected components) - see Concepts_

We have `n` cities and `m` existing roads. Some cities may not be connected to others. Our task is to find the minimum number of new roads needed to connect all cities, and output which cities should be connected.

Key Insight:
The graph may consist of multiple disconnected components. To make the entire graph connected, we need to link these components together. If there are `k` connected components, we need exactly `k-1` new roads.

Algorithm:
1. Find all connected components using DFS/BFS
2. Pick one representative city from each component
3. Connect consecutive components: link component 1 to component 2, component 2 to component 3, etc.

Why k-1 Roads?
Think of it like connecting islands with bridges. With k islands, you need k-1 bridges to form a single connected landmass. Each bridge reduces the number of separate components by 1.

#figure(
  canvas({
    import draw: *

    content((4, 6.2), [Example: 5 cities, 2 roads: (1,2) and (3,4)])

    // Component 1: nodes 1, 2
    circle((1.5, 4.5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((1.5, 4.5), [1])
    circle((2.5, 4.5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2.5, 4.5), [2])
    line((1.8, 4.5), (2.2, 4.5), stroke: 1.5pt)

    // Component 2: nodes 3, 4
    circle((4.5, 4.5), radius: 0.3, fill: rgb("#90EE90"), stroke: 1pt)
    content((4.5, 4.5), [3])
    circle((5.5, 4.5), radius: 0.3, fill: rgb("#90EE90"), stroke: 1pt)
    content((5.5, 4.5), [4])
    line((4.8, 4.5), (5.2, 4.5), stroke: 1.5pt)

    // Component 3: node 5
    circle((7, 4.5), radius: 0.3, fill: rgb("#FFB6C1"), stroke: 1pt)
    content((7, 4.5), [5])

    // Labels
    content((2, 3.8), text(fill: blue, size: 9pt)[Component 1])
    content((5, 3.8), text(fill: green, size: 9pt)[Component 2])
    content((7, 3.8), text(fill: red, size: 9pt)[Component 3])

    // New roads needed
    content((4, 2.8), text(weight: "bold")[New roads needed: 2])

    // Show the connections
    line((2.8, 4.5), (4.2, 4.5), stroke: (paint: red, thickness: 2pt, dash: "dashed"), mark: (end: ">", start: ">"))
    content((3.5, 4.9), text(fill: red, size: 8pt)[Road 1])

    line((5.8, 4.5), (6.7, 4.5), stroke: (paint: red, thickness: 2pt, dash: "dashed"), mark: (end: ">", start: ">"))
    content((6.25, 4.9), text(fill: red, size: 8pt)[Road 2])

    content((4, 2.2), [Output: 2 → 3, 4 → 5])
    content((4, 1.6), text(fill: gray, size: 9pt)[Any representative from each component works])
  })
)

Finding Connected Components:
```
DFS from city 1: visits {1, 2} → Component 1
DFS from city 3: visits {3, 4} → Component 2
DFS from city 5: visits {5}    → Component 3

Components found: 3
Roads needed: 3 - 1 = 2

Connect: 1→3 (or 2→3, 1→4, 2→4)
Connect: 3→5 (or 4→5)
```

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int n, m;
vector<vector<int>> adj;
vector<bool> visited;
vector<int> component_rep;  // One node from each component

void dfs(int u) {
    visited[u] = true;
    for (int v : adj[u]) {
        if (!visited[v]) {
            dfs(v);
        }
    }
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> m;
    adj.resize(n + 1);
    visited.resize(n + 1, false);

    for (int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back(b);
        adj[b].push_back(a);
    }

    // Find all connected components
    for (int i = 1; i <= n; i++) {
        if (!visited[i]) {
            component_rep.push_back(i);  // Save one representative
            dfs(i);
        }
    }

    // Number of new roads = number of components - 1
    int roads_needed = component_rep.size() - 1;
    cout << roads_needed << "\n";

    // Connect consecutive components
    for (int i = 0; i < roads_needed; i++) {
        cout << component_rep[i] << " " << component_rep[i + 1] << "\n";
    }

    return 0;
}
```
#pagebreak()

== Message Route

\
#link("https://cses.fi/problemset/task/1667")[Question - Message Route]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1667")[Backup Link]

\
*Explanation* :

_Concepts used: *BFS* (shortest path in unweighted graphs) - see Concepts_

Syrjälä's network has `n` computers and `m` connections. We need to find the minimum number of computers a message must pass through to get from computer 1 to computer n, and output the actual route.

This is a classic shortest path problem in an unweighted graph. BFS is perfect here because it explores nodes level by level, guaranteeing the first path found to any node is the shortest.

Algorithm:
1. Start BFS from computer 1
2. For each computer, track which computer we came from (parent)
3. When we reach computer n, backtrack through parents to reconstruct the path
4. If computer n is never reached, output "IMPOSSIBLE"

Why BFS Guarantees Shortest Path:
BFS visits all nodes at distance 1 first, then all nodes at distance 2, and so on. The first time we reach the destination, we've found it via the minimum number of edges.

#figure(
  canvas({
    import draw: *

    content((4, 6.2), [Example: 5 computers, route from 1 to 5])

    // Draw nodes
    circle((1, 4.5), radius: 0.35, fill: rgb("#90EE90"), stroke: 1.5pt)
    content((1, 4.5), text(weight: "bold")[1])

    circle((2.5, 5.2), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2.5, 5.2), [2])

    circle((2.5, 3.8), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2.5, 3.8), [3])

    circle((4.5, 5.2), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((4.5, 5.2), [4])

    circle((6, 4.5), radius: 0.35, fill: rgb("#FFB6C1"), stroke: 1.5pt)
    content((6, 4.5), text(weight: "bold")[5])

    // Draw edges
    line((1.35, 4.7), (2.15, 5.0), stroke: 1pt)
    line((1.35, 4.3), (2.15, 4.0), stroke: 1pt)
    line((2.85, 5.2), (4.15, 5.2), stroke: 1pt)
    line((2.85, 3.8), (4.15, 4.9), stroke: 1pt)
    line((4.85, 5.0), (5.65, 4.7), stroke: 1pt)

    // BFS levels
    content((1, 3.5), text(fill: green, size: 8pt)[Level 0])
    content((2.5, 3.0), text(fill: blue, size: 8pt)[Level 1])
    content((4.5, 4.4), text(fill: blue, size: 8pt)[Level 2])
    content((6, 3.7), text(fill: red, size: 8pt)[Level 3])

    // Highlight shortest path
    line((1.35, 4.7), (2.15, 5.0), stroke: (paint: red, thickness: 2.5pt))
    line((2.85, 5.2), (4.15, 5.2), stroke: (paint: red, thickness: 2.5pt))
    line((4.85, 5.0), (5.65, 4.7), stroke: (paint: red, thickness: 2.5pt))

    content((3.5, 2.3), text(fill: red, weight: "bold")[Shortest path: 1 → 2 → 4 → 5])
    content((3.5, 1.7), [Length: 4 computers])
  })
)

BFS Trace:
```
Start: queue = [1], parent[1] = -1

Step 1: Process node 1
        Neighbors: 2, 3
        parent[2] = 1, parent[3] = 1
        queue = [2, 3]

Step 2: Process node 2
        Neighbors: 4
        parent[4] = 2
        queue = [3, 4]

Step 3: Process node 3
        Neighbors: 4 (already visited)
        queue = [4]

Step 4: Process node 4
        Neighbors: 5
        parent[5] = 4
        FOUND! Destination reached.

Backtrack: 5 ← 4 ← 2 ← 1
Path: 1 → 2 → 4 → 5
```

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    vector<vector<int>> adj(n + 1);
    for (int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back(b);
        adj[b].push_back(a);
    }

    vector<int> parent(n + 1, -1);
    vector<bool> visited(n + 1, false);

    queue<int> q;
    q.push(1);
    visited[1] = true;

    while (!q.empty()) {
        int u = q.front();
        q.pop();

        if (u == n) {
            // Reconstruct path
            vector<int> path;
            int curr = n;
            while (curr != -1) {
                path.push_back(curr);
                curr = parent[curr];
            }
            reverse(path.begin(), path.end());

            cout << path.size() << "\n";
            for (int node : path) {
                cout << node << " ";
            }
            cout << "\n";
            return 0;
        }

        for (int v : adj[u]) {
            if (!visited[v]) {
                visited[v] = true;
                parent[v] = u;
                q.push(v);
            }
        }
    }

    cout << "IMPOSSIBLE\n";
    return 0;
}
```
#pagebreak()

== Building Teams

\
#link("https://cses.fi/problemset/task/1668")[Question - Building Teams]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1668")[Backup Link]

\
*Explanation* :

_Concepts used: *BFS* (Graph coloring / bipartite checking) - see Concepts_

We have `n` pupils and `m` friendships. We need to divide all pupils into two teams such that no two friends are on the same team. This is the classic *bipartite graph checking* problem.

Key Insight:
A graph can be divided into two groups with no edges within a group if and only if it is *bipartite*. A graph is bipartite if and only if it contains no odd-length cycles.

Algorithm (Graph Coloring with BFS/DFS):
1. Try to color each node with one of two colors (1 or 2)
2. Adjacent nodes must have different colors
3. If we ever try to color a node that's already colored with the opposite color, the graph is not bipartite
4. Process all connected components (the graph may be disconnected)

#figure(
  canvas({
    import draw: *

    content((4, 6.5), [Bipartite Check: Can we 2-color the graph?])

    // Bipartite example (left)
    content((2, 5.8), text(fill: green, weight: "bold")[Bipartite (YES)])

    circle((1, 4.8), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((1, 4.8), [1])
    circle((2, 5.3), radius: 0.3, fill: rgb("#FFB6C1"), stroke: 1pt)
    content((2, 5.3), [2])
    circle((2, 4.3), radius: 0.3, fill: rgb("#FFB6C1"), stroke: 1pt)
    content((2, 4.3), [3])
    circle((3, 4.8), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((3, 4.8), [4])

    line((1.3, 4.95), (1.7, 5.15), stroke: 1pt)
    line((1.3, 4.65), (1.7, 4.45), stroke: 1pt)
    line((2.3, 5.15), (2.7, 4.95), stroke: 1pt)
    line((2.3, 4.45), (2.7, 4.65), stroke: 1pt)

    content((2, 3.6), text(size: 8pt)[Team 1: \{1, 4\}])
    content((2, 3.2), text(size: 8pt)[Team 2: \{2, 3\}])

    // Non-bipartite example (right) - triangle
    content((6, 5.8), text(fill: red, weight: "bold")[Not Bipartite (NO)])

    circle((5.5, 5.0), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((5.5, 5.0), [1])
    circle((6.5, 5.0), radius: 0.3, fill: rgb("#FFB6C1"), stroke: 1pt)
    content((6.5, 5.0), [2])
    circle((6, 4.2), radius: 0.3, fill: rgb("#FFFF99"), stroke: 1pt)
    content((6, 4.2), [3])

    line((5.8, 5.0), (6.2, 5.0), stroke: 1pt)
    line((5.65, 4.72), (5.85, 4.48), stroke: 1pt)
    line((6.35, 4.72), (6.15, 4.48), stroke: 1pt)

    content((6, 3.6), text(size: 8pt, fill: red)[Odd cycle!])
    content((6, 3.2), text(size: 8pt)[Node 3 needs a 3rd color])

    // Coloring process
    content((4, 2.4), text(weight: "bold")[Coloring Process:])
    content((4, 1.9), text(size: 9pt)[Start node 1 with color 1])
    content((4, 1.5), text(size: 9pt)[Color all neighbors with color 2])
    content((4, 1.1), text(size: 9pt)[Color their neighbors with color 1, etc.])
    content((4, 0.7), text(size: 9pt, fill: red)[Conflict = IMPOSSIBLE])
  })
)

BFS Coloring Trace:
```
Graph: 1-2, 2-3, 3-1 (triangle)

Start: color[1] = 1
Process 1: neighbor 2 → color[2] = 2
           neighbor 3 → color[3] = 2
Process 2: neighbor 1 (already colored 1, OK - different)
           neighbor 3 (already colored 2, OK - different)
Process 3: neighbor 1 (colored 1, we are 2 - OK)
           neighbor 2 (colored 2, we are 2 - CONFLICT!)

Result: IMPOSSIBLE (odd cycle detected)
```

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    vector<vector<int>> adj(n + 1);
    for (int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back(b);
        adj[b].push_back(a);
    }

    vector<int> team(n + 1, 0);  // 0 = unvisited, 1 or 2 = team number
    bool possible = true;

    // Process all components
    for (int start = 1; start <= n && possible; start++) {
        if (team[start] != 0) continue;

        queue<int> q;
        q.push(start);
        team[start] = 1;

        while (!q.empty() && possible) {
            int u = q.front();
            q.pop();

            for (int v : adj[u]) {
                if (team[v] == 0) {
                    // Assign opposite team
                    team[v] = 3 - team[u];  // If u is 1, v is 2; if u is 2, v is 1
                    q.push(v);
                } else if (team[v] == team[u]) {
                    // Same team as neighbor - conflict!
                    possible = false;
                }
            }
        }
    }

    if (possible) {
        for (int i = 1; i <= n; i++) {
            cout << team[i] << " ";
        }
        cout << "\n";
    } else {
        cout << "IMPOSSIBLE\n";
    }

    return 0;
}
```
#pagebreak()

== Round Trip

\
#link("https://cses.fi/problemset/task/1669")[Question - Round Trip]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1669")[Backup Link]

\
*Explanation* :

_Concepts used: *DFS* (Cycle detection) - see Concepts_

We need to find a route that starts and ends at the same city, visiting at least 3 cities. In graph terms, we need to find a *cycle* of length at least 3 in an undirected graph.

Key Insight:
During DFS, if we encounter a node that is already visited and is not the immediate parent of the current node, we have found a cycle! The path from that node to the current node, plus the back edge, forms the cycle.

Algorithm:
1. Run DFS from any unvisited node
2. Track the parent of each node to avoid going back immediately
3. If we reach a visited node that isn't our parent, we found a cycle
4. Reconstruct the cycle by backtracking through parents

Important: In an undirected graph, going back to the parent doesn't count as a cycle (that's just the same edge traversed twice).

#figure(
  canvas({
    import draw: *

    content((4, 6.5), [Cycle Detection with DFS])

    // Draw graph with cycle
    circle((1.5, 4.5), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((1.5, 4.5), [1])
    circle((3, 5.2), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((3, 5.2), [2])
    circle((4.5, 4.5), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((4.5, 4.5), [3])
    circle((3, 3.8), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((3, 3.8), [4])
    circle((6, 4.5), radius: 0.35, fill: rgb("#DDDDDD"), stroke: 1pt)
    content((6, 4.5), [5])

    // Edges
    line((1.85, 4.65), (2.65, 5.05), stroke: 1pt)
    line((3.35, 5.05), (4.15, 4.65), stroke: 1pt)
    line((4.2, 4.35), (3.3, 3.95), stroke: 1pt)  // Edge from node 3 to node 4
    line((3.3, 3.95), (4.2, 4.35), stroke: 1pt)
    line((1.85, 4.35), (2.65, 3.95), stroke: 1pt)
    line((4.85, 4.5), (5.65, 4.5), stroke: 1pt)

    // Cycle highlight
    line((1.85, 4.65), (2.65, 5.05), stroke: (paint: red, thickness: 2.5pt))
    line((3.35, 5.05), (4.15, 4.65), stroke: (paint: red, thickness: 2.5pt))
    line((3.3, 3.95), (4.2, 4.35), stroke: (paint: red, thickness: 2.5pt))
    line((1.85, 4.35), (2.65, 3.95), stroke: (paint: red, thickness: 2.5pt))

    content((3, 2.8), text(fill: red, weight: "bold")[Cycle: 1 → 2 → 3 → 4 → 1])

    // DFS tree illustration
    content((3, 1.8), text(size: 9pt)[DFS from 1: visits 2, then 3, then 4])
    content((3, 1.4), text(size: 9pt)[At 4: neighbor 1 is visited but not parent!])
    content((3, 1.0), text(size: 9pt, fill: green)[Back edge 4→1 reveals cycle])
  })
)

DFS Trace:
```
DFS(1): parent[1] = -1, visited[1] = true
  → DFS(2): parent[2] = 1, visited[2] = true
    → DFS(3): parent[3] = 2, visited[3] = true
      → DFS(4): parent[4] = 3, visited[4] = true
        → Check neighbor 1: visited AND not parent!
           CYCLE FOUND!

Backtrack from 4 to 1 using parents:
  4 → 3 → 2 → 1
Add the back edge to complete cycle:
  1 → 2 → 3 → 4 → 1

Output: 4 cities
        1 2 3 4 1
```

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int n, m;
vector<vector<int>> adj;
vector<bool> visited;
vector<int> parent;
int cycle_start = -1, cycle_end = -1;

bool dfs(int u, int p) {
    visited[u] = true;
    parent[u] = p;

    for (int v : adj[u]) {
        if (v == p) continue;  // Don't go back to parent

        if (visited[v]) {
            // Found a cycle!
            cycle_start = v;
            cycle_end = u;
            return true;
        }

        if (dfs(v, u)) return true;
    }
    return false;
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> m;
    adj.resize(n + 1);
    visited.resize(n + 1, false);
    parent.resize(n + 1, -1);

    for (int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back(b);
        adj[b].push_back(a);
    }

    // Try DFS from each unvisited node
    for (int i = 1; i <= n; i++) {
        if (!visited[i] && dfs(i, -1)) {
            // Reconstruct cycle
            vector<int> cycle;
            cycle.push_back(cycle_start);
            for (int curr = cycle_end; curr != cycle_start; curr = parent[curr]) {
                cycle.push_back(curr);
            }
            cycle.push_back(cycle_start);

            cout << cycle.size() << "\n";
            for (int node : cycle) {
                cout << node << " ";
            }
            cout << "\n";
            return 0;
        }
    }

    cout << "IMPOSSIBLE\n";
    return 0;
}
```
#pagebreak()

== Monsters

\
#link("https://cses.fi/problemset/task/1194")[Question - Monsters]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1194")[Backup Link]

\
*Explanation* :

_Concepts used: *BFS* (Multi-source BFS) - see Concepts_

You're trapped in a labyrinth with monsters. Each turn, you and all monsters move simultaneously. You escape if you reach a boundary cell before any monster catches you (reaches the same cell at the same time or earlier).

Key Insight - Multi-source BFS:
First, compute how quickly each monster can reach every cell using BFS starting from *all monsters simultaneously*. Then, BFS from your position, only moving to cells where you arrive strictly before any monster.

Algorithm:
1. *Monster BFS*: Start BFS from all monster positions at once (multi-source). This gives `monster_dist[i][j]` = minimum time for any monster to reach cell (i,j).
2. *Player BFS*: Start from player position. Only move to cell (nx, ny) if `player_time + 1 < monster_dist[nx][ny]`.
3. If player reaches any boundary cell, we have escaped!

Why Multi-source BFS?
Instead of running separate BFS for each monster (slow), we add all monsters to the initial queue. This computes the minimum distance from *any* monster to each cell in a single pass.

#figure(
  canvas({
    import draw: *

    content((4, 6.5), [Monster vs Player: Race to the Boundary])

    // Draw grid
    for i in range(5) {
      for j in range(5) {
        rect((0.5 + j * 0.8, 5.5 - i * 0.8), (1.3 + j * 0.8, 6.3 - i * 0.8), stroke: 0.5pt)
      }
    }

    // Boundary highlight
    for i in range(5) {
      rect((0.5, 5.5 - i * 0.8), (1.3, 6.3 - i * 0.8), fill: rgb("#90EE90").transparentize(50%), stroke: 0.5pt)
      rect((0.5 + 4 * 0.8, 5.5 - i * 0.8), (1.3 + 4 * 0.8, 6.3 - i * 0.8), fill: rgb("#90EE90").transparentize(50%), stroke: 0.5pt)
    }
    for j in range(1, 4) {
      rect((0.5 + j * 0.8, 5.5), (1.3 + j * 0.8, 6.3), fill: rgb("#90EE90").transparentize(50%), stroke: 0.5pt)
      rect((0.5 + j * 0.8, 5.5 - 4 * 0.8), (1.3 + j * 0.8, 6.3 - 4 * 0.8), fill: rgb("#90EE90").transparentize(50%), stroke: 0.5pt)
    }

    // Player
    content((0.9 + 2 * 0.8, 5.9 - 2 * 0.8), text(fill: blue, weight: "bold", size: 12pt)[A])

    // Monsters
    content((0.9 + 0.8, 5.9 - 0.8), text(fill: red, weight: "bold", size: 12pt)[M])
    content((0.9 + 3 * 0.8, 5.9 - 3 * 0.8), text(fill: red, weight: "bold", size: 12pt)[M])

    // Legend
    content((5.5, 5.5), text(size: 9pt)[Green = Boundary])
    content((5.5, 5.1), text(size: 9pt, fill: blue)[A = Player])
    content((5.5, 4.7), text(size: 9pt, fill: red)[M = Monster])

    // Explanation
    content((4, 2.3), text(weight: "bold")[Strategy:])
    content((4, 1.8), text(size: 9pt)[1. Compute monster arrival times for all cells])
    content((4, 1.4), text(size: 9pt)[2. Player BFS: only go where you beat monsters])
    content((4, 1.0), text(size: 9pt)[3. Escape = reach boundary before monsters])
  })
)

Example Trace:
```
Grid:        Monster distances:    Player can escape?
. M .        . 0 1                 Check each boundary cell:
. A .   →    1 1 2                 - If player_dist < monster_dist: YES
. . M        2 2 0

Player at (1,1), needs to reach boundary
Option: Go UP to (0,1)
  Player arrives at time 1
  Monster arrives at time 1
  1 < 1? NO - monster catches us!

Option: Go LEFT to (1,0)
  Player arrives at time 1
  Monster arrives at time 1
  Still no good...

Need to find path where we're strictly faster!
```

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int n, m;
vector<string> grid;
int dx[] = {0, 0, 1, -1};
int dy[] = {1, -1, 0, 0};
char dc[] = {'R', 'L', 'D', 'U'};

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> m;
    grid.resize(n);

    int ax, ay;
    vector<pair<int,int>> monsters;

    for (int i = 0; i < n; i++) {
        cin >> grid[i];
        for (int j = 0; j < m; j++) {
            if (grid[i][j] == 'A') { ax = i; ay = j; }
            if (grid[i][j] == 'M') monsters.push_back({i, j});
        }
    }

    // Monster BFS - multi-source
    vector<vector<int>> monster_dist(n, vector<int>(m, INT_MAX));
    queue<pair<int,int>> q;

    for (auto [mx, my] : monsters) {
        monster_dist[mx][my] = 0;
        q.push({mx, my});
    }

    while (!q.empty()) {
        auto [x, y] = q.front();
        q.pop();
        for (int d = 0; d < 4; d++) {
            int nx = x + dx[d], ny = y + dy[d];
            if (nx >= 0 && nx < n && ny >= 0 && ny < m &&
                grid[nx][ny] != '#' && monster_dist[nx][ny] == INT_MAX) {
                monster_dist[nx][ny] = monster_dist[x][y] + 1;
                q.push({nx, ny});
            }
        }
    }

    // Player BFS
    vector<vector<int>> player_dist(n, vector<int>(m, INT_MAX));
    vector<vector<pair<int,int>>> parent(n, vector<pair<int,int>>(m, {-1, -1}));
    vector<vector<char>> move_dir(n, vector<char>(m, ' '));

    player_dist[ax][ay] = 0;
    q.push({ax, ay});

    while (!q.empty()) {
        auto [x, y] = q.front();
        q.pop();

        // Check if we escaped (boundary cell)
        if (x == 0 || x == n-1 || y == 0 || y == m-1) {
            // Reconstruct path
            string path = "";
            int cx = x, cy = y;
            while (cx != ax || cy != ay) {
                path += move_dir[cx][cy];
                auto [px, py] = parent[cx][cy];
                cx = px; cy = py;
            }
            reverse(path.begin(), path.end());
            cout << "YES\n" << path.length() << "\n" << path << "\n";
            return 0;
        }

        for (int d = 0; d < 4; d++) {
            int nx = x + dx[d], ny = y + dy[d];
            if (nx >= 0 && nx < n && ny >= 0 && ny < m &&
                grid[nx][ny] != '#' && player_dist[nx][ny] == INT_MAX &&
                player_dist[x][y] + 1 < monster_dist[nx][ny]) {
                player_dist[nx][ny] = player_dist[x][y] + 1;
                parent[nx][ny] = {x, y};
                move_dir[nx][ny] = dc[d];
                q.push({nx, ny});
            }
        }
    }

    cout << "NO\n";
    return 0;
}
```
#pagebreak()

== Shortest Routes I

\
#link("https://cses.fi/problemset/task/1671")[Question - Shortest Routes I]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1671")[Backup Link]

\
*Explanation* :

_Concepts used: *Dijkstra's Algorithm* - see Concepts_

Find the shortest path from node 1 to all other nodes in a weighted directed graph. This is the classic *Dijkstra's algorithm* problem.

Why Not BFS?
BFS works for unweighted graphs (all edges cost 1). With varying edge weights, BFS doesn't guarantee shortest paths. An edge of weight 10 should "cost more" than 10 edges of weight 1.

Dijkstra's Key Idea:
Always process the unvisited node with the smallest known distance. Once processed, a node's distance is finalized (for non-negative weights). Use a priority queue to efficiently get the minimum.

Algorithm:
1. Initialize `dist[1] = 0`, all others = infinity
2. Add (0, 1) to priority queue (distance, node)
3. Extract minimum distance node, skip if already processed
4. For each neighbor, try to relax: if `dist[u] + weight < dist[v]`, update and add to queue
5. Repeat until queue is empty

#figure(
  canvas({
    import draw: *

    content((4, 6.5), [Dijkstra's Algorithm: Shortest Paths from Node 1])

    // Draw graph
    circle((1, 4.5), radius: 0.35, fill: rgb("#90EE90"), stroke: 1.5pt)
    content((1, 4.5), text(weight: "bold")[1])

    circle((3, 5.5), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((3, 5.5), [2])

    circle((3, 3.5), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((3, 3.5), [3])

    circle((5.5, 5.5), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((5.5, 5.5), [4])

    circle((5.5, 3.5), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((5.5, 3.5), [5])

    // Edges with weights
    line((1.35, 4.7), (2.65, 5.3), stroke: 1pt, mark: (end: ">"))
    content((1.8, 5.2), text(size: 8pt, fill: red)[2])

    line((1.35, 4.3), (2.65, 3.7), stroke: 1pt, mark: (end: ">"))
    content((1.8, 3.8), text(size: 8pt, fill: red)[5])

    line((3.35, 5.3), (5.15, 3.7), stroke: 1pt, mark: (end: ">"))
    content((4.0, 4.3), text(size: 8pt, fill: red)[4])

    line((3.35, 3.7), (5.15, 5.3), stroke: 1pt, mark: (end: ">"))
    content((4.5, 4.7), text(size: 8pt, fill: red)[1])

    line((3.35, 5.5), (5.15, 5.5), stroke: 1pt, mark: (end: ">"))
    content((4.25, 5.8), text(size: 8pt, fill: red)[6])

    line((3.35, 3.5), (5.15, 3.5), stroke: 1pt, mark: (end: ">"))
    content((4.25, 3.2), text(size: 8pt, fill: red)[2])

    // Distance labels
    content((1, 3.8), text(size: 8pt, fill: blue)[d=0])
    content((3, 4.8), text(size: 8pt, fill: blue)[d=2])
    content((3, 2.8), text(size: 8pt, fill: blue)[d=5])
    content((5.5, 4.8), text(size: 8pt, fill: blue)[d=6])
    content((5.5, 2.8), text(size: 8pt, fill: blue)[d=7])

    // Process order
    content((4, 1.8), text(weight: "bold")[Processing Order:])
    content((4, 1.3), text(size: 9pt)[1 (d=0) → 2 (d=2) → 3 (d=5) → 4 (d=6) → 5 (d=7)])
  })
)

Dijkstra Trace:
```
Initial: dist = [0, ∞, ∞, ∞, ∞], PQ = [(0,1)]

Process node 1 (dist=0):
  → Relax 2: dist[2] = min(∞, 0+2) = 2
  → Relax 3: dist[3] = min(∞, 0+5) = 5
  PQ = [(2,2), (5,3)]

Process node 2 (dist=2):
  → Relax 4: dist[4] = min(∞, 2+6) = 8
  → Relax 5: dist[5] = min(∞, 2+4) = 6
  PQ = [(5,3), (6,5), (8,4)]

Process node 3 (dist=5):
  → Relax 4: dist[4] = min(8, 5+1) = 6  ← Better path!
  → Relax 5: dist[5] = min(6, 5+2) = 6  (no change)
  PQ = [(6,5), (6,4), (8,4)]

Process node 4 (dist=6): no outgoing edges

Process node 5 (dist=6): no outgoing edges

Final: dist = [0, 2, 5, 6, 6]
```

Time Complexity: O((n + m) log n) with priority queue.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;
const ll INF = 1e18;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    vector<vector<pair<int, ll>>> adj(n + 1);
    for (int i = 0; i < m; i++) {
        int a, b;
        ll w;
        cin >> a >> b >> w;
        adj[a].push_back({b, w});
    }

    vector<ll> dist(n + 1, INF);
    priority_queue<pair<ll, int>, vector<pair<ll, int>>, greater<>> pq;

    dist[1] = 0;
    pq.push({0, 1});

    while (!pq.empty()) {
        auto [d, u] = pq.top();
        pq.pop();

        // Skip if we've already found a better path
        if (d > dist[u]) continue;

        for (auto [v, w] : adj[u]) {
            if (dist[u] + w < dist[v]) {
                dist[v] = dist[u] + w;
                pq.push({dist[v], v});
            }
        }
    }

    for (int i = 1; i <= n; i++) {
        cout << dist[i] << " ";
    }
    cout << "\n";

    return 0;
}
```
#pagebreak()

== Shortest Routes II

\
#link("https://cses.fi/problemset/task/1672")[Question - Shortest Routes II]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1672")[Backup Link]

\
*Explanation* :

_Concepts used: *Floyd-Warshall Algorithm* (all-pairs shortest path) - see Concepts_

Given a weighted graph, answer multiple queries: "What is the shortest path from node a to node b?" This is the *all-pairs shortest path* problem, solved efficiently with *Floyd-Warshall*.

Why Not Run Dijkstra for Each Query?
With q queries and running Dijkstra each time, complexity is O(q · (n + m) log n). For many queries, this is slow. Floyd-Warshall precomputes all pairs in O(n³), then answers each query in O(1).

Floyd-Warshall Key Idea:
Build up shortest paths by considering intermediate nodes one at a time. `dist[i][j]` through nodes {1, 2, ..., k} is either:
- The path not using k: `dist[i][j]` through {1..k-1}
- The path using k: `dist[i][k] + dist[k][j]` through {1..k-1}

Algorithm:
```
for k = 1 to n:          // Try each intermediate node
  for i = 1 to n:        // For each source
    for j = 1 to n:      // For each destination
      dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j])
```

#figure(
  canvas({
    import draw: *

    content((4, 6.5), [Floyd-Warshall: Adding Intermediate Nodes])

    // Before (k=0)
    content((2, 5.8), text(fill: blue, weight: "bold")[Before k=2])
    circle((1, 4.8), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((1, 4.8), [1])
    circle((2, 5.3), radius: 0.3, fill: rgb("#FFFF99"), stroke: 1pt)
    content((2, 5.3), [2])
    circle((3, 4.8), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((3, 4.8), [3])

    line((1.3, 4.95), (1.7, 5.15), stroke: 1pt, mark: (end: ">"))
    content((1.3, 5.3), text(size: 7pt)[4])
    line((2.3, 5.15), (2.7, 4.95), stroke: 1pt, mark: (end: ">"))
    content((2.7, 5.3), text(size: 7pt)[3])

    content((2, 4.2), text(size: 8pt)[dist\[1\]\[3\] = ∞])

    // After (k=2)
    content((6, 5.8), text(fill: green, weight: "bold")[After k=2])
    circle((5, 4.8), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((5, 4.8), [1])
    circle((6, 5.3), radius: 0.3, fill: rgb("#FFFF99"), stroke: 1pt)
    content((6, 5.3), [2])
    circle((7, 4.8), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((7, 4.8), [3])

    line((5.3, 4.95), (5.7, 5.15), stroke: 1pt, mark: (end: ">"))
    content((5.3, 5.3), text(size: 7pt)[4])
    line((6.3, 5.15), (6.7, 4.95), stroke: 1pt, mark: (end: ">"))
    content((6.7, 5.3), text(size: 7pt)[3])
    line((5.3, 4.8), (6.7, 4.8), stroke: (paint: red, thickness: 1.5pt, dash: "dashed"), mark: (end: ">"))
    content((6, 4.4), text(size: 8pt, fill: red)[via 2])

    content((6, 3.8), text(size: 8pt, fill: green)[dist\[1\]\[3\] = 4+3 = 7])

    // Explanation
    content((4, 2.8), text(weight: "bold")[Update Rule:])
    content((4, 2.3), text(size: 9pt)[dist\[i\]\[j\] = min(dist\[i\]\[j\], dist\[i\]\[k\] + dist\[k\]\[j\])])
    content((4, 1.7), text(size: 9pt)[For each k, check if going through k is better])
  })
)

Example Trace (3 nodes):
```
Initial distances:
     1    2    3
1 [  0    4    ∞ ]
2 [  ∞    0    3 ]
3 [  2    ∞    0 ]

After k=1 (using node 1 as intermediate):
  dist[3][2] = min(∞, dist[3][1] + dist[1][2]) = min(∞, 2+4) = 6

After k=2 (using node 2 as intermediate):
  dist[1][3] = min(∞, dist[1][2] + dist[2][3]) = min(∞, 4+3) = 7
  dist[3][1] = min(2, dist[3][2] + dist[2][1]) = min(2, 6+∞) = 2

After k=3 (using node 3 as intermediate):
  dist[1][2] = min(4, dist[1][3] + dist[3][2]) = min(4, 7+6) = 4
  dist[2][1] = min(∞, dist[2][3] + dist[3][1]) = min(∞, 3+2) = 5
```

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;
const ll INF = 1e18;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m, q;
    cin >> n >> m >> q;

    // Distance matrix
    vector<vector<ll>> dist(n + 1, vector<ll>(n + 1, INF));

    // Self-loops have distance 0
    for (int i = 1; i <= n; i++) {
        dist[i][i] = 0;
    }

    // Read edges (keep minimum if multiple edges)
    for (int i = 0; i < m; i++) {
        int a, b;
        ll c;
        cin >> a >> b >> c;
        dist[a][b] = min(dist[a][b], c);
        dist[b][a] = min(dist[b][a], c);
    }

    // Floyd-Warshall
    for (int k = 1; k <= n; k++) {
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= n; j++) {
                if (dist[i][k] < INF && dist[k][j] < INF) {
                    dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j]);
                }
            }
        }
    }

    // Answer queries
    while (q--) {
        int a, b;
        cin >> a >> b;
        if (dist[a][b] == INF) {
            cout << -1 << "\n";
        } else {
            cout << dist[a][b] << "\n";
        }
    }

    return 0;
}
```
#pagebreak()

== High Score

\
#link("https://cses.fi/problemset/task/1673")[Question - High Score]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1673")[Backup Link]

\
*Explanation* :

_Concepts used: *Bellman-Ford Algorithm* (with negative cycle detection) - see Concepts_

Find the maximum score when traveling from node 1 to node n. Each edge gives you points (can be negative). The twist: if you can get *infinite* score through a positive cycle reachable from 1 that can reach n, output -1.

Key Insight:
This is longest path with cycle detection. We negate all weights and find shortest path, but we must detect *positive cycles* (which become negative cycles after negation) that lie on a path from 1 to n.

Bellman-Ford Algorithm:
- Relax all edges n-1 times to find shortest paths
- If we can still relax on the nth iteration, there's a negative cycle
- For this problem: we need cycles reachable from start AND that can reach end

Algorithm:
1. Run Bellman-Ford with negated weights (to find longest path)
2. After n-1 iterations, try n more relaxations
3. Any node relaxed in iterations n to 2n-1 is affected by a cycle
4. If node n is affected, answer is -1 (infinite score possible)

#figure(
  canvas({
    import draw: *

    content((4, 6.5), [High Score: Longest Path with Positive Cycles])

    // Graph with positive cycle
    circle((1, 4.5), radius: 0.35, fill: rgb("#90EE90"), stroke: 1.5pt)
    content((1, 4.5), text(weight: "bold")[1])

    circle((3, 5.2), radius: 0.35, fill: rgb("#FFFF99"), stroke: 1pt)
    content((3, 5.2), [2])

    circle((3, 3.8), radius: 0.35, fill: rgb("#FFFF99"), stroke: 1pt)
    content((3, 3.8), [3])

    circle((5, 4.5), radius: 0.35, fill: rgb("#FFFF99"), stroke: 1pt)
    content((5, 4.5), [4])

    circle((7, 4.5), radius: 0.35, fill: rgb("#FFB6C1"), stroke: 1.5pt)
    content((7, 4.5), text(weight: "bold")[5])

    // Edges
    line((1.35, 4.7), (2.65, 5.0), stroke: 1pt, mark: (end: ">"))
    content((1.7, 5.1), text(size: 8pt, fill: blue)[+5])

    line((3.3, 4.95), (4.7, 4.65), stroke: 1pt, mark: (end: ">"))
    content((4.0, 5.0), text(size: 8pt, fill: blue)[+3])

    line((5.35, 4.5), (6.65, 4.5), stroke: 1pt, mark: (end: ">"))
    content((6, 4.8), text(size: 8pt, fill: blue)[+2])

    // Positive cycle 2-3-4-2
    line((3, 4.85), (3, 4.15), stroke: (paint: red, thickness: 1.5pt), mark: (end: ">"))
    content((2.6, 4.5), text(size: 8pt, fill: red)[+4])

    line((3.3, 3.95), (4.7, 4.35), stroke: (paint: red, thickness: 1.5pt), mark: (end: ">"))
    content((4.2, 3.9), text(size: 8pt, fill: red)[+1])

    line((4.85, 4.25), (3.15, 5.0), stroke: (paint: red, thickness: 1.5pt), mark: (end: ">"))
    content((3.8, 4.9), text(size: 8pt, fill: red)[+2])

    content((3.5, 2.8), text(fill: red, weight: "bold")[Positive cycle: 2→3→4→2 gains +7 each time!])
    content((3.5, 2.2), [Since cycle is reachable and reaches node 5...])
    content((3.5, 1.6), text(fill: red, weight: "bold")[Answer: -1 (infinite score possible)])
  })
)

Bellman-Ford Cycle Detection:
```
After n-1 rounds: dist[i] = shortest distance (with negated weights)

Round n to 2n-1: Keep relaxing
  If dist[v] can still be improved → v is affected by negative cycle

For High Score:
  1. Find all nodes reachable from node 1
  2. Find all nodes that can reach node n
  3. If any cycle-affected node is in both sets → answer is -1
  4. Otherwise → answer is -dist[n] (negate back)
```

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;
const ll INF = 1e18;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    vector<tuple<int, int, ll>> edges;
    vector<vector<int>> adj(n + 1), radj(n + 1);

    for (int i = 0; i < m; i++) {
        int a, b;
        ll x;
        cin >> a >> b >> x;
        edges.push_back({a, b, -x});  // Negate for longest path
        adj[a].push_back(b);
        radj[b].push_back(a);
    }

    // Find nodes reachable from 1
    vector<bool> reach_from_1(n + 1, false);
    queue<int> q;
    q.push(1);
    reach_from_1[1] = true;
    while (!q.empty()) {
        int u = q.front(); q.pop();
        for (int v : adj[u]) {
            if (!reach_from_1[v]) {
                reach_from_1[v] = true;
                q.push(v);
            }
        }
    }

    // Find nodes that can reach n
    vector<bool> reach_to_n(n + 1, false);
    q.push(n);
    reach_to_n[n] = true;
    while (!q.empty()) {
        int u = q.front(); q.pop();
        for (int v : radj[u]) {
            if (!reach_to_n[v]) {
                reach_to_n[v] = true;
                q.push(v);
            }
        }
    }

    // Bellman-Ford
    vector<ll> dist(n + 1, INF);
    dist[1] = 0;

    for (int i = 1; i <= n - 1; i++) {
        for (auto [a, b, w] : edges) {
            if (dist[a] < INF && dist[a] + w < dist[b]) {
                dist[b] = dist[a] + w;
            }
        }
    }

    // Check for negative cycles on path from 1 to n
    for (int i = 1; i <= n; i++) {
        for (auto [a, b, w] : edges) {
            if (dist[a] < INF && dist[a] + w < dist[b]) {
                dist[b] = dist[a] + w;
                // If b is on a valid path, we have infinite score
                if (reach_from_1[b] && reach_to_n[b]) {
                    cout << -1 << "\n";
                    return 0;
                }
            }
        }
    }

    cout << -dist[n] << "\n";
    return 0;
}
```
#pagebreak()

== Flight Discount

\
#link("https://cses.fi/problemset/task/1195")[Question - Flight Discount]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1195")[Backup Link]

\
*Explanation* :

You can halve the cost of *exactly one* flight. Find the minimum total cost to travel from city 1 to city n. This is a classic *state-space Dijkstra* problem.

Key Insight - State Extension:
Instead of just tracking distance to each node, track whether we've used the discount. State = (node, used_discount). This doubles our state space but keeps the problem solvable with Dijkstra.

Two Approaches:

*Approach 1: Two Dijkstra Runs*
- Run Dijkstra from node 1: `dist1[v]` = shortest distance from 1 to v
- Run Dijkstra from node n on reversed graph: `dist2[v]` = shortest distance from v to n
- For each edge (u, v, w): try using discount on this edge
- Answer = min over all edges of: `dist1[u] + w/2 + dist2[v]`

*Approach 2: Extended State Dijkstra*
- State: (distance, node, used_discount)
- Transitions: regular edges, or discounted edge (if not used yet)

#figure(
  canvas({
    import draw: *

    content((4, 6.5), [Flight Discount: Use Coupon on Best Edge])

    // Graph
    circle((1, 4.5), radius: 0.35, fill: rgb("#90EE90"), stroke: 1.5pt)
    content((1, 4.5), text(weight: "bold")[1])

    circle((3, 5.3), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((3, 5.3), [2])

    circle((3, 3.7), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((3, 3.7), [3])

    circle((5.5, 4.5), radius: 0.35, fill: rgb("#FFB6C1"), stroke: 1.5pt)
    content((5.5, 4.5), text(weight: "bold")[4])

    // Edges
    line((1.35, 4.7), (2.65, 5.1), stroke: 1pt, mark: (end: ">"))
    content((1.7, 5.2), text(size: 8pt)[3])

    line((1.35, 4.3), (2.65, 3.9), stroke: 1pt, mark: (end: ">"))
    content((1.7, 3.8), text(size: 8pt)[2])

    line((3.35, 5.1), (5.15, 4.7), stroke: (paint: red, thickness: 2pt), mark: (end: ">"))
    content((4.2, 5.2), text(size: 8pt, fill: red, weight: "bold")[10 → 5])

    line((3.35, 3.9), (5.15, 4.3), stroke: 1pt, mark: (end: ">"))
    content((4.2, 3.8), text(size: 8pt)[4])

    // Analysis
    content((4, 2.6), text(weight: "bold")[Without discount:])
    content((4, 2.1), text(size: 9pt)[Path 1→2→4: cost = 3 + 10 = 13])
    content((4, 1.7), text(size: 9pt)[Path 1→3→4: cost = 2 + 4 = 6])

    content((4, 1.1), text(weight: "bold", fill: green)[With discount on edge 2→4:])
    content((4, 0.6), text(size: 9pt, fill: green)[Path 1→2→4: cost = 3 + 5 = 8])
  })
)

Two-Dijkstra Approach:
```
dist1 from node 1:  [0, 3, 2, 6]   (1→2=3, 1→3=2, 1→3→4=6)
dist2 to node 4:    [6, 10, 4, 0]  (reverse: 4→3=4, 4→2=10, etc.)

For each edge, try discount:
  Edge 1→2 (w=3): dist1[1] + 3/2 + dist2[2] = 0 + 1 + 10 = 11
  Edge 1→3 (w=2): dist1[1] + 2/2 + dist2[3] = 0 + 1 + 4 = 5  ← Best!
  Edge 2→4 (w=10): dist1[2] + 10/2 + dist2[4] = 3 + 5 + 0 = 8
  Edge 3→4 (w=4): dist1[3] + 4/2 + dist2[4] = 2 + 2 + 0 = 4  ← Even better!

Answer: 4
```

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;
using pli = pair<ll, int>;
const ll INF = 1e18;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    vector<vector<pair<int, ll>>> adj(n + 1), radj(n + 1);
    vector<tuple<int, int, ll>> edges;

    for (int i = 0; i < m; i++) {
        int a, b;
        ll c;
        cin >> a >> b >> c;
        adj[a].push_back({b, c});
        radj[b].push_back({a, c});
        edges.push_back({a, b, c});
    }

    // Dijkstra from node 1
    vector<ll> dist1(n + 1, INF);
    priority_queue<pli, vector<pli>, greater<>> pq;
    dist1[1] = 0;
    pq.push({0, 1});

    while (!pq.empty()) {
        auto [d, u] = pq.top();
        pq.pop();
        if (d > dist1[u]) continue;
        for (auto [v, w] : adj[u]) {
            if (dist1[u] + w < dist1[v]) {
                dist1[v] = dist1[u] + w;
                pq.push({dist1[v], v});
            }
        }
    }

    // Dijkstra from node n on reversed graph
    vector<ll> dist2(n + 1, INF);
    dist2[n] = 0;
    pq.push({0, n});

    while (!pq.empty()) {
        auto [d, u] = pq.top();
        pq.pop();
        if (d > dist2[u]) continue;
        for (auto [v, w] : radj[u]) {
            if (dist2[u] + w < dist2[v]) {
                dist2[v] = dist2[u] + w;
                pq.push({dist2[v], v});
            }
        }
    }

    // Try discount on each edge
    ll ans = INF;
    for (auto [a, b, c] : edges) {
        if (dist1[a] < INF && dist2[b] < INF) {
            ans = min(ans, dist1[a] + c / 2 + dist2[b]);
        }
    }

    cout << ans << "\n";
    return 0;
}
```
#pagebreak()

== Cycle Finding

\
#link("https://cses.fi/problemset/task/1197")[Question - Cycle Finding]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1197")[Backup Link]

\
*Explanation* :

_Concepts used: *Bellman-Ford Algorithm*, *Negative Cycle Detection* - see Concepts_

Find a negative cycle in a directed weighted graph, or report that none exists. A negative cycle is a cycle where the sum of edge weights is negative.

Why Negative Cycles Matter:
In shortest path problems, negative cycles allow infinite reduction of path length by going around the cycle repeatedly. Detecting them is crucial for algorithms like Bellman-Ford.

Bellman-Ford for Cycle Detection:
- After n-1 relaxations, shortest paths are found (if no negative cycles)
- If we can still relax on the nth iteration, a negative cycle exists
- The node being relaxed in round n lies on (or is reachable from) a negative cycle

Reconstructing the Cycle:
- When we find a node x that can be relaxed in round n, follow parent pointers
- Go back n times to ensure we're inside the cycle (not just reachable from it)
- Then collect nodes until we return to the starting point

#figure(
  canvas({
    import draw: *

    content((4, 6.5), [Negative Cycle Detection])

    // Graph with negative cycle
    circle((1.5, 4.5), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((1.5, 4.5), [1])

    circle((3.5, 5.3), radius: 0.35, fill: rgb("#FFFF99"), stroke: 1pt)
    content((3.5, 5.3), [2])

    circle((5.5, 4.5), radius: 0.35, fill: rgb("#FFFF99"), stroke: 1pt)
    content((5.5, 4.5), [3])

    circle((3.5, 3.7), radius: 0.35, fill: rgb("#FFFF99"), stroke: 1pt)
    content((3.5, 3.7), [4])

    // Regular edges
    line((1.85, 4.65), (3.15, 5.15), stroke: 1pt, mark: (end: ">"))
    content((2.2, 5.2), text(size: 8pt)[2])

    // Negative cycle: 2 → 3 → 4 → 2
    line((3.85, 5.15), (5.15, 4.65), stroke: (paint: red, thickness: 1.5pt), mark: (end: ">"))
    content((4.7, 5.2), text(size: 8pt, fill: red)[1])

    line((5.35, 4.2), (3.65, 3.9), stroke: (paint: red, thickness: 1.5pt), mark: (end: ">"))
    content((4.7, 3.8), text(size: 8pt, fill: red)[-5])

    line((3.35, 4.0), (3.35, 5.0), stroke: (paint: red, thickness: 1.5pt), mark: (end: ">"))
    content((2.9, 4.5), text(size: 8pt, fill: red)[2])

    content((3.5, 2.6), text(fill: red, weight: "bold")[Negative Cycle: 2 → 3 → 4 → 2])
    content((3.5, 2.0), text(size: 9pt)[Sum: 1 + (-5) + 2 = -2 < 0])
    content((3.5, 1.4), text(size: 9pt, fill: gray)[Each trip around reduces total by 2])
  })
)

Bellman-Ford Trace:
```
Edges: (1,2,2), (2,3,1), (3,4,-5), (4,2,2)

Round 1: dist = [0, 2, ∞, ∞]    (relax 1→2)
Round 2: dist = [0, 2, 3, ∞]    (relax 2→3)
Round 3: dist = [0, 2, 3, -2]   (relax 3→4)
Round 4: dist = [0, 0, 3, -2]   (relax 4→2: dist[4]+2 < dist[2])

Still can relax! dist[2] = 0 but...
Round 5: dist[3] = 0 + 1 = 1 < 3  (can still improve!)

Negative cycle detected!
Backtrack from node being relaxed to find cycle.
```

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;
const ll INF = 1e18;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    vector<tuple<int, int, ll>> edges;
    for (int i = 0; i < m; i++) {
        int a, b;
        ll c;
        cin >> a >> b >> c;
        edges.push_back({a, b, c});
    }

    vector<ll> dist(n + 1, 0);  // Start with 0 to detect all cycles
    vector<int> parent(n + 1, -1);
    int cycle_node = -1;

    // Bellman-Ford: n rounds
    for (int i = 1; i <= n; i++) {
        cycle_node = -1;
        for (auto [a, b, w] : edges) {
            if (dist[a] + w < dist[b]) {
                dist[b] = dist[a] + w;
                parent[b] = a;
                if (i == n) {
                    cycle_node = b;  // Found node on/reachable from negative cycle
                }
            }
        }
    }

    if (cycle_node == -1) {
        cout << "NO\n";
    } else {
        // Go back n times to ensure we're in the cycle
        for (int i = 0; i < n; i++) {
            cycle_node = parent[cycle_node];
        }

        // Collect the cycle
        vector<int> cycle;
        int curr = cycle_node;
        do {
            cycle.push_back(curr);
            curr = parent[curr];
        } while (curr != cycle_node);
        cycle.push_back(cycle_node);

        reverse(cycle.begin(), cycle.end());

        cout << "YES\n";
        for (int node : cycle) {
            cout << node << " ";
        }
        cout << "\n";
    }

    return 0;
}
```
#pagebreak()

== Flight Routes

\
#link("https://cses.fi/problemset/task/1196")[Question - Flight Routes]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1196")[Backup Link]

\
*Explanation* :

Find the k shortest route lengths from city 1 to city n. Routes can reuse cities and edges. This is the *k-shortest paths* problem.

Key Insight:
Instead of stopping when we first reach node n (which gives the shortest path), we continue and collect the first k times we reach node n. Each arrival at n (possibly via different routes) gives us a candidate path length.

Modified Dijkstra for k-Shortest Paths:
- Allow each node to be visited up to k times
- Keep a count of how many times each node has been "finalized"
- When we pop a node from the priority queue, if it's been processed < k times, process it
- Stop when node n has been processed k times

Why This Works:
Dijkstra processes nodes in order of increasing distance. The first time we reach n is the shortest, the second time is the second shortest, etc. By allowing k visits per node, we find all k shortest paths.

#figure(
  canvas({
    import draw: *

    content((4, 6.5), [K-Shortest Paths: Keep Processing Until k Arrivals])

    // Simple graph
    circle((1, 4.5), radius: 0.35, fill: rgb("#90EE90"), stroke: 1.5pt)
    content((1, 4.5), text(weight: "bold")[1])

    circle((3, 5.3), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((3, 5.3), [2])

    circle((3, 3.7), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((3, 3.7), [3])

    circle((5.5, 4.5), radius: 0.35, fill: rgb("#FFB6C1"), stroke: 1.5pt)
    content((5.5, 4.5), text(weight: "bold")[4])

    // Edges
    line((1.35, 4.7), (2.65, 5.1), stroke: 1pt, mark: (end: ">"))
    content((1.7, 5.2), text(size: 8pt)[2])

    line((1.35, 4.3), (2.65, 3.9), stroke: 1pt, mark: (end: ">"))
    content((1.7, 3.8), text(size: 8pt)[3])

    line((3.35, 5.1), (5.15, 4.7), stroke: 1pt, mark: (end: ">"))
    content((4.3, 5.2), text(size: 8pt)[4])

    line((3.35, 3.9), (5.15, 4.3), stroke: 1pt, mark: (end: ">"))
    content((4.3, 3.8), text(size: 8pt)[2])

    // Results
    content((4, 2.6), text(weight: "bold")[k=3 shortest paths to node 4:])
    content((4, 2.0), text(size: 9pt)[1st: 1→3→4 = 3+2 = 5])
    content((4, 1.5), text(size: 9pt)[2nd: 1→2→4 = 2+4 = 6])
    content((4, 1.0), text(size: 9pt)[3rd: (need more edges for different path)])
  })
)

Algorithm Trace (k=3):
```
Priority Queue (min-heap): [(distance, node)]
count[i] = how many times node i has been finalized

Initial: PQ = [(0, 1)], count = [0, 0, 0, 0, 0]

Pop (0, 1): count[1] = 1
  Push: (2, 2), (3, 3)
  PQ = [(2, 2), (3, 3)]

Pop (2, 2): count[2] = 1
  Push: (6, 4)
  PQ = [(3, 3), (6, 4)]

Pop (3, 3): count[3] = 1
  Push: (5, 4)
  PQ = [(5, 4), (6, 4)]

Pop (5, 4): count[4] = 1  → Record: 1st shortest = 5
Pop (6, 4): count[4] = 2  → Record: 2nd shortest = 6
...continue until count[n] = k
```

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;
using pli = pair<ll, int>;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m, k;
    cin >> n >> m >> k;

    vector<vector<pair<int, ll>>> adj(n + 1);
    for (int i = 0; i < m; i++) {
        int a, b;
        ll c;
        cin >> a >> b >> c;
        adj[a].push_back({b, c});
    }

    vector<int> count(n + 1, 0);
    vector<ll> result;

    priority_queue<pli, vector<pli>, greater<>> pq;
    pq.push({0, 1});

    while (!pq.empty() && count[n] < k) {
        auto [d, u] = pq.top();
        pq.pop();

        count[u]++;

        if (u == n) {
            result.push_back(d);
            continue;
        }

        if (count[u] > k) continue;

        for (auto [v, w] : adj[u]) {
            pq.push({d + w, v});
        }
    }

    for (ll dist : result) {
        cout << dist << " ";
    }
    cout << "\n";

    return 0;
}
```
#pagebreak()

== Round Trip II

\
#link("https://cses.fi/problemset/task/1678")[Question - Round Trip II]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1678")[Backup Link]

\
*Explanation* :

Find a cycle in a *directed* graph. Unlike Round Trip I (undirected), here edges have direction, making cycle detection different.

Key Difference from Undirected:
In undirected graphs, any back edge creates a cycle. In directed graphs, we need a back edge to an *ancestor* in the current DFS path, not just any visited node.

Three Node States:
- *White (0)*: Unvisited
- *Gray (1)*: Currently being processed (on the current DFS path)
- *Black (2)*: Completely processed (all descendants explored)

Cycle Detection Rule:
A cycle exists if and only if we find an edge from a gray node to another gray node. This means we found a back edge to an ancestor in our current path.

#figure(
  canvas({
    import draw: *

    content((4, 6.5), [Directed Cycle Detection: Gray Node States])

    // Graph
    circle((1, 5), radius: 0.35, fill: rgb("#CCCCCC"), stroke: 1pt)
    content((1, 5), [1])
    content((1, 4.4), text(size: 7pt)[gray])

    circle((2.5, 5), radius: 0.35, fill: rgb("#CCCCCC"), stroke: 1pt)
    content((2.5, 5), [2])
    content((2.5, 4.4), text(size: 7pt)[gray])

    circle((4, 5), radius: 0.35, fill: rgb("#CCCCCC"), stroke: 1pt)
    content((4, 5), [3])
    content((4, 4.4), text(size: 7pt)[gray])

    circle((5.5, 5), radius: 0.35, fill: rgb("#CCCCCC"), stroke: 1pt)
    content((5.5, 5), [4])
    content((5.5, 4.4), text(size: 7pt)[gray])

    // Forward edges
    line((1.35, 5), (2.15, 5), stroke: 1pt, mark: (end: ">"))
    line((2.85, 5), (3.65, 5), stroke: 1pt, mark: (end: ">"))
    line((4.35, 5), (5.15, 5), stroke: 1pt, mark: (end: ">"))

    // Back edge creating cycle
    bezier((5.5, 4.65), (2.5, 4.65), (4, 3.5), stroke: (paint: red, thickness: 2pt), mark: (end: ">"))
    content((4, 3.2), text(fill: red, weight: "bold")[Back edge to gray node!])

    content((3.5, 2.4), text(weight: "bold")[DFS Path: 1 → 2 → 3 → 4])
    content((3.5, 1.8), text(size: 9pt)[Edge 4→2 goes to gray node (ancestor)])
    content((3.5, 1.2), text(size: 9pt, fill: green)[Cycle found: 2 → 3 → 4 → 2])
  })
)

DFS State Transitions:
```
DFS(1): color[1] = GRAY
  DFS(2): color[2] = GRAY
    DFS(3): color[3] = GRAY
      DFS(4): color[4] = GRAY
        Check neighbor 2: color[2] = GRAY
        → Back edge to ancestor! CYCLE FOUND!

Backtrack: 4 → 3 → 2
Cycle: 2 → 3 → 4 → 2
```

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int n, m;
vector<vector<int>> adj;
vector<int> color;  // 0=white, 1=gray, 2=black
vector<int> parent;
int cycle_start = -1, cycle_end = -1;

bool dfs(int u) {
    color[u] = 1;  // Gray

    for (int v : adj[u]) {
        if (color[v] == 1) {
            // Back edge to ancestor - cycle found!
            cycle_start = v;
            cycle_end = u;
            return true;
        }
        if (color[v] == 0) {
            parent[v] = u;
            if (dfs(v)) return true;
        }
    }

    color[u] = 2;  // Black
    return false;
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> m;
    adj.resize(n + 1);
    color.resize(n + 1, 0);
    parent.resize(n + 1, -1);

    for (int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back(b);
    }

    for (int i = 1; i <= n; i++) {
        if (color[i] == 0 && dfs(i)) {
            // Reconstruct cycle
            vector<int> cycle;
            cycle.push_back(cycle_start);
            for (int curr = cycle_end; curr != cycle_start; curr = parent[curr]) {
                cycle.push_back(curr);
            }
            cycle.push_back(cycle_start);

            reverse(cycle.begin(), cycle.end());

            cout << cycle.size() << "\n";
            for (int node : cycle) {
                cout << node << " ";
            }
            cout << "\n";
            return 0;
        }
    }

    cout << "IMPOSSIBLE\n";
    return 0;
}
```
#pagebreak()

== Course Schedule

\
#link("https://cses.fi/problemset/task/1679")[Question - Course Schedule]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1679")[Backup Link]

\
*Explanation* :

Given n courses and m requirements (course a must be completed before course b), find a valid order to complete all courses. This is *topological sorting*.

Key Property:
A valid ordering exists if and only if the graph has no cycles (it's a DAG - Directed Acyclic Graph). In a topological order, for every edge u→v, node u appears before v.

Kahn's Algorithm (BFS-based):
1. Compute in-degree for each node (number of incoming edges)
2. Add all nodes with in-degree 0 to a queue (no prerequisites)
3. Process queue: remove node, add to result, decrease neighbors' in-degrees
4. If any neighbor's in-degree becomes 0, add it to queue
5. If result has all n nodes, we have a valid ordering; otherwise, cycle exists

#figure(
  canvas({
    import draw: *

    content((4, 6.5), [Topological Sort: Process Zero In-degree Nodes])

    // Graph with dependencies
    circle((1, 5), radius: 0.35, fill: rgb("#90EE90"), stroke: 1pt)
    content((1, 5), [1])
    content((1, 4.4), text(size: 7pt)[in:0])

    circle((2.5, 5.5), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2.5, 5.5), [2])
    content((2.5, 4.9), text(size: 7pt)[in:1])

    circle((2.5, 4.5), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2.5, 4.5), [3])
    content((2.5, 3.9), text(size: 7pt)[in:1])

    circle((4, 5), radius: 0.35, fill: rgb("#FFFF99"), stroke: 1pt)
    content((4, 5), [4])
    content((4, 4.4), text(size: 7pt)[in:2])

    circle((5.5, 5), radius: 0.35, fill: rgb("#FFB6C1"), stroke: 1pt)
    content((5.5, 5), [5])
    content((5.5, 4.4), text(size: 7pt)[in:1])

    // Edges
    line((1.35, 5.15), (2.15, 5.35), stroke: 1pt, mark: (end: ">"))
    line((1.35, 4.85), (2.15, 4.65), stroke: 1pt, mark: (end: ">"))
    line((2.85, 5.35), (3.65, 5.15), stroke: 1pt, mark: (end: ">"))
    line((2.85, 4.65), (3.65, 4.85), stroke: 1pt, mark: (end: ">"))
    line((4.35, 5), (5.15, 5), stroke: 1pt, mark: (end: ">"))

    content((3.5, 2.8), text(weight: "bold")[Processing Order:])
    content((3.5, 2.2), text(size: 9pt)[1. Start with in-degree 0: node 1])
    content((3.5, 1.7), text(size: 9pt)[2. Process 1 → nodes 2,3 become in-degree 0])
    content((3.5, 1.2), text(size: 9pt)[3. Process 2,3 → node 4 becomes in-degree 0])
    content((3.5, 0.7), text(size: 9pt)[4. Process 4 → node 5 becomes in-degree 0])
  })
)

Kahn's Algorithm Trace:
```
Initial in-degrees: [0, 1, 1, 2, 1]
Queue: [1] (only node with in-degree 0)
Result: []

Process 1: Result = [1]
  Decrease in-degree of 2, 3
  in-degrees: [0, 0, 0, 2, 1]
  Queue: [2, 3]

Process 2: Result = [1, 2]
  Decrease in-degree of 4
  in-degrees: [0, 0, 0, 1, 1]
  Queue: [3]

Process 3: Result = [1, 2, 3]
  Decrease in-degree of 4
  in-degrees: [0, 0, 0, 0, 1]
  Queue: [4]

Process 4: Result = [1, 2, 3, 4]
  Decrease in-degree of 5
  Queue: [5]

Process 5: Result = [1, 2, 3, 4, 5]

All nodes processed → Valid topological order!
```

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    vector<vector<int>> adj(n + 1);
    vector<int> indegree(n + 1, 0);

    for (int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back(b);
        indegree[b]++;
    }

    // Kahn's algorithm
    queue<int> q;
    for (int i = 1; i <= n; i++) {
        if (indegree[i] == 0) {
            q.push(i);
        }
    }

    vector<int> result;
    while (!q.empty()) {
        int u = q.front();
        q.pop();
        result.push_back(u);

        for (int v : adj[u]) {
            indegree[v]--;
            if (indegree[v] == 0) {
                q.push(v);
            }
        }
    }

    if (result.size() != n) {
        cout << "IMPOSSIBLE\n";
    } else {
        for (int node : result) {
            cout << node << " ";
        }
        cout << "\n";
    }

    return 0;
}
```
#pagebreak()

== Longest Flight Route

\
#link("https://cses.fi/problemset/task/1680")[Question - Longest Flight Route]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1680")[Backup Link]

\
*Explanation* :

Find the longest path from city 1 to city n in a directed acyclic graph (DAG). Since it's a DAG, we can use dynamic programming with topological ordering.

Key Insight:
In a DAG, we can process nodes in topological order. For each node, the longest path to it is 1 + max(longest path to any predecessor). This works because when we process a node, all its predecessors have already been processed.

Algorithm:
1. Topologically sort the graph
2. Initialize `dist[1] = 1` (path length includes starting node), others = -infinity
3. Process nodes in topological order: for each edge u→v, update `dist[v] = max(dist[v], dist[u] + 1)`
4. Track parent pointers to reconstruct the path

#figure(
  canvas({
    import draw: *

    content((4, 6.2), [Longest Path in DAG: DP on Topological Order])

    // DAG
    circle((1, 4.5), radius: 0.3, fill: rgb("#90EE90"), stroke: 1pt)
    content((1, 4.5), [1])

    circle((2.5, 5.2), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2.5, 5.2), [2])

    circle((2.5, 3.8), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2.5, 3.8), [3])

    circle((4, 5.2), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((4, 5.2), [4])

    circle((5.5, 4.5), radius: 0.3, fill: rgb("#FFB6C1"), stroke: 1pt)
    content((5.5, 4.5), [5])

    line((1.3, 4.65), (2.2, 5.05), stroke: 1pt, mark: (end: ">"))
    line((1.3, 4.35), (2.2, 3.95), stroke: 1pt, mark: (end: ">"))
    line((2.8, 5.2), (3.7, 5.2), stroke: 1pt, mark: (end: ">"))
    line((2.8, 3.95), (5.2, 4.35), stroke: 1pt, mark: (end: ">"))
    line((4.3, 5.05), (5.2, 4.65), stroke: 1pt, mark: (end: ">"))

    // Distances
    content((1, 3.9), text(size: 8pt, fill: blue)[d=1])
    content((2.5, 4.6), text(size: 8pt, fill: blue)[d=2])
    content((2.5, 3.2), text(size: 8pt, fill: blue)[d=2])
    content((4, 4.6), text(size: 8pt, fill: blue)[d=3])
    content((5.5, 3.9), text(size: 8pt, fill: blue)[d=4])

    content((3.5, 2.2), text(fill: red, weight: "bold")[Longest path: 1→2→4→5 (length 4)])
  })
)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    vector<vector<int>> adj(n + 1), radj(n + 1);
    vector<int> indegree(n + 1, 0);

    for (int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back(b);
        radj[b].push_back(a);
        indegree[b]++;
    }

    // Topological sort
    queue<int> q;
    vector<int> topo;
    for (int i = 1; i <= n; i++) {
        if (indegree[i] == 0) q.push(i);
    }
    while (!q.empty()) {
        int u = q.front(); q.pop();
        topo.push_back(u);
        for (int v : adj[u]) {
            if (--indegree[v] == 0) q.push(v);
        }
    }

    // DP for longest path
    vector<int> dist(n + 1, INT_MIN), parent(n + 1, -1);
    dist[1] = 1;

    for (int u : topo) {
        if (dist[u] == INT_MIN) continue;
        for (int v : adj[u]) {
            if (dist[u] + 1 > dist[v]) {
                dist[v] = dist[u] + 1;
                parent[v] = u;
            }
        }
    }

    if (dist[n] == INT_MIN) {
        cout << "IMPOSSIBLE\n";
    } else {
        vector<int> path;
        for (int cur = n; cur != -1; cur = parent[cur]) {
            path.push_back(cur);
        }
        reverse(path.begin(), path.end());
        cout << path.size() << "\n";
        for (int node : path) cout << node << " ";
        cout << "\n";
    }

    return 0;
}
```
#pagebreak()

== Game Routes

\
#link("https://cses.fi/problemset/task/1681")[Question - Game Routes]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1681")[Backup Link]

\
*Explanation* :

Count the number of paths from level 1 to level n in a directed acyclic graph. Since edges only go forward (DAG), we can use DP with topological ordering.

Key Insight:
The number of paths to node v equals the sum of paths to all predecessors of v. Process in topological order so all predecessors are computed before the current node.

Recurrence:
```
paths[v] = sum of paths[u] for all edges u → v
paths[1] = 1 (one way to be at start)
```

#figure(
  canvas({
    import draw: *

    content((4, 5.5), [Counting Paths: Sum from Predecessors])

    circle((1, 4), radius: 0.3, fill: rgb("#90EE90"), stroke: 1pt)
    content((1, 4), [1])
    content((1, 3.4), text(size: 8pt, fill: blue)[p=1])

    circle((2.5, 4.5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2.5, 4.5), [2])
    content((2.5, 3.9), text(size: 8pt, fill: blue)[p=1])

    circle((2.5, 3.5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2.5, 3.5), [3])
    content((2.5, 2.9), text(size: 8pt, fill: blue)[p=1])

    circle((4, 4), radius: 0.3, fill: rgb("#FFB6C1"), stroke: 1pt)
    content((4, 4), [4])
    content((4, 3.4), text(size: 8pt, fill: red)[p=2])

    line((1.3, 4.1), (2.2, 4.4), stroke: 1pt, mark: (end: ">"))
    line((1.3, 3.9), (2.2, 3.6), stroke: 1pt, mark: (end: ">"))
    line((2.8, 4.35), (3.7, 4.1), stroke: 1pt, mark: (end: ">"))
    line((2.8, 3.65), (3.7, 3.9), stroke: 1pt, mark: (end: ">"))

    content((4, 2.2), [paths\[4\] = paths\[2\] + paths\[3\] = 1 + 1 = 2])
  })
)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

const int MOD = 1e9 + 7;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    vector<vector<int>> adj(n + 1);
    vector<int> indegree(n + 1, 0);

    for (int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back(b);
        indegree[b]++;
    }

    // Topological sort
    queue<int> q;
    vector<int> topo;
    for (int i = 1; i <= n; i++) {
        if (indegree[i] == 0) q.push(i);
    }
    while (!q.empty()) {
        int u = q.front(); q.pop();
        topo.push_back(u);
        for (int v : adj[u]) {
            if (--indegree[v] == 0) q.push(v);
        }
    }

    // Count paths
    vector<long long> paths(n + 1, 0);
    paths[1] = 1;

    for (int u : topo) {
        for (int v : adj[u]) {
            paths[v] = (paths[v] + paths[u]) % MOD;
        }
    }

    cout << paths[n] << "\n";
    return 0;
}
```
#pagebreak()

== Investigation

\
#link("https://cses.fi/problemset/task/1202")[Question - Investigation]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1202")[Backup Link]

\
*Explanation* :

Find for the shortest route from 1 to n: (1) minimum price, (2) number of minimum-price routes, (3) minimum flights in a minimum-price route, (4) maximum flights in a minimum-price route.

Key Insight:
Extend Dijkstra to track multiple values. When we find a shorter path, update all values. When we find an equal-length path, combine counts and update min/max flights.

State Updates:
- If `dist[u] + w < dist[v]`: found shorter path, reset all values
- If `dist[u] + w == dist[v]`: found another shortest path, add to count, update min/max flights

#figure(
  canvas({
    import draw: *

    content((4, 5.5), [Extended Dijkstra: Track Multiple Properties])

    circle((1, 4), radius: 0.3, fill: rgb("#90EE90"), stroke: 1pt)
    content((1, 4), [1])

    circle((3, 4.5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((3, 4.5), [2])

    circle((3, 3.5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((3, 3.5), [3])

    circle((5, 4), radius: 0.3, fill: rgb("#FFB6C1"), stroke: 1pt)
    content((5, 4), [4])

    line((1.3, 4.1), (2.7, 4.4), stroke: 1pt, mark: (end: ">"))
    content((1.8, 4.5), text(size: 8pt)[2])
    line((1.3, 3.9), (2.7, 3.6), stroke: 1pt, mark: (end: ">"))
    content((1.8, 3.5), text(size: 8pt)[1])
    line((3.3, 4.4), (4.7, 4.1), stroke: 1pt, mark: (end: ">"))
    content((4, 4.5), text(size: 8pt)[3])
    line((3.3, 3.6), (4.7, 3.9), stroke: 1pt, mark: (end: ">"))
    content((4, 3.5), text(size: 8pt)[4])

    content((3.5, 2.2), text(size: 9pt)[Two paths of cost 5: 1→2→4 and 1→3→4])
    content((3.5, 1.7), text(size: 9pt)[count=2, min\_flights=2, max\_flights=2])
  })
)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;
const ll INF = 1e18;
const int MOD = 1e9 + 7;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    vector<vector<pair<int, ll>>> adj(n + 1);
    for (int i = 0; i < m; i++) {
        int a, b;
        ll c;
        cin >> a >> b >> c;
        adj[a].push_back({b, c});
    }

    vector<ll> dist(n + 1, INF);
    vector<ll> cnt(n + 1, 0);
    vector<int> minf(n + 1, 0), maxf(n + 1, 0);

    priority_queue<pair<ll, int>, vector<pair<ll, int>>, greater<>> pq;
    dist[1] = 0;
    cnt[1] = 1;
    pq.push({0, 1});

    while (!pq.empty()) {
        auto [d, u] = pq.top();
        pq.pop();

        if (d > dist[u]) continue;

        for (auto [v, w] : adj[u]) {
            if (dist[u] + w < dist[v]) {
                dist[v] = dist[u] + w;
                cnt[v] = cnt[u];
                minf[v] = minf[u] + 1;
                maxf[v] = maxf[u] + 1;
                pq.push({dist[v], v});
            } else if (dist[u] + w == dist[v]) {
                cnt[v] = (cnt[v] + cnt[u]) % MOD;
                minf[v] = min(minf[v], minf[u] + 1);
                maxf[v] = max(maxf[v], maxf[u] + 1);
            }
        }
    }

    cout << dist[n] << " " << cnt[n] << " " << minf[n] << " " << maxf[n] << "\n";
    return 0;
}
```
#pagebreak()

== Planets Queries I

\
#link("https://cses.fi/problemset/task/1750")[Question - Planets Queries I]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1750")[Backup Link]

\
*Explanation* :

Each planet has exactly one teleporter to another planet. Given queries "starting from planet x, where do you end up after k teleports?", answer efficiently using *binary lifting*.

Key Insight - Binary Lifting:
Precompute `jump[i][x]` = planet reached from x after $2^i$ teleports. Any k can be decomposed into powers of 2, so we can answer queries by combining jumps.

Building the Table:
- `jump[0][x] = t[x]` (direct teleporter destination)
- `jump[i][x] = jump[i-1][jump[i-1][x]]` (jump $2^i$ = jump $2^(i-1)$ twice)

#figure(
  canvas({
    import draw: *

    content((4, 5.5), [Binary Lifting: Precompute Power-of-2 Jumps])

    content((2, 4.5), text(size: 9pt)[jump\[0\]\[x\] = 1 step])
    content((2, 4.0), text(size: 9pt)[jump\[1\]\[x\] = 2 steps])
    content((2, 3.5), text(size: 9pt)[jump\[2\]\[x\] = 4 steps])
    content((2, 3.0), text(size: 9pt)[...])

    content((5.5, 4.0), text(size: 9pt)[Query k=5 = 4+1:])
    content((5.5, 3.5), text(size: 9pt)[Use jump\[2\] then jump\[0\]])
  })
)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

const int LOG = 30;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, q;
    cin >> n >> q;

    vector<vector<int>> jump(LOG, vector<int>(n + 1));

    for (int i = 1; i <= n; i++) {
        cin >> jump[0][i];
    }

    // Build binary lifting table
    for (int j = 1; j < LOG; j++) {
        for (int i = 1; i <= n; i++) {
            jump[j][i] = jump[j-1][jump[j-1][i]];
        }
    }

    while (q--) {
        int x;
        long long k;
        cin >> x >> k;

        for (int j = 0; j < LOG; j++) {
            if (k & (1LL << j)) {
                x = jump[j][x];
            }
        }

        cout << x << "\n";
    }

    return 0;
}
```
#pagebreak()

== Planets Queries II

\
#link("https://cses.fi/problemset/task/1160")[Question - Planets Queries II]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1160")[Backup Link]

\
*Explanation* :

Given queries "how many teleports to get from planet a to planet b?", find the distance or report impossible. This is more complex because the functional graph has cycles (rho-shaped).

Key Insight:
Each connected component has exactly one cycle (since each node has out-degree 1). Find which cycle each node belongs to, distance to cycle, and position in cycle.

Cases:
1. If a and b are in different components: impossible
2. If b is on the path from a (before cycle): direct distance
3. If both reach the same cycle: distance to cycle + cycle traversal

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

const int LOG = 30;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, q;
    cin >> n >> q;

    vector<int> t(n + 1);
    vector<vector<int>> jump(LOG, vector<int>(n + 1));

    for (int i = 1; i <= n; i++) {
        cin >> t[i];
        jump[0][i] = t[i];
    }

    for (int j = 1; j < LOG; j++) {
        for (int i = 1; i <= n; i++) {
            jump[j][i] = jump[j-1][jump[j-1][i]];
        }
    }

    // Find cycles and distances
    vector<int> cycle_id(n + 1, 0), pos_in_cycle(n + 1, -1), dist_to_cycle(n + 1, -1);
    vector<int> cycle_len;
    int num_cycles = 0;

    vector<int> visited(n + 1, 0), in_stack(n + 1, 0);

    for (int start = 1; start <= n; start++) {
        if (visited[start]) continue;

        vector<int> path;
        int cur = start;

        while (!visited[cur] && !in_stack[cur]) {
            in_stack[cur] = 1;
            path.push_back(cur);
            cur = t[cur];
        }

        if (in_stack[cur]) {
            // Found new cycle
            num_cycles++;
            cycle_len.push_back(0);
            int cycle_start = cur;
            int pos = 0;
            do {
                cycle_id[cur] = num_cycles;
                pos_in_cycle[cur] = pos++;
                dist_to_cycle[cur] = 0;
                cur = t[cur];
            } while (cur != cycle_start);
            cycle_len[num_cycles - 1] = pos;
        }

        // Mark path nodes
        for (int node : path) {
            in_stack[node] = 0;
            visited[node] = 1;
        }
    }

    // Compute dist_to_cycle for non-cycle nodes
    function<void(int)> compute_dist = [&](int u) {
        if (dist_to_cycle[u] != -1) return;
        compute_dist(t[u]);
        dist_to_cycle[u] = dist_to_cycle[t[u]] + 1;
        cycle_id[u] = cycle_id[t[u]];
    };

    for (int i = 1; i <= n; i++) {
        compute_dist(i);
    }

    while (q--) {
        int a, b;
        cin >> a >> b;

        if (cycle_id[a] != cycle_id[b]) {
            cout << -1 << "\n";
            continue;
        }

        // Check if b is reachable from a
        // Try walking from a to see if we hit b before cycle
        int steps = 0;
        int cur = a;
        bool found = false;

        while (dist_to_cycle[cur] > dist_to_cycle[b]) {
            cur = t[cur];
            steps++;
        }

        if (cur == b) {
            cout << steps << "\n";
            continue;
        }

        if (dist_to_cycle[a] > 0 && dist_to_cycle[b] > 0) {
            cout << -1 << "\n";
            continue;
        }

        if (dist_to_cycle[b] > 0) {
            cout << -1 << "\n";
            continue;
        }

        // Both on cycle or a reaches cycle then b
        steps = dist_to_cycle[a];
        cur = a;
        for (int i = 0; i < steps; i++) cur = t[cur];

        int clen = cycle_len[cycle_id[a] - 1];
        int diff = (pos_in_cycle[b] - pos_in_cycle[cur] + clen) % clen;
        cout << steps + diff << "\n";
    }

    return 0;
}
```
#pagebreak()

== Planets Cycles

\
#link("https://cses.fi/problemset/task/1751")[Question - Planets Cycles]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1751")[Backup Link]

\
*Explanation* :

For each planet, find how many teleports until you return to a previously visited planet. This is finding the "tail + cycle length" for each node in a functional graph.

Key Insight:
Starting from any node, you'll eventually enter a cycle. The answer is the distance to the cycle plus the cycle length.

Algorithm:
1. Find all cycles using DFS with timestamp tracking
2. For cycle nodes: answer = cycle length
3. For tail nodes: answer = distance to cycle + cycle length

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n;
    cin >> n;

    vector<int> t(n + 1);
    for (int i = 1; i <= n; i++) {
        cin >> t[i];
    }

    vector<int> ans(n + 1, 0);
    vector<int> visited(n + 1, 0), in_path(n + 1, 0), path_pos(n + 1, 0);

    for (int start = 1; start <= n; start++) {
        if (ans[start] > 0) continue;

        vector<int> path;
        int cur = start;

        while (!visited[cur] && !in_path[cur]) {
            in_path[cur] = 1;
            path_pos[cur] = path.size();
            path.push_back(cur);
            cur = t[cur];
        }

        int cycle_len = 0, cycle_start_pos = 0;

        if (in_path[cur]) {
            // Found cycle
            cycle_start_pos = path_pos[cur];
            cycle_len = path.size() - cycle_start_pos;

            // Set answer for cycle nodes
            for (int i = cycle_start_pos; i < (int)path.size(); i++) {
                ans[path[i]] = cycle_len;
            }
        }

        // Set answer for tail nodes (and cycle nodes if already visited)
        for (int i = (int)path.size() - 1; i >= 0; i--) {
            if (ans[path[i]] == 0) {
                ans[path[i]] = ans[t[path[i]]] + 1;
            }
            in_path[path[i]] = 0;
            visited[path[i]] = 1;
        }
    }

    for (int i = 1; i <= n; i++) {
        cout << ans[i] << " ";
    }
    cout << "\n";

    return 0;
}
```
#pagebreak()

== Road Reparation

\
#link("https://cses.fi/problemset/task/1675")[Question - Road Reparation]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1675")[Backup Link]

\
*Explanation* :

_Concepts used: *Minimum Spanning Tree*, *DSU* (Disjoint Set Union for Kruskal's) - see Concepts_

Find the minimum cost to connect all cities. This is the *Minimum Spanning Tree (MST)* problem.

Kruskal's Algorithm:
1. Sort all edges by weight
2. Use Union-Find (DSU) to track connected components
3. For each edge (in sorted order), if it connects two different components, add it to MST
4. Stop when we have n-1 edges (all nodes connected)

#figure(
  canvas({
    import draw: *

    content((4, 5.5), [Kruskal's MST: Add Cheapest Edges First])

    circle((1, 4), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((1, 4), [1])
    circle((2.5, 4.5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2.5, 4.5), [2])
    circle((2.5, 3.5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2.5, 3.5), [3])
    circle((4, 4), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((4, 4), [4])

    line((1.3, 4.1), (2.2, 4.4), stroke: (paint: green, thickness: 2pt))
    content((1.5, 4.5), text(size: 8pt, fill: green)[1])
    line((1.3, 3.9), (2.2, 3.6), stroke: (paint: green, thickness: 2pt))
    content((1.5, 3.5), text(size: 8pt, fill: green)[2])
    line((2.8, 4.4), (3.7, 4.1), stroke: (paint: green, thickness: 2pt))
    content((3.2, 4.5), text(size: 8pt, fill: green)[3])
    line((2.8, 3.6), (3.7, 3.9), stroke: (paint: gray, thickness: 1pt, dash: "dashed"))
    content((3.2, 3.4), text(size: 8pt, fill: gray)[5])

    content((3, 2.2), text(fill: green)[MST cost = 1 + 2 + 3 = 6])
  })
)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;

vector<int> parent, rank_;

int find(int x) {
    if (parent[x] != x) parent[x] = find(parent[x]);
    return parent[x];
}

bool unite(int a, int b) {
    a = find(a); b = find(b);
    if (a == b) return false;
    if (rank_[a] < rank_[b]) swap(a, b);
    parent[b] = a;
    if (rank_[a] == rank_[b]) rank_[a]++;
    return true;
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    parent.resize(n + 1);
    rank_.resize(n + 1, 0);
    for (int i = 1; i <= n; i++) parent[i] = i;

    vector<tuple<ll, int, int>> edges;
    for (int i = 0; i < m; i++) {
        int a, b;
        ll c;
        cin >> a >> b >> c;
        edges.push_back({c, a, b});
    }

    sort(edges.begin(), edges.end());

    ll total = 0;
    int count = 0;

    for (auto [w, a, b] : edges) {
        if (unite(a, b)) {
            total += w;
            count++;
        }
    }

    if (count != n - 1) {
        cout << "IMPOSSIBLE\n";
    } else {
        cout << total << "\n";
    }

    return 0;
}
```
#pagebreak()

== Road Construction

\
#link("https://cses.fi/problemset/task/1676")[Question - Road Construction]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1676")[Backup Link]

\
*Explanation* :

After each road is built, output the number of connected components and the size of the largest component. Use *Union-Find (DSU)* with size tracking.

Key Operations:
- `unite(a, b)`: merge components, update sizes
- Track component count (decreases by 1 on each successful merge)
- Track maximum component size

#figure(
  canvas({
    import draw: *

    content((4, 5), [DSU: Track Components and Sizes])

    content((2, 4), text(size: 9pt)[Initially: n components, each size 1])
    content((2, 3.5), text(size: 9pt)[After merge: components--, update max size])
  })
)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

vector<int> parent, size_;

int find(int x) {
    if (parent[x] != x) parent[x] = find(parent[x]);
    return parent[x];
}

void unite(int a, int b, int &components, int &max_size) {
    a = find(a); b = find(b);
    if (a == b) return;

    if (size_[a] < size_[b]) swap(a, b);
    parent[b] = a;
    size_[a] += size_[b];
    max_size = max(max_size, size_[a]);
    components--;
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    parent.resize(n + 1);
    size_.resize(n + 1, 1);
    for (int i = 1; i <= n; i++) parent[i] = i;

    int components = n, max_size = 1;

    while (m--) {
        int a, b;
        cin >> a >> b;
        unite(a, b, components, max_size);
        cout << components << " " << max_size << "\n";
    }

    return 0;
}
```
#pagebreak()

== Flight Routes Check

\
#link("https://cses.fi/problemset/task/1682")[Question - Flight Routes Check]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1682")[Backup Link]

\
*Explanation* :

Check if every city can reach every other city using flights. The graph is *strongly connected* if and only if this is true.

Key Insight:
A directed graph is strongly connected iff:
1. Every node is reachable from node 1 (check with DFS/BFS from 1)
2. Node 1 is reachable from every node (check with DFS/BFS on reversed graph from 1)

If not strongly connected, find two nodes a, b where a cannot reach b.

#figure(
  canvas({
    import draw: *

    content((4, 5), [Strongly Connected: Both DFS Must Visit All])

    circle((1.5, 3.5), radius: 0.3, fill: rgb("#90EE90"), stroke: 1pt)
    content((1.5, 3.5), [1])
    circle((3, 4), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((3, 4), [2])
    circle((3, 3), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((3, 3), [3])

    line((1.8, 3.6), (2.7, 3.9), stroke: 1pt, mark: (end: ">"))
    line((2.7, 3.1), (1.8, 3.4), stroke: 1pt, mark: (end: ">"))
    line((3, 3.7), (3, 3.3), stroke: 1pt, mark: (end: ">"))

    content((5, 3.5), text(size: 9pt)[DFS from 1: reaches all])
    content((5, 3.0), text(size: 9pt)[Reverse DFS from 1: reaches all])
    content((5, 2.5), text(size: 9pt, fill: green)[→ Strongly connected!])
  })
)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    vector<vector<int>> adj(n + 1), radj(n + 1);
    for (int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back(b);
        radj[b].push_back(a);
    }

    // BFS from node 1
    vector<bool> vis1(n + 1, false);
    queue<int> q;
    q.push(1);
    vis1[1] = true;
    while (!q.empty()) {
        int u = q.front(); q.pop();
        for (int v : adj[u]) {
            if (!vis1[v]) {
                vis1[v] = true;
                q.push(v);
            }
        }
    }

    // BFS from node 1 on reversed graph
    vector<bool> vis2(n + 1, false);
    q.push(1);
    vis2[1] = true;
    while (!q.empty()) {
        int u = q.front(); q.pop();
        for (int v : radj[u]) {
            if (!vis2[v]) {
                vis2[v] = true;
                q.push(v);
            }
        }
    }

    // Check if all nodes visited in both
    for (int i = 1; i <= n; i++) {
        if (!vis1[i]) {
            cout << "NO\n" << 1 << " " << i << "\n";
            return 0;
        }
        if (!vis2[i]) {
            cout << "NO\n" << i << " " << 1 << "\n";
            return 0;
        }
    }

    cout << "YES\n";
    return 0;
}
```
#pagebreak()

== Planets and Kingdoms

\
#link("https://cses.fi/problemset/task/1683")[Question - Planets and Kingdoms]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1683")[Backup Link]

\
*Explanation* :

Divide planets into kingdoms where planets in the same kingdom can reach each other. This is finding *Strongly Connected Components (SCCs)*.

Kosaraju's Algorithm:
1. DFS on original graph, push nodes to stack in finish order
2. DFS on reversed graph in stack order (reverse finish order)
3. Each DFS tree in step 2 is an SCC

#figure(
  canvas({
    import draw: *

    content((4, 5), [Kosaraju: Two DFS Passes])

    content((2, 4), text(size: 9pt)[1. DFS on G, record finish times])
    content((2, 3.5), text(size: 9pt)[2. DFS on G\u{5765} in reverse finish order])
    content((2, 3), text(size: 9pt)[3. Each tree = one SCC])
  })
)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int n, m;
vector<vector<int>> adj, radj;
vector<bool> visited;
vector<int> order, comp;
int num_scc = 0;

void dfs1(int u) {
    visited[u] = true;
    for (int v : adj[u]) {
        if (!visited[v]) dfs1(v);
    }
    order.push_back(u);
}

void dfs2(int u, int c) {
    comp[u] = c;
    for (int v : radj[u]) {
        if (comp[v] == 0) dfs2(v, c);
    }
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> m;
    adj.resize(n + 1);
    radj.resize(n + 1);
    visited.resize(n + 1, false);
    comp.resize(n + 1, 0);

    for (int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back(b);
        radj[b].push_back(a);
    }

    // First DFS pass
    for (int i = 1; i <= n; i++) {
        if (!visited[i]) dfs1(i);
    }

    // Second DFS pass in reverse finish order
    reverse(order.begin(), order.end());
    for (int u : order) {
        if (comp[u] == 0) {
            num_scc++;
            dfs2(u, num_scc);
        }
    }

    cout << num_scc << "\n";
    for (int i = 1; i <= n; i++) {
        cout << comp[i] << " ";
    }
    cout << "\n";

    return 0;
}
```
#pagebreak()

== Giant Pizza

\
#link("https://cses.fi/problemset/task/1684")[Question - Giant Pizza]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1684")[Backup Link]

\
*Explanation* :

Each person wants at least one of two toppings (+ means include, - means exclude). Find a valid assignment or report impossible. This is the classic *2-SAT* problem.

2-SAT Formulation:
- Variable $x_i$ = true if topping i is included
- Clause $(a or b)$ becomes implication: $not a => b$ and $not b => a$

Solution via SCC:
- Build implication graph
- Find SCCs using Kosaraju's algorithm
- If $x$ and $not x$ are in the same SCC, no solution exists
- Otherwise, for each variable, pick the literal whose SCC comes later in topological order

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int n, m;
vector<vector<int>> adj, radj;
vector<int> order, comp;
vector<bool> visited;

void dfs1(int u) {
    visited[u] = true;
    for (int v : adj[u]) if (!visited[v]) dfs1(v);
    order.push_back(u);
}

void dfs2(int u, int c) {
    comp[u] = c;
    for (int v : radj[u]) if (comp[v] == -1) dfs2(v, c);
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> m >> n;

    // 2n nodes: i for x_i, i+n for NOT x_i
    adj.resize(2 * n);
    radj.resize(2 * n);
    visited.resize(2 * n, false);
    comp.resize(2 * n, -1);

    for (int i = 0; i < m; i++) {
        char c1, c2;
        int t1, t2;
        cin >> c1 >> t1 >> c2 >> t2;
        t1--; t2--;

        // Convert to literal indices
        int a = (c1 == '+') ? t1 : t1 + n;
        int b = (c2 == '+') ? t2 : t2 + n;
        int na = (a < n) ? a + n : a - n;
        int nb = (b < n) ? b + n : b - n;

        // Add implications: NOT a => b, NOT b => a
        adj[na].push_back(b);
        adj[nb].push_back(a);
        radj[b].push_back(na);
        radj[a].push_back(nb);
    }

    // Kosaraju's algorithm
    for (int i = 0; i < 2 * n; i++) {
        if (!visited[i]) dfs1(i);
    }

    int num_scc = 0;
    reverse(order.begin(), order.end());
    for (int u : order) {
        if (comp[u] == -1) dfs2(u, num_scc++);
    }

    // Check satisfiability
    for (int i = 0; i < n; i++) {
        if (comp[i] == comp[i + n]) {
            cout << "IMPOSSIBLE\n";
            return 0;
        }
    }

    // Build assignment (pick literal with higher SCC number)
    for (int i = 0; i < n; i++) {
        cout << (comp[i] > comp[i + n] ? '+' : '-') << " ";
    }
    cout << "\n";

    return 0;
}
```
#pagebreak()

== Coin Collector

\
#link("https://cses.fi/problemset/task/1686")[Question - Coin Collector]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1686")[Backup Link]

\
*Explanation* :

Collect maximum coins starting from any room. Rooms in the same SCC can all be collected together, so condense SCCs into a DAG, then find the longest path.

Algorithm:
1. Find SCCs and sum coins in each SCC
2. Build condensed DAG between SCCs
3. Find longest path in DAG using topological order DP

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;

int n, m;
vector<vector<int>> adj, radj;
vector<int> order, comp;
vector<bool> visited;
vector<ll> coins, scc_coins;

void dfs1(int u) {
    visited[u] = true;
    for (int v : adj[u]) if (!visited[v]) dfs1(v);
    order.push_back(u);
}

void dfs2(int u, int c) {
    comp[u] = c;
    scc_coins[c] += coins[u];
    for (int v : radj[u]) if (comp[v] == -1) dfs2(v, c);
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> m;
    adj.resize(n + 1);
    radj.resize(n + 1);
    coins.resize(n + 1);
    visited.resize(n + 1, false);
    comp.resize(n + 1, -1);

    for (int i = 1; i <= n; i++) cin >> coins[i];

    for (int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back(b);
        radj[b].push_back(a);
    }

    // Find SCCs
    for (int i = 1; i <= n; i++) if (!visited[i]) dfs1(i);

    int num_scc = 0;
    scc_coins.resize(n + 1, 0);
    reverse(order.begin(), order.end());
    for (int u : order) if (comp[u] == -1) dfs2(u, num_scc++);

    // Build condensed DAG and find longest path
    vector<vector<int>> dag(num_scc);
    vector<int> indegree(num_scc, 0);

    for (int u = 1; u <= n; u++) {
        for (int v : adj[u]) {
            if (comp[u] != comp[v]) {
                dag[comp[u]].push_back(comp[v]);
                indegree[comp[v]]++;
            }
        }
    }

    // Topological sort + DP
    vector<ll> dp(num_scc);
    for (int i = 0; i < num_scc; i++) dp[i] = scc_coins[i];

    queue<int> q;
    for (int i = 0; i < num_scc; i++) {
        if (indegree[i] == 0) q.push(i);
    }

    while (!q.empty()) {
        int u = q.front(); q.pop();
        for (int v : dag[u]) {
            dp[v] = max(dp[v], dp[u] + scc_coins[v]);
            if (--indegree[v] == 0) q.push(v);
        }
    }

    cout << *max_element(dp.begin(), dp.end()) << "\n";
    return 0;
}
```
#pagebreak()

== Mail Delivery

\
#link("https://cses.fi/problemset/task/1691")[Question - Mail Delivery]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1691")[Backup Link]

\
*Explanation* :

Starting from post office 1, traverse every street exactly once and return to 1. This is finding an *Eulerian circuit* in an undirected graph.

Eulerian Circuit Exists When:
1. Graph is connected (considering only vertices with edges)
2. Every vertex has even degree

Hierholzer's Algorithm:
Start from any vertex, greedily follow unused edges. When stuck, backtrack and insert the cycle. Use a stack-based implementation for efficiency.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    vector<vector<pair<int, int>>> adj(n + 1);
    vector<int> degree(n + 1, 0);
    vector<bool> used(m, false);

    for (int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back({b, i});
        adj[b].push_back({a, i});
        degree[a]++;
        degree[b]++;
    }

    // Check if Eulerian circuit exists
    for (int i = 1; i <= n; i++) {
        if (degree[i] % 2 != 0) {
            cout << "IMPOSSIBLE\n";
            return 0;
        }
    }

    // Hierholzer's algorithm
    vector<int> path;
    stack<int> st;
    vector<int> ptr(n + 1, 0);
    st.push(1);

    while (!st.empty()) {
        int u = st.top();
        bool found = false;

        while (ptr[u] < (int)adj[u].size()) {
            auto [v, idx] = adj[u][ptr[u]++];
            if (!used[idx]) {
                used[idx] = true;
                st.push(v);
                found = true;
                break;
            }
        }

        if (!found) {
            path.push_back(u);
            st.pop();
        }
    }

    if ((int)path.size() != m + 1) {
        cout << "IMPOSSIBLE\n";
    } else {
        for (int node : path) cout << node << " ";
        cout << "\n";
    }

    return 0;
}
```
#pagebreak()

== De Bruijn Sequence

\
#link("https://cses.fi/problemset/task/1692")[Question - De Bruijn Sequence]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1692")[Backup Link]

\
*Explanation* :

Find the shortest string containing all n-bit binary strings as substrings. Length is $2^n + n - 1$.

Key Insight:
Model as Eulerian path problem. Create nodes for all (n-1)-bit strings. Edge from "abc" to "bcd" labeled with last bit. Finding Eulerian path gives De Bruijn sequence.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n;
    cin >> n;

    if (n == 1) {
        cout << "01\n";
        return 0;
    }

    int nodes = 1 << (n - 1);
    int mask = nodes - 1;

    vector<int> ptr(nodes, 0);
    vector<int> path;
    stack<int> st;
    st.push(0);

    while (!st.empty()) {
        int u = st.top();
        if (ptr[u] < 2) {
            int v = ((u << 1) | ptr[u]++) & mask;
            st.push(v);
        } else {
            path.push_back(u);
            st.pop();
        }
    }

    reverse(path.begin(), path.end());

    string result(n - 1, '0');
    for (int i = 0; i < (int)path.size() - 1; i++) {
        result += ('0' + (path[i + 1] & 1));
    }

    cout << result << "\n";
    return 0;
}
```
#pagebreak()

== Teleporters Path

\
#link("https://cses.fi/problemset/task/1693")[Question - Teleporters Path]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1693")[Backup Link]

\
*Explanation* :

Find a path using each teleporter exactly once, starting from level 1 and ending at level n. This is an *Eulerian path* in a directed graph.

Eulerian Path Exists When:
1. At most one vertex has out-degree - in-degree = 1 (start)
2. At most one vertex has in-degree - out-degree = 1 (end)
3. All other vertices have equal in-degree and out-degree
4. Graph is connected

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    vector<vector<int>> adj(n + 1);
    vector<int> in_deg(n + 1, 0), out_deg(n + 1, 0);

    for (int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back(b);
        out_deg[a]++;
        in_deg[b]++;
    }

    // Check Eulerian path conditions
    bool valid = true;
    valid &= (out_deg[1] - in_deg[1] == 1);  // Start at 1
    valid &= (in_deg[n] - out_deg[n] == 1);  // End at n

    for (int i = 2; i < n; i++) {
        if (in_deg[i] != out_deg[i]) valid = false;
    }

    if (!valid) {
        cout << "IMPOSSIBLE\n";
        return 0;
    }

    // Hierholzer's algorithm
    vector<int> path;
    vector<int> ptr(n + 1, 0);
    stack<int> st;
    st.push(1);

    while (!st.empty()) {
        int u = st.top();
        if (ptr[u] < (int)adj[u].size()) {
            st.push(adj[u][ptr[u]++]);
        } else {
            path.push_back(u);
            st.pop();
        }
    }

    reverse(path.begin(), path.end());

    if ((int)path.size() != m + 1) {
        cout << "IMPOSSIBLE\n";
    } else {
        for (int node : path) cout << node << " ";
        cout << "\n";
    }

    return 0;
}
```
#pagebreak()

== Hamiltonian Flights

\
#link("https://cses.fi/problemset/task/1690")[Question - Hamiltonian Flights]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1690")[Backup Link]

\
*Explanation* :

Count the number of *Hamiltonian paths* from city 1 to city n. A Hamiltonian path visits every node exactly once.

*Key Insight:* Use *bitmask DP* where `dp[mask][i]` = number of paths that:
- Visit exactly the cities in `mask`
- End at city `i`

*Algorithm:*
1. State: `dp[mask][i]` where mask has bit j set if city j is visited
2. Base case: `dp[1][0] = 1` (only city 1 visited, at city 1)
3. Transition: For each edge (j → i), `dp[mask | (1<<i)][i] += dp[mask][j]`
4. Answer: `dp[(1<<n)-1][n-1]` (all cities visited, at city n)

#figure(
  canvas(length: 1cm, {
    import draw: *

    // Show 4-node example
    let nodes = ((0, 2), (3, 2), (0, 0), (3, 0))
    let labels = ("1", "2", "3", "4")

    for (i, pos) in nodes.enumerate() {
      circle(pos, radius: 0.35, fill: if i == 0 { rgb("#90EE90") } else if i == 3 { rgb("#FFB6C1") } else { white }, stroke: black, name: "n" + str(i))
      content(pos, labels.at(i))
    }

    // Edges
    line("n0", "n1", mark: (end: ">"), stroke: black)
    line("n0", "n2", mark: (end: ">"), stroke: black)
    line("n1", "n2", mark: (end: ">"), stroke: black)
    line("n1", "n3", mark: (end: ">"), stroke: black)
    line("n2", "n3", mark: (end: ">"), stroke: black)

    content((1.5, -1), [Graph with 4 cities])

    // DP visualization
    content((7, 3), [*Bitmask DP States:*], anchor: "west")
    content((7, 2.3), [`mask = 0001`: at city 1], anchor: "west")
    content((7, 1.7), [`mask = 0011`: cities \{1,2\} visited], anchor: "west")
    content((7, 1.1), [`mask = 0111`: cities \{1,2,3\} visited], anchor: "west")
    content((7, 0.5), [`mask = 1111`: all visited, at city 4], anchor: "west")

    // Path example
    content((7, -0.3), [*Example path:* 1→2→3→4], anchor: "west")
    content((7, -0.9), [*Another:* 1→3→2→4], anchor: "west")
  }),
  caption: [Hamiltonian path counting with bitmask DP]
)

*Trace Example (n=4):*
- `dp[0001][0] = 1` (start at city 1)
- From city 1: go to 2 → `dp[0011][1] = 1`
- From city 1: go to 3 → `dp[0101][2] = 1`
- From city 2: go to 3 → `dp[0111][2] += dp[0011][1] = 1`
- From city 2: go to 4 → `dp[1011][3] = 1`
- From city 3: go to 4 → `dp[1111][3] += dp[0111][2] = 1`
- Continue until `dp[1111][3]` = total Hamiltonian paths to city 4

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

const int MOD = 1e9 + 7;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    vector<vector<int>> adj(n);
    for (int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        a--; b--;
        adj[a].push_back(b);
    }

    // dp[mask][i] = number of Hamiltonian paths ending at i with visited set = mask
    vector<vector<long long>> dp(1 << n, vector<long long>(n, 0));
    dp[1][0] = 1;  // Start at city 1 (0-indexed: city 0)

    for (int mask = 1; mask < (1 << n); mask++) {
        for (int u = 0; u < n; u++) {
            if (!(mask & (1 << u))) continue;  // u must be in mask
            if (dp[mask][u] == 0) continue;

            for (int v : adj[u]) {
                if (mask & (1 << v)) continue;  // v must not be visited
                int newMask = mask | (1 << v);
                dp[newMask][v] = (dp[newMask][v] + dp[mask][u]) % MOD;
            }
        }
    }

    // Answer: all cities visited, ending at city n (0-indexed: n-1)
    cout << dp[(1 << n) - 1][n - 1] << "\n";

    return 0;
}
```
#pagebreak()

== Knight's Tour

\
#link("https://cses.fi/problemset/task/1689")[Question - Knight's Tour]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1689")[Backup Link]

\
*Explanation* :

Find a knight's tour on an 8×8 chessboard starting from a given position. The knight must visit every square exactly once.

*Key Insight:* Use *backtracking* with *Warnsdorff's heuristic*: always move to the square with the fewest onward moves. This greedy heuristic dramatically reduces backtracking.

*Algorithm:*
1. From current position, find all valid knight moves
2. Sort moves by their *degree* (number of onward moves from each)
3. Try moves in order of ascending degree (Warnsdorff's rule)
4. If stuck, backtrack
5. Stop when all 64 squares are visited

#figure(
  canvas(length: 0.6cm, {
    import draw: *

    // Draw 8x8 board
    for i in range(8) {
      for j in range(8) {
        let fill_color = if calc.rem(i + j, 2) == 0 { rgb("#EEEED2") } else { rgb("#769656") }
        rect((i, j), (i + 1, j + 1), fill: fill_color, stroke: gray + 0.3pt)
      }
    }

    // Knight starting position (e.g., 2,2)
    circle((2.5, 2.5), radius: 0.3, fill: rgb("#4169E1"), stroke: black)
    content((2.5, 2.5), text(fill: white, size: 8pt)[K])

    // Possible moves from (2,2)
    let moves = ((0, 1), (0, 3), (1, 0), (1, 4), (3, 0), (3, 4), (4, 1), (4, 3))
    for (mx, my) in moves {
      circle((mx + 0.5, my + 0.5), radius: 0.25, fill: rgb("#90EE90"), stroke: black)
    }

    // Show degree annotation
    content((0.5, 1.5), text(size: 6pt)[2], anchor: "center")
    content((0.5, 3.5), text(size: 6pt)[3], anchor: "center")
    content((1.5, 0.5), text(size: 6pt)[2], anchor: "center")
    content((1.5, 4.5), text(size: 6pt)[4], anchor: "center")
    content((3.5, 0.5), text(size: 6pt)[3], anchor: "center")
    content((3.5, 4.5), text(size: 6pt)[5], anchor: "center")
    content((4.5, 1.5), text(size: 6pt)[4], anchor: "center")
    content((4.5, 3.5), text(size: 6pt)[6], anchor: "center")

    content((4, -1), [Knight at (3,3): green = reachable squares])
    content((4, -1.8), [Numbers = degree (onward moves)])
    content((4, -2.6), [Warnsdorff: try degree 2 first])
  }),
  caption: [Warnsdorff's heuristic - prefer squares with fewer exits]
)

*Knight Move Offsets:*
```
dx = {-2, -2, -1, -1, +1, +1, +2, +2}
dy = {-1, +1, -2, +2, -2, +2, -1, +1}
```

*Why Warnsdorff Works:*
- Visiting "corner" squares early (fewer exits) prevents getting trapped
- Leaves central squares (more exits) for later flexibility
- Almost always finds solution without backtracking

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int board[8][8];
int dx[] = {-2, -2, -1, -1, 1, 1, 2, 2};
int dy[] = {-1, 1, -2, 2, -2, 2, -1, 1};

bool valid(int x, int y) {
    return x >= 0 && x < 8 && y >= 0 && y < 8 && board[x][y] == 0;
}

int degree(int x, int y) {
    int cnt = 0;
    for (int i = 0; i < 8; i++) {
        int nx = x + dx[i], ny = y + dy[i];
        if (valid(nx, ny)) cnt++;
    }
    return cnt;
}

bool solve(int x, int y, int move) {
    board[x][y] = move;
    if (move == 64) return true;

    // Get all valid next moves with their degrees
    vector<tuple<int, int, int>> next;
    for (int i = 0; i < 8; i++) {
        int nx = x + dx[i], ny = y + dy[i];
        if (valid(nx, ny)) {
            next.push_back({degree(nx, ny), nx, ny});
        }
    }

    // Sort by degree (Warnsdorff's heuristic)
    sort(next.begin(), next.end());

    for (auto& [deg, nx, ny] : next) {
        if (solve(nx, ny, move + 1)) return true;
    }

    board[x][y] = 0;  // Backtrack
    return false;
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int x, y;
    cin >> x >> y;
    x--; y--;  // Convert to 0-indexed

    memset(board, 0, sizeof(board));

    if (solve(y, x, 1)) {  // Note: input is (col, row)
        for (int i = 0; i < 8; i++) {
            for (int j = 0; j < 8; j++) {
                cout << board[i][j];
                if (j < 7) cout << " ";
            }
            cout << "\n";
        }
    }

    return 0;
}
```
#pagebreak()

== Download Speed

\
#link("https://cses.fi/problemset/task/1694")[Question - Download Speed]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1694")[Backup Link]

\
*Explanation* :

Find the *maximum flow* from computer 1 to computer n through a network of connections with limited capacities.

*Key Insight:* This is the classic *Maximum Flow* problem. Use *Edmonds-Karp algorithm* (BFS-based Ford-Fulkerson) or *Dinic's algorithm* for efficiency.

*Dinic's Algorithm:*
1. Build level graph using BFS (distance from source)
2. Find blocking flow using DFS (saturate paths)
3. Repeat until no augmenting path exists
4. Time: O(V²E) - much faster in practice

#figure(
  canvas(length: 1cm, {
    import draw: *

    // Network nodes
    let positions = ((0, 1), (2, 2), (2, 0), (4, 2), (4, 0), (6, 1))
    let labels = ("S", "A", "B", "C", "D", "T")

    for (i, pos) in positions.enumerate() {
      let fill_color = if i == 0 { rgb("#90EE90") } else if i == 5 { rgb("#FFB6C1") } else { white }
      circle(pos, radius: 0.35, fill: fill_color, stroke: black, name: "n" + str(i))
      content(pos, labels.at(i))
    }

    // Edges with capacities (flow/capacity format)
    set-style(mark: (end: ">"))
    line("n0", "n1", stroke: blue)
    content((0.8, 1.8), text(size: 8pt)[10], anchor: "south")

    line("n0", "n2", stroke: blue)
    content((0.8, 0.2), text(size: 8pt)[10], anchor: "north")

    line("n1", "n2", stroke: blue)
    content((2.4, 1), text(size: 8pt)[2], anchor: "west")

    line("n1", "n3", stroke: blue)
    content((3, 2.3), text(size: 8pt)[4], anchor: "south")

    line("n2", "n4", stroke: blue)
    content((3, -0.3), text(size: 8pt)[9], anchor: "north")

    line("n1", "n4", stroke: blue)
    content((2.8, 1.2), text(size: 8pt)[8], anchor: "south")

    line("n3", "n5", stroke: blue)
    content((5.2, 1.8), text(size: 8pt)[10], anchor: "south")

    line("n4", "n5", stroke: blue)
    content((5.2, 0.2), text(size: 8pt)[10], anchor: "north")

    line("n3", "n4", stroke: blue)
    content((4.4, 1), text(size: 8pt)[6], anchor: "west")

    // Legend
    content((3, -1.2), [*Max Flow = 19*])
    content((3, -1.9), [Capacity on each edge])
  }),
  caption: [Network flow - find maximum flow from S to T]
)

*Key Concepts:*
- *Residual Graph:* Shows remaining capacity on edges
- *Augmenting Path:* Path from S to T with positive residual capacity
- *Blocking Flow:* No more augmenting paths in level graph

*Dinic's Algorithm Trace:*
1. BFS builds level graph: S(0) → A,B(1) → C,D(2) → T(3)
2. DFS finds paths and pushes flow
3. Repeat until T unreachable from S

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

struct Edge {
    int to, rev;
    long long cap;
};

class Dinic {
    vector<vector<Edge>> graph;
    vector<int> level, iter;
    int n;

    bool bfs(int s, int t) {
        fill(level.begin(), level.end(), -1);
        queue<int> q;
        level[s] = 0;
        q.push(s);
        while (!q.empty()) {
            int v = q.front(); q.pop();
            for (auto& e : graph[v]) {
                if (e.cap > 0 && level[e.to] < 0) {
                    level[e.to] = level[v] + 1;
                    q.push(e.to);
                }
            }
        }
        return level[t] >= 0;
    }

    long long dfs(int v, int t, long long f) {
        if (v == t) return f;
        for (int& i = iter[v]; i < (int)graph[v].size(); i++) {
            Edge& e = graph[v][i];
            if (e.cap > 0 && level[v] < level[e.to]) {
                long long d = dfs(e.to, t, min(f, e.cap));
                if (d > 0) {
                    e.cap -= d;
                    graph[e.to][e.rev].cap += d;
                    return d;
                }
            }
        }
        return 0;
    }

public:
    Dinic(int n) : n(n), graph(n), level(n), iter(n) {}

    void addEdge(int from, int to, long long cap) {
        graph[from].push_back({to, (int)graph[to].size(), cap});
        graph[to].push_back({from, (int)graph[from].size() - 1, 0});
    }

    long long maxflow(int s, int t) {
        long long flow = 0;
        while (bfs(s, t)) {
            fill(iter.begin(), iter.end(), 0);
            long long f;
            while ((f = dfs(s, t, LLONG_MAX)) > 0) {
                flow += f;
            }
        }
        return flow;
    }
};

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    Dinic dinic(n);
    for (int i = 0; i < m; i++) {
        int a, b;
        long long c;
        cin >> a >> b >> c;
        a--; b--;
        dinic.addEdge(a, b, c);
    }

    cout << dinic.maxflow(0, n - 1) << "\n";

    return 0;
}
```
#pagebreak()

== Police Chase

\
#link("https://cses.fi/problemset/task/1695")[Question - Police Chase]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1695")[Backup Link]

\
*Explanation* :

Find the *minimum number of streets* to block so the robber cannot reach crossroad n from crossroad 1. This is the *Minimum Cut* problem.

*Key Insight:* By the *Max-Flow Min-Cut theorem*, the minimum cut equals the maximum flow. After computing max flow, find the cut edges.

*Finding the Min Cut:*
1. Run max flow algorithm (Dinic's)
2. BFS from source in residual graph (only edges with remaining capacity)
3. Mark all reachable nodes as set S
4. Min cut edges: edges from S to non-S nodes that are saturated

#figure(
  canvas(length: 1cm, {
    import draw: *

    // Network with min cut visualization
    let positions = ((0, 1), (2, 2), (2, 0), (4, 2), (4, 0), (6, 1))
    let labels = ("1", "A", "B", "C", "D", "n")

    // Draw S set (reachable from source)
    rect((-0.6, -0.6), (2.7, 2.7), fill: rgb("#E6F3FF"), stroke: none)
    content((1, 2.9), text(size: 9pt)[Set S (reachable)])

    for (i, pos) in positions.enumerate() {
      let fill_color = if i == 0 { rgb("#90EE90") } else if i == 5 { rgb("#FFB6C1") } else { white }
      circle(pos, radius: 0.35, fill: fill_color, stroke: black, name: "n" + str(i))
      content(pos, labels.at(i))
    }

    // Normal edges
    set-style(mark: (end: ">"))
    line("n0", "n1", stroke: gray)
    line("n0", "n2", stroke: gray)
    line("n1", "n2", stroke: gray)

    // CUT EDGES (highlighted in red)
    line("n1", "n3", stroke: red + 2pt)
    line("n2", "n4", stroke: red + 2pt)

    line("n3", "n5", stroke: gray)
    line("n4", "n5", stroke: gray)
    line("n3", "n4", stroke: gray)

    // Legend
    content((3, -1), [#text(fill: red)[Red edges] = minimum cut])
    content((3, -1.7), [Block these streets!])
  }),
  caption: [Min cut separates source (node 1) from sink (node n)]
)

*Algorithm:*
1. Build graph with capacity 1 for each undirected edge (add both directions)
2. Compute max flow from node 1 to node n
3. BFS from node 1 using only edges with remaining capacity > 0
4. For each original edge (u,v): if u is reachable and v is not, it's a cut edge

*Why It Works:*
- Max-Flow Min-Cut theorem guarantees optimality
- Saturated edges crossing the S/T partition form the minimum cut

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

struct Edge {
    int to, rev;
    int cap;
};

class Dinic {
public:
    vector<vector<Edge>> graph;
    vector<int> level, iter;
    int n;

    bool bfs(int s, int t) {
        fill(level.begin(), level.end(), -1);
        queue<int> q;
        level[s] = 0;
        q.push(s);
        while (!q.empty()) {
            int v = q.front(); q.pop();
            for (auto& e : graph[v]) {
                if (e.cap > 0 && level[e.to] < 0) {
                    level[e.to] = level[v] + 1;
                    q.push(e.to);
                }
            }
        }
        return level[t] >= 0;
    }

    int dfs(int v, int t, int f) {
        if (v == t) return f;
        for (int& i = iter[v]; i < (int)graph[v].size(); i++) {
            Edge& e = graph[v][i];
            if (e.cap > 0 && level[v] < level[e.to]) {
                int d = dfs(e.to, t, min(f, e.cap));
                if (d > 0) {
                    e.cap -= d;
                    graph[e.to][e.rev].cap += d;
                    return d;
                }
            }
        }
        return 0;
    }

    Dinic(int n) : n(n), graph(n), level(n), iter(n) {}

    void addEdge(int from, int to, int cap) {
        graph[from].push_back({to, (int)graph[to].size(), cap});
        graph[to].push_back({from, (int)graph[from].size() - 1, cap});  // Undirected
    }

    int maxflow(int s, int t) {
        int flow = 0;
        while (bfs(s, t)) {
            fill(iter.begin(), iter.end(), 0);
            int f;
            while ((f = dfs(s, t, INT_MAX)) > 0) {
                flow += f;
            }
        }
        return flow;
    }
};

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    Dinic dinic(n);
    vector<pair<int,int>> edges;

    for (int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        a--; b--;
        dinic.addEdge(a, b, 1);
        edges.push_back({a, b});
    }

    int flow = dinic.maxflow(0, n - 1);

    // Find reachable nodes from source in residual graph
    vector<bool> reachable(n, false);
    queue<int> q;
    q.push(0);
    reachable[0] = true;
    while (!q.empty()) {
        int u = q.front(); q.pop();
        for (auto& e : dinic.graph[u]) {
            if (e.cap > 0 && !reachable[e.to]) {
                reachable[e.to] = true;
                q.push(e.to);
            }
        }
    }

    // Find cut edges
    vector<pair<int,int>> cutEdges;
    for (auto& [a, b] : edges) {
        if ((reachable[a] && !reachable[b]) || (reachable[b] && !reachable[a])) {
            cutEdges.push_back({a + 1, b + 1});
        }
    }

    cout << cutEdges.size() << "\n";
    for (auto& [a, b] : cutEdges) {
        cout << a << " " << b << "\n";
    }

    return 0;
}
```
#pagebreak()

== School Dance

\
#link("https://cses.fi/problemset/task/1696")[Question - School Dance]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1696")[Backup Link]

\
*Explanation* :

Find the *maximum matching* in a bipartite graph - pair maximum number of boys with girls where each person can only be in one pair.

*Key Insight:* Model as *maximum flow*:
- Source connects to all boys (capacity 1)
- Each boy connects to compatible girls (capacity 1)
- All girls connect to sink (capacity 1)
- Max flow = maximum matching

#figure(
  canvas(length: 1cm, {
    import draw: *

    // Source
    circle((0, 1.5), radius: 0.3, fill: rgb("#90EE90"), stroke: black, name: "s")
    content((0, 1.5), [S])

    // Boys
    for i in range(3) {
      circle((2, 3 - i * 1.5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: black, name: "b" + str(i))
      content((2, 3 - i * 1.5), [B#str(i + 1)])
    }

    // Girls
    for i in range(3) {
      circle((4, 3 - i * 1.5), radius: 0.3, fill: rgb("#FFB6C1"), stroke: black, name: "g" + str(i))
      content((4, 3 - i * 1.5), [G#str(i + 1)])
    }

    // Sink
    circle((6, 1.5), radius: 0.3, fill: rgb("#FFB6C1"), stroke: black, name: "t")
    content((6, 1.5), [T])

    // Source to boys
    set-style(mark: (end: ">"))
    line("s", "b0", stroke: gray)
    line("s", "b1", stroke: gray)
    line("s", "b2", stroke: gray)

    // Boy-girl compatibility (matching edges highlighted)
    line("b0", "g0", stroke: blue + 2pt)  // Matched
    line("b0", "g1", stroke: gray)
    line("b1", "g1", stroke: blue + 2pt)  // Matched
    line("b1", "g2", stroke: gray)
    line("b2", "g0", stroke: gray)
    line("b2", "g2", stroke: blue + 2pt)  // Matched

    // Girls to sink
    line("g0", "t", stroke: gray)
    line("g1", "t", stroke: gray)
    line("g2", "t", stroke: gray)

    content((3, -0.8), [#text(fill: blue)[Blue] = matched pairs])
    content((3, -1.5), [Max matching = 3])
  }),
  caption: [Bipartite matching as max flow]
)

*Alternative: Kuhn's Algorithm (Hungarian)*

For bipartite matching, we can also use a simpler DFS-based approach:
- Try to match each boy with an available girl
- If girl is taken, try to reassign the current holder

*Complexity:* O(V × E) for Kuhn's algorithm, or O(E√V) using Hopcroft-Karp

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

vector<int> adj[505];
int match_girl[505], match_boy[505];
bool used[505];
int n, m, k;

bool dfs(int boy) {
    for (int girl : adj[boy]) {
        if (used[girl]) continue;
        used[girl] = true;

        // If girl is free OR we can reassign her current match
        if (match_girl[girl] == -1 || dfs(match_girl[girl])) {
            match_girl[girl] = boy;
            match_boy[boy] = girl;
            return true;
        }
    }
    return false;
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> m >> k;

    for (int i = 0; i < k; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back(b);
    }

    memset(match_girl, -1, sizeof(match_girl));
    memset(match_boy, -1, sizeof(match_boy));

    int matching = 0;
    for (int boy = 1; boy <= n; boy++) {
        memset(used, false, sizeof(used));
        if (dfs(boy)) matching++;
    }

    cout << matching << "\n";
    for (int boy = 1; boy <= n; boy++) {
        if (match_boy[boy] != -1) {
            cout << boy << " " << match_boy[boy] << "\n";
        }
    }

    return 0;
}
```
#pagebreak()

== Distinct Routes

\
#link("https://cses.fi/problemset/task/1711")[Question - Distinct Routes]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1711")[Backup Link]

\
*Explanation* :

Find the *maximum number of edge-disjoint paths* from room 1 to room n, and output the paths.

*Key Insight:* This is max flow with capacity 1 on each edge. Each unit of flow represents one path, and capacity 1 ensures edges are not reused.

*Algorithm:*
1. Build flow network with capacity 1 on each edge
2. Compute max flow - this gives number of paths
3. Reconstruct paths by following saturated edges from source to sink

#figure(
  canvas(length: 1cm, {
    import draw: *

    // Example graph
    let positions = ((0, 1), (2, 2), (2, 0), (4, 1))
    let labels = ("1", "2", "3", "n")

    for (i, pos) in positions.enumerate() {
      let fill_color = if i == 0 { rgb("#90EE90") } else if i == 3 { rgb("#FFB6C1") } else { white }
      circle(pos, radius: 0.35, fill: fill_color, stroke: black, name: "n" + str(i))
      content(pos, labels.at(i))
    }

    // Edges - two disjoint paths shown
    set-style(mark: (end: ">"))
    line("n0", "n1", stroke: blue + 2pt)  // Path 1
    line("n1", "n3", stroke: blue + 2pt)  // Path 1

    line("n0", "n2", stroke: red + 2pt)   // Path 2
    line("n2", "n3", stroke: red + 2pt)   // Path 2

    content((2, -1), [#text(fill: blue)[Path 1:] 1 → 2 → n])
    content((2, -1.7), [#text(fill: red)[Path 2:] 1 → 3 → n])
    content((2, -2.4), [Max edge-disjoint paths = 2])
  }),
  caption: [Edge-disjoint paths - no edge shared between paths]
)

*Path Reconstruction:*
After max flow, for each path:
1. Start at node 1
2. Find an outgoing edge that was used (original capacity - residual > 0)
3. "Undo" the flow on that edge (restore capacity)
4. Move to next node, repeat until reaching n

*Why Capacity 1:*
- Each edge can only be used once
- Flow of k means k edge-disjoint paths exist

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

struct Edge {
    int to, rev;
    int cap, flow;
};

class Dinic {
public:
    vector<vector<Edge>> graph;
    vector<int> level, iter;
    int n;

    Dinic(int n) : n(n), graph(n), level(n), iter(n) {}

    void addEdge(int from, int to, int cap) {
        graph[from].push_back({to, (int)graph[to].size(), cap, 0});
        graph[to].push_back({from, (int)graph[from].size() - 1, 0, 0});
    }

    bool bfs(int s, int t) {
        fill(level.begin(), level.end(), -1);
        queue<int> q;
        level[s] = 0;
        q.push(s);
        while (!q.empty()) {
            int v = q.front(); q.pop();
            for (auto& e : graph[v]) {
                if (e.cap - e.flow > 0 && level[e.to] < 0) {
                    level[e.to] = level[v] + 1;
                    q.push(e.to);
                }
            }
        }
        return level[t] >= 0;
    }

    int dfs(int v, int t, int f) {
        if (v == t) return f;
        for (int& i = iter[v]; i < (int)graph[v].size(); i++) {
            Edge& e = graph[v][i];
            if (e.cap - e.flow > 0 && level[v] < level[e.to]) {
                int d = dfs(e.to, t, min(f, e.cap - e.flow));
                if (d > 0) {
                    e.flow += d;
                    graph[e.to][e.rev].flow -= d;
                    return d;
                }
            }
        }
        return 0;
    }

    int maxflow(int s, int t) {
        int flow = 0;
        while (bfs(s, t)) {
            fill(iter.begin(), iter.end(), 0);
            int f;
            while ((f = dfs(s, t, INT_MAX)) > 0) {
                flow += f;
            }
        }
        return flow;
    }
};

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, m;
    cin >> n >> m;

    Dinic dinic(n);
    for (int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        a--; b--;
        dinic.addEdge(a, b, 1);
    }

    int k = dinic.maxflow(0, n - 1);

    cout << k << "\n";

    // Reconstruct paths
    for (int p = 0; p < k; p++) {
        vector<int> path;
        int cur = 0;
        path.push_back(1);

        while (cur != n - 1) {
            for (auto& e : dinic.graph[cur]) {
                if (e.flow > 0) {
                    e.flow--;
                    path.push_back(e.to + 1);
                    cur = e.to;
                    break;
                }
            }
        }

        cout << path.size() << "\n";
        for (int node : path) {
            cout << node << " ";
        }
        cout << "\n";
    }

    return 0;
}
```
#pagebreak()