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

== Tree Diameter

\
#link("https://cses.fi/problemset/task/1131")[Question - Tree Diameter]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1131")[Backup Link]

\
*Explanation* :

The diameter of a tree is the longest path between any two nodes. We need to find this maximum distance.

There are two classic approaches:

*Approach 1: Two BFS/DFS*
1. Start BFS/DFS from any node, find the farthest node `u`
2. Start BFS/DFS from `u`, find the farthest node `v`
3. The distance from `u` to `v` is the diameter

Why does this work? The farthest node from any node must be an endpoint of the diameter.

#figure(
  canvas({
    import draw: *

    content((4, 7), text(weight: "bold")[Two-BFS Approach for Diameter])

    // Draw tree
    circle((1, 5), radius: 0.3, fill: rgb("#90EE90"), stroke: 2pt)
    content((1, 5), [1])

    circle((2.5, 5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2.5, 5), [2])

    circle((4, 5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((4, 5), [3])

    circle((5.5, 5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((5.5, 5), [4])

    circle((7, 5), radius: 0.3, fill: rgb("#FFB6C1"), stroke: 2pt)
    content((7, 5), [5])

    circle((4, 3.7), radius: 0.3, fill: rgb("#E8E8E8"), stroke: 1pt)
    content((4, 3.7), [6])

    // Edges
    line((1.3, 5), (2.2, 5), stroke: 1.5pt)
    line((2.8, 5), (3.7, 5), stroke: 1.5pt)
    line((4.3, 5), (5.2, 5), stroke: 1.5pt)
    line((5.8, 5), (6.7, 5), stroke: 1.5pt)
    line((4, 4.7), (4, 4), stroke: 1.5pt)

    // Diameter path highlighted
    line((1.3, 5), (2.2, 5), stroke: (paint: red, thickness: 3pt))
    line((2.8, 5), (3.7, 5), stroke: (paint: red, thickness: 3pt))
    line((4.3, 5), (5.2, 5), stroke: (paint: red, thickness: 3pt))
    line((5.8, 5), (6.7, 5), stroke: (paint: red, thickness: 3pt))

    content((4, 2.8), text(size: 9pt)[Step 1: BFS from node 3, farthest = node 1 (or 5)])
    content((4, 2.3), text(size: 9pt)[Step 2: BFS from node 1, farthest = node 5])
    content((4, 1.8), text(fill: red, weight: "bold")[Diameter = 4 edges])
  })
)

*Approach 2: Tree DP (Single DFS)*

For each node, compute the two longest paths going down into its subtree. The diameter passing through this node = sum of these two paths.

- `depth[u]` = longest path from u going down
- At each node, combine the two longest child depths

#figure(
  canvas({
    import draw: *

    content((4, 7), text(weight: "bold")[Tree DP Approach])

    // Draw tree
    circle((4, 5.8), radius: 0.35, fill: rgb("#FFD700"), stroke: 2pt)
    content((4, 5.8), [1])
    content((5.2, 5.8), text(size: 8pt)[depth=3])

    circle((2, 4.5), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2, 4.5), [2])
    content((0.8, 4.5), text(size: 8pt)[depth=2])

    circle((6, 4.5), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((6, 4.5), [3])
    content((7.2, 4.5), text(size: 8pt)[depth=1])

    circle((1, 3.2), radius: 0.35, fill: rgb("#90EE90"), stroke: 1pt)
    content((1, 3.2), [4])
    content((-0.2, 3.2), text(size: 8pt)[depth=1])

    circle((3, 3.2), radius: 0.35, fill: rgb("#90EE90"), stroke: 1pt)
    content((3, 3.2), [5])
    content((4.2, 3.2), text(size: 8pt)[depth=0])

    circle((6, 3.2), radius: 0.35, fill: rgb("#90EE90"), stroke: 1pt)
    content((6, 3.2), [6])
    content((7.2, 3.2), text(size: 8pt)[depth=0])

    circle((1, 1.9), radius: 0.35, fill: rgb("#E8E8E8"), stroke: 1pt)
    content((1, 1.9), [7])

    // Edges
    line((4, 5.45), (2, 4.85), stroke: 1.5pt)
    line((4, 5.45), (6, 4.85), stroke: 1.5pt)
    line((2, 4.15), (1, 3.55), stroke: 1.5pt)
    line((2, 4.15), (3, 3.55), stroke: 1.5pt)
    line((6, 4.15), (6, 3.55), stroke: 1.5pt)
    line((1, 2.85), (1, 2.25), stroke: 1.5pt)

    // Diameter path
    line((1, 2.25), (1, 2.85), stroke: (paint: red, thickness: 2.5pt))
    line((1, 3.55), (2, 4.15), stroke: (paint: red, thickness: 2.5pt))
    line((2, 4.85), (4, 5.45), stroke: (paint: red, thickness: 2.5pt))
    line((4, 5.45), (6, 4.85), stroke: (paint: red, thickness: 2.5pt))
    line((6, 4.15), (6, 3.55), stroke: (paint: red, thickness: 2.5pt))

    content((4, 1.0), text(size: 9pt)[At node 1: two longest = 3 (via 2) and 2 (via 3)])
    content((4, 0.5), text(fill: red, weight: "bold")[Diameter = 3 + 2 = 5 edges])
  })
)

The DP approach is preferred as it only requires one DFS and naturally extends to finding the actual diameter path.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int n;
vector<vector<int>> adj;
int diameter = 0;

// Returns the longest path going down from u
int dfs(int u, int parent) {
    int max1 = 0, max2 = 0;  // Two longest paths down

    for (int v : adj[u]) {
        if (v == parent) continue;

        int depth = dfs(v, u) + 1;

        // Keep track of two largest depths
        if (depth > max1) {
            max2 = max1;
            max1 = depth;
        } else if (depth > max2) {
            max2 = depth;
        }
    }

    // Diameter through u = longest + second longest
    diameter = max(diameter, max1 + max2);

    return max1;  // Return longest path down
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n;
    adj.resize(n + 1);

    for (int i = 0; i < n - 1; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back(b);
        adj[b].push_back(a);
    }

    dfs(1, 0);

    cout << diameter << "\n";

    return 0;
}
```
#pagebreak()

== Tree Distances I

\
#link("https://cses.fi/problemset/task/1132")[Question - Tree Distances I]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1132")[Backup Link]

\
*Explanation* :

For each node, find the maximum distance to any other node in the tree. This requires the *rerooting technique* - we need information from both the subtree below AND the rest of the tree above.

Key Insight:
The farthest node from any node `u` is either:
1. In the subtree of `u` (going down), OR
2. Outside the subtree of `u` (going up through parent)

We compute both in two DFS passes:
- *DFS 1 (downward)*: For each node, compute the longest path going down into its subtree
- *DFS 2 (upward)*: For each node, compute the longest path going up through its parent

#figure(
  canvas({
    import draw: *

    content((4, 7.5), text(weight: "bold")[Rerooting: Down + Up Distances])

    // Draw tree
    circle((4, 6.2), radius: 0.35, fill: rgb("#FFD700"), stroke: 2pt)
    content((4, 6.2), [1])

    circle((2, 5), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2, 5), [2])

    circle((6, 5), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((6, 5), [3])

    circle((1, 3.7), radius: 0.35, fill: rgb("#90EE90"), stroke: 1pt)
    content((1, 3.7), [4])

    circle((3, 3.7), radius: 0.35, fill: rgb("#90EE90"), stroke: 1pt)
    content((3, 3.7), [5])

    // Edges
    line((4, 5.85), (2, 5.35), stroke: 1.5pt)
    line((4, 5.85), (6, 5.35), stroke: 1.5pt)
    line((2, 4.65), (1, 4.05), stroke: 1.5pt)
    line((2, 4.65), (3, 4.05), stroke: 1.5pt)

    // Annotations
    content((0, 6.2), text(size: 8pt, fill: blue)[down=2])
    content((0, 5), text(size: 8pt, fill: blue)[down=1])
    content((7.5, 5), text(size: 8pt, fill: blue)[down=0])
    content((0, 3.7), text(size: 8pt, fill: blue)[down=0])

    content((5.3, 6.6), text(size: 8pt, fill: red)[up=0])
    content((3.2, 5.4), text(size: 8pt, fill: red)[up=2])
    content((7, 5.4), text(size: 8pt, fill: red)[up=3])
    content((1.7, 3.3), text(size: 8pt, fill: red)[up=3])

    content((4, 2.5), text(size: 9pt)[For node 4: down=0, up=3])
    content((4, 2.0), text(size: 9pt)[Answer = max(0, 3) = *3*])
    content((4, 1.5), text(size: 9pt, fill: gray)[Farthest from 4 is node 3])
  })
)

*Computing "up" distance:*

For node `v` with parent `u`, the "up" path can go:
1. Up through grandparent: `up[u] + 1`
2. Down through a sibling: best path in another child of `u`, plus 2

To efficiently get the best sibling path, we track the two longest downward paths for each node.

#figure(
  canvas({
    import draw: *

    content((4, 5.5), text(weight: "bold")[Computing Up Distance for Node v])

    circle((4, 4.2), radius: 0.4, fill: rgb("#E8E8E8"), stroke: 1pt)
    content((4, 4.2), [u])

    circle((2, 3), radius: 0.35, fill: rgb("#FFB6C1"), stroke: 2pt)
    content((2, 3), [v])

    circle((4, 3), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((4, 3), [s1])

    circle((6, 3), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((6, 3), [s2])

    line((4, 3.8), (2, 3.35), stroke: 1.5pt)
    line((4, 3.8), (4, 3.35), stroke: 1.5pt)
    line((4, 3.8), (6, 3.35), stroke: 1.5pt)

    // Up arrow
    line((4, 4.6), (4, 5.1), stroke: (paint: red, thickness: 1.5pt), mark: (end: ">"))
    content((4.8, 4.85), text(size: 8pt, fill: red)[up\[u\]])

    content((4, 1.8), text(size: 9pt)[up\[v\] = 1 + max(up\[u\], best sibling path)])
    content((4, 1.3), text(size: 9pt)[If v has longest down path, use 2nd longest for sibling])
  })
)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int n;
vector<vector<int>> adj;
vector<int> down1, down2, up_dist;  // down1 = longest, down2 = second longest

// DFS 1: Compute downward distances
void dfs_down(int u, int parent) {
    down1[u] = down2[u] = 0;

    for (int v : adj[u]) {
        if (v == parent) continue;
        dfs_down(v, u);

        int d = down1[v] + 1;
        if (d > down1[u]) {
            down2[u] = down1[u];
            down1[u] = d;
        } else if (d > down2[u]) {
            down2[u] = d;
        }
    }
}

// DFS 2: Compute upward distances
void dfs_up(int u, int parent) {
    for (int v : adj[u]) {
        if (v == parent) continue;

        // If v contributes to down1[u], use down2[u] for sibling
        if (down1[v] + 1 == down1[u]) {
            up_dist[v] = max(up_dist[u], down2[u]) + 1;
        } else {
            up_dist[v] = max(up_dist[u], down1[u]) + 1;
        }

        dfs_up(v, u);
    }
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n;
    adj.resize(n + 1);
    down1.resize(n + 1);
    down2.resize(n + 1);
    up_dist.resize(n + 1, 0);

    for (int i = 0; i < n - 1; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back(b);
        adj[b].push_back(a);
    }

    dfs_down(1, 0);
    dfs_up(1, 0);

    for (int i = 1; i <= n; i++) {
        cout << max(down1[i], up_dist[i]);
        if (i < n) cout << " ";
    }
    cout << "\n";

    return 0;
}
```
#pagebreak()

== Tree Distances II

\
#link("https://cses.fi/problemset/task/1133")[Question - Tree Distances II]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1133")[Backup Link]

\
*Explanation* :

For each node, find the *sum* of distances to all other nodes. This is another classic rerooting problem.

Key Insight:
When we move from node `u` to its child `v`:
- All nodes in subtree of `v` get 1 closer (there are `subtree_size[v]` of them)
- All other nodes get 1 farther (there are `n - subtree_size[v]` of them)

So: `sum[v] = sum[u] - subtree_size[v] + (n - subtree_size[v])`
    `sum[v] = sum[u] + n - 2 * subtree_size[v]`

#figure(
  canvas({
    import draw: *

    content((4, 7), text(weight: "bold")[Rerooting: Sum of Distances])

    // Draw tree
    circle((4, 5.8), radius: 0.4, fill: rgb("#FFD700"), stroke: 2pt)
    content((4, 5.8), [u])

    circle((2.5, 4.5), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2.5, 4.5), [v])

    circle((5.5, 4.5), radius: 0.35, fill: rgb("#E8E8E8"), stroke: 1pt)
    content((5.5, 4.5), [..])

    // Subtree of v
    circle((1.5, 3.2), radius: 0.3, fill: rgb("#90EE90"), stroke: 1pt)
    circle((2.5, 3.2), radius: 0.3, fill: rgb("#90EE90"), stroke: 1pt)
    circle((3.5, 3.2), radius: 0.3, fill: rgb("#90EE90"), stroke: 1pt)

    line((4, 5.4), (2.5, 4.85), stroke: 1.5pt)
    line((4, 5.4), (5.5, 4.85), stroke: 1.5pt)
    line((2.5, 4.15), (1.5, 3.5), stroke: 1pt)
    line((2.5, 4.15), (2.5, 3.5), stroke: 1pt)
    line((2.5, 4.15), (3.5, 3.5), stroke: 1pt)

    // Annotations
    rect((1.0, 2.8), (4.0, 4.9), stroke: (paint: green, thickness: 1.5pt, dash: "dashed"))
    content((2.5, 2.4), text(size: 8pt, fill: green)[subtree\[v\] nodes get closer])

    content((5.5, 3.5), text(size: 8pt, fill: red)[rest get farther])

    content((4, 1.5), text(size: 9pt)[sum(v) = sum(u) + n - 2 \u{00D7} subtree(v)])
  })
)

Algorithm:
1. *DFS 1*: Compute subtree sizes and sum of distances from root (node 1)
2. *DFS 2*: Propagate to children using the rerooting formula

For the initial sum from root:
`sum[1] = sum of depths of all nodes from node 1`

#figure(
  canvas({
    import draw: *

    content((4, 6), text(weight: "bold")[Example: n=5])

    circle((4, 5), radius: 0.3, fill: rgb("#FFD700"), stroke: 2pt)
    content((4, 5), [1])

    circle((2.5, 4), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2.5, 4), [2])

    circle((5.5, 4), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((5.5, 4), [3])

    circle((2, 3), radius: 0.3, fill: rgb("#90EE90"), stroke: 1pt)
    content((2, 3), [4])

    circle((3, 3), radius: 0.3, fill: rgb("#90EE90"), stroke: 1pt)
    content((3, 3), [5])

    line((4, 4.7), (2.5, 4.3), stroke: 1pt)
    line((4, 4.7), (5.5, 4.3), stroke: 1pt)
    line((2.5, 3.7), (2, 3.3), stroke: 1pt)
    line((2.5, 3.7), (3, 3.3), stroke: 1pt)

    content((7, 5), text(size: 8pt)[sum\[1\]=0+1+1+2+2=6])
    content((7, 4.5), text(size: 8pt)[subtree\[2\]=3])
    content((7, 4), text(size: 8pt)[sum\[2\]=6+5-6=5])
    content((7, 3.5), text(size: 8pt)[subtree\[3\]=1])
    content((7, 3), text(size: 8pt)[sum\[3\]=6+5-2=9])
  })
)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;

int n;
vector<vector<int>> adj;
vector<int> subtree_size;
vector<ll> dist_sum;

// DFS 1: Compute subtree sizes and initial distances from node 1
void dfs1(int u, int parent, int depth) {
    subtree_size[u] = 1;
    dist_sum[1] += depth;  // Add this node's distance to root

    for (int v : adj[u]) {
        if (v == parent) continue;
        dfs1(v, u, depth + 1);
        subtree_size[u] += subtree_size[v];
    }
}

// DFS 2: Reroot to compute sum for all nodes
void dfs2(int u, int parent) {
    for (int v : adj[u]) {
        if (v == parent) continue;

        // Moving from u to v:
        // subtree[v] nodes get closer, (n - subtree[v]) get farther
        dist_sum[v] = dist_sum[u] + n - 2 * subtree_size[v];

        dfs2(v, u);
    }
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n;
    adj.resize(n + 1);
    subtree_size.resize(n + 1);
    dist_sum.resize(n + 1, 0);

    for (int i = 0; i < n - 1; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back(b);
        adj[b].push_back(a);
    }

    dfs1(1, 0, 0);
    dfs2(1, 0);

    for (int i = 1; i <= n; i++) {
        cout << dist_sum[i];
        if (i < n) cout << " ";
    }
    cout << "\n";

    return 0;
}
```
#pagebreak()

== Company Queries I

\
#link("https://cses.fi/problemset/task/1687")[Question - Company Queries I]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1687")[Backup Link]

\
*Explanation* :

Given a company hierarchy (a rooted tree), answer queries: "Who is the k-th ancestor of employee x?"

This is the classic *Binary Lifting* problem. Naive approach (climbing k steps) is O(k) per query - too slow for large k.

Binary Lifting Idea:
Precompute `up[x][j]` = the $2^j$-th ancestor of node x. Any k can be expressed as sum of powers of 2, so we can jump in O(log k) steps.

#figure(
  canvas({
    import draw: *

    content((4, 7.5), text(weight: "bold")[Binary Lifting: Jumping in Powers of 2])

    // Tree visualization
    circle((4, 6.3), radius: 0.3, fill: rgb("#FFD700"), stroke: 2pt)
    content((4, 6.3), [1])

    circle((2.5, 5.3), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2.5, 5.3), [2])

    circle((5.5, 5.3), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((5.5, 5.3), [3])

    circle((1.5, 4.3), radius: 0.3, fill: rgb("#90EE90"), stroke: 1pt)
    content((1.5, 4.3), [4])

    circle((3.5, 4.3), radius: 0.3, fill: rgb("#90EE90"), stroke: 1pt)
    content((3.5, 4.3), [5])

    circle((1, 3.3), radius: 0.3, fill: rgb("#E8E8E8"), stroke: 1pt)
    content((1, 3.3), [6])

    circle((2, 3.3), radius: 0.3, fill: rgb("#E8E8E8"), stroke: 1pt)
    content((2, 3.3), [7])

    circle((1.5, 2.3), radius: 0.3, fill: rgb("#FFB6C1"), stroke: 2pt)
    content((1.5, 2.3), [8])

    // Edges
    line((4, 6), (2.5, 5.6), stroke: 1pt)
    line((4, 6), (5.5, 5.6), stroke: 1pt)
    line((2.5, 5), (1.5, 4.6), stroke: 1pt)
    line((2.5, 5), (3.5, 4.6), stroke: 1pt)
    line((1.5, 4), (1, 3.6), stroke: 1pt)
    line((1.5, 4), (2, 3.6), stroke: 1pt)
    line((1, 3), (1.5, 2.6), stroke: 1pt)

    // Binary lifting jumps
    line((1.8, 2.3), (2.3, 3.0), stroke: (paint: red, thickness: 2pt), mark: (end: ">"))
    content((2.6, 2.6), text(size: 7pt, fill: red)[$2^0$])

    line((1.8, 2.5), (1.8, 4.0), stroke: (paint: blue, thickness: 2pt), mark: (end: ">"))
    content((2.3, 3.3), text(size: 7pt, fill: blue)[$2^1$])

    line((1.5, 2.6), (2.2, 5.0), stroke: (paint: green, thickness: 2pt), mark: (end: ">"))
    content((2.5, 4.0), text(size: 7pt, fill: green)[$2^2$])

    // Table
    content((6, 4.5), text(size: 8pt, weight: "bold")[up table for node 8:])
    content((6, 4.0), text(size: 8pt)[up\[8\]\[0\] = 6 ($2^0$ = 1st)])
    content((6, 3.5), text(size: 8pt)[up\[8\]\[1\] = 4 ($2^1$ = 2nd)])
    content((6, 3.0), text(size: 8pt)[up\[8\]\[2\] = 2 ($2^2$ = 4th)])
    content((6, 2.5), text(size: 8pt)[up\[8\]\[3\] = 1 ($2^3$ = 8th)])

    content((4, 1.3), text(size: 9pt)[Query: 5th ancestor of 8?])
    content((4, 0.8), text(size: 9pt)[5 = 4 + 1 = $2^2$ + $2^0$, jump to 2, then to 1])
  })
)

Recurrence:
```
up[x][0] = parent[x]
up[x][j] = up[up[x][j-1]][j-1]  (jump 2^(j-1), then another 2^(j-1))
```

Query for k-th ancestor:
For each set bit in k, make the corresponding jump.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

const int MAXLOG = 20;  // log2(200000) < 18

int n, q;
vector<vector<int>> up;  // up[x][j] = 2^j-th ancestor of x

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> q;
    up.assign(n + 1, vector<int>(MAXLOG, 0));

    // Read parents and set up[x][0]
    for (int i = 2; i <= n; i++) {
        cin >> up[i][0];
    }
    up[1][0] = 0;  // Root has no parent

    // Build sparse table
    for (int j = 1; j < MAXLOG; j++) {
        for (int i = 1; i <= n; i++) {
            if (up[i][j - 1] != 0) {
                up[i][j] = up[up[i][j - 1]][j - 1];
            }
        }
    }

    // Answer queries
    while (q--) {
        int x, k;
        cin >> x >> k;

        // Jump using binary representation of k
        for (int j = 0; j < MAXLOG && x != 0; j++) {
            if (k & (1 << j)) {
                x = up[x][j];
            }
        }

        cout << (x == 0 ? -1 : x) << "\n";
    }

    return 0;
}
```
#pagebreak()

== Company Queries II

\
#link("https://cses.fi/problemset/task/1688")[Question - Company Queries II]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1688")[Backup Link]

\
*Explanation* :

Given a company hierarchy, answer queries: "Who is the lowest common ancestor (LCA) of employees a and b?"

The LCA of two nodes is their deepest common ancestor - the node farthest from the root that is an ancestor of both.

LCA Algorithm using Binary Lifting:
1. Bring both nodes to the same depth (lift the deeper one)
2. Binary search for the LCA by lifting both nodes together

#figure(
  canvas({
    import draw: *

    content((4, 7.5), text(weight: "bold")[Finding LCA of nodes 7 and 5])

    // Tree
    circle((4, 6.5), radius: 0.3, fill: rgb("#FFD700"), stroke: 2pt)
    content((4, 6.5), [1])

    circle((2.5, 5.5), radius: 0.3, fill: rgb("#90EE90"), stroke: 2pt)
    content((2.5, 5.5), [2])

    circle((5.5, 5.5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((5.5, 5.5), [3])

    circle((1.5, 4.5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((1.5, 4.5), [4])

    circle((3.5, 4.5), radius: 0.3, fill: rgb("#FFB6C1"), stroke: 2pt)
    content((3.5, 4.5), [5])

    circle((1, 3.5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((1, 3.5), [6])

    circle((2, 3.5), radius: 0.3, fill: rgb("#FFB6C1"), stroke: 2pt)
    content((2, 3.5), [7])

    // Edges
    line((4, 6.2), (2.5, 5.8), stroke: 1pt)
    line((4, 6.2), (5.5, 5.8), stroke: 1pt)
    line((2.5, 5.2), (1.5, 4.8), stroke: 1pt)
    line((2.5, 5.2), (3.5, 4.8), stroke: 1pt)
    line((1.5, 4.2), (1, 3.8), stroke: 1pt)
    line((1.5, 4.2), (2, 3.8), stroke: 1pt)

    // Depth annotations
    content((6.5, 6.5), text(size: 8pt)[depth 0])
    content((6.5, 5.5), text(size: 8pt)[depth 1])
    content((6.5, 4.5), text(size: 8pt)[depth 2])
    content((6.5, 3.5), text(size: 8pt)[depth 3])

    // Steps
    content((4, 2.5), text(size: 9pt)[Step 1: depth\[7\]=3, depth\[5\]=2. Lift 7 to depth 2])
    content((4, 2.0), text(size: 9pt)[Now at nodes 4 and 5])
    content((4, 1.5), text(size: 9pt)[Step 2: Lift both until they meet at LCA])
    content((4, 1.0), text(fill: green, weight: "bold")[LCA(7, 5) = 2])
  })
)

Algorithm Details:
```
1. If depth[a] > depth[b], swap them
2. Lift b up by (depth[b] - depth[a]) steps
3. If a == b, return a (one is ancestor of other)
4. For j from MAXLOG-1 to 0:
     If up[a][j] != up[b][j], lift both
5. Return up[a][0] (parent of where they met)
```

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

const int MAXLOG = 20;

int n, q;
vector<vector<int>> up;
vector<int> depth;
vector<vector<int>> children;

void dfs(int u, int d) {
    depth[u] = d;
    for (int v : children[u]) {
        dfs(v, d + 1);
    }
}

int lca(int a, int b) {
    // Make sure a is shallower (or equal depth)
    if (depth[a] > depth[b]) swap(a, b);

    // Lift b to same depth as a
    int diff = depth[b] - depth[a];
    for (int j = 0; j < MAXLOG; j++) {
        if (diff & (1 << j)) {
            b = up[b][j];
        }
    }

    if (a == b) return a;

    // Binary search for LCA
    for (int j = MAXLOG - 1; j >= 0; j--) {
        if (up[a][j] != up[b][j]) {
            a = up[a][j];
            b = up[b][j];
        }
    }

    return up[a][0];
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> q;
    up.assign(n + 1, vector<int>(MAXLOG, 0));
    depth.resize(n + 1);
    children.resize(n + 1);

    for (int i = 2; i <= n; i++) {
        cin >> up[i][0];
        children[up[i][0]].push_back(i);
    }

    // Compute depths
    dfs(1, 0);

    // Build binary lifting table
    for (int j = 1; j < MAXLOG; j++) {
        for (int i = 1; i <= n; i++) {
            if (up[i][j - 1] != 0) {
                up[i][j] = up[up[i][j - 1]][j - 1];
            }
        }
    }

    while (q--) {
        int a, b;
        cin >> a >> b;
        cout << lca(a, b) << "\n";
    }

    return 0;
}
```
#pagebreak()

== Distance Queries

\
#link("https://cses.fi/problemset/task/1135")[Question - Distance Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1135")[Backup Link]

\
*Explanation* :

Given a tree, answer queries: "What is the distance between nodes a and b?"

Key Formula using LCA:
```
dist(a, b) = depth[a] + depth[b] - 2 * depth[LCA(a, b)]
```

#figure(
  canvas({
    import draw: *

    content((4, 7), text(weight: "bold")[Distance via LCA])

    // Tree
    circle((4, 5.8), radius: 0.3, fill: rgb("#90EE90"), stroke: 2pt)
    content((4, 5.8), [L])
    content((4.8, 5.8), text(size: 8pt)[LCA])

    circle((2.5, 4.5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2.5, 4.5), [.])

    circle((5.5, 4.5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((5.5, 4.5), [.])

    circle((1.5, 3.2), radius: 0.3, fill: rgb("#FFB6C1"), stroke: 2pt)
    content((1.5, 3.2), [a])

    circle((6.5, 3.2), radius: 0.3, fill: rgb("#FFB6C1"), stroke: 2pt)
    content((6.5, 3.2), [b])

    // Edges
    line((4, 5.5), (2.5, 4.8), stroke: 1.5pt)
    line((4, 5.5), (5.5, 4.8), stroke: 1.5pt)
    line((2.5, 4.2), (1.5, 3.5), stroke: 1.5pt)
    line((5.5, 4.2), (6.5, 3.5), stroke: 1.5pt)

    // Path highlighting
    line((1.5, 3.5), (2.5, 4.2), stroke: (paint: red, thickness: 2pt))
    line((2.5, 4.8), (4, 5.5), stroke: (paint: red, thickness: 2pt))
    line((4, 5.5), (5.5, 4.8), stroke: (paint: red, thickness: 2pt))
    line((5.5, 4.2), (6.5, 3.5), stroke: (paint: red, thickness: 2pt))

    // Formula explanation
    content((4, 2.2), text(size: 9pt)[Path from a to b goes through LCA])
    content((4, 1.7), text(size: 9pt)[dist = (depth\[a\] - depth\[L\]) + (depth\[b\] - depth\[L\])])
    content((4, 1.2), text(size: 9pt)[    = depth\[a\] + depth\[b\] - 2 \u{00D7} depth\[L\]])
  })
)

This is a direct application of LCA from Company Queries II combined with depth computation.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

const int MAXLOG = 20;

int n, q;
vector<vector<int>> adj, up;
vector<int> depth;

void dfs(int u, int parent, int d) {
    depth[u] = d;
    up[u][0] = parent;
    for (int v : adj[u]) {
        if (v != parent) {
            dfs(v, u, d + 1);
        }
    }
}

int lca(int a, int b) {
    if (depth[a] > depth[b]) swap(a, b);

    int diff = depth[b] - depth[a];
    for (int j = 0; j < MAXLOG; j++) {
        if (diff & (1 << j)) {
            b = up[b][j];
        }
    }

    if (a == b) return a;

    for (int j = MAXLOG - 1; j >= 0; j--) {
        if (up[a][j] != up[b][j]) {
            a = up[a][j];
            b = up[b][j];
        }
    }

    return up[a][0];
}

int dist(int a, int b) {
    return depth[a] + depth[b] - 2 * depth[lca(a, b)];
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> q;
    adj.resize(n + 1);
    up.assign(n + 1, vector<int>(MAXLOG, 0));
    depth.resize(n + 1);

    for (int i = 0; i < n - 1; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back(b);
        adj[b].push_back(a);
    }

    dfs(1, 0, 0);

    // Build binary lifting table
    for (int j = 1; j < MAXLOG; j++) {
        for (int i = 1; i <= n; i++) {
            if (up[i][j - 1] != 0) {
                up[i][j] = up[up[i][j - 1]][j - 1];
            }
        }
    }

    while (q--) {
        int a, b;
        cin >> a >> b;
        cout << dist(a, b) << "\n";
    }

    return 0;
}
```
#pagebreak()

== Counting Paths

\
#link("https://cses.fi/problemset/task/1136")[Question - Counting Paths]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1136")[Backup Link]

\
*Explanation* :

Given m paths in a tree (each path from a to b), count how many paths pass through each node.

Key Technique: *Difference Array on Tree*

For each path (a, b) with LCA L:
- Add +1 at node a
- Add +1 at node b
- Subtract -1 at L
- Subtract -1 at parent of L

After processing all paths, do a DFS to compute prefix sums from leaves to root.

#figure(
  canvas({
    import draw: *

    content((4, 7), text(weight: "bold")[Difference Array on Tree Path])

    // Tree
    circle((4, 5.8), radius: 0.35, fill: rgb("#90EE90"), stroke: 2pt)
    content((4, 5.8), [L])

    circle((2.5, 4.5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2.5, 4.5), [x])

    circle((5.5, 4.5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((5.5, 4.5), [y])

    circle((1.5, 3.2), radius: 0.3, fill: rgb("#FFB6C1"), stroke: 2pt)
    content((1.5, 3.2), [a])

    circle((6.5, 3.2), radius: 0.3, fill: rgb("#FFB6C1"), stroke: 2pt)
    content((6.5, 3.2), [b])

    circle((4, 7), radius: 0.3, fill: rgb("#E8E8E8"), stroke: 1pt)
    content((4, 7), [P])

    // Edges
    line((4, 6.7), (4, 6.15), stroke: 1pt)
    line((4, 5.45), (2.5, 4.85), stroke: 1.5pt)
    line((4, 5.45), (5.5, 4.85), stroke: 1.5pt)
    line((2.5, 4.2), (1.5, 3.55), stroke: 1.5pt)
    line((5.5, 4.2), (6.5, 3.55), stroke: 1.5pt)

    // Annotations
    content((0.5, 3.2), text(size: 8pt, fill: green)[+1])
    content((7.5, 3.2), text(size: 8pt, fill: green)[+1])
    content((5, 5.8), text(size: 8pt, fill: red)[-1])
    content((5, 7), text(size: 8pt, fill: red)[-1])

    content((4, 2.0), text(size: 9pt)[After DFS sum: each node on path has count 1])
    content((4, 1.5), text(size: 9pt)[Nodes outside path have count 0])
  })
)

Why This Works:
When we sum from leaves upward:
- Node a gets +1 (it's on the path)
- Each ancestor of a up to L accumulates the +1
- At L, we subtract 1, so the sum stops propagating above L
- Same for the b side

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

const int MAXLOG = 20;

int n, m;
vector<vector<int>> adj, up;
vector<int> depth, diff, result;

void dfs_depth(int u, int parent, int d) {
    depth[u] = d;
    up[u][0] = parent;
    for (int v : adj[u]) {
        if (v != parent) dfs_depth(v, u, d + 1);
    }
}

int lca(int a, int b) {
    if (depth[a] > depth[b]) swap(a, b);
    int d = depth[b] - depth[a];
    for (int j = 0; j < MAXLOG; j++)
        if (d & (1 << j)) b = up[b][j];
    if (a == b) return a;
    for (int j = MAXLOG - 1; j >= 0; j--)
        if (up[a][j] != up[b][j]) { a = up[a][j]; b = up[b][j]; }
    return up[a][0];
}

// DFS to compute subtree sums
void dfs_sum(int u, int parent) {
    result[u] = diff[u];
    for (int v : adj[u]) {
        if (v != parent) {
            dfs_sum(v, u);
            result[u] += result[v];
        }
    }
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> m;
    adj.resize(n + 1);
    up.assign(n + 1, vector<int>(MAXLOG, 0));
    depth.resize(n + 1);
    diff.resize(n + 1, 0);
    result.resize(n + 1, 0);

    for (int i = 0; i < n - 1; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back(b);
        adj[b].push_back(a);
    }

    dfs_depth(1, 0, 0);

    for (int j = 1; j < MAXLOG; j++)
        for (int i = 1; i <= n; i++)
            if (up[i][j - 1]) up[i][j] = up[up[i][j - 1]][j - 1];

    // Process each path
    for (int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        int l = lca(a, b);

        diff[a]++;
        diff[b]++;
        diff[l]--;
        if (up[l][0] != 0) diff[up[l][0]]--;
    }

    dfs_sum(1, 0);

    for (int i = 1; i <= n; i++) {
        cout << result[i];
        if (i < n) cout << " ";
    }
    cout << "\n";

    return 0;
}
```
#pagebreak()

== Subtree Queries

\
#link("https://cses.fi/problemset/task/1137")[Question - Subtree Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1137")[Backup Link]

\
*Explanation* :

Given a rooted tree with values on nodes, handle two types of queries:
1. Update the value of node s to x
2. Calculate the sum of values in the subtree of node s

Key Technique: *Euler Tour (Flattening the Tree)*

By doing a DFS and recording entry/exit times, we can map each subtree to a contiguous range in an array. Then use a Fenwick Tree or Segment Tree for range sum queries.

#figure(
  canvas({
    import draw: *

    content((4, 7.5), text(weight: "bold")[Euler Tour: Flattening Subtrees])

    // Tree
    circle((4, 6.3), radius: 0.35, fill: rgb("#FFD700"), stroke: 2pt)
    content((4, 6.3), [1])

    circle((2.5, 5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2.5, 5), [2])

    circle((5.5, 5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((5.5, 5), [3])

    circle((1.5, 3.7), radius: 0.3, fill: rgb("#90EE90"), stroke: 1pt)
    content((1.5, 3.7), [4])

    circle((3.5, 3.7), radius: 0.3, fill: rgb("#90EE90"), stroke: 1pt)
    content((3.5, 3.7), [5])

    // Edges
    line((4, 5.95), (2.5, 5.35), stroke: 1pt)
    line((4, 5.95), (5.5, 5.35), stroke: 1pt)
    line((2.5, 4.7), (1.5, 4.05), stroke: 1pt)
    line((2.5, 4.7), (3.5, 4.05), stroke: 1pt)

    // DFS order annotations
    content((4.7, 6.3), text(size: 7pt, fill: blue)[in=1])
    content((1.8, 5), text(size: 7pt, fill: blue)[in=2])
    content((6.2, 5), text(size: 7pt, fill: blue)[in=5])
    content((0.8, 3.7), text(size: 7pt, fill: blue)[in=3])
    content((4.2, 3.7), text(size: 7pt, fill: blue)[in=4])

    // Flattened array
    content((4, 2.5), text(weight: "bold")[Flattened Array (DFS order):])

    for (i, node) in ((0, 1), (1, 2), (2, 4), (3, 5), (4, 3)) {
      rect((1.2 + i * 1.0, 1.5), (2.0 + i * 1.0, 2.1), stroke: 1pt, fill: rgb("#E8F4FD"))
      content((1.6 + i * 1.0, 1.8), text(size: 9pt)[#node])
    }

    // Subtree range
    rect((2.2, 1.4), (5.0, 2.2), stroke: (paint: red, thickness: 2pt, dash: "dashed"))
    content((3.6, 1.0), text(size: 8pt, fill: red)[Subtree of 2: indices 2-4])
  })
)

For each node u:
- `tin[u]` = entry time (index in flattened array)
- `tout[u]` = exit time (last index in subtree)
- Subtree of u = range `[tin[u], tout[u]]`

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;

int n, q, timer = 0;
vector<vector<int>> children;
vector<int> tin, tout;
vector<ll> val, fenw;

void dfs(int u) {
    tin[u] = ++timer;
    for (int v : children[u]) dfs(v);
    tout[u] = timer;
}

void update(int i, ll delta) {
    for (; i <= n; i += i & (-i))
        fenw[i] += delta;
}

ll query(int i) {
    ll sum = 0;
    for (; i > 0; i -= i & (-i))
        sum += fenw[i];
    return sum;
}

ll range_query(int l, int r) {
    return query(r) - query(l - 1);
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> q;
    children.resize(n + 1);
    tin.resize(n + 1);
    tout.resize(n + 1);
    val.resize(n + 1);
    fenw.resize(n + 1, 0);

    for (int i = 1; i <= n; i++) cin >> val[i];

    for (int i = 2; i <= n; i++) {
        int p;
        cin >> p;
        children[p].push_back(i);
    }

    dfs(1);

    // Initialize Fenwick tree with values in DFS order
    for (int i = 1; i <= n; i++) {
        update(tin[i], val[i]);
    }

    while (q--) {
        int type;
        cin >> type;

        if (type == 1) {
            int s;
            ll x;
            cin >> s >> x;
            update(tin[s], x - val[s]);
            val[s] = x;
        } else {
            int s;
            cin >> s;
            cout << range_query(tin[s], tout[s]) << "\n";
        }
    }

    return 0;
}
```
#pagebreak()

== Path Queries

\
#link("https://cses.fi/problemset/task/1138")[Question - Path Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1138")[Backup Link]

\
*Explanation* :

Given a rooted tree with values on nodes, handle:
1. Update value of node s to x
2. Calculate sum of values on path from root to node s

Key Insight: Use Euler Tour with +/- contributions.

When entering a node during DFS, add its value (+val).
When leaving, subtract its value (-val).
The prefix sum at any entry time gives the path sum from root!

#figure(
  canvas({
    import draw: *

    content((4, 7), text(weight: "bold")[Path Query using Euler Tour])

    // Tree
    circle((4, 5.8), radius: 0.35, fill: rgb("#FFD700"), stroke: 2pt)
    content((4, 5.8), [1])
    content((4.7, 5.8), text(size: 7pt)[v=2])

    circle((2.5, 4.5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2.5, 4.5), [2])
    content((3.2, 4.5), text(size: 7pt)[v=3])

    circle((5.5, 4.5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((5.5, 4.5), [3])
    content((6.2, 4.5), text(size: 7pt)[v=5])

    circle((2.5, 3.2), radius: 0.3, fill: rgb("#90EE90"), stroke: 1pt)
    content((2.5, 3.2), [4])
    content((3.2, 3.2), text(size: 7pt)[v=4])

    // Edges
    line((4, 5.45), (2.5, 4.85), stroke: 1pt)
    line((4, 5.45), (5.5, 4.85), stroke: 1pt)
    line((2.5, 4.2), (2.5, 3.55), stroke: 1pt)

    // Euler tour representation
    content((4, 2.3), text(size: 8pt)[Euler array: +2, +3, +4, -4, -3, +5, -5, -2])
    content((4, 1.8), text(size: 8pt)[Prefix at node 4's entry: 2+3+4 = 9])
    content((4, 1.3), text(size: 8pt, fill: green)[Path sum 1->2->4 = 9])
  })
)

For update at node s: update both +val position and -val position.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;

int n, q, timer = 0;
vector<vector<int>> children;
vector<int> tin, tout;
vector<ll> val, fenw;

void dfs(int u) {
    tin[u] = ++timer;
    for (int v : children[u]) dfs(v);
    tout[u] = ++timer;
}

void update(int i, ll delta) {
    for (; i <= 2 * n; i += i & (-i))
        fenw[i] += delta;
}

ll query(int i) {
    ll sum = 0;
    for (; i > 0; i -= i & (-i))
        sum += fenw[i];
    return sum;
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> q;
    children.resize(n + 1);
    tin.resize(n + 1);
    tout.resize(n + 1);
    val.resize(n + 1);
    fenw.resize(2 * n + 2, 0);

    for (int i = 1; i <= n; i++) cin >> val[i];

    for (int i = 2; i <= n; i++) {
        int p;
        cin >> p;
        children[p].push_back(i);
    }

    dfs(1);

    // Initialize: +val at entry, -val at exit
    for (int i = 1; i <= n; i++) {
        update(tin[i], val[i]);
        update(tout[i], -val[i]);
    }

    while (q--) {
        int type;
        cin >> type;

        if (type == 1) {
            int s;
            ll x;
            cin >> s >> x;
            ll diff = x - val[s];
            update(tin[s], diff);
            update(tout[s], -diff);
            val[s] = x;
        } else {
            int s;
            cin >> s;
            cout << query(tin[s]) << "\n";
        }
    }

    return 0;
}
```
#pagebreak()

== Path Queries II

\
#link("https://cses.fi/problemset/task/2134")[Question - Path Queries II]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/2134")[Backup Link]

\
*Explanation* :

Given a tree with node values, handle:
1. Update value of node s to x
2. Find maximum value on path from a to b

This requires *Heavy-Light Decomposition (HLD)* - a technique that decomposes the tree into chains so that any path crosses at most O(log n) chains.

Key Ideas of HLD:
- Decompose tree into "heavy" and "light" edges
- Heavy edge: goes to child with largest subtree
- Each root-to-leaf path has at most O(log n) light edges
- Nodes in each heavy chain get consecutive positions in a segment tree

#figure(
  canvas({
    import draw: *

    content((4, 7.5), text(weight: "bold")[Heavy-Light Decomposition])

    // Tree with heavy edges marked
    circle((4, 6.3), radius: 0.35, fill: rgb("#FFD700"), stroke: 2pt)
    content((4, 6.3), [1])

    circle((2.5, 5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2.5, 5), [2])

    circle((5.5, 5), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((5.5, 5), [3])

    circle((2.5, 3.7), radius: 0.3, fill: rgb("#90EE90"), stroke: 1pt)
    content((2.5, 3.7), [4])

    circle((5.5, 3.7), radius: 0.3, fill: rgb("#90EE90"), stroke: 1pt)
    content((5.5, 3.7), [5])

    circle((2.5, 2.4), radius: 0.3, fill: rgb("#E8E8E8"), stroke: 1pt)
    content((2.5, 2.4), [6])

    // Heavy edges (thick)
    line((4, 5.95), (2.5, 5.35), stroke: (paint: red, thickness: 3pt))
    line((2.5, 4.7), (2.5, 4.05), stroke: (paint: red, thickness: 3pt))
    line((2.5, 3.4), (2.5, 2.75), stroke: (paint: red, thickness: 3pt))

    // Light edges (thin)
    line((4, 5.95), (5.5, 5.35), stroke: 1pt)
    line((5.5, 4.7), (5.5, 4.05), stroke: 1pt)

    content((7, 5), text(size: 8pt, fill: red)[Heavy chain])
    content((7, 4.5), text(size: 8pt, fill: red)[1-2-4-6])

    content((4, 1.5), text(size: 8pt)[Path query: traverse O(log n) chains])
    content((4, 1.0), text(size: 8pt)[Each chain query: O(log n) with segment tree])
  })
)

For path max(a,b): repeatedly move the node with deeper chain head upward, querying segment tree for each chain segment, until both nodes are on the same chain.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int n, q;
vector<vector<int>> adj;
vector<int> parent, depth, heavy, head, pos, val;
vector<int> tree;  // Segment tree for max
int cur_pos = 0;

int dfs(int u) {
    int size = 1, max_c_size = 0;
    for (int v : adj[u]) {
        if (v != parent[u]) {
            parent[v] = u;
            depth[v] = depth[u] + 1;
            int c_size = dfs(v);
            size += c_size;
            if (c_size > max_c_size) {
                max_c_size = c_size;
                heavy[u] = v;
            }
        }
    }
    return size;
}

void decompose(int u, int h) {
    head[u] = h;
    pos[u] = cur_pos++;

    if (heavy[u] != -1)
        decompose(heavy[u], h);

    for (int v : adj[u]) {
        if (v != parent[u] && v != heavy[u])
            decompose(v, v);
    }
}

void update(int p, int v) {
    for (tree[p += n] = v; p > 1; p >>= 1)
        tree[p >> 1] = max(tree[p], tree[p ^ 1]);
}

int query(int l, int r) {
    int res = 0;
    for (l += n, r += n + 1; l < r; l >>= 1, r >>= 1) {
        if (l & 1) res = max(res, tree[l++]);
        if (r & 1) res = max(res, tree[--r]);
    }
    return res;
}

int path_max(int a, int b) {
    int res = 0;
    while (head[a] != head[b]) {
        if (depth[head[a]] < depth[head[b]]) swap(a, b);
        res = max(res, query(pos[head[a]], pos[a]));
        a = parent[head[a]];
    }
    if (depth[a] > depth[b]) swap(a, b);
    res = max(res, query(pos[a], pos[b]));
    return res;
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> q;
    adj.resize(n + 1);
    parent.resize(n + 1);
    depth.resize(n + 1);
    heavy.resize(n + 1, -1);
    head.resize(n + 1);
    pos.resize(n + 1);
    val.resize(n + 1);
    tree.resize(2 * n);

    for (int i = 1; i <= n; i++) cin >> val[i];

    for (int i = 0; i < n - 1; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back(b);
        adj[b].push_back(a);
    }

    parent[1] = 0;
    depth[1] = 0;
    dfs(1);
    decompose(1, 1);

    for (int i = 1; i <= n; i++)
        update(pos[i], val[i]);

    while (q--) {
        int t;
        cin >> t;
        if (t == 1) {
            int s, x;
            cin >> s >> x;
            val[s] = x;
            update(pos[s], x);
        } else {
            int a, b;
            cin >> a >> b;
            cout << path_max(a, b) << "\n";
        }
    }

    return 0;
}
```
#pagebreak()

== Distinct Colors

\
#link("https://cses.fi/problemset/task/1139")[Question - Distinct Colors]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1139")[Backup Link]

\
*Explanation* :

Each node has a color. For each node, count the number of distinct colors in its subtree.

Key Technique: *Small-to-Large Merging (DSU on Tree)*

When merging sets from children to parent, always merge the smaller set into the larger one. This ensures each element is moved at most O(log n) times total.

#figure(
  canvas({
    import draw: *

    content((4, 7), text(weight: "bold")[Small-to-Large Merging])

    // Parent node
    circle((4, 5.5), radius: 0.4, fill: rgb("#FFD700"), stroke: 2pt)
    content((4, 5.5), [u])

    // Children with sets
    circle((2, 4), radius: 0.35, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2, 4), [c1])
    content((2, 3.3), text(size: 7pt)[set: 5 colors])

    circle((4, 4), radius: 0.35, fill: rgb("#90EE90"), stroke: 1pt)
    content((4, 4), [c2])
    content((4, 3.3), text(size: 7pt)[set: 2 colors])

    circle((6, 4), radius: 0.35, fill: rgb("#FFB6C1"), stroke: 1pt)
    content((6, 4), [c3])
    content((6, 3.3), text(size: 7pt)[set: 8 colors])

    // Edges
    line((4, 5.1), (2, 4.35), stroke: 1pt)
    line((4, 5.1), (4, 4.35), stroke: 1pt)
    line((4, 5.1), (6, 4.35), stroke: 1pt)

    // Merge arrows
    line((2.3, 4.2), (5.5, 4.2), stroke: (paint: blue, thickness: 1.5pt, dash: "dashed"), mark: (end: ">"))
    line((4.3, 4.2), (5.6, 4.2), stroke: (paint: blue, thickness: 1.5pt, dash: "dashed"), mark: (end: ">"))

    content((4, 2.3), text(size: 9pt)[Keep largest set (c3), merge others into it])
    content((4, 1.8), text(size: 9pt)[Total moves: O(n log n) across all merges])
  })
)

Algorithm:
1. DFS from root, for each node maintain a set of colors in its subtree
2. When returning from children, merge all children's sets into the largest one
3. Add current node's color
4. Store answer as set size

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int n;
vector<vector<int>> children;
vector<int> color, ans;
vector<set<int>> colors;

void dfs(int u) {
    // Process all children first
    for (int v : children[u]) {
        dfs(v);

        // Small-to-large merging
        if (colors[v].size() > colors[u].size()) {
            swap(colors[u], colors[v]);
        }
        for (int c : colors[v]) {
            colors[u].insert(c);
        }
        colors[v].clear();  // Free memory
    }

    // Add current node's color
    colors[u].insert(color[u]);

    // Store answer
    ans[u] = colors[u].size();
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n;
    children.resize(n + 1);
    color.resize(n + 1);
    ans.resize(n + 1);
    colors.resize(n + 1);

    for (int i = 1; i <= n; i++) cin >> color[i];

    for (int i = 0; i < n - 1; i++) {
        int a, b;
        cin >> a >> b;
        // Build rooted tree (undirected input)
        children[a].push_back(b);
        children[b].push_back(a);
    }

    // Convert to rooted tree via BFS/DFS from node 1
    vector<bool> visited(n + 1, false);
    queue<int> q;
    q.push(1);
    visited[1] = true;
    vector<vector<int>> tree_children(n + 1);

    while (!q.empty()) {
        int u = q.front();
        q.pop();
        for (int v : children[u]) {
            if (!visited[v]) {
                visited[v] = true;
                tree_children[u].push_back(v);
                q.push(v);
            }
        }
    }
    children = tree_children;

    dfs(1);

    for (int i = 1; i <= n; i++) {
        cout << ans[i];
        if (i < n) cout << " ";
    }
    cout << "\n";

    return 0;
}
```
#pagebreak()

== Finding a Centroid

\
#link("https://cses.fi/problemset/task/2079")[Question - Finding a Centroid]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/2079")[Backup Link]

\
*Explanation* :

A centroid of a tree is a node such that when removed, no remaining subtree has more than n/2 nodes. Every tree has at least one centroid (and at most two).

Key Property:
If we root the tree at any node and a subtree has more than n/2 nodes, the centroid must be in that subtree.

#figure(
  canvas({
    import draw: *

    content((4, 7.5), text(weight: "bold")[Tree Centroid])

    // Tree with centroid marked
    circle((4, 6), radius: 0.4, fill: rgb("#FFD700"), stroke: 3pt)
    content((4, 6), text(weight: "bold")[C])

    circle((2, 4.7), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2, 4.7), [2])

    circle((4, 4.7), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((4, 4.7), [3])

    circle((6, 4.7), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((6, 4.7), [4])

    circle((1, 3.4), radius: 0.3, fill: rgb("#90EE90"), stroke: 1pt)
    content((1, 3.4), [5])

    circle((3, 3.4), radius: 0.3, fill: rgb("#90EE90"), stroke: 1pt)
    content((3, 3.4), [6])

    // Edges
    line((4, 5.6), (2, 5.05), stroke: 1pt)
    line((4, 5.6), (4, 5.05), stroke: 1pt)
    line((4, 5.6), (6, 5.05), stroke: 1pt)
    line((2, 4.4), (1, 3.75), stroke: 1pt)
    line((2, 4.4), (3, 3.75), stroke: 1pt)

    // Subtree sizes after removing C
    content((1, 2.8), text(size: 7pt)[size: 1])
    content((3, 2.8), text(size: 7pt)[size: 1])
    content((2, 4.1), text(size: 7pt)[size: 3])
    content((4, 4.1), text(size: 7pt)[size: 1])
    content((6, 4.1), text(size: 7pt)[size: 1])

    content((4, 2.0), text(size: 9pt)[n=6, max subtree after removing C = 3])
    content((4, 1.5), text(size: 9pt)[3 <= 6/2, so C is a valid centroid])
  })
)

Algorithm:
1. Compute subtree sizes with DFS
2. For current node, check if all subtrees (including "upward" subtree) have size <= n/2
3. If not, move to the child with subtree > n/2
4. Repeat until centroid found

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int n;
vector<vector<int>> adj;
vector<int> subtree_size;

void dfs_size(int u, int parent) {
    subtree_size[u] = 1;
    for (int v : adj[u]) {
        if (v != parent) {
            dfs_size(v, u);
            subtree_size[u] += subtree_size[v];
        }
    }
}

int find_centroid(int u, int parent) {
    for (int v : adj[u]) {
        if (v != parent && subtree_size[v] > n / 2) {
            return find_centroid(v, u);
        }
    }

    // Check upward subtree: n - subtree_size[u]
    // This is implicitly <= n/2 if we reached here from a valid path

    return u;
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n;
    adj.resize(n + 1);
    subtree_size.resize(n + 1);

    for (int i = 0; i < n - 1; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back(b);
        adj[b].push_back(a);
    }

    dfs_size(1, 0);

    cout << find_centroid(1, 0) << "\n";

    return 0;
}
```
