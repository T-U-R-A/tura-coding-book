== Dynamic Segment Tree //chap2

#v(0.5em)

So far, we've learned about segment trees that work on arrays of fixed size. But what if the array we need to work with is extremely large? Say we have an array of size $n = 10^9$, but we only need to perform $q = 2 times 10^5$ operations on it. If we tried to build a normal segment tree, we would need to allocate $4 times 10^9$ memory locations, which is around *16 gigabytes* of memory! This is far beyond what competitive programming judges allow (usually 256 MB to 512 MB).

The key insight is that we don't actually need all $4n$ nodes of the segment tree. In fact, with only $q$ operations, we'll only ever touch at most $q times log(n)$ nodes. For $q = 2 times 10^5$ and $n = 10^9$, that's only about $2 times 10^5 times 30 = 6 times 10^6$ nodes - much more manageable!

This is where *dynamic segment trees* come in. Instead of allocating all nodes upfront, we create nodes only when we need them. This is called *lazy allocation* or *on-demand allocation*.

=== How Dynamic Segment Trees Work

In a regular segment tree, each node has two children at fixed positions in an array. In a dynamic segment tree, each node contains pointers to its left and right children. When we create a node, both pointers are initially `nullptr`. We only allocate a child node when we actually need to access it.

Let's see how this looks with a small example. Say we have an array of size $n = 8$ (for visualization purposes), initially all zeros, and we want to:
1. Update position 5 to value 7
2. Update position 2 to value 3
3. Query the sum from position 2 to 6

Here's what the tree looks like after each operation:

#align(center)[
  #text(weight: "bold")[After update(5, 7):]
]

#align(center)[
  #cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // Only the path to index 5 is created
    // Root [1,8]
    circle((0, 0), radius: 0.3, name: "root")
    content("root", [0])
    content((0, -0.6), text(size: 8pt)[[1,8]])
    
    // Right child [5,8]
    circle((2, -1.5), radius: 0.3, name: "r1")
    content("r1", [7])
    content((2, -2.1), text(size: 8pt)[[5,8]])
    line("root", "r1")
    
    // Left child of [5,8] which is [5,6]
    circle((1, -3), radius: 0.3, name: "r1l")
    content("r1l", [7])
    content((1, -3.6), text(size: 8pt)[[5,6]])
    line("r1", "r1l")
    
    // Left child of [5,6] which is [5,5]
    circle((0.5, -4.5), radius: 0.3, name: "leaf")
    content("leaf", [7])
    content((0.5, -5.1), text(size: 8pt)[[5,5]])
    line("r1l", "leaf")
    
    // Show that left child of root doesn't exist
    content((-2, -1.5), text(fill: gray)[nullptr])
    line("root", (-2, -1.5), stroke: (dash: "dashed", paint: gray))
  })
]

Notice how we only created the nodes along the path from the root to position 5. We didn't create any nodes for positions 1-4 or 6-8 because we didn't need them!

#align(center)[
  #text(weight: "bold")[After update(2, 3):]
]

#align(center)[
  #cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // Root [1,8]
    circle((0, 0), radius: 0.3, name: "root")
    content("root", [10])
    content((0, -0.6), text(size: 8pt)[[1,8]])
    
    // Left child [1,4]
    circle((-2, -1.5), radius: 0.3, name: "l1")
    content("l1", [3])
    content((-2, -2.1), text(size: 8pt)[[1,4]])
    line("root", "l1")
    
    // Right child [5,8]
    circle((2, -1.5), radius: 0.3, name: "r1")
    content("r1", [7])
    content((2, -2.1), text(size: 8pt)[[5,8]])
    line("root", "r1")
    
    // Left child of [1,4] which is [1,2]
    circle((-3, -3), radius: 0.3, name: "l1l")
    content("l1l", [3])
    content((-3, -3.6), text(size: 8pt)[[1,2]])
    line("l1", "l1l")
    
    // Right child of [1,2] which is [2,2]
    circle((-2.5, -4.5), radius: 0.3, name: "leaf2")
    content("leaf2", [3])
    content((-2.5, -5.1), text(size: 8pt)[[2,2]])
    line("l1l", "leaf2")
    
    // The rest of the right subtree from before
    circle((1, -3), radius: 0.3, name: "r1l")
    content("r1l", [7])
    content((1, -3.6), text(size: 8pt)[[5,6]])
    line("r1", "r1l")
    
    circle((0.5, -4.5), radius: 0.3, name: "leaf5")
    content("leaf5", [7])
    content((0.5, -5.1), text(size: 8pt)[[5,5]])
    line("r1l", "leaf5")
  })
]

Now we've also created the path to position 2, but we still haven't allocated nodes for positions 1, 3, 4, 6, 7, or 8.

=== Implementation

Here's the structure for a dynamic segment tree node:

```cpp
struct Node {
    int sum;
    Node* left;
    Node* right;
    
    Node() : sum(0), left(nullptr), right(nullptr) {}
};
```

Each node stores:
- `sum`: the sum of elements in this node's range
- `left`: pointer to left child (or `nullptr` if not created)
- `right`: pointer to right child (or `nullptr` if not created)

Now let's implement the update and query functions:

```cpp
#include <bits/stdc++.h>
using namespace std;

struct Node {
    int sum;
    Node* left;
    Node* right;
    
    Node() : sum(0), left(nullptr), right(nullptr) {}
};

class DynamicSegTree {
private:
    Node* root;
    int n;
    
    void update(Node*& node, int tl, int tr, int pos, int val) {
        if (node == nullptr) {
            node = new Node();
        }
        
        if (tl == tr) {
            node->sum = val;
            return;
        }
        
        int tm = (tl + tr) / 2;
        if (pos <= tm) {
            update(node->left, tl, tm, pos, val);
        } else {
            update(node->right, tm + 1, tr, pos, val);
        }
        
        int leftSum = (node->left ? node->left->sum : 0);
        int rightSum = (node->right ? node->right->sum : 0);
        node->sum = leftSum + rightSum;
    }
    
    int query(Node* node, int tl, int tr, int l, int r) {
        if (node == nullptr || r < tl || tr < l) {
            return 0;
        }
        
        if (l <= tl && tr <= r) {
            return node->sum;
        }
        
        int tm = (tl + tr) / 2;
        int leftSum = query(node->left, tl, tm, l, r);
        int rightSum = query(node->right, tm + 1, tr, l, r);
        return leftSum + rightSum;
    }
    
public:
    DynamicSegTree(int size) : n(size), root(nullptr) {}
    
    void update(int pos, int val) {
        update(root, 1, n, pos, val);
    }
    
    int query(int l, int r) {
        return query(root, 1, n, l, r);
    }
};

int main() {
    int n, q;
    cin >> n >> q;
    
    DynamicSegTree tree(n);
    
    for (int i = 0; i < q; i++) {
        int type;
        cin >> type;
        
        if (type == 1) {
            // Update query
            int pos, val;
            cin >> pos >> val;
            tree.update(pos, val);
        } else {
            // Range sum query
            int l, r;
            cin >> l >> r;
            cout << tree.query(l, r) << "\n";
        }
    }
    
    return 0;
}
```

Let's break down the key differences from a regular segment tree:

1. *Node Creation:* We check `if (node == nullptr)` before using a node and create it only when needed.

2. *Null Checks:* When calculating sums, we check if child nodes exist: `(node->left ? node->left->sum : 0)`.

3. *Reference Parameter:* The update function takes `Node*& node` (reference to pointer) so we can modify which node the pointer points to.

Sample input:

```
8 6
1 5 7
1 2 3
2 2 6
1 3 5
2 1 8
2 3 3
```

Output:

```
10
15
5
```

Explanation of the sample:
- Update position 5 to 7
- Update position 2 to 3
- Query sum from 2 to 6: positions 2,3,4,5,6 = 3+0+0+7+0 = 10
- Update position 3 to 5
- Query sum from 1 to 8: positions 1-8 = 0+3+5+0+7+0+0+0 = 15
- Query sum from 3 to 3: position 3 = 5

=== Memory Analysis

Let's compare the memory usage:

*Regular Segment Tree:*
- For $n = 10^9$: needs $4 times 10^9$ nodes = ~16 GB

*Dynamic Segment Tree:*
- Each update/query touches $O(log n)$ nodes
- With $q$ operations: at most $q times log n$ nodes
- For $n = 10^9, q = 2 times 10^5$: at most $2 times 10^5 times 30 = 6 times 10^6$ nodes = ~24 MB

That's a reduction from 16 GB to 24 MB - a factor of over 650 times less memory!

=== Persistent Segment Trees

An interesting extension of dynamic segment trees is *persistent segment trees*. Instead of modifying nodes in place, we create new nodes for each update, keeping the old version intact. This allows us to query any previous version of the tree.

Here's a visualization of how this works. Say we start with an empty tree and do three updates:

#align(center)[
  #cetz.canvas(length: 0.8cm, {
    import cetz.draw: *
    
    // Version 0 (empty)
    content((0, 0), text(weight: "bold")[Version 0])
    circle((0, -1), radius: 0.3, name: "v0root")
    content("v0root", [0])
    
    // Version 1 (update pos 3)
    content((5, 0), text(weight: "bold")[Version 1])
    circle((5, -1), radius: 0.3, name: "v1root")
    content("v1root", [5])
    
    circle((4, -2.5), radius: 0.3, name: "v1l", stroke: (paint: blue))
    content("v1l", text(fill: blue)[5])
    line("v1root", "v1l", stroke: (paint: blue))
    
    // Show shared structure
    content((2, -2), text(size: 8pt, fill: gray)[shared])
    
    // Version 2 (update pos 7)
    content((10, 0), text(weight: "bold")[Version 2])
    circle((10, -1), radius: 0.3, name: "v2root")
    content("v2root", [9])
    
    circle((9, -2.5), radius: 0.3, name: "v2l")
    content("v2l", [5])
    line("v2root", "v2l")
    
    circle((11, -2.5), radius: 0.3, name: "v2r", stroke: (paint: blue))
    content("v2r", text(fill: blue)[4])
    line("v2root", "v2r", stroke: (paint: blue))
    
    content((7, -2), text(size: 8pt, fill: blue)[new nodes])
  })
]

Blue nodes are newly created; other nodes are shared between versions. This enables time-travel queries: "What was the sum from 2 to 5 after the 3rd update?"

Here's the code for a persistent segment tree:

```cpp
#include <bits/stdc++.h>
using namespace std;

struct Node {
    int sum;
    Node* left;
    Node* right;
    
    Node() : sum(0), left(nullptr), right(nullptr) {}
    Node(int s, Node* l, Node* r) : sum(s), left(l), right(r) {}
};

class PersistentSegTree {
private:
    int n;
    vector<Node*> roots; // Store root of each version
    
    Node* update(Node* node, int tl, int tr, int pos, int val) {
        if (tl == tr) {
            return new Node(val, nullptr, nullptr);
        }
        
        int tm = (tl + tr) / 2;
        Node* newNode = new Node();
        
        if (pos <= tm) {
            newNode->left = update(node ? node->left : nullptr, tl, tm, pos, val);
            newNode->right = node ? node->right : nullptr;
        } else {
            newNode->left = node ? node->left : nullptr;
            newNode->right = update(node ? node->right : nullptr, tm + 1, tr, pos, val);
        }
        
        int leftSum = (newNode->left ? newNode->left->sum : 0);
        int rightSum = (newNode->right ? newNode->right->sum : 0);
        newNode->sum = leftSum + rightSum;
        
        return newNode;
    }
    
    int query(Node* node, int tl, int tr, int l, int r) {
        if (node == nullptr || r < tl || tr < l) {
            return 0;
        }
        
        if (l <= tl && tr <= r) {
            return node->sum;
        }
        
        int tm = (tl + tr) / 2;
        int leftSum = query(node->left, tl, tm, l, r);
        int rightSum = query(node->right, tm + 1, tr, l, r);
        return leftSum + rightSum;
    }
    
public:
    PersistentSegTree(int size) : n(size) {
        roots.push_back(nullptr); // Version 0 is empty
    }
    
    void update(int pos, int val) {
        Node* newRoot = update(roots.back(), 1, n, pos, val);
        roots.push_back(newRoot);
    }
    
    int query(int version, int l, int r) {
        return query(roots[version], 1, n, l, r);
    }
    
    int numVersions() {
        return roots.size() - 1;
    }
};

int main() {
    int n, q;
    cin >> n >> q;
    
    PersistentSegTree tree(n);
    
    for (int i = 0; i < q; i++) {
        int type;
        cin >> type;
        
        if (type == 1) {
            // Update query
            int pos, val;
            cin >> pos >> val;
            tree.update(pos, val);
        } else {
            // Range sum query on a specific version
            int version, l, r;
            cin >> version >> l >> r;
            cout << tree.query(version, l, r) << "\n";
        }
    }
    
    return 0;
}
```

Sample input:

```
8 7
1 3 5
1 7 4
1 2 6
2 0 1 8
2 1 1 8
2 2 1 8
2 3 1 8
```

Output:

```
0
5
9
15
```

Explanation:
- Version 0: all zeros
- Version 1: update pos 3 to 5
- Version 2: update pos 7 to 4
- Version 3: update pos 2 to 6
- Query version 0 (all zeros): 0
- Query version 1 (only pos 3=5): 5
- Query version 2 (pos 3=5, pos 7=4): 9
- Query version 3 (pos 2=6, pos 3=5, pos 7=4): 15

=== When to Use Dynamic Segment Trees

Use dynamic segment trees when:

1. *Large Range, Few Operations:* When $n$ is huge (up to $10^9$ or $10^(18)$) but $q$ is small (up to $10^5$ or $10^6$).

2. *Coordinate Compression Alternative:* Sometimes coordinate compression is tricky or impossible. Dynamic segment trees can handle arbitrary coordinates directly.

3. *2D Segment Trees:* Building a 2D segment tree with $n times m = 10^9 times 10^9$ is impossible, but a dynamic 2D segment tree only creates the nodes you need.

4. *Persistence Required:* When you need to query previous versions of the data structure.

The key insight is that dynamic allocation lets us work with theoretical ranges far larger than we could ever store in memory, as long as we only access a small portion of that range.
