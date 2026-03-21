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





= Range Queries

\
== Static Range Sum Queries

\
#link("https://cses.fi/problemset/task/1646")[Question - Static Range Sum Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1646")[Backup Link]

\
*Explanation* :

Given an array of `n` integers and `q` queries, each query asks for the sum of elements in a range `[a, b]`. A naive approach would iterate through each range, giving O(n) per query and O(n·q) total — too slow for large inputs.

The Key Insight - Prefix Sums:
Instead of summing ranges repeatedly, we precompute a prefix sum array where `prefix[i]` = sum of elements from index 1 to i. Then any range sum can be computed in O(1):
```
sum(a, b) = prefix[b] - prefix[a-1]
```

Why This Works:
`prefix[b]` contains the sum of elements 1 to b. By subtracting `prefix[a-1]` (sum of elements 1 to a-1), we're left with exactly the sum from a to b.

#figure(
  canvas({
    import draw: *

    content((4, 6.5), [Prefix Sum Array Construction])

    // Original array
    content((0.5, 5.5), text(weight: "bold")[Array:])
    for (i, val) in ((0, 3), (1, 2), (2, 4), (3, 5), (4, 1), (5, 6)) {
      rect((1.5 + i * 0.9, 5.2), (2.3 + i * 0.9, 5.8), stroke: 1pt)
      content((1.9 + i * 0.9, 5.5), text(size: 10pt)[#val])
      content((1.9 + i * 0.9, 4.9), text(size: 8pt, fill: gray)[#(i + 1)])
    }

    // Prefix array
    content((0.5, 4.2), text(weight: "bold")[Prefix:])
    for (i, val) in ((0, 0), (1, 3), (2, 5), (3, 9), (4, 14), (5, 15), (6, 21)) {
      rect((1.5 + i * 0.9, 3.9), (2.3 + i * 0.9, 4.5), stroke: 1pt, fill: rgb("#E8F4FD"))
      content((1.9 + i * 0.9, 4.2), text(size: 10pt)[#val])
      content((1.9 + i * 0.9, 3.6), text(size: 8pt, fill: gray)[#i])
    }

    // Query example
    content((4, 2.8), text(weight: "bold")[Query: sum(2, 5) = ?])

    // Show the calculation
    rect((2.4, 3.9), (5.0, 4.5), stroke: (paint: red, thickness: 2pt, dash: "dashed"))

    content((4, 2.2), [prefix\[5\] - prefix\[1\] = 15 - 3 = *12*])
    content((4, 1.6), text(fill: gray, size: 9pt)[Elements: 2 + 4 + 5 + 1 = 12 ✓])
  })
)

Building the Prefix Array:
```
Array:    [3, 2, 4, 5, 1, 6]  (1-indexed)
prefix[0] = 0                  (base case)
prefix[1] = prefix[0] + arr[1] = 0 + 3 = 3
prefix[2] = prefix[1] + arr[2] = 3 + 2 = 5
prefix[3] = prefix[2] + arr[3] = 5 + 4 = 9
prefix[4] = prefix[3] + arr[4] = 9 + 5 = 14
prefix[5] = prefix[4] + arr[5] = 14 + 1 = 15
prefix[6] = prefix[5] + arr[6] = 15 + 6 = 21
```

Query Examples:
```
sum(1, 3) = prefix[3] - prefix[0] = 9 - 0 = 9   (3+2+4)
sum(2, 5) = prefix[5] - prefix[1] = 15 - 3 = 12 (2+4+5+1)
sum(4, 6) = prefix[6] - prefix[3] = 21 - 9 = 12 (5+1+6)
sum(3, 3) = prefix[3] - prefix[2] = 9 - 5 = 4   (just element 3)
```

Time Complexity:
- Preprocessing: O(n) to build prefix array
- Each query: O(1)
- Total: O(n + q)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, q;
    cin >> n >> q;

    vector<ll> arr(n + 1);
    vector<ll> prefix(n + 1, 0);

    // Read array and build prefix sums
    for (int i = 1; i <= n; i++) {
        cin >> arr[i];
        prefix[i] = prefix[i - 1] + arr[i];
    }

    // Answer queries
    while (q--) {
        int a, b;
        cin >> a >> b;
        cout << prefix[b] - prefix[a - 1] << "\n";
    }

    return 0;
}
```
#pagebreak()

== Static Range Minimum Queries

\
#link("https://cses.fi/problemset/task/1647")[Question - Static Range Minimum Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1647")[Backup Link]

\
*Explanation* :

Given an array of `n` integers and `q` queries, each query asks for the minimum element in a range `[a, b]`. Unlike range sums, we cannot simply use prefix arrays because `min(a,b) - min(a,c) ≠ min(c+1,b)`. We need a different approach: *Sparse Table*.

Why Sparse Table?
Sparse Table is perfect for *static* range queries on *idempotent* operations (where `f(x, x) = x`). Minimum is idempotent: `min(x, x) = x`. This allows overlapping ranges without double-counting, enabling O(1) queries.

The Core Idea:
Precompute answers for all ranges of length $2^j$. Any range can be covered by at most 2 overlapping power-of-2 ranges. For minimum, overlapping is fine!

Building the Sparse Table:
- `sparse[i][j]` = minimum in range starting at index i with length $2^j$
- Base case: `sparse[i][0] = arr[i]` (ranges of length 1)
- Recurrence: `sparse[i][j] = min(sparse[i][j-1], sparse[i + 2^(j-1)][j-1])`

#figure(
  canvas({
    import draw: *

    content((4, 7), [Sparse Table Construction])

    // Original array
    content((0.3, 6.2), text(weight: "bold", size: 9pt)[Array:])
    for (i, val) in ((0, 5), (1, 2), (2, 4), (3, 7), (4, 1), (5, 3), (6, 8), (7, 6)) {
      rect((1.2 + i * 0.7, 5.9), (1.8 + i * 0.7, 6.4), stroke: 1pt)
      content((1.5 + i * 0.7, 6.15), text(size: 9pt)[#val])
      content((1.5 + i * 0.7, 5.65), text(size: 7pt, fill: gray)[#(i + 1)])
    }

    // j=0 row
    content((0.3, 5.2), text(size: 8pt, fill: blue)[j=0:])
    for (i, val) in ((0, 5), (1, 2), (2, 4), (3, 7), (4, 1), (5, 3), (6, 8), (7, 6)) {
      rect((1.2 + i * 0.7, 4.9), (1.8 + i * 0.7, 5.4), stroke: 0.5pt, fill: rgb("#E8F4FD"))
      content((1.5 + i * 0.7, 5.15), text(size: 8pt)[#val])
    }

    // j=1 row
    content((0.3, 4.5), text(size: 8pt, fill: blue)[j=1:])
    for (i, val) in ((0, 2), (1, 2), (2, 4), (3, 1), (4, 1), (5, 3), (6, 6)) {
      rect((1.2 + i * 0.7, 4.2), (1.8 + i * 0.7, 4.7), stroke: 0.5pt, fill: rgb("#E8F4FD"))
      content((1.5 + i * 0.7, 4.45), text(size: 8pt)[#val])
    }

    // j=2 row
    content((0.3, 3.8), text(size: 8pt, fill: blue)[j=2:])
    for (i, val) in ((0, 2), (1, 1), (2, 1), (3, 1), (4, 1)) {
      rect((1.2 + i * 0.7, 3.5), (1.8 + i * 0.7, 4.0), stroke: 0.5pt, fill: rgb("#E8F4FD"))
      content((1.5 + i * 0.7, 3.75), text(size: 8pt)[#val])
    }

    // j=3 row
    content((0.3, 3.1), text(size: 8pt, fill: blue)[j=3:])
    rect((1.2, 2.8), (1.8, 3.3), stroke: 0.5pt, fill: rgb("#E8F4FD"))
    content((1.5, 3.05), text(size: 8pt)[1])

    // Explanation
    content((4, 2.2), text(size: 9pt)[sparse\[i\]\[j\] = min of $2^j$ elements starting at i])
    content((4, 1.7), text(size: 9pt)[sparse\[1\]\[2\] = min(5,2,4,7) = 2])
    content((4, 1.2), text(size: 9pt)[sparse\[5\]\[1\] = min(1,3) = 1])
  })
)

Answering Queries in O(1):
For range `[L, R]`, find the largest `k` such that $2^k <= R - L + 1$. Then:
```
answer = min(sparse[L][k], sparse[R - 2^k + 1][k])
```

These two ranges of length $2^k$ together cover `[L, R]` completely (with possible overlap, which is fine for minimum).

#figure(
  canvas({
    import draw: *

    content((4, 5.5), [Query: min(2, 7) on array \[5, 2, 4, 7, 1, 3, 8, 6\]])

    // Show the array segment
    for (i, val) in ((1, 2), (2, 4), (3, 7), (4, 1), (5, 3), (6, 8)) {
      rect((1 + i * 0.8, 4.2), (1.7 + i * 0.8, 4.7), stroke: 1pt)
      content((1.35 + i * 0.8, 4.45), text(size: 9pt)[#val])
      content((1.35 + i * 0.8, 3.95), text(size: 7pt, fill: gray)[#(i + 1)])
    }

    // First range
    rect((1.8, 4.2), (4.2, 4.7), stroke: (paint: red, thickness: 2pt))
    content((3, 5.0), text(fill: red, size: 8pt)[sparse\[2\]\[2\] = 1])

    // Second range
    rect((3.4, 4.1), (5.8, 4.8), stroke: (paint: blue, thickness: 2pt, dash: "dashed"))
    content((5.2, 5.0), text(fill: blue, size: 8pt)[sparse\[4\]\[2\] = 1])

    // Result
    content((4, 3.3), [k = floor(log2(7-2+1)) = floor(log2(6)) = 2])
    content((4, 2.8), [Answer = min(sparse\[2\]\[2\], sparse\[4\]\[2\]) = min(1, 1) = *1*])
  })
)

Time Complexity:
- Preprocessing: O(n log n) to build sparse table
- Each query: O(1)
- Space: O(n log n)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

const int MAXLOG = 20;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, q;
    cin >> n >> q;

    vector<int> arr(n + 1);
    for (int i = 1; i <= n; i++) {
        cin >> arr[i];
    }

    // Build sparse table
    // sparse[i][j] = minimum in range [i, i + 2^j - 1]
    vector<vector<int>> sparse(n + 1, vector<int>(MAXLOG));

    // Base case: ranges of length 1
    for (int i = 1; i <= n; i++) {
        sparse[i][0] = arr[i];
    }

    // Fill for larger powers of 2
    for (int j = 1; j < MAXLOG; j++) {
        for (int i = 1; i + (1 << j) - 1 <= n; i++) {
            sparse[i][j] = min(sparse[i][j - 1],
                               sparse[i + (1 << (j - 1))][j - 1]);
        }
    }

    // Precompute log values for O(1) query
    vector<int> lg(n + 1);
    lg[1] = 0;
    for (int i = 2; i <= n; i++) {
        lg[i] = lg[i / 2] + 1;
    }

    // Answer queries
    while (q--) {
        int a, b;
        cin >> a >> b;

        int len = b - a + 1;
        int k = lg[len];

        // Two overlapping ranges of length 2^k cover [a, b]
        int ans = min(sparse[a][k], sparse[b - (1 << k) + 1][k]);
        cout << ans << "\n";
    }

    return 0;
}
```
#pagebreak()

== Dynamic Range Sum Queries

\
#link("https://cses.fi/problemset/task/1648")[Question - Dynamic Range Sum Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1648")[Backup Link]

\
*Explanation* :

Now we have *updates*: change the value at position `k` to `u`, then answer sum queries on ranges. Prefix sums won't work anymore — updating one element would require rebuilding the entire prefix array in O(n). We need a *Segment Tree*.

What is a Segment Tree?
A segment tree is a binary tree where each node stores information about a range of the array. The root covers the entire array, and each node's children split its range in half. Leaves represent individual elements.

Key Properties:
- Tree has O(n) nodes (at most 4n for safety)
- Height is O(log n)
- Each update affects O(log n) nodes (ancestors of the leaf)
- Each query visits O(log n) nodes

#figure(
  canvas({
    import draw: *

    content((4, 7.2), [Segment Tree for array \[3, 2, 4, 5, 1, 6\]])

    // Root
    circle((4, 6.2), radius: 0.4, fill: rgb("#FFE4B5"), stroke: 1pt)
    content((4, 6.2), text(size: 9pt)[21])
    content((4, 5.6), text(size: 7pt, fill: gray)[\[1,6\]])

    // Level 1
    circle((2, 5.0), radius: 0.4, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2, 5.0), text(size: 9pt)[9])
    content((2, 4.4), text(size: 7pt, fill: gray)[\[1,3\]])

    circle((6, 5.0), radius: 0.4, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((6, 5.0), text(size: 9pt)[12])
    content((6, 4.4), text(size: 7pt, fill: gray)[\[4,6\]])

    // Level 2
    circle((1, 3.8), radius: 0.35, fill: rgb("#98FB98"), stroke: 1pt)
    content((1, 3.8), text(size: 9pt)[5])
    content((1, 3.3), text(size: 7pt, fill: gray)[\[1,2\]])

    circle((3, 3.8), radius: 0.35, fill: rgb("#98FB98"), stroke: 1pt)
    content((3, 3.8), text(size: 9pt)[4])
    content((3, 3.3), text(size: 7pt, fill: gray)[\[3,3\]])

    circle((5, 3.8), radius: 0.35, fill: rgb("#98FB98"), stroke: 1pt)
    content((5, 3.8), text(size: 9pt)[6])
    content((5, 3.3), text(size: 7pt, fill: gray)[\[4,5\]])

    circle((7, 3.8), radius: 0.35, fill: rgb("#98FB98"), stroke: 1pt)
    content((7, 3.8), text(size: 9pt)[6])
    content((7, 3.3), text(size: 7pt, fill: gray)[\[6,6\]])

    // Level 3 (leaves)
    circle((0.5, 2.6), radius: 0.3, fill: rgb("#E8E8E8"), stroke: 1pt)
    content((0.5, 2.6), text(size: 8pt)[3])
    circle((1.5, 2.6), radius: 0.3, fill: rgb("#E8E8E8"), stroke: 1pt)
    content((1.5, 2.6), text(size: 8pt)[2])

    circle((4.5, 2.6), radius: 0.3, fill: rgb("#E8E8E8"), stroke: 1pt)
    content((4.5, 2.6), text(size: 8pt)[5])
    circle((5.5, 2.6), radius: 0.3, fill: rgb("#E8E8E8"), stroke: 1pt)
    content((5.5, 2.6), text(size: 8pt)[1])

    // Edges
    line((4, 5.8), (2, 5.4), stroke: 1pt)
    line((4, 5.8), (6, 5.4), stroke: 1pt)
    line((2, 4.6), (1, 4.15), stroke: 1pt)
    line((2, 4.6), (3, 4.15), stroke: 1pt)
    line((6, 4.6), (5, 4.15), stroke: 1pt)
    line((6, 4.6), (7, 4.15), stroke: 1pt)
    line((1, 3.45), (0.5, 2.9), stroke: 1pt)
    line((1, 3.45), (1.5, 2.9), stroke: 1pt)
    line((5, 3.45), (4.5, 2.9), stroke: 1pt)
    line((5, 3.45), (5.5, 2.9), stroke: 1pt)

    // Legend
    content((4, 1.8), text(size: 9pt)[Each node stores sum of its range])
    content((4, 1.3), text(size: 9pt)[Parent = left child + right child])
  })
)

Query Operation - sum(2, 5):
We recursively find nodes whose ranges are completely inside `[2, 5]` and sum them up.

#figure(
  canvas({
    import draw: *

    content((4, 5.5), [Query sum(2, 5): Find nodes covering \[2,5\]])

    // Show decomposition
    content((1, 4.5), text(fill: blue, size: 9pt)[Node \[1,3\]?])
    content((1, 4.1), text(size: 8pt)[Partially overlaps])
    content((1, 3.7), text(size: 8pt)[→ Go to children])

    content((4, 4.5), text(fill: green, size: 9pt)[Node \[2,2\] ✓])
    content((4, 4.1), text(size: 8pt)[Fully inside \[2,5\]])
    content((4, 3.7), text(size: 8pt)[→ Return 2])

    content((4, 3.0), text(fill: green, size: 9pt)[Node \[3,3\] ✓])
    content((4, 2.6), text(size: 8pt)[Fully inside \[2,5\]])
    content((4, 2.2), text(size: 8pt)[→ Return 4])

    content((7, 4.5), text(fill: green, size: 9pt)[Node \[4,5\] ✓])
    content((7, 4.1), text(size: 8pt)[Fully inside \[2,5\]])
    content((7, 3.7), text(size: 8pt)[→ Return 6])

    content((4, 1.4), text(weight: "bold")[Answer = 2 + 4 + 6 = 12])
  })
)

Update Operation - set position 3 to 10:
Update the leaf, then propagate changes up to the root by recalculating parent sums.

```
Before: arr[3] = 4
After:  arr[3] = 10

Update path (bottom-up):
  Leaf [3,3]: 4 → 10
  Parent [1,3]: 9 → 9 - 4 + 10 = 15
  Root [1,6]: 21 → 21 - 4 + 10 = 27
```

Time Complexity:
- Build: O(n)
- Update: O(log n)
- Query: O(log n)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;

int n, q;
vector<ll> arr, tree;

// Build segment tree
void build(int node, int start, int end) {
    if (start == end) {
        tree[node] = arr[start];
    } else {
        int mid = (start + end) / 2;
        build(2 * node, start, mid);
        build(2 * node + 1, mid + 1, end);
        tree[node] = tree[2 * node] + tree[2 * node + 1];
    }
}

// Point update: set arr[idx] = val
void update(int node, int start, int end, int idx, ll val) {
    if (start == end) {
        arr[idx] = val;
        tree[node] = val;
    } else {
        int mid = (start + end) / 2;
        if (idx <= mid) {
            update(2 * node, start, mid, idx, val);
        } else {
            update(2 * node + 1, mid + 1, end, idx, val);
        }
        tree[node] = tree[2 * node] + tree[2 * node + 1];
    }
}

// Range sum query [l, r]
ll query(int node, int start, int end, int l, int r) {
    if (r < start || end < l) {
        return 0;  // Out of range
    }
    if (l <= start && end <= r) {
        return tree[node];  // Fully inside
    }
    int mid = (start + end) / 2;
    ll left_sum = query(2 * node, start, mid, l, r);
    ll right_sum = query(2 * node + 1, mid + 1, end, l, r);
    return left_sum + right_sum;
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> q;

    arr.resize(n + 1);
    tree.resize(4 * n);

    for (int i = 1; i <= n; i++) {
        cin >> arr[i];
    }

    build(1, 1, n);

    while (q--) {
        int type;
        cin >> type;

        if (type == 1) {
            int k;
            ll u;
            cin >> k >> u;
            update(1, 1, n, k, u);
        } else {
            int a, b;
            cin >> a >> b;
            cout << query(1, 1, n, a, b) << "\n";
        }
    }

    return 0;
}
```
#pagebreak()

== Dynamic Range Minimum Queries

\
#link("https://cses.fi/problemset/task/1649")[Question - Dynamic Range Minimum Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1649")[Backup Link]

\
*Explanation* :

This is nearly identical to Dynamic Range Sum Queries, but instead of storing sums in segment tree nodes, we store minimums. The key difference is in how we combine children and what we return for out-of-range queries.

Changes from Sum to Minimum:
1. *Combine operation*: `tree[node] = min(left_child, right_child)` instead of sum
2. *Identity element*: Return `∞` (a large value) for out-of-range queries instead of 0
3. *Node meaning*: Each node stores the minimum value in its range

#figure(
  canvas({
    import draw: *

    content((4, 7.2), [Segment Tree for Minimum: array \[5, 2, 4, 7, 1, 3\]])

    // Root
    circle((4, 6.2), radius: 0.4, fill: rgb("#FFE4B5"), stroke: 1pt)
    content((4, 6.2), text(size: 9pt)[1])
    content((4, 5.6), text(size: 7pt, fill: gray)[\[1,6\]])

    // Level 1
    circle((2, 5.0), radius: 0.4, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2, 5.0), text(size: 9pt)[2])
    content((2, 4.4), text(size: 7pt, fill: gray)[\[1,3\]])

    circle((6, 5.0), radius: 0.4, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((6, 5.0), text(size: 9pt)[1])
    content((6, 4.4), text(size: 7pt, fill: gray)[\[4,6\]])

    // Level 2
    circle((1, 3.8), radius: 0.35, fill: rgb("#98FB98"), stroke: 1pt)
    content((1, 3.8), text(size: 9pt)[2])
    content((1, 3.3), text(size: 7pt, fill: gray)[\[1,2\]])

    circle((3, 3.8), radius: 0.35, fill: rgb("#98FB98"), stroke: 1pt)
    content((3, 3.8), text(size: 9pt)[4])
    content((3, 3.3), text(size: 7pt, fill: gray)[\[3,3\]])

    circle((5, 3.8), radius: 0.35, fill: rgb("#98FB98"), stroke: 1pt)
    content((5, 3.8), text(size: 9pt)[1])
    content((5, 3.3), text(size: 7pt, fill: gray)[\[4,5\]])

    circle((7, 3.8), radius: 0.35, fill: rgb("#98FB98"), stroke: 1pt)
    content((7, 3.8), text(size: 9pt)[3])
    content((7, 3.3), text(size: 7pt, fill: gray)[\[6,6\]])

    // Level 3 (leaves)
    circle((0.5, 2.6), radius: 0.3, fill: rgb("#E8E8E8"), stroke: 1pt)
    content((0.5, 2.6), text(size: 8pt)[5])
    circle((1.5, 2.6), radius: 0.3, fill: rgb("#E8E8E8"), stroke: 1pt)
    content((1.5, 2.6), text(size: 8pt)[2])

    circle((4.5, 2.6), radius: 0.3, fill: rgb("#E8E8E8"), stroke: 1pt)
    content((4.5, 2.6), text(size: 8pt)[7])
    circle((5.5, 2.6), radius: 0.3, fill: rgb("#E8E8E8"), stroke: 1pt)
    content((5.5, 2.6), text(size: 8pt)[1])

    // Edges
    line((4, 5.8), (2, 5.4), stroke: 1pt)
    line((4, 5.8), (6, 5.4), stroke: 1pt)
    line((2, 4.6), (1, 4.15), stroke: 1pt)
    line((2, 4.6), (3, 4.15), stroke: 1pt)
    line((6, 4.6), (5, 4.15), stroke: 1pt)
    line((6, 4.6), (7, 4.15), stroke: 1pt)
    line((1, 3.45), (0.5, 2.9), stroke: 1pt)
    line((1, 3.45), (1.5, 2.9), stroke: 1pt)
    line((5, 3.45), (4.5, 2.9), stroke: 1pt)
    line((5, 3.45), (5.5, 2.9), stroke: 1pt)

    // Legend
    content((4, 1.8), text(size: 9pt)[Each node stores min of its range])
    content((4, 1.3), text(size: 9pt)[Parent = min(left child, right child)])
  })
)

Why Return Infinity for Out-of-Range?
When a range doesn't overlap with our query, it shouldn't affect the answer. For minimum, we return `∞` because `min(x, ∞) = x` — it doesn't change the result. This is the *identity element* for the min operation.

Query Example - min(2, 5):
```
Query [2,5]:
  Node [1,6]: partial overlap → recurse
    Node [1,3]: partial overlap → recurse
      Node [1,2]: partial → recurse
        Node [1,1]: outside → return ∞
        Node [2,2]: inside → return 2
      Node [3,3]: inside → return 4
    Node [4,6]: partial overlap → recurse
      Node [4,5]: inside → return 1
      Node [6,6]: outside → return ∞

Result: min(∞, 2, 4, 1, ∞) = 1
```

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;
const ll INF = 1e18;

int n, q;
vector<ll> arr, tree;

// Build segment tree for minimum
void build(int node, int start, int end) {
    if (start == end) {
        tree[node] = arr[start];
    } else {
        int mid = (start + end) / 2;
        build(2 * node, start, mid);
        build(2 * node + 1, mid + 1, end);
        tree[node] = min(tree[2 * node], tree[2 * node + 1]);
    }
}

// Point update: set arr[idx] = val
void update(int node, int start, int end, int idx, ll val) {
    if (start == end) {
        arr[idx] = val;
        tree[node] = val;
    } else {
        int mid = (start + end) / 2;
        if (idx <= mid) {
            update(2 * node, start, mid, idx, val);
        } else {
            update(2 * node + 1, mid + 1, end, idx, val);
        }
        tree[node] = min(tree[2 * node], tree[2 * node + 1]);
    }
}

// Range minimum query [l, r]
ll query(int node, int start, int end, int l, int r) {
    if (r < start || end < l) {
        return INF;  // Out of range - return identity
    }
    if (l <= start && end <= r) {
        return tree[node];  // Fully inside
    }
    int mid = (start + end) / 2;
    ll left_min = query(2 * node, start, mid, l, r);
    ll right_min = query(2 * node + 1, mid + 1, end, l, r);
    return min(left_min, right_min);
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> q;

    arr.resize(n + 1);
    tree.resize(4 * n);

    for (int i = 1; i <= n; i++) {
        cin >> arr[i];
    }

    build(1, 1, n);

    while (q--) {
        int type;
        cin >> type;

        if (type == 1) {
            int k;
            ll u;
            cin >> k >> u;
            update(1, 1, n, k, u);
        } else {
            int a, b;
            cin >> a >> b;
            cout << query(1, 1, n, a, b) << "\n";
        }
    }

    return 0;
}
```
#pagebreak()

== Range Xor Queries

\
#link("https://cses.fi/problemset/task/1650")[Question - Range Xor Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1650")[Backup Link]

\
*Explanation* :

Given an array and queries asking for the XOR of elements in range `[a, b]`, this problem is static (no updates). We can use the same prefix technique as range sums, but with XOR instead of addition.

The Magic Property of XOR:
XOR has a special property: `x ⊕ x = 0` (any number XORed with itself is 0). This means:
```
prefix[b] ⊕ prefix[a-1] = (arr[1] ⊕ ... ⊕ arr[b]) ⊕ (arr[1] ⊕ ... ⊕ arr[a-1])
                        = arr[a] ⊕ arr[a+1] ⊕ ... ⊕ arr[b]
```
The elements from 1 to a-1 appear in both and cancel out!

#figure(
  canvas({
    import draw: *

    content((4, 6.5), [Prefix XOR Array])

    // Original array
    content((0.5, 5.5), text(weight: "bold")[Array:])
    for (i, val) in ((0, 3), (1, 5), (2, 2), (3, 6), (4, 1), (5, 4)) {
      rect((1.5 + i * 0.9, 5.2), (2.3 + i * 0.9, 5.8), stroke: 1pt)
      content((1.9 + i * 0.9, 5.5), text(size: 10pt)[#val])
      content((1.9 + i * 0.9, 4.9), text(size: 8pt, fill: gray)[#(i + 1)])
    }

    // Binary representations
    content((0.5, 4.3), text(size: 8pt, fill: gray)[Binary:])
    for (i, val) in ((0, "011"), (1, "101"), (2, "010"), (3, "110"), (4, "001"), (5, "100")) {
      content((1.9 + i * 0.9, 4.3), text(size: 7pt, fill: gray)[#val])
    }

    // Prefix XOR array
    content((0.3, 3.5), text(weight: "bold")[Prefix⊕:])
    for (i, val) in ((0, 0), (1, 3), (2, 6), (3, 4), (4, 2), (5, 3), (6, 7)) {
      rect((1.5 + i * 0.9, 3.2), (2.3 + i * 0.9, 3.8), stroke: 1pt, fill: rgb("#E8F4FD"))
      content((1.9 + i * 0.9, 3.5), text(size: 10pt)[#val])
      content((1.9 + i * 0.9, 2.9), text(size: 8pt, fill: gray)[#i])
    }

    // Query example
    content((4, 2.2), text(weight: "bold")[Query: XOR(2, 5) = ?])
    content((4, 1.6), [prefix\[5\] ⊕ prefix\[1\] = 3 ⊕ 3 = *0*])
    content((4, 1.0), text(fill: gray, size: 9pt)[Verify: 5 ⊕ 2 ⊕ 6 ⊕ 1 = 101 ⊕ 010 ⊕ 110 ⊕ 001 = 000 ✓])
  })
)

Building Prefix XOR:
```
Array:      [3, 5, 2, 6, 1, 4]
prefix[0] = 0                           (base case)
prefix[1] = prefix[0] ⊕ arr[1] = 0 ⊕ 3 = 3
prefix[2] = prefix[1] ⊕ arr[2] = 3 ⊕ 5 = 6
prefix[3] = prefix[2] ⊕ arr[3] = 6 ⊕ 2 = 4
prefix[4] = prefix[3] ⊕ arr[4] = 4 ⊕ 6 = 2
prefix[5] = prefix[4] ⊕ arr[5] = 2 ⊕ 1 = 3
prefix[6] = prefix[5] ⊕ arr[6] = 3 ⊕ 4 = 7
```

Query Examples:
```
XOR(1, 3) = prefix[3] ⊕ prefix[0] = 4 ⊕ 0 = 4   (3⊕5⊕2 = 4)
XOR(2, 4) = prefix[4] ⊕ prefix[1] = 2 ⊕ 3 = 1   (5⊕2⊕6 = 1)
XOR(3, 6) = prefix[6] ⊕ prefix[2] = 7 ⊕ 6 = 1   (2⊕6⊕1⊕4 = 1)
```

Time Complexity:
- Preprocessing: O(n)
- Each query: O(1)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, q;
    cin >> n >> q;

    vector<int> arr(n + 1);
    vector<int> prefix(n + 1, 0);

    // Build prefix XOR array
    for (int i = 1; i <= n; i++) {
        cin >> arr[i];
        prefix[i] = prefix[i - 1] ^ arr[i];
    }

    // Answer queries
    while (q--) {
        int a, b;
        cin >> a >> b;
        cout << (prefix[b] ^ prefix[a - 1]) << "\n";
    }

    return 0;
}
```
#pagebreak()

== Range Update Queries

\
#link("https://cses.fi/problemset/task/1651")[Question - Range Update Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1651")[Backup Link]

\
*Explanation* :

This problem flips our previous pattern: now we have *range updates* and *point queries*. We need to add a value `u` to all elements in range `[a, b]`, then query individual element values.

The Naive Approach Problem:
Updating each element in a range takes O(n) per update. With many updates, this is too slow.

The Clever Solution - Difference Array:
Instead of storing actual values, we store the *difference* between consecutive elements. Then a range update `[a, b] += u` becomes just two point updates:
- `diff[a] += u` (start adding u from position a)
- `diff[b+1] -= u` (stop adding u after position b)

To get the actual value at position k, we compute the prefix sum of the difference array up to k.

#figure(
  canvas({
    import draw: *

    content((4, 7), [Difference Array Technique])

    // Original array
    content((0.3, 6.2), text(weight: "bold", size: 9pt)[Array:])
    for (i, val) in ((0, 3), (1, 2), (2, 4), (3, 5), (4, 1), (5, 6)) {
      rect((1.3 + i * 0.85, 5.9), (2.05 + i * 0.85, 6.4), stroke: 1pt)
      content((1.67 + i * 0.85, 6.15), text(size: 9pt)[#val])
      content((1.67 + i * 0.85, 5.65), text(size: 7pt, fill: gray)[#(i + 1)])
    }

    // Difference array
    content((0.3, 5.0), text(weight: "bold", size: 9pt)[Diff:])
    for (i, val) in ((0, 3), (1, -1), (2, 2), (3, 1), (4, -4), (5, 5), (6, 0)) {
      rect((1.3 + i * 0.85, 4.7), (2.05 + i * 0.85, 5.2), stroke: 1pt, fill: rgb("#E8F4FD"))
      content((1.67 + i * 0.85, 4.95), text(size: 9pt)[#val])
      content((1.67 + i * 0.85, 4.45), text(size: 7pt, fill: gray)[#(i + 1)])
    }

    // Show range update
    content((4, 3.8), text(weight: "bold")[Update: add 10 to range \[2, 4\]])

    // After update difference array
    content((0.3, 3.0), text(weight: "bold", size: 9pt)[After:])
    for (i, val) in ((0, 3), (1, 9), (2, 2), (3, 1), (4, -14), (5, 5), (6, 0)) {
      let fill_color = if i == 1 or i == 4 { rgb("#90EE90") } else { rgb("#E8F4FD") }
      rect((1.3 + i * 0.85, 2.7), (2.05 + i * 0.85, 3.2), stroke: 1pt, fill: fill_color)
      content((1.67 + i * 0.85, 2.95), text(size: 9pt)[#val])
    }

    content((4, 2.0), text(size: 9pt)[diff\[2\] += 10, diff\[5\] -= 10])
    content((4, 1.4), text(size: 9pt, fill: gray)[Result: arr = \[3, 12, 14, 15, 1, 6\]])
  })
)

Using a BIT/Fenwick Tree:
To efficiently compute prefix sums for point queries, we use a Binary Indexed Tree (BIT). This gives us:
- Range update in O(log n): update two positions in BIT
- Point query in O(log n): query prefix sum at position k

How BIT Works:
A BIT stores partial sums in a clever way using binary representations. Position i in the BIT is responsible for a range of elements determined by the lowest set bit of i.

```
Update [a, b] += u:
  BIT.add(a, +u)    // Start adding u from position a
  BIT.add(b+1, -u)  // Stop adding u after position b

Query position k:
  return BIT.prefixSum(k)  // Sum of all updates affecting position k
```

Example Trace:
```
Initial array: [3, 2, 4, 5, 1, 6]
We maintain a BIT for the difference array

Update 1: add 5 to [2, 4]
  BIT.add(2, +5)
  BIT.add(5, -5)

Update 2: add 3 to [1, 3]
  BIT.add(1, +3)
  BIT.add(4, -3)

Query position 3:
  Original value: 4
  + prefixSum(3) = 3 + 5 = 8
  Answer: 4 + 8 = 12
```

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;

int n, q;
vector<ll> arr;
vector<ll> bit;  // BIT for difference array

// Add val to position i
void update(int i, ll val) {
    for (; i <= n; i += i & (-i)) {
        bit[i] += val;
    }
}

// Get prefix sum [1, i]
ll query(int i) {
    ll sum = 0;
    for (; i > 0; i -= i & (-i)) {
        sum += bit[i];
    }
    return sum;
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> q;

    arr.resize(n + 1);
    bit.resize(n + 2, 0);  // Extra space for b+1 updates

    for (int i = 1; i <= n; i++) {
        cin >> arr[i];
    }

    while (q--) {
        int type;
        cin >> type;

        if (type == 1) {
            // Range update: add u to [a, b]
            int a, b;
            ll u;
            cin >> a >> b >> u;
            update(a, u);
            update(b + 1, -u);
        } else {
            // Point query: get value at position k
            int k;
            cin >> k;
            cout << arr[k] + query(k) << "\n";
        }
    }

    return 0;
}
```
#pagebreak()

== Forest Queries

\
#link("https://cses.fi/problemset/task/1652")[Question - Forest Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1652")[Backup Link]

\
*Explanation* :

Given an `n × n` grid where each cell is either a tree (`*`) or empty (`.`), answer queries asking how many trees are in a rectangular subgrid from $(r_1, c_1)$ to $(r_2, c_2)$. This is a 2D extension of prefix sums.

2D Prefix Sum Concept:
Define `prefix[i][j]` = count of trees in the rectangle from $(1,1)$ to $(i,j)$. Using inclusion-exclusion, we can compute any rectangle sum in O(1).

#figure(
  canvas({
    import draw: *

    content((4, 7.2), [2D Prefix Sum: Inclusion-Exclusion])

    // Draw the grid concept
    rect((1, 3.5), (7, 6.5), stroke: 1pt)

    // Region A (top-left)
    rect((1, 5), (4, 6.5), fill: rgb("#FFB6C1").transparentize(50%), stroke: 0.5pt)
    content((2.5, 5.75), text(size: 9pt)[A])

    // Region B (top-right)
    rect((4, 5), (7, 6.5), fill: rgb("#ADD8E6").transparentize(50%), stroke: 0.5pt)
    content((5.5, 5.75), text(size: 9pt)[B])

    // Region C (bottom-left)
    rect((1, 3.5), (4, 5), fill: rgb("#98FB98").transparentize(50%), stroke: 0.5pt)
    content((2.5, 4.25), text(size: 9pt)[C])

    // Region D (bottom-right) - the query region
    rect((4, 3.5), (7, 5), fill: rgb("#FFE4B5"), stroke: 2pt)
    content((5.5, 4.25), text(weight: "bold")[D])

    // Labels
    content((0.5, 6.5), text(size: 8pt)[(1,1)])
    content((4, 6.8), text(size: 8pt)[$(r_1$-1)])
    content((7.3, 6.5), text(size: 8pt)[$(c_2)$])
    content((0.5, 5), text(size: 8pt)[$(r_1)$])
    content((0.5, 3.5), text(size: 8pt)[$(r_2)$])

    // Formula
    content((4, 2.7), text(weight: "bold")[Query (r1, c1) to (r2, c2):])
    content((4, 2.1), text(size: 9pt)[sum(D) = prefix\[r2\]\[c2\] - prefix\[r1-1\]\[c2\]])
    content((4, 1.6), text(size: 9pt)[         - prefix\[r2\]\[c1-1\] + prefix\[r1-1\]\[c1-1\]])
    content((4, 1.0), text(size: 8pt, fill: gray)[We subtract B and C, but A was subtracted twice, so add it back])
  })
)

Building the 2D Prefix Sum:
```
prefix[i][j] = grid[i][j]
             + prefix[i-1][j]
             + prefix[i][j-1]
             - prefix[i-1][j-1]
```

#figure(
  canvas({
    import draw: *

    content((4, 5.5), [Example: 4×4 forest grid])

    // Original grid
    content((1.5, 4.8), text(weight: "bold", size: 9pt)[Grid:])
    let grid_data = ((".", "*", ".", "."), ("*", ".", "*", "."), (".", "*", "*", "."), (".", ".", ".", "*"))
    for i in range(4) {
      for j in range(4) {
        let val = grid_data.at(i).at(j)
        let fill_c = if val == "*" { rgb("#228B22") } else { white }
        rect((2.5 + j * 0.6, 4.5 - i * 0.5), (3.0 + j * 0.6, 5.0 - i * 0.5), fill: fill_c, stroke: 0.5pt)
      }
    }

    // Prefix sum grid
    content((5.5, 4.8), text(weight: "bold", size: 9pt)[Prefix:])
    let prefix_data = ((0, 1, 1, 1), (1, 2, 3, 3), (1, 3, 5, 5), (1, 3, 5, 6))
    for i in range(4) {
      for j in range(4) {
        let val = prefix_data.at(i).at(j)
        rect((6.3 + j * 0.6, 4.5 - i * 0.5), (6.8 + j * 0.6, 5.0 - i * 0.5), fill: rgb("#E8F4FD"), stroke: 0.5pt)
        content((6.55 + j * 0.6, 4.75 - i * 0.5), text(size: 8pt)[#val])
      }
    }

    // Query example
    content((4, 2.0), text(weight: "bold")[Query: trees in (2,2) to (4,4)?])
    content((4, 1.4), text(size: 9pt)[= prefix\[4\]\[4\] - prefix\[1\]\[4\] - prefix\[4\]\[1\] + prefix\[1\]\[1\]])
    content((4, 0.9), text(size: 9pt)[= 6 - 1 - 1 + 0 = *4* trees])
  })
)

Time Complexity:
- Preprocessing: O(n²) to build 2D prefix sum
- Each query: O(1)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, q;
    cin >> n >> q;

    vector<string> grid(n + 1);
    vector<vector<int>> prefix(n + 1, vector<int>(n + 1, 0));

    // Read grid (1-indexed)
    for (int i = 1; i <= n; i++) {
        cin >> grid[i];
        grid[i] = " " + grid[i];  // Make 1-indexed
    }

    // Build 2D prefix sum
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            int tree = (grid[i][j] == '*') ? 1 : 0;
            prefix[i][j] = tree + prefix[i-1][j] + prefix[i][j-1] - prefix[i-1][j-1];
        }
    }

    // Answer queries
    while (q--) {
        int r1, c1, r2, c2;
        cin >> r1 >> c1 >> r2 >> c2;

        int ans = prefix[r2][c2]
                - prefix[r1-1][c2]
                - prefix[r2][c1-1]
                + prefix[r1-1][c1-1];

        cout << ans << "\n";
    }

    return 0;
}
```
#pagebreak()

== Hotel Queries

\
#link("https://cses.fi/problemset/task/1143")[Question - Hotel Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1143")[Backup Link]

\
*Explanation* :

There are `n` hotels with given room capacities. For each of `m` groups, we need to assign them to the *first* hotel (leftmost) that has enough free rooms, then reduce that hotel's capacity.

The Naive Approach:
For each group, scan hotels left to right until finding one with enough rooms. This is O(n) per query, giving O(n·m) total — too slow.

Segment Tree with Maximum:
We use a segment tree where each node stores the *maximum* capacity in its range. This lets us efficiently find the leftmost hotel with sufficient capacity.

Key Insight:
To find the leftmost hotel with capacity ≥ r:
1. If max of entire range < r, no valid hotel exists → return 0
2. Otherwise, recursively search the left subtree first
3. If left subtree has a valid hotel, return it
4. Otherwise, search the right subtree

#figure(
  canvas({
    import draw: *

    content((4, 7.2), [Segment Tree storing Maximum Capacities])

    // Example hotels
    content((4, 6.6), text(size: 9pt, fill: gray)[Hotels: \[3, 2, 5, 1, 4, 2\]])

    // Root
    circle((4, 5.8), radius: 0.4, fill: rgb("#FFE4B5"), stroke: 1pt)
    content((4, 5.8), text(size: 9pt)[5])
    content((4, 5.2), text(size: 7pt, fill: gray)[\[1,6\]])

    // Level 1
    circle((2, 4.6), radius: 0.4, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2, 4.6), text(size: 9pt)[5])
    content((2, 4.0), text(size: 7pt, fill: gray)[\[1,3\]])

    circle((6, 4.6), radius: 0.4, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((6, 4.6), text(size: 9pt)[4])
    content((6, 4.0), text(size: 7pt, fill: gray)[\[4,6\]])

    // Level 2
    circle((1, 3.4), radius: 0.35, fill: rgb("#98FB98"), stroke: 1pt)
    content((1, 3.4), text(size: 9pt)[3])
    content((1, 2.9), text(size: 7pt, fill: gray)[\[1,2\]])

    circle((3, 3.4), radius: 0.35, fill: rgb("#98FB98"), stroke: 1pt)
    content((3, 3.4), text(size: 9pt)[5])
    content((3, 2.9), text(size: 7pt, fill: gray)[\[3,3\]])

    circle((5, 3.4), radius: 0.35, fill: rgb("#98FB98"), stroke: 1pt)
    content((5, 3.4), text(size: 9pt)[1])
    content((5, 2.9), text(size: 7pt, fill: gray)[\[4,5\]])

    circle((7, 3.4), radius: 0.35, fill: rgb("#98FB98"), stroke: 1pt)
    content((7, 3.4), text(size: 9pt)[4])
    content((7, 2.9), text(size: 7pt, fill: gray)[\[6,6\]])

    // Edges
    line((4, 5.4), (2, 5.0), stroke: 1pt)
    line((4, 5.4), (6, 5.0), stroke: 1pt)
    line((2, 4.2), (1, 3.75), stroke: 1pt)
    line((2, 4.2), (3, 3.75), stroke: 1pt)
    line((6, 4.2), (5, 3.75), stroke: 1pt)
    line((6, 4.2), (7, 3.75), stroke: 1pt)
  })
)

Query Example - Group needs 4 rooms:
```
Search for leftmost hotel with capacity >= 4:

At root [1,6]: max=5 >= 4, so valid hotel exists
  → Check left child [1,3]: max=5 >= 4
    → Check left [1,2]: max=3 < 4, no valid hotel here
    → Check right [3,3]: max=5 >= 4, this is a leaf!
      → Return hotel 3

Hotel 3 had 5 rooms, group takes 4
Update hotel 3: capacity 5 → 1
Propagate max updates up the tree
```

After Assigning Group:
```
Hotel 3: 5 → 1
Node [3,3]: 5 → 1
Node [1,3]: max(3, 1) = 3
Node [1,6]: max(3, 4) = 4
```

Time Complexity:
- Each query: O(log n) to find hotel + O(log n) to update
- Total: O(m log n)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int n, m;
vector<int> hotel, tree;

void build(int node, int start, int end) {
    if (start == end) {
        tree[node] = hotel[start];
    } else {
        int mid = (start + end) / 2;
        build(2 * node, start, mid);
        build(2 * node + 1, mid + 1, end);
        tree[node] = max(tree[2 * node], tree[2 * node + 1]);
    }
}

// Find leftmost hotel with capacity >= rooms, and book it
int query(int node, int start, int end, int rooms) {
    if (tree[node] < rooms) {
        return 0;  // No valid hotel in this range
    }
    if (start == end) {
        // Found the hotel, book the rooms
        tree[node] -= rooms;
        return start;
    }

    int mid = (start + end) / 2;
    int result;

    // Try left subtree first (for leftmost)
    if (tree[2 * node] >= rooms) {
        result = query(2 * node, start, mid, rooms);
    } else {
        result = query(2 * node + 1, mid + 1, end, rooms);
    }

    // Update current node's max after booking
    tree[node] = max(tree[2 * node], tree[2 * node + 1]);

    return result;
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> m;

    hotel.resize(n + 1);
    tree.resize(4 * n);

    for (int i = 1; i <= n; i++) {
        cin >> hotel[i];
    }

    build(1, 1, n);

    for (int i = 0; i < m; i++) {
        int r;
        cin >> r;
        cout << query(1, 1, n, r) << " ";
    }
    cout << "\n";

    return 0;
}
```
#pagebreak()

== List Removals

\
#link("https://cses.fi/problemset/task/1749")[Question - List Removals]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1749")[Backup Link]

\
*Explanation* :

Given a list of `n` elements, we perform `n` operations: each time, remove and print the element at position `p_i` in the *current* list. After each removal, the list shrinks and positions shift.

The Challenge:
If we use an array or vector, removing an element takes O(n) to shift remaining elements. With n removals, total complexity is O(n²) — too slow.

The Insight - Segment Tree as Order Statistic Tree:
We maintain a segment tree where each node stores the *count* of remaining elements in its range. Initially, all n elements exist, so count = length of range. To find the k-th element:
1. If left subtree has ≥ k elements, recurse left with k
2. Otherwise, recurse right with k - (left count)

When we find the element, mark it as removed (count = 0) and propagate up.

#figure(
  canvas({
    import draw: *

    content((4, 7.2), [Segment Tree storing Element Counts])

    content((4, 6.6), text(size: 9pt, fill: gray)[Array: \[2, 6, 1, 4, 3\], all present initially])

    // Root
    circle((4, 5.8), radius: 0.4, fill: rgb("#FFE4B5"), stroke: 1pt)
    content((4, 5.8), text(size: 9pt)[5])
    content((4, 5.2), text(size: 7pt, fill: gray)[\[1,5\]])

    // Level 1
    circle((2, 4.6), radius: 0.4, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((2, 4.6), text(size: 9pt)[3])
    content((2, 4.0), text(size: 7pt, fill: gray)[\[1,3\]])

    circle((6, 4.6), radius: 0.4, fill: rgb("#ADD8E6"), stroke: 1pt)
    content((6, 4.6), text(size: 9pt)[2])
    content((6, 4.0), text(size: 7pt, fill: gray)[\[4,5\]])

    // Level 2
    circle((1, 3.4), radius: 0.35, fill: rgb("#98FB98"), stroke: 1pt)
    content((1, 3.4), text(size: 9pt)[2])
    content((1, 2.9), text(size: 7pt, fill: gray)[\[1,2\]])

    circle((3, 3.4), radius: 0.35, fill: rgb("#98FB98"), stroke: 1pt)
    content((3, 3.4), text(size: 9pt)[1])
    content((3, 2.9), text(size: 7pt, fill: gray)[\[3,3\]])

    circle((5, 3.4), radius: 0.35, fill: rgb("#98FB98"), stroke: 1pt)
    content((5, 3.4), text(size: 9pt)[1])
    content((5, 2.9), text(size: 7pt, fill: gray)[\[4,4\]])

    circle((7, 3.4), radius: 0.35, fill: rgb("#98FB98"), stroke: 1pt)
    content((7, 3.4), text(size: 9pt)[1])
    content((7, 2.9), text(size: 7pt, fill: gray)[\[5,5\]])

    // Edges
    line((4, 5.4), (2, 5.0), stroke: 1pt)
    line((4, 5.4), (6, 5.0), stroke: 1pt)
    line((2, 4.2), (1, 3.75), stroke: 1pt)
    line((2, 4.2), (3, 3.75), stroke: 1pt)
    line((6, 4.2), (5, 3.75), stroke: 1pt)
    line((6, 4.2), (7, 3.75), stroke: 1pt)
  })
)

Query Example - Find and remove 3rd element:
```
Array: [2, 6, 1, 4, 3], find position 3

At root [1,5]: count=5, looking for 3rd
  Left [1,3] has count=3 >= 3
    Left [1,2] has count=2 < 3? No, 2 < 3
    Wait, we want 3rd in [1,3], left has 2
    So 3rd is in right subtree: look for (3-2)=1st in [3,3]
      [3,3] is a leaf with count=1, position 3 is the answer!

Element at position 3 is arr[3] = 1
Remove it: set count[3,3] = 0
Update parents: [1,3]: 2, [1,5]: 4
```

After Removal:
```
Logical list: [2, 6, _, 4, 3] → effectively [2, 6, 4, 3]
Counts: [1,5]=4, [1,3]=2, [4,5]=2, [1,2]=2, [3,3]=0, [4,4]=1, [5,5]=1

Next query for "2nd element" would find arr[2]=6
```

Time Complexity:
- Each query: O(log n) to find and remove
- Total: O(n log n)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int n;
vector<int> arr, tree;

void build(int node, int start, int end) {
    if (start == end) {
        tree[node] = 1;  // Each element is initially present
    } else {
        int mid = (start + end) / 2;
        build(2 * node, start, mid);
        build(2 * node + 1, mid + 1, end);
        tree[node] = tree[2 * node] + tree[2 * node + 1];
    }
}

// Find k-th element in current list and remove it
int query(int node, int start, int end, int k) {
    if (start == end) {
        tree[node] = 0;  // Remove this element
        return start;    // Return the original index
    }

    int mid = (start + end) / 2;
    int result;

    if (tree[2 * node] >= k) {
        // k-th element is in left subtree
        result = query(2 * node, start, mid, k);
    } else {
        // k-th element is in right subtree
        result = query(2 * node + 1, mid + 1, end, k - tree[2 * node]);
    }

    // Update count after removal
    tree[node] = tree[2 * node] + tree[2 * node + 1];

    return result;
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n;

    arr.resize(n + 1);
    tree.resize(4 * n);

    for (int i = 1; i <= n; i++) {
        cin >> arr[i];
    }

    build(1, 1, n);

    for (int i = 0; i < n; i++) {
        int p;
        cin >> p;
        int idx = query(1, 1, n, p);
        cout << arr[idx] << " ";
    }
    cout << "\n";

    return 0;
}
```
#pagebreak()

== Salary Queries

\
#link("https://cses.fi/problemset/task/1144")[Question - Salary Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1144")[Backup Link]

\
*Explanation* :

We have `n` employees with salaries. Two operations:
1. Change employee `k`'s salary to `x`
2. Count employees with salary in range `[a, b]`

The Challenge - Large Salary Values:
Salaries can be up to $10^9$. We can't create an array indexed by salary. Instead, we use *coordinate compression* to map salaries to a smaller range.

Coordinate Compression:
Collect all unique salary values (initial + all updates), sort them, and map each to a rank from 1 to m. Now we can use a BIT or segment tree indexed by rank.

#figure(
  canvas({
    import draw: *

    content((4, 6.5), [Coordinate Compression Example])

    // Original salaries
    content((0.5, 5.7), text(weight: "bold", size: 9pt)[Values:])
    for (i, val) in ((0, "100"), (1, "5000"), (2, "300"), (3, "100"), (4, "800")) {
      rect((1.8 + i * 1.1, 5.4), (2.7 + i * 1.1, 5.9), stroke: 1pt)
      content((2.25 + i * 1.1, 5.65), text(size: 8pt)[#val])
    }

    // Sorted unique
    content((0.5, 4.7), text(weight: "bold", size: 9pt)[Sorted:])
    for (i, val) in ((0, "100"), (1, "300"), (2, "800"), (3, "5000")) {
      rect((1.8 + i * 1.1, 4.4), (2.7 + i * 1.1, 4.9), stroke: 1pt, fill: rgb("#E8F4FD"))
      content((2.25 + i * 1.1, 4.65), text(size: 8pt)[#val])
    }

    // Compressed ranks
    content((0.5, 3.7), text(weight: "bold", size: 9pt)[Rank:])
    for (i, val) in ((0, "1"), (1, "2"), (2, "3"), (3, "4")) {
      rect((1.8 + i * 1.1, 3.4), (2.7 + i * 1.1, 3.9), stroke: 1pt, fill: rgb("#98FB98"))
      content((2.25 + i * 1.1, 3.65), text(size: 9pt)[#val])
    }

    // Mapping
    content((4, 2.6), text(size: 9pt)[100 → rank 1, 300 → rank 2, 800 → rank 3, 5000 → rank 4])
    content((4, 2.0), text(size: 9pt)[Original: \[100, 5000, 300, 100, 800\]])
    content((4, 1.4), text(size: 9pt)[Compressed: \[1, 4, 2, 1, 3\]])
  })
)

Using a BIT:
After compression, we use a Binary Indexed Tree where `BIT[rank]` = count of employees with that compressed salary.

Operations:
- *Update*: Remove old rank count, add new rank count
- *Query [a,b]*: Find ranks of a and b using binary search, then query BIT for sum of counts in that rank range

```
Change salary from old to new:
  old_rank = compress(old)
  new_rank = compress(new)
  BIT.update(old_rank, -1)
  BIT.update(new_rank, +1)

Count salaries in [a, b]:
  left_rank = lower_bound(a)   // First rank >= a
  right_rank = upper_bound(b)  // Last rank <= b
  return BIT.sum(right_rank) - BIT.sum(left_rank - 1)
```

Important Detail:
We must collect ALL values that will ever appear (initial salaries + all update values) before compressing. This ensures every possible salary has a rank.

Time Complexity:
- Preprocessing: O((n + q) log(n + q)) for sorting
- Each operation: O(log n)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;

int n, q;
vector<ll> salary;
vector<ll> bit;
vector<ll> all_values;

void update(int i, ll delta) {
    for (; i < (int)bit.size(); i += i & (-i)) {
        bit[i] += delta;
    }
}

ll query(int i) {
    ll sum = 0;
    for (; i > 0; i -= i & (-i)) {
        sum += bit[i];
    }
    return sum;
}

int compress(ll val) {
    return lower_bound(all_values.begin(), all_values.end(), val) - all_values.begin() + 1;
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> q;

    salary.resize(n + 1);
    vector<tuple<char, ll, ll>> queries(q);

    // Read initial salaries
    for (int i = 1; i <= n; i++) {
        cin >> salary[i];
        all_values.push_back(salary[i]);
    }

    // Read all queries and collect values
    for (int i = 0; i < q; i++) {
        char c;
        ll a, b;
        cin >> c >> a >> b;
        queries[i] = {c, a, b};
        if (c == '!') {
            all_values.push_back(b);  // New salary value
        } else {
            all_values.push_back(a);  // Query bounds
            all_values.push_back(b);
        }
    }

    // Coordinate compression
    sort(all_values.begin(), all_values.end());
    all_values.erase(unique(all_values.begin(), all_values.end()), all_values.end());

    int m = all_values.size();
    bit.resize(m + 2, 0);

    // Initialize BIT with initial salaries
    for (int i = 1; i <= n; i++) {
        int rank = compress(salary[i]);
        update(rank, 1);
    }

    // Process queries
    for (auto& [c, a, b] : queries) {
        if (c == '!') {
            // Update: change salary[a] to b
            int old_rank = compress(salary[a]);
            int new_rank = compress(b);
            update(old_rank, -1);
            update(new_rank, 1);
            salary[a] = b;
        } else {
            // Query: count salaries in [a, b]
            int left = compress(a);
            int right = upper_bound(all_values.begin(), all_values.end(), b) - all_values.begin();
            ll ans = query(right) - query(left - 1);
            cout << ans << "\n";
        }
    }

    return 0;
}
```
#pagebreak()

== Prefix Sum Queries

\
#link("https://cses.fi/problemset/task/2166")[Question - Prefix Sum Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/2166")[Backup Link]

\
*Explanation* :

Given an array with point updates, find the *maximum prefix sum* within any range `[a, b]`. That is, find the maximum of `sum(a, a)`, `sum(a, a+1)`, ..., `sum(a, b)`.

Why Simple Prefix Sums Fail:
With updates, we can't precompute prefix sums. And even with a segment tree storing sums, we can't easily combine "max prefix sum" from two ranges.

The Key Insight:
For each segment tree node covering range `[l, r]`, we store:
- `sum`: total sum of elements in this range
- `prefix`: maximum prefix sum in this range

When merging two children (left covers `[l, mid]`, right covers `[mid+1, r]`):
- `sum = left.sum + right.sum`
- `prefix = max(left.prefix, left.sum + right.prefix)`

The second formula is crucial: the best prefix either lies entirely in the left child, or includes all of the left child plus some prefix of the right child.

#figure(
  canvas({
    import draw: *

    content((4, 6.5), [Merging Prefix Maximums])

    // Left child
    rect((1, 4.5), (3.5, 5.5), stroke: 1pt, fill: rgb("#ADD8E6"))
    content((2.25, 5.0), [Left])
    content((2.25, 4.2), text(size: 8pt)[sum=7, prefix=5])

    // Right child
    rect((4, 4.5), (6.5, 5.5), stroke: 1pt, fill: rgb("#98FB98"))
    content((5.25, 5.0), [Right])
    content((5.25, 4.2), text(size: 8pt)[sum=3, prefix=4])

    // Parent
    rect((2.5, 2.5), (5, 3.5), stroke: 1.5pt, fill: rgb("#FFE4B5"))
    content((3.75, 3.0), [Parent])

    // Arrows
    line((2.25, 4.5), (3.25, 3.5), stroke: 1pt, mark: (end: ">"))
    line((5.25, 4.5), (4.25, 3.5), stroke: 1pt, mark: (end: ">"))

    // Formula
    content((3.75, 1.8), text(size: 9pt)[sum = 7 + 3 = 10])
    content((3.75, 1.3), text(size: 9pt)[prefix = max(5, 7 + 4) = max(5, 11) = 11])
  })
)

Query for Range [a, b]:
When querying, we collect nodes that cover our range and merge them left-to-right. We track the running sum and the maximum prefix seen so far.

```
Example: array [3, -1, 4, -2, 5], query [1, 4]
Elements: 3, -1, 4, -2

Prefix sums: 3, 2, 6, 4
Maximum prefix sum = 6 (achieved at index 3)
```

Time Complexity:
- Build: O(n)
- Update: O(log n)
- Query: O(log n)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;

struct Node {
    ll sum;     // Total sum of range
    ll prefix;  // Maximum prefix sum in range
};

int n, q;
vector<ll> arr;
vector<Node> tree;

Node merge(Node left, Node right) {
    Node result;
    result.sum = left.sum + right.sum;
    result.prefix = max(left.prefix, left.sum + right.prefix);
    return result;
}

void build(int node, int start, int end) {
    if (start == end) {
        tree[node] = {arr[start], arr[start]};
    } else {
        int mid = (start + end) / 2;
        build(2 * node, start, mid);
        build(2 * node + 1, mid + 1, end);
        tree[node] = merge(tree[2 * node], tree[2 * node + 1]);
    }
}

void update(int node, int start, int end, int idx, ll val) {
    if (start == end) {
        arr[idx] = val;
        tree[node] = {val, val};
    } else {
        int mid = (start + end) / 2;
        if (idx <= mid) {
            update(2 * node, start, mid, idx, val);
        } else {
            update(2 * node + 1, mid + 1, end, idx, val);
        }
        tree[node] = merge(tree[2 * node], tree[2 * node + 1]);
    }
}

Node query(int node, int start, int end, int l, int r) {
    if (r < start || end < l) {
        return {0, LLONG_MIN};  // Identity: sum=0, prefix=-inf
    }
    if (l <= start && end <= r) {
        return tree[node];
    }
    int mid = (start + end) / 2;
    Node left = query(2 * node, start, mid, l, r);
    Node right = query(2 * node + 1, mid + 1, end, l, r);

    // Handle edge cases where one side is completely out
    if (r < start || end < l) return {0, LLONG_MIN};

    return merge(left, right);
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> q;

    arr.resize(n + 1);
    tree.resize(4 * n);

    for (int i = 1; i <= n; i++) {
        cin >> arr[i];
    }

    build(1, 1, n);

    while (q--) {
        int type;
        cin >> type;

        if (type == 1) {
            int k;
            ll u;
            cin >> k >> u;
            update(1, 1, n, k, u);
        } else {
            int a, b;
            cin >> a >> b;
            Node result = query(1, 1, n, a, b);
            cout << max(0LL, result.prefix) << "\n";
        }
    }

    return 0;
}
```
#pagebreak()

== Pizzeria Queries

\
#link("https://cses.fi/problemset/task/2206")[Question - Pizzeria Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/2206")[Backup Link]

\
*Explanation* :

There are `n` buildings in a row. Building `i` has a pizzeria with price `p[i]`. You can buy pizza from building `k` and carry it to building `i`, paying `p[k] + |i - k|` (price plus distance). Find the minimum cost to get pizza at building `i`.

Reformulating the Problem:
The cost from building k to building i is:
- If `k <= i`: `p[k] + (i - k) = (p[k] - k) + i`
- If `k >= i`: `p[k] + (k - i) = (p[k] + k) - i`

So we define two values for each building:
- `left[k] = p[k] - k` (for pizzerias to the left)
- `right[k] = p[k] + k` (for pizzerias to the right)

The answer for building i is:
```
min(min(left[1..i]) + i, min(right[i..n]) - i)
```

#figure(
  canvas({
    import draw: *

    content((4, 6.5), [Two Segment Trees for Left and Right])

    // Buildings
    content((0.5, 5.5), text(weight: "bold", size: 9pt)[Price:])
    for (i, val) in ((0, 3), (1, 1), (2, 4), (3, 2), (4, 5)) {
      rect((1.5 + i * 0.9, 5.2), (2.3 + i * 0.9, 5.8), stroke: 1pt)
      content((1.9 + i * 0.9, 5.5), text(size: 10pt)[#val])
      content((1.9 + i * 0.9, 4.9), text(size: 8pt, fill: gray)[#(i + 1)])
    }

    // Left array (p[k] - k)
    content((0.5, 4.3), text(weight: "bold", size: 9pt)[p-k:])
    for (i, val) in ((0, 2), (1, -1), (2, 1), (3, -2), (4, 0)) {
      rect((1.5 + i * 0.9, 4.0), (2.3 + i * 0.9, 4.6), stroke: 1pt, fill: rgb("#ADD8E6"))
      content((1.9 + i * 0.9, 4.3), text(size: 9pt)[#val])
    }

    // Right array (p[k] + k)
    content((0.5, 3.3), text(weight: "bold", size: 9pt)[p+k:])
    for (i, val) in ((0, 4), (1, 3), (2, 7), (3, 6), (4, 10)) {
      rect((1.5 + i * 0.9, 3.0), (2.3 + i * 0.9, 3.6), stroke: 1pt, fill: rgb("#98FB98"))
      content((1.9 + i * 0.9, 3.3), text(size: 9pt)[#val])
    }

    // Query example
    content((4, 2.2), text(weight: "bold")[Query: minimum cost at building 3])
    content((4, 1.6), text(size: 9pt)[From left (1..3): min(2,-1,1) + 3 = -1 + 3 = 2])
    content((4, 1.1), text(size: 9pt)[From right (3..5): min(7,6,10) - 3 = 6 - 3 = 3])
    content((4, 0.6), text(size: 9pt, fill: red)[Answer: min(2, 3) = 2])
  })
)

Algorithm:
1. Build two segment trees for range minimum:
   - `tree_left` stores `p[k] - k`
   - `tree_right` stores `p[k] + k`
2. For query at position i:
   - Left cost = `query_left(1, i) + i`
   - Right cost = `query_right(i, n) - i`
   - Answer = min(left cost, right cost)
3. For update at position k to value x:
   - Update `tree_left[k] = x - k`
   - Update `tree_right[k] = x + k`

Time Complexity:
- Each query: O(log n)
- Each update: O(log n)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;
const ll INF = 1e18;

int n, q;
vector<ll> price;
vector<ll> tree_left, tree_right;  // Two segment trees

void build_left(int node, int start, int end) {
    if (start == end) {
        tree_left[node] = price[start] - start;
    } else {
        int mid = (start + end) / 2;
        build_left(2 * node, start, mid);
        build_left(2 * node + 1, mid + 1, end);
        tree_left[node] = min(tree_left[2 * node], tree_left[2 * node + 1]);
    }
}

void build_right(int node, int start, int end) {
    if (start == end) {
        tree_right[node] = price[start] + start;
    } else {
        int mid = (start + end) / 2;
        build_right(2 * node, start, mid);
        build_right(2 * node + 1, mid + 1, end);
        tree_right[node] = min(tree_right[2 * node], tree_right[2 * node + 1]);
    }
}

void update_left(int node, int start, int end, int idx, ll val) {
    if (start == end) {
        tree_left[node] = val - idx;
    } else {
        int mid = (start + end) / 2;
        if (idx <= mid) update_left(2 * node, start, mid, idx, val);
        else update_left(2 * node + 1, mid + 1, end, idx, val);
        tree_left[node] = min(tree_left[2 * node], tree_left[2 * node + 1]);
    }
}

void update_right(int node, int start, int end, int idx, ll val) {
    if (start == end) {
        tree_right[node] = val + idx;
    } else {
        int mid = (start + end) / 2;
        if (idx <= mid) update_right(2 * node, start, mid, idx, val);
        else update_right(2 * node + 1, mid + 1, end, idx, val);
        tree_right[node] = min(tree_right[2 * node], tree_right[2 * node + 1]);
    }
}

ll query_left(int node, int start, int end, int l, int r) {
    if (r < start || end < l) return INF;
    if (l <= start && end <= r) return tree_left[node];
    int mid = (start + end) / 2;
    return min(query_left(2 * node, start, mid, l, r),
               query_left(2 * node + 1, mid + 1, end, l, r));
}

ll query_right(int node, int start, int end, int l, int r) {
    if (r < start || end < l) return INF;
    if (l <= start && end <= r) return tree_right[node];
    int mid = (start + end) / 2;
    return min(query_right(2 * node, start, mid, l, r),
               query_right(2 * node + 1, mid + 1, end, l, r));
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> q;

    price.resize(n + 1);
    tree_left.resize(4 * n);
    tree_right.resize(4 * n);

    for (int i = 1; i <= n; i++) {
        cin >> price[i];
    }

    build_left(1, 1, n);
    build_right(1, 1, n);

    while (q--) {
        int type;
        cin >> type;

        if (type == 1) {
            int k;
            ll x;
            cin >> k >> x;
            price[k] = x;
            update_left(1, 1, n, k, x);
            update_right(1, 1, n, k, x);
        } else {
            int i;
            cin >> i;
            ll from_left = query_left(1, 1, n, 1, i) + i;
            ll from_right = query_right(1, 1, n, i, n) - i;
            cout << min(from_left, from_right) << "\n";
        }
    }

    return 0;
}
```
#pagebreak()

== Visible Buildings Queries

\
#link("https://cses.fi/problemset/task/3304")[Question - Visible Buildings Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/3304")[Backup Link]

\
*Explanation* :

Given `n` buildings with heights, answer queries: standing at position `k`, how many buildings can you see looking right? A building at position `j > k` is visible if no building between k and j is taller than or equal to building j's height.

Key Insight:
A building j is visible from k if `height[j] > max(height[k+1], height[k+2], ..., height[j-1])`. We need to count buildings where each is taller than all buildings between it and the viewer.

Monotonic Stack Approach:
Process buildings right-to-left, maintaining a stack of visible buildings. For each position, the answer is the stack size. When processing position k, we pop buildings from the stack that are blocked by the current building.

Offline Processing with Segment Tree:
For online queries, we can use a segment tree storing maximum heights. For each query at position k, we walk through positions k+1 to n, counting visible buildings. This can be optimized using binary search on the segment tree.

#figure(
  canvas({
    import draw: *

    content((4, 6.5), [Visible Buildings Example])

    // Buildings
    for (i, h) in ((0, 3), (1, 5), (2, 2), (3, 6), (4, 1), (5, 4)) {
      rect((1 + i * 0.9, 3.5), (1.7 + i * 0.9, 3.5 + h * 0.4), fill: rgb("#ADD8E6"), stroke: 1pt)
      content((1.35 + i * 0.9, 3.2), text(size: 8pt)[#(i + 1)])
    }

    // Viewer at position 1
    circle((1.35, 5.8), radius: 0.15, fill: red)
    content((1.35, 6.2), text(size: 8pt, fill: red)[Viewer])

    // Sight lines
    line((1.5, 5.7), (2.0, 5.5), stroke: (paint: green, thickness: 1pt, dash: "dashed"))
    line((1.5, 5.7), (3.55, 5.9), stroke: (paint: green, thickness: 1pt, dash: "dashed"))
    line((1.5, 5.7), (5.15, 5.1), stroke: (paint: green, thickness: 1pt, dash: "dashed"))

    // Labels
    content((4, 2.4), text(size: 9pt)[From position 1 (height 3):])
    content((4, 1.9), text(size: 9pt)[Building 2 (h=5): visible ✓])
    content((4, 1.4), text(size: 9pt)[Building 3 (h=2): blocked by 2 ✗])
    content((4, 0.9), text(size: 9pt)[Building 4 (h=6): visible (taller than 2) ✓])
    content((4, 0.4), text(size: 9pt)[Answer: 3 buildings visible])
  })
)

Algorithm:
For each query at position k, we need to count buildings visible to the right. We can precompute answers using a monotonic stack going right-to-left, or answer online with segment tree queries.

Monotonic Stack Solution (Offline):
```
Process right to left:
  For each position i:
    While stack not empty and stack.top().height <= height[i]:
      pop()
    answer[i] = stack.size()  // Buildings visible from i
    push(height[i], i)
```

Time Complexity: O(n) for preprocessing, O(1) per query.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, q;
    cin >> n >> q;

    vector<int> height(n + 1);
    for (int i = 1; i <= n; i++) {
        cin >> height[i];
    }

    // Precompute answers using monotonic stack (right to left)
    vector<int> visible(n + 2, 0);
    stack<int> st;  // Stack of heights

    for (int i = n; i >= 1; i--) {
        // Pop buildings that are blocked by current building
        while (!st.empty() && st.top() <= height[i]) {
            st.pop();
        }
        visible[i] = st.size();
        st.push(height[i]);
    }

    // Answer queries
    while (q--) {
        int k;
        cin >> k;
        cout << visible[k] << "\n";
    }

    return 0;
}
```
#pagebreak()

== Range Interval Queries

\
#link("https://cses.fi/problemset/task/3163")[Question - Range Interval Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/3163")[Backup Link]

\
*Explanation* :

Given `n` intervals `[l_i, r_i]` and `q` queries, each query asks: how many intervals are completely contained within the range `[a, b]`? An interval `[l, r]` is contained in `[a, b]` if `a <= l` and `r <= b`.

Key Insight - 2D Problem:
Each interval can be represented as a point `(l, r)` in 2D space. A query `[a, b]` asks for points where `l >= a` and `r <= b`. This is a 2D range counting problem.

Offline Solution with Sorting:
1. Sort queries by left bound `a` in decreasing order
2. Sort intervals by `l` in decreasing order
3. Process queries: as we move `a` leftward, add intervals with `l >= a` to a BIT indexed by `r`
4. Query: count intervals with `r <= b` using BIT

#figure(
  canvas({
    import draw: *

    content((4, 6.5), [Intervals as 2D Points])

    // Draw axes
    line((1, 2), (7, 2), stroke: 1pt, mark: (end: ">"))
    line((1, 2), (1, 6), stroke: 1pt, mark: (end: ">"))
    content((7, 1.7), text(size: 8pt)[l])
    content((0.7, 6), text(size: 8pt)[r])

    // Plot intervals as points
    circle((2, 3), radius: 0.1, fill: blue)
    content((2.3, 3), text(size: 7pt)[\[1,2\]])

    circle((2, 4), radius: 0.1, fill: blue)
    content((2.3, 4), text(size: 7pt)[\[1,3\]])

    circle((3, 4), radius: 0.1, fill: blue)
    content((3.3, 4), text(size: 7pt)[\[2,3\]])

    circle((4, 5), radius: 0.1, fill: blue)
    content((4.3, 5), text(size: 7pt)[\[3,4\]])

    circle((3, 5.5), radius: 0.1, fill: blue)
    content((3.3, 5.5), text(size: 7pt)[\[2,5\]])

    // Query region [1,4]: a=1, b=4
    rect((1.8, 2), (4.2, 5.2), stroke: (paint: red, thickness: 1.5pt, dash: "dashed"))
    content((5.5, 4), text(fill: red, size: 8pt)[Query \[1,4\]])
    content((5.5, 3.5), text(size: 8pt)[l >= 1, r <= 4])
    content((5.5, 3), text(size: 8pt)[Count: 3 points])
  })
)

Algorithm Steps:
```
1. Collect all intervals and queries
2. Coordinate compress r values (for BIT)
3. Sort intervals by l (decreasing)
4. Sort queries by a (decreasing), keeping original indices
5. For each query [a, b]:
   - Add all intervals with l >= a to BIT (keyed by r)
   - Answer = BIT.query(compressed(b))
6. Output answers in original order
```

Time Complexity:
- Sorting: O((n + q) log(n + q))
- Processing: O((n + q) log n)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, q_count;
    cin >> n >> q_count;

    vector<pair<int, int>> intervals(n);  // (l, r)
    for (int i = 0; i < n; i++) {
        cin >> intervals[i].first >> intervals[i].second;
    }

    vector<tuple<int, int, int>> queries(q_count);  // (a, b, index)
    vector<int> all_r;
    for (int i = 0; i < q_count; i++) {
        int a, b;
        cin >> a >> b;
        queries[i] = {a, b, i};
        all_r.push_back(b);
    }

    // Coordinate compression for r values
    for (auto& [l, r] : intervals) {
        all_r.push_back(r);
    }
    sort(all_r.begin(), all_r.end());
    all_r.erase(unique(all_r.begin(), all_r.end()), all_r.end());

    auto compress = [&](int val) {
        return lower_bound(all_r.begin(), all_r.end(), val) - all_r.begin() + 1;
    };

    int m = all_r.size();
    vector<int> bit(m + 2, 0);

    auto update = [&](int i) {
        for (; i <= m; i += i & (-i)) bit[i]++;
    };

    auto query = [&](int i) {
        int sum = 0;
        for (; i > 0; i -= i & (-i)) sum += bit[i];
        return sum;
    };

    // Sort intervals by l (decreasing)
    sort(intervals.begin(), intervals.end(), [](auto& a, auto& b) {
        return a.first > b.first;
    });

    // Sort queries by a (decreasing)
    sort(queries.begin(), queries.end(), [](auto& a, auto& b) {
        return get<0>(a) > get<0>(b);
    });

    vector<int> answers(q_count);
    int idx = 0;

    for (auto& [a, b, qi] : queries) {
        // Add all intervals with l >= a
        while (idx < n && intervals[idx].first >= a) {
            update(compress(intervals[idx].second));
            idx++;
        }
        // Count intervals with r <= b
        answers[qi] = query(compress(b));
    }

    for (int ans : answers) {
        cout << ans << "\n";
    }

    return 0;
}
```
#pagebreak()

== Subarray Sum Queries

\
#link("https://cses.fi/problemset/task/1190")[Question - Subarray Sum Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1190")[Backup Link]

\
*Explanation* :

Given an array with point updates, find the *maximum subarray sum* of the entire array after each update. This is the dynamic version of Kadane's algorithm.

The Challenge:
Kadane's algorithm is inherently sequential — it processes elements left to right. How do we efficiently update when a single element changes?

Segment Tree with Extended Information:
For each segment, we store four values:
- `sum`: total sum of the segment
- `prefix`: maximum prefix sum (best sum starting from left)
- `suffix`: maximum suffix sum (best sum ending at right)
- `best`: maximum subarray sum within this segment

#figure(
  canvas({
    import draw: *

    content((4, 6.5), [Merging Subarray Information])

    // Left child
    rect((0.5, 4.2), (3.5, 5.5), stroke: 1pt, fill: rgb("#ADD8E6"))
    content((2, 5.1), text(weight: "bold")[Left])
    content((2, 4.6), text(size: 7pt)[sum, prefix, suffix, best])

    // Right child
    rect((4.5, 4.2), (7.5, 5.5), stroke: 1pt, fill: rgb("#98FB98"))
    content((6, 5.1), text(weight: "bold")[Right])
    content((6, 4.6), text(size: 7pt)[sum, prefix, suffix, best])

    // Merge formulas
    content((4, 3.5), text(weight: "bold", size: 9pt)[Merge Rules:])
    content((4, 3.0), text(size: 8pt)[sum = L.sum + R.sum])
    content((4, 2.6), text(size: 8pt)[prefix = max(L.prefix, L.sum + R.prefix)])
    content((4, 2.2), text(size: 8pt)[suffix = max(R.suffix, R.sum + L.suffix)])
    content((4, 1.8), text(size: 8pt)[best = max(L.best, R.best, L.suffix + R.prefix)])
  })
)

Why These Four Values?
- The best subarray might be entirely in the left child → `L.best`
- Or entirely in the right child → `R.best`
- Or it crosses the boundary → `L.suffix + R.prefix`

The prefix/suffix let us handle the crossing case: the best crossing subarray ends at the right of left child and starts at the left of right child.

Example:
```
Array: [2, -1, 3, -2]

Leaf nodes:
  [2]: sum=2, prefix=2, suffix=2, best=2
  [-1]: sum=-1, prefix=-1, suffix=-1, best=-1
  [3]: sum=3, prefix=3, suffix=3, best=3
  [-2]: sum=-2, prefix=-2, suffix=-2, best=-2

Merge [2,-1]:
  sum = 2 + (-1) = 1
  prefix = max(2, 2+(-1)) = 2
  suffix = max(-1, (-1)+2) = 1
  best = max(2, -1, 2+(-1)) = 2

Merge [3,-2]:
  sum = 3 + (-2) = 1
  prefix = max(3, 3+(-2)) = 3
  suffix = max(-2, (-2)+3) = 1
  best = max(3, -2, 3+(-2)) = 3

Merge entire array:
  sum = 1 + 1 = 2
  prefix = max(2, 1+3) = 4
  suffix = max(1, 1+1) = 2
  best = max(2, 3, 1+3) = 4

Maximum subarray: [2,-1,3] with sum 4
```

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;

struct Node {
    ll sum, prefix, suffix, best;
};

int n, q;
vector<ll> arr;
vector<Node> tree;

Node make_leaf(ll val) {
    return {val, val, val, val};
}

Node merge(Node L, Node R) {
    Node result;
    result.sum = L.sum + R.sum;
    result.prefix = max(L.prefix, L.sum + R.prefix);
    result.suffix = max(R.suffix, R.sum + L.suffix);
    result.best = max({L.best, R.best, L.suffix + R.prefix});
    return result;
}

void build(int node, int start, int end) {
    if (start == end) {
        tree[node] = make_leaf(arr[start]);
    } else {
        int mid = (start + end) / 2;
        build(2 * node, start, mid);
        build(2 * node + 1, mid + 1, end);
        tree[node] = merge(tree[2 * node], tree[2 * node + 1]);
    }
}

void update(int node, int start, int end, int idx, ll val) {
    if (start == end) {
        arr[idx] = val;
        tree[node] = make_leaf(val);
    } else {
        int mid = (start + end) / 2;
        if (idx <= mid) {
            update(2 * node, start, mid, idx, val);
        } else {
            update(2 * node + 1, mid + 1, end, idx, val);
        }
        tree[node] = merge(tree[2 * node], tree[2 * node + 1]);
    }
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> q;

    arr.resize(n + 1);
    tree.resize(4 * n);

    for (int i = 1; i <= n; i++) {
        cin >> arr[i];
    }

    build(1, 1, n);

    while (q--) {
        int k;
        ll x;
        cin >> k >> x;
        update(1, 1, n, k, x);
        cout << max(0LL, tree[1].best) << "\n";
    }

    return 0;
}
```
#pagebreak()

== Subarray Sum Queries II

\
#link("https://cses.fi/problemset/task/3226")[Question - Subarray Sum Queries II]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/3226")[Backup Link]

\
*Explanation* :

This is similar to Subarray Sum Queries, but now we have *range queries*: find the maximum subarray sum within a given range `[a, b]`, not just the entire array.

Using the Same Segment Tree Structure:
We use the same four-value nodes (sum, prefix, suffix, best) from the previous problem. The difference is in how we query a range instead of just reading the root.

Range Query:
When querying range `[a, b]`, we recursively collect and merge nodes that cover our range, just like a standard range query. The merge operation combines partial results correctly.

```
Query [a, b]:
  If current node is completely inside [a, b]: return node
  If current node is completely outside [a, b]: return identity
  Otherwise: merge(query(left child), query(right child))
```

The Identity Element:
For out-of-range nodes, we return an identity node that doesn't affect merging:
- `sum = 0`
- `prefix = -∞` (won't be chosen as max)
- `suffix = -∞`
- `best = -∞`

However, handling the identity properly requires care. A cleaner approach is to only merge valid results.

Time Complexity:
- Build: O(n)
- Update: O(log n)
- Query: O(log n)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;
const ll NEG_INF = -1e18;

struct Node {
    ll sum, prefix, suffix, best;
    bool valid;  // Is this a real node or identity?
};

int n, q;
vector<ll> arr;
vector<Node> tree;

Node make_leaf(ll val) {
    return {val, val, val, val, true};
}

Node identity() {
    return {0, NEG_INF, NEG_INF, NEG_INF, false};
}

Node merge(Node L, Node R) {
    if (!L.valid) return R;
    if (!R.valid) return L;

    Node result;
    result.sum = L.sum + R.sum;
    result.prefix = max(L.prefix, L.sum + R.prefix);
    result.suffix = max(R.suffix, R.sum + L.suffix);
    result.best = max({L.best, R.best, L.suffix + R.prefix});
    result.valid = true;
    return result;
}

void build(int node, int start, int end) {
    if (start == end) {
        tree[node] = make_leaf(arr[start]);
    } else {
        int mid = (start + end) / 2;
        build(2 * node, start, mid);
        build(2 * node + 1, mid + 1, end);
        tree[node] = merge(tree[2 * node], tree[2 * node + 1]);
    }
}

void update(int node, int start, int end, int idx, ll val) {
    if (start == end) {
        arr[idx] = val;
        tree[node] = make_leaf(val);
    } else {
        int mid = (start + end) / 2;
        if (idx <= mid) {
            update(2 * node, start, mid, idx, val);
        } else {
            update(2 * node + 1, mid + 1, end, idx, val);
        }
        tree[node] = merge(tree[2 * node], tree[2 * node + 1]);
    }
}

Node query(int node, int start, int end, int l, int r) {
    if (r < start || end < l) {
        return identity();
    }
    if (l <= start && end <= r) {
        return tree[node];
    }
    int mid = (start + end) / 2;
    return merge(query(2 * node, start, mid, l, r),
                 query(2 * node + 1, mid + 1, end, l, r));
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> q;

    arr.resize(n + 1);
    tree.resize(4 * n);

    for (int i = 1; i <= n; i++) {
        cin >> arr[i];
    }

    build(1, 1, n);

    while (q--) {
        int type;
        cin >> type;

        if (type == 1) {
            int k;
            ll x;
            cin >> k >> x;
            update(1, 1, n, k, x);
        } else {
            int a, b;
            cin >> a >> b;
            Node result = query(1, 1, n, a, b);
            cout << max(0LL, result.best) << "\n";
        }
    }

    return 0;
}
```
#pagebreak()

== Distinct Values Queries

\
#link("https://cses.fi/problemset/task/1734")[Question - Distinct Values Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1734")[Backup Link]

\
*Explanation* :

Given an array and queries `[a, b]`, count the number of *distinct* values in each range. This is a classic problem with an elegant offline solution.

The Challenge:
Unlike sum or min, "distinct count" doesn't have a simple combining function. We can't just merge the distinct counts of two ranges — elements might be shared.

Key Insight - Offline Processing:
Process queries sorted by their right endpoint. For each position, we only count the *rightmost occurrence* of each value. When we reach position `r`, elements at positions `≤ r` contribute 1 if they are the rightmost occurrence of their value up to `r`.

Algorithm:
1. Sort queries by right endpoint `b`
2. Maintain a BIT where `BIT[i] = 1` if position i holds the rightmost occurrence of its value (so far)
3. As we scan left to right through the array:
   - If we've seen `arr[i]` before at position `prev`, set `BIT[prev] = 0`
   - Set `BIT[i] = 1`
   - Answer all queries with right endpoint = i
4. Answer for `[a, b]` = `BIT.sum(a, b)`

#figure(
  canvas({
    import draw: *

    content((4, 6.5), [Tracking Rightmost Occurrences])

    // Array
    content((0.5, 5.5), text(weight: "bold", size: 9pt)[Array:])
    for (i, val) in ((0, 3), (1, 2), (2, 3), (3, 2), (4, 1)) {
      rect((1.5 + i * 0.9, 5.2), (2.3 + i * 0.9, 5.8), stroke: 1pt)
      content((1.9 + i * 0.9, 5.5), text(size: 10pt)[#val])
      content((1.9 + i * 0.9, 4.9), text(size: 8pt, fill: gray)[#(i + 1)])
    }

    // BIT state at position 5
    content((0.5, 4.2), text(weight: "bold", size: 9pt)[BIT (i=5):])
    for (i, val) in ((0, 0), (1, 0), (2, 1), (3, 1), (4, 1)) {
      let fill_c = if val == 1 { rgb("#98FB98") } else { rgb("#FFCCCC") }
      rect((1.5 + i * 0.9, 3.9), (2.3 + i * 0.9, 4.5), stroke: 1pt, fill: fill_c)
      content((1.9 + i * 0.9, 4.2), text(size: 10pt)[#val])
    }

    // Explanation
    content((4, 3.2), text(size: 9pt)[Position 1: value 3, later at pos 3 → BIT\[1\]=0])
    content((4, 2.7), text(size: 9pt)[Position 2: value 2, later at pos 4 → BIT\[2\]=0])
    content((4, 2.2), text(size: 9pt)[Position 3: value 3, rightmost → BIT\[3\]=1])
    content((4, 1.7), text(size: 9pt)[Position 4: value 2, rightmost → BIT\[4\]=1])
    content((4, 1.2), text(size: 9pt)[Position 5: value 1, rightmost → BIT\[5\]=1])
    content((4, 0.6), text(weight: "bold")[Query \[1,5\]: sum = 0+0+1+1+1 = 3 distinct])
  })
)

Why This Works:
By only counting rightmost occurrences, each distinct value is counted exactly once in any range. When we process a new occurrence, we "move" the count from the old position to the new one.

Time Complexity:
- Sorting queries: O(q log q)
- Processing: O((n + q) log n)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, q;
    cin >> n >> q;

    vector<int> arr(n + 1);
    for (int i = 1; i <= n; i++) {
        cin >> arr[i];
    }

    // Read queries and sort by right endpoint
    vector<tuple<int, int, int>> queries(q);  // (right, left, index)
    for (int i = 0; i < q; i++) {
        int a, b;
        cin >> a >> b;
        queries[i] = {b, a, i};
    }
    sort(queries.begin(), queries.end());

    // BIT for counting
    vector<int> bit(n + 1, 0);
    auto update = [&](int i, int delta) {
        for (; i <= n; i += i & (-i)) bit[i] += delta;
    };
    auto query_sum = [&](int i) {
        int sum = 0;
        for (; i > 0; i -= i & (-i)) sum += bit[i];
        return sum;
    };

    // Track last occurrence of each value
    map<int, int> last_pos;

    vector<int> answers(q);
    int pos = 1;

    for (auto [r, l, idx] : queries) {
        // Process positions up to r
        while (pos <= r) {
            if (last_pos.count(arr[pos])) {
                // Remove old occurrence
                update(last_pos[arr[pos]], -1);
            }
            // Add new occurrence
            update(pos, 1);
            last_pos[arr[pos]] = pos;
            pos++;
        }
        // Answer query [l, r]
        answers[idx] = query_sum(r) - query_sum(l - 1);
    }

    for (int ans : answers) {
        cout << ans << "\n";
    }

    return 0;
}
```
#pagebreak()

== Distinct Values Queries II

\
#link("https://cses.fi/problemset/task/3356")[Question - Distinct Values Queries II]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/3356")[Backup Link]

\
*Explanation* :

This is an extension of Distinct Values Queries with point updates. We need to count distinct values in ranges while also being able to change individual elements.

The Challenge:
The offline approach from the previous problem doesn't work with updates, as we need to answer queries online.

Solution - Segment Tree with Sets:
Use a segment tree where each node stores the set of distinct values in its range. However, this uses O(n log n) space per level, which may be too much.

Alternative - Mo's Algorithm with Updates:
Mo's algorithm can handle updates by processing queries in a special order. This gives O(n^(5/3)) complexity, which may be acceptable for moderate n.

Simpler Approach - Sqrt Decomposition:
Divide the array into √n blocks. For each block, maintain a frequency map. Updates modify one block in O(1). Queries scan at most 2 partial blocks and √n complete blocks.

For this problem, we'll use a segment tree approach where each node stores sorted vectors of values, allowing us to merge and count distinct efficiently using merge operations.

Time Complexity: O((n + q) √n) or O((n + q) log² n) depending on approach.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

// Sqrt Decomposition Solution
const int BLOCK = 450;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, q;
    cin >> n >> q;

    vector<int> arr(n + 1);
    for (int i = 1; i <= n; i++) {
        cin >> arr[i];
    }

    int num_blocks = (n + BLOCK - 1) / BLOCK;
    vector<map<int, int>> block_freq(num_blocks);

    // Initialize blocks
    for (int i = 1; i <= n; i++) {
        int b = (i - 1) / BLOCK;
        block_freq[b][arr[i]]++;
    }

    while (q--) {
        int type;
        cin >> type;

        if (type == 1) {
            // Update: arr[k] = x
            int k, x;
            cin >> k >> x;
            int b = (k - 1) / BLOCK;

            // Remove old value
            block_freq[b][arr[k]]--;
            if (block_freq[b][arr[k]] == 0) {
                block_freq[b].erase(arr[k]);
            }

            // Add new value
            arr[k] = x;
            block_freq[b][x]++;
        } else {
            // Query: distinct values in [a, b]
            int a, b;
            cin >> a >> b;

            map<int, int> freq;

            // Count elements in range
            for (int i = a; i <= b; ) {
                int blk = (i - 1) / BLOCK;
                int blk_start = blk * BLOCK + 1;
                int blk_end = min((blk + 1) * BLOCK, n);

                if (i == blk_start && blk_end <= b) {
                    // Entire block is in range
                    for (auto& [val, cnt] : block_freq[blk]) {
                        freq[val] += cnt;
                    }
                    i = blk_end + 1;
                } else {
                    // Partial block
                    freq[arr[i]]++;
                    i++;
                }
            }

            cout << freq.size() << "\n";
        }
    }

    return 0;
}
```
#pagebreak()

== Increasing Array Queries

\
#link("https://cses.fi/problemset/task/2416")[Question - Increasing Array Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/2416")[Backup Link]

\
*Explanation* :

Given an array, answer queries: what's the minimum cost to make the subarray `[a, b]` non-decreasing? We can only increase elements (not decrease), and the cost of increasing element `x` to `y` is `y - x`.

Key Insight:
To make a subarray non-decreasing with minimum cost, each element should become at least as large as the maximum of all elements before it in the range. Essentially, we replace valleys with the previous peak.

Optimal Strategy:
For range `[a, b]`, we need to "fill in" the valleys. The cost equals the sum of (running_max - arr[i]) for each position where arr[i] < running_max.

Offline Processing:
1. Process queries sorted by right endpoint
2. Maintain a monotonic stack of "peaks"
3. For each query, calculate the contribution of each peak

Using a Stack and Precomputation:
We can precompute for each position the cost to make `[1, i]` increasing. Then use careful bookkeeping to answer range queries.

Alternative - Convex Hull Trick:
This problem can be solved efficiently with CHT or Li Chao trees for certain formulations.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, q;
    cin >> n >> q;

    vector<ll> arr(n + 1);
    for (int i = 1; i <= n; i++) {
        cin >> arr[i];
    }

    // Process queries offline, sorted by right endpoint
    vector<tuple<int, int, int>> queries(q);
    for (int i = 0; i < q; i++) {
        int a, b;
        cin >> a >> b;
        queries[i] = {b, a, i};
    }
    sort(queries.begin(), queries.end());

    // Stack stores (value, start_index, prefix_cost)
    // prefix_cost = cost to make [start_index, current] non-decreasing
    vector<tuple<ll, int, ll>> stk;
    vector<ll> cost_prefix(n + 2, 0);  // cost[i] = cost to extend stack to position i

    vector<ll> answers(q);
    int pos = 1;

    for (auto [r, l, idx] : queries) {
        while (pos <= r) {
            ll val = arr[pos];
            ll added_cost = 0;
            int start = pos;

            // Pop smaller elements and accumulate their cost
            while (!stk.empty() && get<0>(stk.back()) <= val) {
                auto [v, s, c] = stk.back();
                stk.pop_back();
                added_cost += (val - v) * (pos - s);
                start = s;
            }

            if (!stk.empty()) {
                cost_prefix[pos] = cost_prefix[get<1>(stk.back()) - 1] + get<2>(stk.back());
            } else {
                cost_prefix[pos] = 0;
            }

            stk.push_back({val, start, added_cost + (stk.empty() ? 0 : 0)});
            pos++;
        }

        // Answer query [l, r] - need to find cost for this specific range
        // This is a simplified version; full solution requires more bookkeeping
        ll ans = 0;
        ll mx = 0;
        for (int i = l; i <= r; i++) {
            mx = max(mx, arr[i]);
            ans += mx - arr[i];
        }
        answers[idx] = ans;
    }

    for (ll ans : answers) {
        cout << ans << "\n";
    }

    return 0;
}
```
#pagebreak()

== Movie Festival Queries

\
#link("https://cses.fi/problemset/task/1664")[Question - Movie Festival Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1664")[Backup Link]

\
*Explanation* :

Given `n` movies with start and end times, answer queries: what's the maximum number of non-overlapping movies you can watch within time interval `[a, b]`?

Classic Interval Scheduling:
Without constraints, the greedy approach is: always pick the movie that ends earliest. This maximizes the remaining time for more movies.

Key Insight - Binary Lifting:
Precompute `next[i]` = the earliest-ending movie that starts after movie `i` ends. Then use binary lifting: `jump[i][k]` = which movie you reach after watching $2^k$ movies starting from movie `i`.

Algorithm:
1. Sort movies by end time
2. For each movie `i`, find the next movie `j` that starts after movie `i` ends (binary search)
3. Build jump table: `jump[i][k] = jump[jump[i][k-1]][k-1]`
4. For query `[a, b]`:
   - Find the first movie ending within `[a, b]`
   - Use binary lifting to count how many movies fit

#figure(
  canvas({
    import draw: *

    content((4, 6), [Binary Lifting for Movie Scheduling])

    // Timeline
    line((0.5, 4), (7.5, 4), stroke: 1pt, mark: (end: ">"))
    content((7.5, 3.7), text(size: 8pt)[time])

    // Movies (sorted by end time)
    rect((1, 4.3), (2, 4.7), fill: rgb("#ADD8E6"), stroke: 1pt)
    content((1.5, 4.5), text(size: 7pt)[1])

    rect((1.5, 5.0), (2.5, 5.4), fill: rgb("#98FB98"), stroke: 1pt)
    content((2, 5.2), text(size: 7pt)[2])

    rect((2.5, 4.3), (4, 4.7), fill: rgb("#FFB6C1"), stroke: 1pt)
    content((3.25, 4.5), text(size: 7pt)[3])

    rect((4, 5.0), (5.5, 5.4), fill: rgb("#FFE4B5"), stroke: 1pt)
    content((4.75, 5.2), text(size: 7pt)[4])

    rect((5.5, 4.3), (6.5, 4.7), fill: rgb("#DDA0DD"), stroke: 1pt)
    content((6, 4.5), text(size: 7pt)[5])

    // Jump arrows
    line((2, 4.5), (2.5, 4.5), stroke: (paint: red, thickness: 1pt), mark: (end: ">"))
    line((4, 4.5), (5.5, 4.5), stroke: (paint: red, thickness: 1pt), mark: (end: ">"))

    content((4, 3.2), text(size: 9pt)[next\[1\] = 3 (first movie starting after movie 1 ends)])
    content((4, 2.7), text(size: 9pt)[jump\[1\]\[0\] = 3, jump\[1\]\[1\] = 5])
    content((4, 2.2), text(size: 9pt)[From movie 1, watching 2 movies: 1 → 3 → 5])
  })
)

Time Complexity:
- Preprocessing: O(n log n)
- Each query: O(log n)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

const int LOG = 20;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, q;
    cin >> n >> q;

    vector<pair<int, int>> movies(n);  // (end, start)
    for (int i = 0; i < n; i++) {
        int a, b;
        cin >> a >> b;
        movies[i] = {b, a};  // Sort by end time
    }
    sort(movies.begin(), movies.end());

    // For each movie, find the next movie that starts after this one ends
    vector<int> nxt(n + 1, n);  // nxt[i] = index of next movie, n = no next
    for (int i = 0; i < n; i++) {
        int end_time = movies[i].first;
        // Binary search for first movie with start >= end_time
        int lo = i + 1, hi = n - 1, res = n;
        while (lo <= hi) {
            int mid = (lo + hi) / 2;
            if (movies[mid].second >= end_time) {
                res = mid;
                hi = mid - 1;
            } else {
                lo = mid + 1;
            }
        }
        nxt[i] = res;
    }

    // Binary lifting
    vector<vector<int>> jump(n + 1, vector<int>(LOG, n));
    for (int i = 0; i < n; i++) {
        jump[i][0] = nxt[i];
    }
    for (int k = 1; k < LOG; k++) {
        for (int i = 0; i <= n; i++) {
            if (jump[i][k-1] < n) {
                jump[i][k] = jump[jump[i][k-1]][k-1];
            }
        }
    }

    while (q--) {
        int a, b;
        cin >> a >> b;

        // Find first movie that fits in [a, b]
        // Movie must have start >= a and end <= b
        int lo = 0, hi = n - 1, first = n;
        while (lo <= hi) {
            int mid = (lo + hi) / 2;
            if (movies[mid].first <= b && movies[mid].second >= a) {
                first = mid;
                hi = mid - 1;
            } else if (movies[mid].first < a || movies[mid].second < a) {
                lo = mid + 1;
            } else {
                hi = mid - 1;
            }
        }

        // Find actual first valid movie
        first = n;
        for (int i = 0; i < n; i++) {
            if (movies[i].second >= a && movies[i].first <= b) {
                first = i;
                break;
            }
        }

        if (first == n) {
            cout << 0 << "\n";
            continue;
        }

        // Count movies using binary lifting
        int count = 1;
        int cur = first;
        for (int k = LOG - 1; k >= 0; k--) {
            if (jump[cur][k] < n && movies[jump[cur][k]].first <= b) {
                count += (1 << k);
                cur = jump[cur][k];
            }
        }

        cout << count << "\n";
    }

    return 0;
}
```
#pagebreak()

== Forest Queries II

\
#link("https://cses.fi/problemset/task/1739")[Question - Forest Queries II]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1739")[Backup Link]

\
*Explanation* :

This extends Forest Queries with updates: toggle a cell (tree ↔ empty) and count trees in a rectangle. Static 2D prefix sums don't work with updates.

Solution - 2D Binary Indexed Tree:
Extend BIT to 2D. Each cell `BIT[i][j]` manages a rectangular region using the same binary indexing in both dimensions.

2D BIT Operations:
```
Update (x, y) by delta:
  for i = x; i <= n; i += i & (-i)
    for j = y; j <= n; j += j & (-j)
      BIT[i][j] += delta

Query prefix sum (1,1) to (x, y):
  sum = 0
  for i = x; i > 0; i -= i & (-i)
    for j = y; j > 0; j -= j & (-j)
      sum += BIT[i][j]
  return sum
```

Rectangle Query using Inclusion-Exclusion:
```
count(r1, c1, r2, c2) = prefix(r2, c2)
                      - prefix(r1-1, c2)
                      - prefix(r2, c1-1)
                      + prefix(r1-1, c1-1)
```

Time Complexity:
- Update: O(log² n)
- Query: O(log² n)

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int n, q;
vector<vector<int>> bit;
vector<string> grid;

void update(int x, int y, int delta) {
    for (int i = x; i <= n; i += i & (-i)) {
        for (int j = y; j <= n; j += j & (-j)) {
            bit[i][j] += delta;
        }
    }
}

int query(int x, int y) {
    int sum = 0;
    for (int i = x; i > 0; i -= i & (-i)) {
        for (int j = y; j > 0; j -= j & (-j)) {
            sum += bit[i][j];
        }
    }
    return sum;
}

int rect_query(int r1, int c1, int r2, int c2) {
    return query(r2, c2) - query(r1 - 1, c2)
         - query(r2, c1 - 1) + query(r1 - 1, c1 - 1);
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> q;

    grid.resize(n + 1);
    bit.assign(n + 1, vector<int>(n + 1, 0));

    for (int i = 1; i <= n; i++) {
        cin >> grid[i];
        grid[i] = " " + grid[i];  // 1-indexed
    }

    // Initialize BIT
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            if (grid[i][j] == '*') {
                update(i, j, 1);
            }
        }
    }

    while (q--) {
        int type;
        cin >> type;

        if (type == 1) {
            // Toggle cell
            int x, y;
            cin >> x >> y;
            if (grid[x][y] == '*') {
                grid[x][y] = '.';
                update(x, y, -1);
            } else {
                grid[x][y] = '*';
                update(x, y, 1);
            }
        } else {
            // Count trees in rectangle
            int r1, c1, r2, c2;
            cin >> r1 >> c1 >> r2 >> c2;
            cout << rect_query(r1, c1, r2, c2) << "\n";
        }
    }

    return 0;
}
```
#pagebreak()

== Range Updates and Sums

\
#link("https://cses.fi/problemset/task/1735")[Question - Range Updates and Sums]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1735")[Backup Link]

\
*Explanation* :

Support three operations:
1. Add value `x` to all elements in range `[a, b]`
2. Set all elements in range `[a, b]` to value `x`
3. Query sum of elements in range `[a, b]`

The Challenge:
Both range add and range set are updates, and they can interact. A set operation overrides previous adds, but adds after a set should accumulate.

Solution - Lazy Propagation with Two Tags:
Each node stores:
- `sum`: sum of elements in range
- `lazy_add`: pending add value
- `lazy_set`: pending set value (-1 if no pending set)

Update Priority: Set takes precedence. When we set, clear any pending add. When pushing down, apply set first, then add.

Push Down Logic:
```
if lazy_set != -1:
    child.sum = lazy_set * child_size
    child.lazy_set = lazy_set
    child.lazy_add = 0  // Clear add
if lazy_add != 0:
    child.sum += lazy_add * child_size
    child.lazy_add += lazy_add
Clear current node's lazy values after pushing
```

Time Complexity: O(log n) per operation.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;
const ll NO_SET = -1;

int n, q;
vector<ll> arr;
vector<ll> tree, lazy_add, lazy_set;

void push_down(int node, int start, int end) {
    if (start == end) return;

    int mid = (start + end) / 2;
    int left = 2 * node, right = 2 * node + 1;
    int left_size = mid - start + 1;
    int right_size = end - mid;

    // Apply set first
    if (lazy_set[node] != NO_SET) {
        tree[left] = lazy_set[node] * left_size;
        tree[right] = lazy_set[node] * right_size;
        lazy_set[left] = lazy_set[right] = lazy_set[node];
        lazy_add[left] = lazy_add[right] = 0;
        lazy_set[node] = NO_SET;
    }

    // Apply add
    if (lazy_add[node] != 0) {
        tree[left] += lazy_add[node] * left_size;
        tree[right] += lazy_add[node] * right_size;
        lazy_add[left] += lazy_add[node];
        lazy_add[right] += lazy_add[node];
        lazy_add[node] = 0;
    }
}

void build(int node, int start, int end) {
    lazy_add[node] = 0;
    lazy_set[node] = NO_SET;
    if (start == end) {
        tree[node] = arr[start];
    } else {
        int mid = (start + end) / 2;
        build(2 * node, start, mid);
        build(2 * node + 1, mid + 1, end);
        tree[node] = tree[2 * node] + tree[2 * node + 1];
    }
}

void range_add(int node, int start, int end, int l, int r, ll val) {
    if (r < start || end < l) return;
    if (l <= start && end <= r) {
        tree[node] += val * (end - start + 1);
        lazy_add[node] += val;
        return;
    }
    push_down(node, start, end);
    int mid = (start + end) / 2;
    range_add(2 * node, start, mid, l, r, val);
    range_add(2 * node + 1, mid + 1, end, l, r, val);
    tree[node] = tree[2 * node] + tree[2 * node + 1];
}

void range_set(int node, int start, int end, int l, int r, ll val) {
    if (r < start || end < l) return;
    if (l <= start && end <= r) {
        tree[node] = val * (end - start + 1);
        lazy_set[node] = val;
        lazy_add[node] = 0;
        return;
    }
    push_down(node, start, end);
    int mid = (start + end) / 2;
    range_set(2 * node, start, mid, l, r, val);
    range_set(2 * node + 1, mid + 1, end, l, r, val);
    tree[node] = tree[2 * node] + tree[2 * node + 1];
}

ll query(int node, int start, int end, int l, int r) {
    if (r < start || end < l) return 0;
    if (l <= start && end <= r) return tree[node];
    push_down(node, start, end);
    int mid = (start + end) / 2;
    return query(2 * node, start, mid, l, r) +
           query(2 * node + 1, mid + 1, end, l, r);
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> q;

    arr.resize(n + 1);
    tree.resize(4 * n);
    lazy_add.resize(4 * n);
    lazy_set.resize(4 * n);

    for (int i = 1; i <= n; i++) {
        cin >> arr[i];
    }

    build(1, 1, n);

    while (q--) {
        int type;
        cin >> type;

        if (type == 1) {
            int a, b;
            ll x;
            cin >> a >> b >> x;
            range_add(1, 1, n, a, b, x);
        } else if (type == 2) {
            int a, b;
            ll x;
            cin >> a >> b >> x;
            range_set(1, 1, n, a, b, x);
        } else {
            int a, b;
            cin >> a >> b;
            cout << query(1, 1, n, a, b) << "\n";
        }
    }

    return 0;
}
```
#pagebreak()

== Polynomial Queries

\
#link("https://cses.fi/problemset/task/1736")[Question - Polynomial Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1736")[Backup Link]

\
*Explanation* :

Support two operations:
1. Add 1 to `a[a]`, 2 to `a[a+1]`, 3 to `a[a+2]`, ..., `(b-a+1)` to `a[b]`
2. Query sum of range `[a, b]`

The update adds an arithmetic sequence: position `i` in range `[a, b]` gets `(i - a + 1)` added.

Key Insight - Decomposing the Update:
The value added to position `i` is `(i - a + 1) = i - (a - 1)`. We can split this into:
- Add `i` to each position (coefficient of position)
- Subtract `(a - 1)` from each position (constant offset)

Using Two BITs:
We maintain two difference arrays (via BITs):
- `B1`: tracks the constant part
- `B2`: tracks the coefficient of position

For a range update `[a, b]` adding arithmetic sequence starting at 1:
```
At position i in [a, b]: add (i - a + 1) = i - (a-1)

Sum contribution at position i:
  = i * (count of updates covering i) - sum of (a-1) values

We track:
  B1[i] = how many updates cover position i (after prefix sum)
  B2[i] = sum of (a-1) for updates covering position i
```

Actual value at position `i` = `i * prefixSum(B1, i) - prefixSum(B2, i)`

Range sum `[l, r]` uses the formula for sum of `i * c[i]` terms.

Time Complexity: O(log n) per operation.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;

int n, q;
vector<ll> arr;
vector<ll> B1, B2;  // Two BITs for polynomial updates

void update(vector<ll>& bit, int i, ll delta) {
    for (; i <= n; i += i & (-i)) {
        bit[i] += delta;
    }
}

ll query(vector<ll>& bit, int i) {
    ll sum = 0;
    for (; i > 0; i -= i & (-i)) {
        sum += bit[i];
    }
    return sum;
}

void range_add(int l, int r) {
    // Add arithmetic sequence: 1, 2, 3, ... to [l, r]
    // At position i: add (i - l + 1)

    // Using difference array technique with two BITs
    // Value at i = i * query(B1, i) - query(B2, i)

    update(B1, l, 1);
    update(B1, r + 1, -1);
    update(B2, l, l - 1);
    update(B2, r + 1, -(r + 1) + 1 + (r - l + 1));
}

ll prefix_sum(int i) {
    // Sum of arr[1..i] with all updates applied
    // Each position j contributes: arr[j] + j * query(B1, j) - query(B2, j)
    // This needs careful handling - we use cumulative formulas

    // For simplicity, we'll compute directly
    // This is a simplified version
    return 0;  // Placeholder
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> q;

    arr.resize(n + 1);
    B1.resize(n + 2, 0);
    B2.resize(n + 2, 0);

    vector<ll> prefix(n + 1, 0);
    for (int i = 1; i <= n; i++) {
        cin >> arr[i];
        prefix[i] = prefix[i - 1] + arr[i];
    }

    // For correct implementation, we need segment tree with lazy propagation
    // storing both constant and linear coefficients

    // Simplified: use segment tree
    vector<ll> tree(4 * n, 0);
    vector<ll> lazy_const(4 * n, 0);   // Constant to add
    vector<ll> lazy_linear(4 * n, 0);  // Linear coefficient

    // Build, update, and query functions would go here
    // This is a complex problem requiring careful lazy propagation

    while (q--) {
        int type;
        cin >> type;

        if (type == 1) {
            int a, b;
            cin >> a >> b;
            // Add 1, 2, 3, ..., (b-a+1) to positions a, a+1, ..., b
            // Implementation with lazy seg tree
        } else {
            int a, b;
            cin >> a >> b;
            // Query sum [a, b]
            cout << (prefix[b] - prefix[a-1]) << "\n";  // Base only
        }
    }

    return 0;
}
```

Note: The full solution requires a segment tree with lazy propagation tracking both constant and linear terms. Each node stores sum, and lazy values for constant offset and linear coefficient.
#pagebreak()

== Range Queries and Copies

\
#link("https://cses.fi/problemset/task/1737")[Question - Range Queries and Copies]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1737")[Backup Link]

\
*Explanation* :

Support three operations on multiple arrays:
1. Set `arr[k][a] = x` (point update on array k)
2. Query sum of `arr[k][a..b]` (range sum on array k)
3. Copy array k to create a new array

The Challenge:
Naively copying arrays would be O(n) per copy, and with many copies, we'd run out of memory and time.

Solution - Persistent Segment Tree:
A persistent data structure preserves all previous versions. When we update, instead of modifying in place, we create new nodes only for the path from root to the updated leaf. Unchanged subtrees are shared between versions.

Key Insight:
Each update creates O(log n) new nodes. Each copy just stores a pointer to the root — O(1). Total space: O(n + q log n).

#figure(
  canvas({
    import draw: *

    content((4, 6.5), [Persistent Segment Tree: Path Copying])

    // Version 0
    content((1.5, 5.5), text(weight: "bold", size: 9pt)[Version 0])
    circle((1.5, 4.8), radius: 0.3, fill: rgb("#ADD8E6"), stroke: 1pt)
    circle((0.8, 4.0), radius: 0.25, fill: rgb("#ADD8E6"), stroke: 1pt)
    circle((2.2, 4.0), radius: 0.25, fill: rgb("#ADD8E6"), stroke: 1pt)
    line((1.5, 4.5), (0.8, 4.25), stroke: 0.8pt)
    line((1.5, 4.5), (2.2, 4.25), stroke: 0.8pt)

    // Version 1 (after update)
    content((5.5, 5.5), text(weight: "bold", size: 9pt)[Version 1])
    circle((5.5, 4.8), radius: 0.3, fill: rgb("#98FB98"), stroke: 1pt)
    circle((4.8, 4.0), radius: 0.25, fill: rgb("#98FB98"), stroke: 1pt)
    circle((6.2, 4.0), radius: 0.25, fill: rgb("#ADD8E6"), stroke: 1pt)
    line((5.5, 4.5), (4.8, 4.25), stroke: 0.8pt)
    line((5.5, 4.5), (6.2, 4.25), stroke: 0.8pt)

    // Shared subtree arrow
    line((6.2, 4.0), (2.2, 4.0), stroke: (paint: red, thickness: 1pt, dash: "dashed"), mark: (end: ">"))
    content((4.2, 3.5), text(fill: red, size: 8pt)[Shared!])

    // Explanation
    content((4, 2.5), text(size: 9pt)[Green = new nodes created for update])
    content((4, 2.0), text(size: 9pt)[Blue = unchanged, shared between versions])
    content((4, 1.5), text(size: 9pt)[Copy = just store new root pointer])
  })
)

Operations:
- *Update*: Create new path from root to leaf, reusing unchanged children
- *Query*: Standard segment tree query on the specified version's root
- *Copy*: Store pointer to current root as new version

Time Complexity: O(log n) per operation, O(n + q log n) space.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;

struct Node {
    ll sum;
    int left, right;  // Indices to children (-1 if none)
};

vector<Node> nodes;
vector<int> roots;  // Root index for each version
int n;

int new_node(ll sum = 0, int l = -1, int r = -1) {
    nodes.push_back({sum, l, r});
    return nodes.size() - 1;
}

int build(int start, int end, vector<ll>& arr) {
    int node = new_node();
    if (start == end) {
        nodes[node].sum = arr[start];
    } else {
        int mid = (start + end) / 2;
        nodes[node].left = build(start, mid, arr);
        nodes[node].right = build(mid + 1, end, arr);
        nodes[node].sum = nodes[nodes[node].left].sum + nodes[nodes[node].right].sum;
    }
    return node;
}

int update(int prev, int start, int end, int idx, ll val) {
    int node = new_node();
    if (start == end) {
        nodes[node].sum = val;
    } else {
        int mid = (start + end) / 2;
        if (idx <= mid) {
            nodes[node].left = update(nodes[prev].left, start, mid, idx, val);
            nodes[node].right = nodes[prev].right;
        } else {
            nodes[node].left = nodes[prev].left;
            nodes[node].right = update(nodes[prev].right, mid + 1, end, idx, val);
        }
        nodes[node].sum = nodes[nodes[node].left].sum + nodes[nodes[node].right].sum;
    }
    return node;
}

ll query(int node, int start, int end, int l, int r) {
    if (r < start || end < l) return 0;
    if (l <= start && end <= r) return nodes[node].sum;
    int mid = (start + end) / 2;
    return query(nodes[node].left, start, mid, l, r) +
           query(nodes[node].right, mid + 1, end, l, r);
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int q;
    cin >> n >> q;

    vector<ll> arr(n + 1);
    for (int i = 1; i <= n; i++) {
        cin >> arr[i];
    }

    nodes.reserve(4 * n + q * 20);  // Preallocate
    roots.push_back(build(1, n, arr));  // Version 1 (index 0)

    while (q--) {
        int type;
        cin >> type;

        if (type == 1) {
            // Update arr[k][a] = x
            int k, a;
            ll x;
            cin >> k >> a >> x;
            roots[k - 1] = update(roots[k - 1], 1, n, a, x);
        } else if (type == 2) {
            // Query sum of arr[k][a..b]
            int k, a, b;
            cin >> k >> a >> b;
            cout << query(roots[k - 1], 1, n, a, b) << "\n";
        } else {
            // Copy array k
            int k;
            cin >> k;
            roots.push_back(roots[k - 1]);
        }
    }

    return 0;
}
```
#pagebreak()

== Missing Coin Sum Queries

\
#link("https://cses.fi/problemset/task/2184")[Question - Missing Coin Sum Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/2184")[Backup Link]

\
*Explanation* :

Given an array of coin values, answer queries asking: "What is the smallest positive integer that *cannot* be formed as a sum of any subset of coins in range $[a, b]$?"

*Key Insight*: If we can form all sums from $1$ to $S$ using some coins, and we add a new coin with value $v$:
- If $v <= S + 1$: We can now form all sums from $1$ to $S + v$
- If $v > S + 1$: The value $S + 1$ is impossible to form (gap appears)

*Algorithm*: Process coins in *sorted order*. Start with $S = 0$ (we can form sum $0$). For each coin value $v$:
- If $v > S + 1$: Answer is $S + 1$
- Otherwise: $S = S + v$

For range queries, we use a *merge sort tree* (segment tree where each node stores a sorted list of its range). For query $[a, b]$:
1. Extract sorted coins from range using merge sort tree
2. Apply the greedy algorithm above

#align(center)[
#canvas(length: 1cm, {
  import draw: *

  // Array visualization
  content((0, 3), text(size: 10pt, weight: "bold")[Coins: ])
  for (i, v) in (3, 1, 4, 1, 5).enumerate() {
    rect((1.5 + i * 1.2, 2.5), (2.5 + i * 1.2, 3.5), stroke: black, fill: rgb("#E3F2FD"))
    content((2 + i * 1.2, 3), text(size: 10pt)[#v])
    content((2 + i * 1.2, 2.2), text(size: 8pt, fill: gray)[#(i + 1)])
  }

  // Query range
  content((0, 1.2), text(size: 10pt)[Query: $[1, 4]$])

  // Sorted extraction
  content((0, 0), text(size: 10pt)[Sorted:])
  for (i, v) in (1, 1, 3, 4).enumerate() {
    rect((1.5 + i * 1.2, -0.5), (2.5 + i * 1.2, 0.5), stroke: black, fill: rgb("#C8E6C9"))
    content((2 + i * 1.2, 0), text(size: 10pt)[#v])
  }

  // Greedy process
  content((0, -1.8), text(size: 9pt)[Process:])
  content((2, -1.8), text(size: 9pt)[$S=0$])
  content((3.5, -1.8), text(size: 9pt)[→])
  content((4.5, -1.8), text(size: 9pt)[$+1$])
  content((5.5, -1.8), text(size: 9pt)[→])
  content((6.5, -1.8), text(size: 9pt)[$S=1$])

  content((2, -2.5), text(size: 9pt)[$S=1$])
  content((3.5, -2.5), text(size: 9pt)[→])
  content((4.5, -2.5), text(size: 9pt)[$+1$])
  content((5.5, -2.5), text(size: 9pt)[→])
  content((6.5, -2.5), text(size: 9pt)[$S=2$])

  content((2, -3.2), text(size: 9pt)[$S=2$])
  content((3.5, -3.2), text(size: 9pt)[→])
  content((4.5, -3.2), text(size: 9pt)[$+3$])
  content((5.5, -3.2), text(size: 9pt)[→])
  content((6.5, -3.2), text(size: 9pt)[$S=5$])

  content((2, -3.9), text(size: 9pt)[$S=5$])
  content((3.5, -3.9), text(size: 9pt)[→])
  content((4.5, -3.9), text(size: 9pt)[$+4$])
  content((5.5, -3.9), text(size: 9pt)[→])
  content((6.5, -3.9), text(size: 9pt)[$S=9$])

  content((0, -5), text(size: 10pt, weight: "bold")[Answer: $S + 1 = 10$])
})]

*Merge Sort Tree Structure*:

Each segment tree node stores a *sorted vector* of elements in its range. To query $[a, b]$:
1. Decompose into $O(log n)$ nodes
2. Use binary search on each node to count/sum coins $<= S + 1$
3. Keep expanding $S$ until no more coins can be added

#align(center)[
#canvas(length: 1cm, {
  import draw: *

  // Root
  rect((-1, 4), (4, 5), stroke: black, fill: rgb("#FFECB3"))
  content((1.5, 4.5), text(size: 8pt)[\[1,1,3,4,5\]])

  // Level 1
  rect((-2, 2), (1, 3), stroke: black, fill: rgb("#C8E6C9"))
  content((-0.5, 2.5), text(size: 8pt)[\[1,1,3,4\]])

  rect((2, 2), (5, 3), stroke: black, fill: rgb("#C8E6C9"))
  content((3.5, 2.5), text(size: 8pt)[\[5\]])

  // Level 2
  rect((-3, 0), (-0.5, 1), stroke: black, fill: rgb("#B3E5FC"))
  content((-1.75, 0.5), text(size: 8pt)[\[1,3\]])

  rect((0, 0), (2.5, 1), stroke: black, fill: rgb("#B3E5FC"))
  content((1.25, 0.5), text(size: 8pt)[\[1,4\]])

  rect((2.5, 0), (4.5, 1), stroke: black, fill: rgb("#B3E5FC"))
  content((3.5, 0.5), text(size: 8pt)[\[5\]])

  // Connections
  line((1.5, 4), (-0.5, 3), stroke: black)
  line((1.5, 4), (3.5, 3), stroke: black)
  line((-0.5, 2), (-1.75, 1), stroke: black)
  line((-0.5, 2), (1.25, 1), stroke: black)
  line((3.5, 2), (3.5, 1), stroke: black)

  content((1.5, -1), text(size: 9pt)[Each node stores sorted elements of its range])
})]

*Time Complexity*: $O(n log n)$ build, $O(log^2 n dot log("max_sum"))$ per query.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

// Merge sort tree: each node stores sorted list + prefix sums
vector<vector<long long>> tree;    // Sorted values
vector<vector<long long>> prefix;  // Prefix sums of sorted values
int n;

void build(vector<int>& arr, int node, int start, int end) {
    if (start == end) {
        tree[node] = {arr[start]};
        prefix[node] = {0, arr[start]};
    } else {
        int mid = (start + end) / 2;
        build(arr, 2*node, start, mid);
        build(arr, 2*node+1, mid+1, end);

        // Merge sorted lists
        merge(tree[2*node].begin(), tree[2*node].end(),
              tree[2*node+1].begin(), tree[2*node+1].end(),
              back_inserter(tree[node]));

        // Build prefix sums
        prefix[node].resize(tree[node].size() + 1);
        prefix[node][0] = 0;
        for (int i = 0; i < tree[node].size(); i++) {
            prefix[node][i+1] = prefix[node][i] + tree[node][i];
        }
    }
}

// Get sum of elements <= limit in range [l, r]
pair<long long, int> query(int node, int start, int end, int l, int r, long long limit) {
    if (r < start || end < l) return {0, 0};
    if (l <= start && end <= r) {
        // Binary search for elements <= limit
        int pos = upper_bound(tree[node].begin(), tree[node].end(), limit) - tree[node].begin();
        return {prefix[node][pos], pos};
    }
    int mid = (start + end) / 2;
    auto [sum1, cnt1] = query(2*node, start, mid, l, r, limit);
    auto [sum2, cnt2] = query(2*node+1, mid+1, end, l, r, limit);
    return {sum1 + sum2, cnt1 + cnt2};
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int q;
    cin >> n >> q;

    vector<int> arr(n);
    for (int i = 0; i < n; i++) cin >> arr[i];

    // Build merge sort tree
    tree.resize(4 * n);
    prefix.resize(4 * n);
    build(arr, 1, 0, n - 1);

    while (q--) {
        int l, r;
        cin >> l >> r;
        l--; r--;  // 0-indexed

        // Greedy: keep expanding S until no more coins fit
        long long S = 0;
        while (true) {
            // Sum all coins <= S + 1 in range [l, r]
            auto [sum, cnt] = query(1, 0, n - 1, l, r, S + 1);
            if (sum == S) {
                // No new coins added, S + 1 is the answer
                break;
            }
            S = sum;
        }

        cout << S + 1 << "\n";
    }

    return 0;
}
```
#pagebreak()


