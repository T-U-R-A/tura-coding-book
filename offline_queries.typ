== Offline Queries //chap2

#v(0.5em)

So far, we've been dealing with *online queries* — queries that must be answered immediately as they come. However, in competitive programming, many problems give you all the queries at once and don't require you to answer them in order. These are called *offline queries*, and they open up powerful optimization techniques.

The key insight is this: when you can read all queries before answering any of them, you can reorder or process them in whatever way is most efficient. This often reduces time complexity from $O(n^2)$ or $O(n q)$ to $O(n log n)$ or $O(q log q)$.

=== When to Use Offline Queries

You can use offline query techniques when:

+ All queries are given at the start (not interactive)
+ Queries can be answered in any order
+ You can store all queries in memory

Common scenarios include:
- Range queries on static arrays
- Finding elements within ranges
- Counting inversions or specific patterns
- Processing events at different time points

=== Mo's Algorithm

Mo's algorithm is one of the most elegant offline query techniques. It works on problems where you can efficiently add or remove elements from the current range.

*Problem Setup:* Given an array and $q$ queries asking for some property of subarray $[L, R]$, answer all queries efficiently.

*Key Idea:* Reorder queries so that moving from one query to the next requires minimal changes to the current range.

Let's say you're currently processing range $[L_1, R_1]$ and the next query asks for $[L_2, R_2]$. You can transition by:
- Moving the left pointer from $L_1$ to $L_2$ (adding/removing elements)
- Moving the right pointer from $R_1$ to $R_2$ (adding/removing elements)

The trick is to order queries so these transitions are cheap.

==== Mo's Algorithm: Block Decomposition Ordering

Divide the array into blocks of size $sqrt(n)$. Sort queries by:
1. Block number of the left endpoint (ascending)
2. Right endpoint (ascending for even blocks, descending for odd blocks)

This ordering guarantees:
- Left pointer moves at most $O(n sqrt(n))$ times total
- Right pointer moves at most $O(n sqrt(n))$ times total
- Total complexity: $O((n + q) sqrt(n))$

Here's a complete implementation for counting distinct elements in ranges:

```cpp
#include <bits/stdc++.h>
using namespace std;

const int MAXN = 200005;
int n, q;
int arr[MAXN];
int freq[MAXN]; // frequency of each element in current range
int distinct_count = 0; // number of distinct elements
int block_size;
int answers[MAXN];

struct Query {
  int l, r, idx; // left, right, original index
  
  bool operator<(const Query& other) const {
    int block1 = l / block_size;
    int block2 = other.l / block_size;
    
    if (block1 != block2)
      return block1 < block2;
    
    // Alternate direction for odd/even blocks (optimization)
    if (block1 & 1)
      return r > other.r;
    return r < other.r;
  }
};

vector<Query> queries;

void add(int pos) {
  // Add element at position pos to current range
  if (freq[arr[pos]] == 0)
    distinct_count++;
  freq[arr[pos]]++;
}

void remove(int pos) {
  // Remove element at position pos from current range
  freq[arr[pos]]--;
  if (freq[arr[pos]] == 0)
    distinct_count--;
}

void mos_algorithm() {
  sort(queries.begin(), queries.end());
  
  int cur_l = 0, cur_r = -1;
  
  for (const Query& query : queries) {
    // Expand/shrink the current range to match query
    while (cur_r < query.r) {
      cur_r++;
      add(cur_r);
    }
    while (cur_r > query.r) {
      remove(cur_r);
      cur_r--;
    }
    while (cur_l < query.l) {
      remove(cur_l);
      cur_l++;
    }
    while (cur_l > query.l) {
      cur_l--;
      add(cur_l);
    }
    
    answers[query.idx] = distinct_count;
  }
}

int main() {
  cin >> n >> q;
  block_size = sqrt(n);
  
  for (int i = 0; i < n; i++)
    cin >> arr[i];
  
  for (int i = 0; i < q; i++) {
    int l, r;
    cin >> l >> r;
    l--; r--; // convert to 0-indexed
    queries.push_back({l, r, i});
  }
  
  mos_algorithm();
  
  for (int i = 0; i < q; i++)
    cout << answers[i] << endl;
  
  return 0;
}
```

Sample input:

```
8 5
1 2 1 3 2 3 4 1
0 3
2 5
1 7
0 7
4 6
```

Output:

```
3
3
4
4
2
```

The `add()` and `remove()` functions define how to update your answer when the range changes. For counting distinct elements:
- `add()` increments the frequency and increases distinct count if this is the first occurrence
- `remove()` decrements the frequency and decreases distinct count if this was the last occurrence

==== Alternative: Recursive Mo's Algorithm

Some programmers prefer a recursive implementation of the range adjustment:

```cpp
void adjust_range(int target_l, int target_r, int& cur_l, int& cur_r) {
  // Recursively adjust right endpoint
  if (cur_r < target_r) {
    cur_r++;
    add(cur_r);
    adjust_range(target_l, target_r, cur_l, cur_r);
  }
  else if (cur_r > target_r) {
    remove(cur_r);
    cur_r--;
    adjust_range(target_l, target_r, cur_l, cur_r);
  }
  // Recursively adjust left endpoint
  else if (cur_l < target_l) {
    remove(cur_l);
    cur_l++;
    adjust_range(target_l, target_r, cur_l, cur_r);
  }
  else if (cur_l > target_l) {
    cur_l--;
    add(cur_l);
    adjust_range(target_l, target_r, cur_l, cur_r);
  }
}

void mos_algorithm_recursive() {
  sort(queries.begin(), queries.end());
  
  int cur_l = 0, cur_r = -1;
  
  for (const Query& query : queries) {
    adjust_range(query.l, query.r, cur_l, cur_r);
    answers[query.idx] = distinct_count;
  }
}
```

The recursive version is more elegant but can cause stack overflow for large range differences. The iterative version is preferred in practice.

=== Query Sorting by Time

Another common offline technique is processing queries sorted by a specific attribute.

*Problem:* Given $n$ elements with values and $q$ queries asking "how many elements have value $<= x$", answer all queries.

*Online Solution:* For each query, scan all elements. $O(n q)$ — too slow.

*Offline Solution:* Sort elements and queries, process together. $O(n log n + q log q)$.

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
  int n, q;
  cin >> n >> q;
  
  vector<int> elements(n);
  for (int i = 0; i < n; i++)
    cin >> elements[i];
  
  sort(elements.begin(), elements.end());
  
  vector<pair<int, int>> queries(q); // {value, original_index}
  for (int i = 0; i < q; i++) {
    cin >> queries[i].first;
    queries[i].second = i;
  }
  
  sort(queries.begin(), queries.end());
  
  vector<int> answers(q);
  int elem_idx = 0;
  
  for (int i = 0; i < q; i++) {
    // Count all elements <= queries[i].first
    while (elem_idx < n && elements[elem_idx] <= queries[i].first)
      elem_idx++;
    
    answers[queries[i].second] = elem_idx;
  }
  
  for (int i = 0; i < q; i++)
    cout << answers[i] << endl;
  
  return 0;
}
```

Sample input:

```
6 4
3 7 2 9 1 5
5
3
8
2
```

Output:

```
4
3
5
2
```

The key insight: once you've counted elements $<= x$, you don't need to recount for $<= y$ if $y > x$. Just continue from where you left off.

=== Offline Range Updates with Difference Arrays

Sometimes you have multiple range update queries and only need the final state.

*Problem:* Start with array of zeros. Process $q$ updates of form "add $v$ to range $[l, r]$". Output final array.

*Online Solution:* For each update, iterate through range. $O(n q)$.

*Offline Solution:* Use difference array technique. $O(n + q)$.

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
  int n, q;
  cin >> n >> q;
  
  vector<long long> diff(n + 1, 0); // difference array
  
  for (int i = 0; i < q; i++) {
    int l, r;
    long long v;
    cin >> l >> r >> v;
    
    diff[l] += v;
    diff[r + 1] -= v;
  }
  
  // Reconstruct the actual array
  vector<long long> arr(n);
  arr[0] = diff[0];
  for (int i = 1; i < n; i++)
    arr[i] = arr[i - 1] + diff[i];
  
  for (int i = 0; i < n; i++)
    cout << arr[i] << " ";
  cout << endl;
  
  return 0;
}
```

Sample input:

```
5 3
1 3 5
0 4 2
2 2 -3
```

Output:

```
7 7 4 7 7
```

The difference array stores changes at boundaries. `diff[l] += v` means "increase by $v$ starting at position $l$", and `diff[r+1] -= v` means "stop increasing at position $r+1$". The prefix sum reconstructs the final values.

==== Recursive Difference Array Construction

You can also build the difference array recursively:

```cpp
void apply_update(vector<long long>& diff, int l, int r, long long v) {
  if (l > r)
    return;
  
  diff[l] += v;
  if (r + 1 < diff.size())
    diff[r + 1] -= v;
}

void reconstruct(vector<long long>& arr, vector<long long>& diff, int pos) {
  if (pos >= arr.size())
    return;
  
  if (pos == 0)
    arr[pos] = diff[pos];
  else
    arr[pos] = arr[pos - 1] + diff[pos];
  
  reconstruct(arr, diff, pos + 1);
}
```

=== Sweep Line Algorithm

The sweep line technique processes events in sorted order, maintaining state as we "sweep" through.

*Problem:* Given $n$ intervals $[l_i, r_i]$, find the maximum number of overlapping intervals at any point.

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
  int n;
  cin >> n;
  
  vector<pair<int, int>> events; // {position, type}
  // type: +1 for start, -1 for end
  
  for (int i = 0; i < n; i++) {
    int l, r;
    cin >> l >> r;
    events.push_back({l, 1});
    events.push_back({r + 1, -1}); // end at r+1 so interval includes r
  }
  
  sort(events.begin(), events.end());
  
  int current_overlap = 0;
  int max_overlap = 0;
  
  for (auto [pos, type] : events) {
    current_overlap += type;
    max_overlap = max(max_overlap, current_overlap);
  }
  
  cout << "Maximum overlap: " << max_overlap << endl;
  
  return 0;
}
```

Sample input:

```
4
1 5
2 6
3 4
7 9
```

Output:

```
Maximum overlap: 3
```

At position 3, intervals $[1,5]$, $[2,6]$, and $[3,4]$ all overlap, giving us the maximum of 3.

==== Recursive Event Processing

The event processing can be done recursively:

```cpp
void process_events(vector<pair<int, int>>& events, int idx, 
                    int& current, int& maximum) {
  if (idx >= events.size())
    return;
  
  current += events[idx].second;
  maximum = max(maximum, current);
  
  process_events(events, idx + 1, current, maximum);
}

int main() {
  // ... input processing ...
  
  sort(events.begin(), events.end());
  
  int current = 0, maximum = 0;
  process_events(events, 0, current, maximum);
  
  cout << "Maximum overlap: " << maximum << endl;
  return 0;
}
```

=== Offline Queries with Binary Indexed Tree

Combining offline queries with data structures gives powerful results.

*Problem:* Given an array and queries asking "sum of elements in range $[l, r]$ where element value $<= k$".

*Solution:* Process queries offline sorted by $k$, use BIT to track elements.

```cpp
#include <bits/stdc++.h>
using namespace std;

const int MAXN = 200005;
int n, q;
vector<int> fenw;

void add(int x, int v) {
  for (; x <= n; x += x & -x)
    fenw[x] += v;
}

int sum(int x) {
  int ans = 0;
  for (; x > 0; x -= x & -x)
    ans += fenw[x];
  return ans;
}

int sum(int l, int r) {
  return sum(r) - sum(l - 1);
}

struct Element {
  int value, position;
  bool operator<(const Element& other) const {
    return value < other.value;
  }
};

struct Query {
  int l, r, k, idx;
  bool operator<(const Query& other) const {
    return k < other.k;
  }
};

int main() {
  cin >> n >> q;
  
  vector<Element> elements(n);
  for (int i = 0; i < n; i++) {
    cin >> elements[i].value;
    elements[i].position = i + 1; // 1-indexed
  }
  
  sort(elements.begin(), elements.end());
  
  vector<Query> queries(q);
  for (int i = 0; i < q; i++) {
    cin >> queries[i].l >> queries[i].r >> queries[i].k;
    queries[i].idx = i;
  }
  
  sort(queries.begin(), queries.end());
  
  fenw.resize(n + 1, 0);
  vector<int> answers(q);
  
  int elem_idx = 0;
  for (int i = 0; i < q; i++) {
    // Add all elements with value <= k to BIT
    while (elem_idx < n && elements[elem_idx].value <= queries[i].k) {
      add(elements[elem_idx].position, elements[elem_idx].value);
      elem_idx++;
    }
    
    answers[queries[i].idx] = sum(queries[i].l, queries[i].r);
  }
  
  for (int i = 0; i < q; i++)
    cout << answers[i] << endl;
  
  return 0;
}
```

Sample input:

```
5 3
3 7 2 9 1
1 3 5
2 4 8
1 5 3
```

Output:

```
5
9
6
```

For the first query $[1, 3]$ with $k = 5$: elements are $[3, 7, 2]$, but only $3$ and $2$ are $<= 5$, so sum is $3 + 2 = 5$.

=== Summary of Offline Query Techniques

Here's when to use each technique:

*Mo's Algorithm*: When you can maintain answer while adding/removing elements
- Time: $O((n + q) sqrt(n))$
- Use for: distinct elements, mode, sum of squares

*Query Sorting*: When processing queries in sorted order helps
- Time: $O(n log n + q log q)$
- Use for: counting, threshold queries

*Difference Array*: When you only need final state after many updates
- Time: $O(n + q)$
- Use for: range updates, interval scheduling

*Sweep Line*: When events have clear start/end points
- Time: $O(n log n)$
- Use for: overlaps, closest pairs, skyline

*Combined with BIT/Segment Tree*: When you need both sorting and range queries
- Time: $O((n + q) log n)$
- Use for: conditional range queries

The key to offline queries is recognizing that you don't need to answer queries in the order they're given. Reordering them can dramatically reduce complexity!
