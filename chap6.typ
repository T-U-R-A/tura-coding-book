#import "@preview/cetz:0.3.4": canvas, draw
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

= Tree Algorithms

_This chapter covers tree algorithm problems from CSES. Trees are connected acyclic graphs with n nodes and n-1 edges. Key techniques include: *DFS/BFS traversal*, *Dynamic Programming on Trees*, *Binary Lifting* for ancestor queries, *LCA* (Lowest Common Ancestor), *Euler Tour* for subtree queries, and *Rerooting* technique._

\

== What is a Tree?

A *tree* is a special type of graph with unique properties that make it fundamental in computer science:

#figure(
  canvas({
    import draw: *

    content((4, 7), text(weight: "bold")[Tree vs Non-Tree Comparison])

    // Tree example (left)
    content((2, 6.2), text(fill: green, weight: "bold")[Valid Tree])

    circle((2, 5), radius: 0.3, fill: rgb("#90EE90"), stroke: 1pt)
    content((2, 5), [1])

    circle((1, 4), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((1, 4), [2])

    circle((3, 4), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((3, 4), [3])

    circle((0.5, 3), radius: 0.3, fill: rgb("#E8E8E8"), stroke: 1pt)
    content((0.5, 3), [4])

    circle((1.5, 3), radius: 0.3, fill: rgb("#E8E8E8"), stroke: 1pt)
    content((1.5, 3), [5])

    circle((3, 3), radius: 0.3, fill: rgb("#E8E8E8"), stroke: 1pt)
    content((3, 3), [6])

    // Tree edges
    line((2, 4.7), (1, 4.3), stroke: 1.5pt)
    line((2, 4.7), (3, 4.3), stroke: 1.5pt)
    line((1, 3.7), (0.5, 3.3), stroke: 1.5pt)
    line((1, 3.7), (1.5, 3.3), stroke: 1.5pt)
    line((3, 3.7), (3, 3.3), stroke: 1.5pt)

    content((2, 2.3), text(size: 9pt)[6 nodes, 5 edges])
    content((2, 1.9), text(size: 9pt)[Connected, No cycles])

    // Non-tree example (right) - has cycle
    content((6, 6.2), text(fill: red, weight: "bold")[Not a Tree (has cycle)])

    circle((6, 5), radius: 0.3, fill: rgb("#FFB6C1"), stroke: 1pt)
    content((6, 5), [1])

    circle((5, 4), radius: 0.3, fill: rgb("#FFB6C1"), stroke: 1pt)
    content((5, 4), [2])

    circle((7, 4), radius: 0.3, fill: rgb("#FFB6C1"), stroke: 1pt)
    content((7, 4), [3])

    circle((6, 3), radius: 0.3, fill: rgb("#FFB6C1"), stroke: 1pt)
    content((6, 3), [4])

    line((6, 4.7), (5, 4.3), stroke: 1.5pt)
    line((6, 4.7), (7, 4.3), stroke: 1.5pt)
    line((5, 3.7), (6, 3.3), stroke: 1.5pt)
    line((7, 3.7), (6, 3.3), stroke: 1.5pt)
    line((5, 4), (7, 4), stroke: (paint: red, thickness: 2pt, dash: "dashed"))

    content((6, 2.3), text(size: 9pt)[4 nodes, 5 edges])
    content((6, 1.9), text(size: 9pt, fill: red)[Cycle: 2-3-4-2])
  })
)

*Key Properties of Trees:*
- *n nodes, n-1 edges*: A tree with n nodes always has exactly n-1 edges
- *Connected*: There is a path between every pair of nodes
- *Acyclic*: No cycles exist - exactly one path between any two nodes
- *Rooted vs Unrooted*: We can designate any node as the "root" to give direction

\

*Tree Terminology:*

#figure(
  canvas({
    import draw: *

    content((4, 7.5), text(weight: "bold")[Tree Terminology])

    // Root
    circle((4, 6.5), radius: 0.35, fill: rgb("#FFD700"), stroke: 2pt)
    content((4, 6.5), text(weight: "bold")[1])
    content((5.8, 6.5), text(size: 9pt)[Root (no parent)])

    // Level 1
    circle((2.5, 5.2), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2.5, 5.2), [2])

    circle((5.5, 5.2), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((5.5, 5.2), [3])

    // Level 2
    circle((1.5, 3.9), radius: 0.35, fill: rgb("#90EE90"), stroke: 1pt)
    content((1.5, 3.9), [4])

    circle((3.5, 3.9), radius: 0.35, fill: rgb("#90EE90"), stroke: 1pt)
    content((3.5, 3.9), [5])

    circle((5.5, 3.9), radius: 0.35, fill: rgb("#90EE90"), stroke: 1pt)
    content((5.5, 3.9), [6])

    // Level 3 (leaves)
    circle((1, 2.6), radius: 0.35, fill: rgb("#E8E8E8"), stroke: 1pt)
    content((1, 2.6), [7])

    circle((2, 2.6), radius: 0.35, fill: rgb("#E8E8E8"), stroke: 1pt)
    content((2, 2.6), [8])

    // Edges
    line((4, 6.15), (2.5, 5.55), stroke: 1.5pt)
    line((4, 6.15), (5.5, 5.55), stroke: 1.5pt)
    line((2.5, 4.85), (1.5, 4.25), stroke: 1.5pt)
    line((2.5, 4.85), (3.5, 4.25), stroke: 1.5pt)
    line((5.5, 4.85), (5.5, 4.25), stroke: 1.5pt)
    line((1.5, 3.55), (1, 2.95), stroke: 1.5pt)
    line((1.5, 3.55), (2, 2.95), stroke: 1.5pt)

    // Annotations
    content((0, 5.2), text(size: 8pt, fill: blue)[Depth 1])
    content((0, 3.9), text(size: 8pt, fill: blue)[Depth 2])
    content((0, 2.6), text(size: 8pt, fill: blue)[Depth 3])

    content((7, 5.2), text(size: 8pt)[Children of 1])
    content((7, 3.9), text(size: 8pt)[7,8 are leaves])
    content((7, 2.6), text(size: 8pt)[(no children)])

    // Subtree highlight
    rect((0.4, 2.2), (2.6, 4.4), stroke: (paint: green, thickness: 1.5pt, dash: "dashed"))
    content((1.5, 1.8), text(size: 8pt, fill: green)[Subtree of node 4])
  })
)

- *Root*: The topmost node (node 1 in rooted trees)
- *Parent*: The node directly above (node 2's parent is node 1)
- *Children*: Nodes directly below (node 2's children are 4 and 5)
- *Leaf*: A node with no children (nodes 7, 8, 5, 6)
- *Subtree*: A node and all its descendants (subtree of 4 includes 4, 7, 8)
- *Depth*: Distance from root (root has depth 0)
- *Height*: Maximum depth of any node in the tree

\

*Common Tree Representations in Code:*

```cpp
// Adjacency List (most common for trees)
vector<vector<int>> adj(n + 1);  // adj[u] = list of neighbors of u

// For rooted trees, often store parent separately
vector<int> parent(n + 1);

// Reading a tree with n-1 edges
for (int i = 0; i < n - 1; i++) {
    int a, b;
    cin >> a >> b;
    adj[a].push_back(b);
    adj[b].push_back(a);  // undirected
}
```

#pagebreak()

== Subordinates

\
#link("https://cses.fi/problemset/task/1674")[Question - Subordinates]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1674")[Backup Link]

\
*Explanation* :

_Concepts used: *DFS*, *Subtree Size Calculation*_

Given a company with `n` employees where each employee (except the boss) has exactly one direct boss, we need to find the number of subordinates for each employee. The boss is employee 1.

This is essentially asking: for each node, how many nodes are in its subtree (excluding itself)?

Key Insight:
The number of subordinates of a node = (size of its subtree) - 1. We can compute subtree sizes using a single DFS traversal from the root.

#figure(
  canvas({
    import draw: *

    content((4, 7), text(weight: "bold")[Subordinates = Subtree Size - 1])

    // Draw tree
    circle((4, 5.8), radius: 0.4, fill: rgb("#FFD700"), stroke: 2pt)
    content((4, 5.8), text(weight: "bold")[1])
    content((5.2, 5.8), text(size: 9pt)[size=5])

    circle((2.5, 4.5), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2.5, 4.5), [2])
    content((1.3, 4.5), text(size: 9pt)[size=1])

    circle((5.5, 4.5), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((5.5, 4.5), [3])
    content((6.7, 4.5), text(size: 9pt)[size=3])

    circle((4.5, 3.2), radius: 0.35, fill: rgb("#90EE90"), stroke: 1pt)
    content((4.5, 3.2), [4])
    content((3.3, 3.2), text(size: 9pt)[size=1])

    circle((6.5, 3.2), radius: 0.35, fill: rgb("#90EE90"), stroke: 1pt)
    content((6.5, 3.2), [5])
    content((7.7, 3.2), text(size: 9pt)[size=1])

    // Edges
    line((4, 5.4), (2.5, 4.85), stroke: 1.5pt)
    line((4, 5.4), (5.5, 4.85), stroke: 1.5pt)
    line((5.5, 4.15), (4.5, 3.55), stroke: 1.5pt)
    line((5.5, 4.15), (6.5, 3.55), stroke: 1.5pt)

    // Results
    content((4, 2.2), text(weight: "bold")[Subordinates:])
    content((4, 1.7), [Node 1: 5-1 = *4* subordinates])
    content((4, 1.3), [Node 2: 1-1 = *0* subordinates])
    content((4, 0.9), [Node 3: 3-1 = *2* subordinates])
    content((4, 0.5), [Nodes 4,5: 1-1 = *0* subordinates])
  })
)

Algorithm:
1. Build the tree from parent information
2. Run DFS from root (node 1)
3. For each node, subtree size = 1 + sum of children's subtree sizes
4. Answer for each node = subtree_size - 1

DFS Traversal Order:
```
DFS(1):
  DFS(2): leaf, size[2] = 1
  DFS(3):
    DFS(4): leaf, size[4] = 1
    DFS(5): leaf, size[5] = 1
    size[3] = 1 + size[4] + size[5] = 3
  size[1] = 1 + size[2] + size[3] = 5
```

Time Complexity: O(n) - each node visited exactly once

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int n;
vector<vector<int>> children;
vector<int> subtree_size;

int dfs(int u) {
    subtree_size[u] = 1;  // Count self
    for (int child : children[u]) {
        subtree_size[u] += dfs(child);
    }
    return subtree_size[u];
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n;
    children.resize(n + 1);
    subtree_size.resize(n + 1);

    // Read parent of each employee (except boss)
    for (int i = 2; i <= n; i++) {
        int parent;
        cin >> parent;
        children[parent].push_back(i);
    }

    // DFS from root to compute subtree sizes
    dfs(1);

    // Output subordinates (subtree_size - 1)
    for (int i = 1; i <= n; i++) {
        cout << subtree_size[i] - 1;
        if (i < n) cout << " ";
    }
    cout << "\n";

    return 0;
}
```
#pagebreak()

== Tree Matching

\
#link("https://cses.fi/problemset/task/1130")[Question - Tree Matching]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1130")[Backup Link]

\
*Explanation* :

_Concepts used: *Tree DP* (Dynamic Programming on Trees)_

Given a tree with `n` nodes, find the maximum matching - the largest set of edges where no two edges share a common node. Each node can be part of at most one matched edge.

Key Insight - Tree DP:
For each node, we track two states:
- `dp[u][0]` = max matching in subtree of u, where u is *not* matched with any child
- `dp[u][1]` = max matching in subtree of u, where u *is* matched with one of its children

#figure(
  canvas({
    import draw: *

    content((4, 7.5), text(weight: "bold")[Tree Matching Example])

    // Draw tree
    circle((4, 6.3), radius: 0.35, fill: rgb("#FFD700"), stroke: 2pt)
    content((4, 6.3), text(weight: "bold")[1])

    circle((2, 5), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2, 5), [2])

    circle((6, 5), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((6, 5), [3])

    circle((1, 3.7), radius: 0.35, fill: rgb("#90EE90"), stroke: 1pt)
    content((1, 3.7), [4])

    circle((3, 3.7), radius: 0.35, fill: rgb("#90EE90"), stroke: 1pt)
    content((3, 3.7), [5])

    circle((5, 3.7), radius: 0.35, fill: rgb("#90EE90"), stroke: 1pt)
    content((5, 3.7), [6])

    circle((7, 3.7), radius: 0.35, fill: rgb("#90EE90"), stroke: 1pt)
    content((7, 3.7), [7])

    // Regular edges
    line((4, 5.95), (2, 5.35), stroke: 1pt)
    line((4, 5.95), (6, 5.35), stroke: 1pt)
    line((2, 4.65), (1, 4.05), stroke: 1pt)
    line((2, 4.65), (3, 4.05), stroke: 1pt)
    line((6, 4.65), (5, 4.05), stroke: 1pt)
    line((6, 4.65), (7, 4.05), stroke: 1pt)

    // Matched edges (highlighted)
    line((2, 4.65), (1, 4.05), stroke: (paint: red, thickness: 3pt))
    line((6, 4.65), (5, 4.05), stroke: (paint: red, thickness: 3pt))

    content((4, 2.7), text(fill: red, weight: "bold")[Maximum Matching = 2 edges])
    content((4, 2.2), text(size: 9pt)[Matched: (2,4) and (3,6)])
    content((4, 1.7), text(size: 9pt, fill: gray)[Could also be (2,5) and (3,7)])
  })
)

DP Transitions:

*Case 1: Node u is NOT matched (dp\[u\]\[0\])*
- All children can be in either state (matched or unmatched)
- Take the best option for each child
```
dp[u][0] = sum over children c of max(dp[c][0], dp[c][1])
```

*Case 2: Node u IS matched with one child (dp\[u\]\[1\])*
- Pick one child c to match with u (adds 1 edge)
- That child must be unmatched (dp\[c\]\[0\]) since we're using it
- Other children take their best state
```
dp[u][1] = max over children c of:
           (dp[c][0] + 1) + sum over other children c' of max(dp[c'][0], dp[c'][1])
```

This simplifies to:
```
dp[u][1] = dp[u][0] + max over children c of (dp[c][0] + 1 - max(dp[c][0], dp[c][1]))
```

#figure(
  canvas({
    import draw: *

    content((4, 6), text(weight: "bold")[DP State Visualization])

    // Node with states
    circle((2, 4.5), radius: 0.5, fill: rgb("#E8E8E8"), stroke: 1pt)
    content((2, 4.5), [u])

    // Children
    circle((1, 3), radius: 0.4, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((1, 3), [c1])
    circle((2, 3), radius: 0.4, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2, 3), [c2])
    circle((3, 3), radius: 0.4, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((3, 3), [c3])

    line((2, 4), (1, 3.4), stroke: 1pt)
    line((2, 4), (2, 3.4), stroke: 1pt)
    line((2, 4), (3, 3.4), stroke: 1pt)

    // Explanation
    content((6, 5), text(size: 9pt)[dp\[u\]\[0\]: u not matched])
    content((6, 4.5), text(size: 9pt)[= best(c1) + best(c2) + best(c3)])

    content((6, 3.5), text(size: 9pt)[dp\[u\]\[1\]: u matched with one child])
    content((6, 3), text(size: 9pt)[= pick best child to match,])
    content((6, 2.5), text(size: 9pt)[  others take their best])
  })
)

Time Complexity: O(n) - each node processed once

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int n;
vector<vector<int>> adj;
vector<array<int, 2>> dp;  // dp[u][0], dp[u][1]

void dfs(int u, int parent) {
    dp[u][0] = 0;  // u not matched
    dp[u][1] = 0;  // u matched with a child

    for (int v : adj[u]) {
        if (v == parent) continue;
        dfs(v, u);

        // For dp[u][0]: take best of each child
        dp[u][0] += max(dp[v][0], dp[v][1]);
    }

    // For dp[u][1]: try matching u with each child
    for (int v : adj[u]) {
        if (v == parent) continue;

        // Match u with v: gain 1 edge, v must be unmatched
        // Other children already counted in dp[u][0]
        int gain = dp[v][0] + 1 - max(dp[v][0], dp[v][1]);
        dp[u][1] = max(dp[u][1], dp[u][0] + gain);
    }
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n;
    adj.resize(n + 1);
    dp.resize(n + 1);

    for (int i = 0; i < n - 1; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back(b);
        adj[b].push_back(a);
    }

    dfs(1, 0);

    cout << max(dp[1][0], dp[1][1]) << "\n";

    return 0;
}
```
#pagebreak()
