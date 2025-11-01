#set text(
  font: "New Computer Modern Math" 
)
#set page(
  numbering: "1"
)
#set heading(
  numbering: "1."
)
#show raw.where(block: true): block.with(fill: luma(240), inset: 8pt, radius: 4pt)

#show link: underline
#outline()
#pagebreak()

= Introductory Problems

\
== Weird Algorithm

\
#link("https://cses.fi/problemset/task/1068")[Question - Weird Algorithm]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1068")[Backup Link]

\
*Explanation* : 

+ Modulus Function (%): Used to check the parity of n
   - If (n % 2 == 0), n is even, so divide n by 2 
   - If (n % 2 == 1),  n is odd, so multiply n by 3 and add 1

+ While Loop: Continues the process until n becomes 1.
   - The loop runs as long as n is not 1 (n != 1), applying the above rules in each iteration.
   - Print each value of n to track the sequence.

\
*Code :*
 
```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    long long n; // Use long long to handle large values of n
    cin >> n;
    cout << n << " "; // Print the starting number

    // Continue until n becomes 1
    while (n != 1) {
      // Case 1: n is even → halve it
      if (n % 2 == 0) n /= 2;
        
      // Case 2: n is odd → apply 3n + 1
      else n = 3 * n + 1;
    
      // Print current value after operation
      cout << n << " ";
    }

    return 0;
}
```



== Missing Number

\
#link("https://cses.fi/problemset/task/1083")[Question - Missing Number]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1083")[Backup Link]

\
*Explanation* : 

We use a simple mathematical trick: calculate the expected sum of numbers from 1 to n using the arithmetic progression formula $ n(n+1)/2 $

Then subtract the actual sum of the given numbers to reveal the missing number, as this difference represents the value that's absent, elegantly avoiding any searching or sorting in a fast way.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;
 
int main() {
    long long n, x, total = 0;
    cin >> n;
 
    for (int i = 0; i < n - 1; i++) {
        cin >> x;
        total += x;
    } // Read n-1 numbers and sum them
 
    long long sum = n * (n + 1) / 2;  // Expected sum of 1 to n
    
    // The missing number is the difference
    cout << sum - total << endl;
    return 0;
}
```

== Repetitions

\
#link("https://cses.fi/problemset/task/1069")[Question - Repetitions]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1069")[Backup Link]

\
*Explanation* : 
This program finds the longest stretch of the same character in a string.

It goes through each character one by one:

+ If it’s the same as the previous one, it extends the current streak.
+ If it’s different, it resets the count.
+  It keeps track of the maximum streak found.

Finally, it prints the length of that longest consecutive sequence.


\
*Code :*
  
```cpp 
#include <bits/stdc++.h>
using namespace std;

int main() {
    string s;
    cin >> s;
    int maxLen = 1, current = 1;

    for (int i = 1; i < s.length(); i++) {
        // Check if current character matches the previous one

        // Increment current length of consecutive characters
        if (s[i] == s[i - 1]) current++;

        // Reset current to 1 if characters differ
        else current = 1; 

        // Update maxLen if current is larger
        maxLen = max(maxLen, current); 
    }

    cout << maxLen << "\n";
    return 0;
}
```

\
#pagebreak()
== Increasing Array

\
#link("https://cses.fi/problemset/task/1094")[Question - Increasing Array]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1094")[Backup Link]

\
*Explanation* :  

Intuitive Explanation

We need to make the given array non-decreasing — that is, every element must be at least as large as the one before it. Whenever a number is smaller than the previous one, we must increase it until the condition a[i] ≥ a[i−1] holds. The problem asks for the total number of increments required to achieve this. 
\

\

*Algorithm (Step by Step Flow):*  

+ Read the first element and store it as prev.
+ Iterate through the rest of the array:
+ If current ≥ prev, move on — the order is fine.
+ If current < prev, we need to increase it by (prev − current).
+ Add this difference to the total count and update current = prev.
+ Continue until all elements are processed.
+ Output the total count of increments. required.

\

*Code :*
  
```cpp 
#include <iostream>
using namespace std; 
 
int main() {
    int n;            // n = number of elements
    int prev;         // prev = previous element
    long long operations = 0; // total number of increments needed
    cin >> n >> prev;    // take first element as 'prev'
    
    // process the rest of the array
    for (int i = 1; i < n; ++i) {
        int current;
        cin >> current;  // read the current element

        // if the current element is smaller than the previous,
        // we need to increment it to match 'prev' (to keep array non-decreasing)
        if (current < prev) {
            // count how many increments are required
            operations += prev - current; 
            // simulate the increment (virtually update current)
            current = prev;               
        }

        prev = current; // update 'prev' for the next iteration
    }
 
    // output the total number of operations
    cout << operations << '\n';
    return 0;
}

```

\

#pagebreak()

== Permutations

\
#link("https://cses.fi/problemset/task/1618")[Question - Trailing Zeros]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1618")[Backup Link]


\

*Explanation* : 

The trick we exploit here is to first print all the numbers up to n of one parity (odd or even), and then print all the numbers of the opposite parity.

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;
 
int main() {
    int n;
    cin >> n;
 
    // Special case: if n = 2 or 3, it is impossible to arrange
    // numbers from 1...n so that no two consecutive numbers
    // differ by 1. Hence, print "NO SOLUTION".
    if (n > 1 && n < 4) 
        cout << "NO SOLUTION";
 
    // Base case: if n = 1, the only permutation is "1".
    else if (n == 1)
        cout << "1";
 
    // Edge case: if n = 4, the general logic won't directly
    // give a valid solution, so hardcode one valid answer.
    else if (n == 4) 
        cout << "2 4 1 3";
 
    // General case: n >= 5
    else {
        // First print all odd numbers in descending order
        // This ensures that consecutive numbers differ by >= 2
        for (int i = n; i >= 1; i -= 2)
            cout << i << " ";
 
        // Then print all even numbers in descending order
        // This also ensures no two adjacent numbers differ by 1
        for (int i = n - 1; i >= 1; i -= 2)
            cout << i << " ";
    }
}

```
#pagebreak()

== Number Spiral

\
#link("https://cses.fi/problemset/task/1071")[Question - Number Spiral]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1071")[Backup Link]

\

*Intuitive Explanation* : 

Every coordinate sits on a diagonal “layer” whose index is the maximum of the row and column. The square at the end of that layer has value layer², and depending on whether the layer index is even or odd we walk along the layer to the requested cell.

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int t;
    cin >> t;
    while (t--) {
        long long y, x;
        cin >> y >> x;
        long long layer = max(y, x);
        long long base = (layer - 1) * (layer - 1);
        long long value;
        if (layer % 2 == 0) {
            if (y == layer) value = base + x;
            else value = layer * layer - (y - 1);
        } else {
            if (x == layer) value = base + y;
            else value = layer * layer - (x - 1);
        }
        cout << value << "\n";
    }
    return 0;
}
```

\
#pagebreak()

== Two Knights

\
#link("https://cses.fi/problemset/task/1072")[Question - Two Knights]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1072")[Backup Link]

\

*Intuitive Explanation* : 

Count all unordered pairs of squares, then subtract the placements where two knights attack each other. Those attacking positions live inside 2×3 or 3×2 rectangles, and there are 4 of each per rectangle.

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

int main() {
    long long n;
    cin >> n;
    for (long long k = 1; k <= n; ++k) {
        long long total = k * k;
        long long ways = total * (total - 1) / 2;
        if (k > 2) ways -= 4 * (k - 1) * (k - 2);
        cout << ways << "\n";
    }
    return 0;
}
```

\
#pagebreak()

== Two Sets

\
#link("https://cses.fi/problemset/task/1092")[Question - Two Sets]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1092")[Backup Link]


\

*Intuitive Explanation* : 

The total sum from 1 to n is n(n+1)/2. If that sum is odd we cannot split it evenly. Otherwise we keep taking the largest remaining number into the first set while we still stay under half of the sum; every other number goes into the second set.

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

int main() {
    long long n;
    cin >> n;
    long long total = n * (n + 1) / 2;
    if (total % 2) {
        cout << "NO\n";
        return 0;
    }
    cout << "YES\n";
    long long target = total / 2;
    vector<long long> first, second;
    for (long long x = n; x >= 1; --x) {
        if (x <= target) {
            first.push_back(x);
            target -= x;
        } else {
            second.push_back(x);
        }
    }
    cout << first.size() << "\n";
    for (size_t i = 0; i < first.size(); ++i) {
        if (i) cout << " ";
        cout << first[i];
    }
    cout << "\n" << second.size() << "\n";
    for (size_t i = 0; i < second.size(); ++i) {
        if (i) cout << " ";
        cout << second[i];
    }
    cout << "\n";
    return 0;
}
```

\
#pagebreak()


== Bit Strings

\
#link("https://cses.fi/problemset/task/1617")[Question - Bit Strings]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1617")[Backup Link]


\

*Intuitive Explanation* : 

Each of the n positions can be either 0 or 1, so the answer is simply 2^n. We compute the power iteratively while taking remainders modulo 1e9+7 to avoid overflow.

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

int main() {
    const long long MOD = 1'000'000'007;
    long long n;
    cin >> n;
    long long answer = 1;
    for (long long i = 0; i < n; ++i) {
        answer = (answer * 2) % MOD;
    }
    cout << answer << "\n";
    return 0;
}
```
\
#pagebreak()

== Trailing Zeros

\
#link("https://cses.fi/problemset/task/1618")[Question - Trailing Zeros]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1618")[Backup Link]


\

*Explanation* : 

The problem asks for the number of trailing zeros in n factorial. Zeros come from factor pairs of 2s and 5s. There will be excess 2s. Therefore the number of 5s alone determine the number of zeros.

Each multiple of 5 (5, 10, 15, 20, 25…) contributes one 5. Each multiple of 25 (25, 50, 75, 100, 125...) contributes an additional 5.  Each multiple of 125 contributes another 5, and so on. The code loops through powers of 5 and counts the total number of the factor 5 present in n factorial.

Eg : n = 27
- $floor(27/5)$ = 5  (5s from 5, 10, 15, 20, 25).

- $floor(27/25)$ = 1 (extra 5 from 25).

- $floor(27/125)$ = 0 (stop).

- Total: 5 + 1 + 0 = 6 zeros.
\

Note : want to add reference as to what the meaning of the floor function is...

*Code :*

   
```cpp  
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n, count = 0;
    cin >> n; // Read input number n
    
    // Count factors of 5 in n! by summing n/5 + n/25 + n/125 + ...
    // 
    for (int i = 5; n / i >= 1; i *= 5) {
        count += n / i; // Add number of multiples of i (powers of 5)
    }
    
    cout << count << endl; // Output the number of trailing zeros
    return 0;
}

```
#pagebreak()

== Coin Piles



\
#link("https://cses.fi/problemset/task/1618")[Question - Trailing Zeros]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1618")[Backup Link]


\

*Explanation* : 

There are two key observations in this question :-

The first key observation  is that each time you remove 2 coins from pile A and 1 coin from pile B or 1 coin from pile A and 2 coins from pile B, the total number of coins in both the towers always gets reduced by 3 so to empty both piles, the sum of coins in the two piles must be divisible by 3.

The second key observation is that the number of coins in one pile cannot exceed twice the number of coins in the other pile. Because in that case you cannot empty the bigger pile even if you remove 2 coins from the bigger pile for each time you remove 1 coin from the smaller pile.

Using this we check if the above two conditions are met and accordingly output the result.


*Code :*

```cpp  
#include <bits/stdc++.h> 
using namespace std;
 
int main() {
    int t;
    cin >> t;
 
    while (t--) {
        int a, b;
        cin >> a >> b;

        bool cond_1 = (a + b) % 3 == 0;
        bool cond_2 = max(a, b) <= 2 * min(a, b);
 
        if(cond_1 && cond_2) {
          cout<<"YES"<<endl;
        }
        else {
          cout<<"NO";
        }
    }
  
    return 0;
}


```
\
#pagebreak()

== Palindrome Reorder

\
#link("https://cses.fi/problemset/task/1755")[Question - Palindrome Reorder]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1755")[Backup Link]


\

*Intuitive Explanation* : 

Count the frequency of every letter. A palindrome can have at most one character with an odd count; if more exist the task is impossible. Otherwise we build the left half using half of each frequency, keep the optional odd character for the middle, and mirror the left half to complete the string.

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

int main() {
    string s;
    cin >> s;
    vector<int> freq(26, 0);
    for (char c : s) freq[c - 'A']++;
    int odd = 0;
    int oddIndex = -1;
    for (int i = 0; i < 26; ++i) {
        if (freq[i] % 2) {
            odd++;
            oddIndex = i;
        }
    }
    if (odd > 1) {
        cout << "NO SOLUTION\n";
        return 0;
    }
    string half;
    for (int i = 0; i < 26; ++i) {
        half.append(freq[i] / 2, char('A' + i));
    }
    string result = half;
    if (oddIndex != -1) result += char('A' + oddIndex);
    reverse(half.begin(), half.end());
    result += half;
    cout << result << "\n";
    return 0;
}
```

\
#pagebreak()


== Gray Code

\
#link("https://cses.fi/problemset/task/2205")[Question - Gray Code]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/2205")[Backup Link]


\

*Intuitive Explanation* : 

Start with the 1-bit codes 0 and 1. To create the next length, prepend 0 to the current list and 1 to its reverse. This reflection guarantees that consecutive strings differ by exactly one bit.

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n;
    cin >> n;
    vector<string> codes = {"0", "1"};
    if (n == 1) {
        for (const string& code : codes) cout << code << "\n";
        return 0;
    }
    for (int len = 2; len <= n; ++len) {
        vector<string> rev = codes;
        reverse(rev.begin(), rev.end());
        for (string& code : codes) code = "0" + code;
        for (string& code : rev) code = "1" + code;
        codes.insert(codes.end(), rev.begin(), rev.end());
    }
    for (const string& code : codes) cout << code << "\n";
    return 0;
}
```

\
#pagebreak()


== Tower of Hanoi

\
#link("https://cses.fi/problemset/task/2165")[Question - Tower of Hanoi]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/2165")[Backup Link]


\

*Intuitive Explanation* : 

To move n disks, first move the top n−1 disks to the helper peg, then move the largest disk to the destination, and finally move the stack from the helper to the destination. This recursion yields 2^n − 1 moves and provides the lexicographically simple solution.

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

void solve(int n, int from, int to, int aux) {
    if (n == 0) return;
    solve(n - 1, from, aux, to);
    cout << from << " " << to << "\n";
    solve(n - 1, aux, to, from);
}

int main() {
    int n;
    cin >> n;
    long long moves = (1LL << n) - 1;
    cout << moves << "\n";
    solve(n, 1, 3, 2);
    return 0;
}
```

\
#pagebreak()


== Creating Strings

\
#link("https://cses.fi/problemset/task/1618")[Question - Trailing Zeros]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1618")[Backup Link]


\

*Explanation* : 

In c++ there is a very useful function called 'next_permutation' which helps us tackle this exact question. This function can be used to generate the next lexiograpical sequence for a string or a vector.

It returns false when no other gretaer permutations exists, otherwise it rearranges the string or the vector.

Note : Apurva add your explanation to the next permutation question...

Note : explain meaning of lexiographical down below

\
*Code :*

```cpp  

#include <bits/stdc++.h>
using namespace std;
 
int main() {
    string s;
    cin >> s;

    //sort the string to get the lowest possible lexiographical sequence
    sort(s.begin(), s.end());

    vector<string> v;

    do {
        v.push_back(s);
    } while (next_permutation(s.begin(), s.end()));
    // returns false if no other permutation exists
    // otherwise it rearranges the string
 
    cout<<v.size()<<"\n";
    for (int i = 0; i < v.size(); i++) {
        cout << v[i] << endl;
    }
}

```
\
#pagebreak()
== Apple Division

\
#link("https://cses.fi/problemset/task/1623")[Question - Apple Division]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1623")[Backup Link]


\

*Intuitive Explanation* : 

Try every subset by recursively deciding for each apple whether it goes to the first pile. Track the running weight and update the best difference compared to the total sum. With n ≤ 20 this brute-force with pruning easily fits in time.

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

long long bestDiff;
vector<long long> weight;
long long total;

void dfs(int idx, long long current) {
    if (idx == (int)weight.size()) {
        long long other = total - current;
        bestDiff = min(bestDiff, llabs(current - other));
        return;
    }
    dfs(idx + 1, current + weight[idx]);
    dfs(idx + 1, current);
}

int main() {
    int n;
    cin >> n;
    weight.resize(n);
    total = 0;
    for (int i = 0; i < n; ++i) {
        cin >> weight[i];
        total += weight[i];
    }
    bestDiff = LLONG_MAX;
    dfs(0, 0);
    cout << bestDiff << "\n";
    return 0;
}
```

\
#pagebreak()


== Chessboard and Queens

\
#link("https://cses.fi/problemset/task/1624")[Question - Chessboard and Queens]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1624")[Backup Link]


\

*Intuitive Explanation* : 

Place queens row by row. At each row we try every column that is not blocked and whose column and diagonals are still free. Bitmasks help track used columns and diagonals in O(1), and recursion counts all valid configurations.

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

vector<string> board(8);
long long solutions = 0;

void search(int row, int cols, int diag1, int diag2) {
    if (row == 8) {
        solutions++;
        return;
    }
    for (int col = 0; col < 8; ++col) {
        if (board[row][col] == '*') continue;
        int colMask = 1 << col;
        int d1Mask = 1 << (row + col);
        int d2Mask = 1 << (row - col + 7);
        if (cols & colMask) continue;
        if (diag1 & d1Mask) continue;
        if (diag2 & d2Mask) continue;
        search(row + 1, cols | colMask, diag1 | d1Mask, diag2 | d2Mask);
    }
}

int main() {
    for (int i = 0; i < 8; ++i) cin >> board[i];
    search(0, 0, 0, 0);
    cout << solutions << "\n";
    return 0;
}
```

\
#pagebreak()


== Raab Game I

\
#link("https://cses.fi/problemset/task/3399")[Question - Raab Game I]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/3399")[Backup Link]


\

*Intuitive Explanation* : 

We can fix the order of the first player as 1…n and seek a permutation of the second player’s cards that yields exactly a wins, b losses, and the remaining draws. Treat each position as needing “greater than”, “equal”, or “less than” relations and build a bipartite graph between positions and card values. A standard augmenting-path matching either finds a valid assignment or proves it impossible.

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int t;
    cin >> t;
    while (t--) {
        int n, a, b;
        cin >> n >> a >> b;
        if (a + b > n) {
            cout << "NO\n";
            continue;
        }
        int draws = n - (a + b);
        vector<char> category;
        category.insert(category.end(), b, 'B');
        category.insert(category.end(), draws, 'D');
        category.insert(category.end(), a, 'A');
        vector<vector<int>> adj(n);
        for (int i = 0; i < n; ++i) {
            int pos = i + 1;
            if (category[i] == 'B') {
                for (int val = pos + 1; val <= n; ++val) adj[i].push_back(val);
            } else if (category[i] == 'D') {
                adj[i].push_back(pos);
            } else {
                for (int val = 1; val < pos; ++val) adj[i].push_back(val);
            }
            if (adj[i].empty()) {
                adj.clear();
                break;
            }
        }
        if (adj.empty()) {
            cout << "NO\n";
            continue;
        }
        vector<int> match(n + 1, -1);
        function<bool(int, vector<int>&)> dfs = [&](int u, vector<int>& seen) {
            for (int v : adj[u]) {
                if (seen[v]) continue;
                seen[v] = 1;
                if (match[v] == -1 || dfs(match[v], seen)) {
                    match[v] = u;
                    return true;
                }
            }
            return false;
        };
        bool ok = true;
        for (int i = 0; i < n && ok; ++i) {
            vector<int> seen(n + 1, 0);
            if (!dfs(i, seen)) ok = false;
        }
        if (!ok) {
            cout << "NO\n";
            continue;
        }
        vector<int> order(n);
        for (int val = 1; val <= n; ++val) {
            int pos = match[val];
            order[pos] = val;
        }
        cout << "YES\n";
        for (int i = 1; i <= n; ++i) {
            if (i > 1) cout << ' ';
            cout << i;
        }
        cout << "\n";
        for (int i = 0; i < n; ++i) {
            if (i) cout << ' ';
            cout << order[i];
        }
        cout << "\n";
    }
    return 0;
}
```

\
#pagebreak()


== Mex Grid Construction

\
#link("https://cses.fi/problemset/task/3419")[Question - Mex Grid Construction]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/3419")[Backup Link]


\

*Intuitive Explanation* : 

Fill the grid row by row. For each cell collect the numbers already appearing to its left and above, then choose the smallest nonnegative integer missing from that set. With n ≤ 100 the straightforward O(n³) implementation is perfectly fast.

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n;
    cin >> n;
    vector<vector<int>> grid(n, vector<int>(n, 0));
    int limit = 2 * n + 5;
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            vector<int> seen(limit, 0);
            for (int c = 0; c < j; ++c) seen[grid[i][c]] = 1;
            for (int r = 0; r < i; ++r) seen[grid[r][j]] = 1;
            int mex = 0;
            while (seen[mex]) ++mex;
            grid[i][j] = mex;
        }
    }
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            if (j) cout << ' ';
            cout << grid[i][j];
        }
        cout << "\n";
    }
    return 0;
}
```

\
#pagebreak()


== Knight Moves Grid

\
#link("https://cses.fi/problemset/task/3217")[Question - Knight Moves Grid]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/3217")[Backup Link]


\

*Intuitive Explanation* : 

Run a breadth-first search from the top-left corner. Each BFS layer corresponds to knight moves; the first time we reach any cell gives its minimum distance.

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n;
    cin >> n;
    vector<vector<int>> dist(n, vector<int>(n, -1));
    queue<pair<int,int>> q;
    dist[0][0] = 0;
    q.push({0, 0});
    const int dr[8] = {-2, -2, -1, -1, 1, 1, 2, 2};
    const int dc[8] = {-1, 1, -2, 2, -2, 2, -1, 1};
    while (!q.empty()) {
        auto [r, c] = q.front();
        q.pop();
        for (int k = 0; k < 8; ++k) {
            int nr = r + dr[k];
            int nc = c + dc[k];
            if (nr < 0 || nr >= n || nc < 0 || nc >= n) continue;
            if (dist[nr][nc] != -1) continue;
            dist[nr][nc] = dist[r][c] + 1;
            q.push({nr, nc});
        }
    }
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            if (j) cout << ' ';
            cout << dist[i][j];
        }
        cout << "\n";
    }
    return 0;
}
```

\
#pagebreak()


== Grid Coloring I

\
#link("https://cses.fi/problemset/task/3311")[Question - Grid Coloring I]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/3311")[Backup Link]


\

*Intuitive Explanation* : 

A chessboard coloring works: assign two letters to black squares and two letters to white squares. Because adjacent cells have opposite parity, they automatically differ. Each cell then chooses the letter from its parity pair that is different from its original character.

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n, m;
    cin >> n >> m;
    vector<string> grid(n);
    for (int i = 0; i < n; ++i) cin >> grid[i];
    const string even = "AB";
    const string odd = "CD";
    vector<string> ans = grid;
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < m; ++j) {
            const string& options = ((i + j) % 2 == 0) ? even : odd;
            ans[i][j] = (options[0] != grid[i][j]) ? options[0] : options[1];
        }
    }
    for (int i = 0; i < n; ++i) cout << ans[i] << "\n";
    return 0;
}
```

\
#pagebreak()


== Digit Queries

\
#link("https://cses.fi/problemset/task/2431")[Question - Digit Queries]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/2431")[Backup Link]


\

*Intuitive Explanation* : 

Numbers are grouped by digit length. We subtract whole blocks (1-digit numbers, 2-digit numbers, …) until we locate the block containing the k-th digit. Then we identify the exact number in that block and index into its string form.

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int q;
    cin >> q;
    while (q--) {
        long long k;
        cin >> k;
        long long digits = 1;
        long long count = 9;
        long long start = 1;
        while (k > (__int128)digits * count) {
            k -= digits * count;
            digits++;
            count *= 10;
            start *= 10;
        }
        long long number = start + (k - 1) / digits;
        string s = to_string(number);
        cout << s[(k - 1) % digits] << "\n";
    }
    return 0;
}
```

\
#pagebreak()


== String Reorder

\
#link("https://cses.fi/problemset/task/1743")[Question - String Reorder]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1743")[Backup Link]


\

*Intuitive Explanation* : 

We count character frequencies and greedily append the smallest possible letter that differs from the previous character and still allows a valid completion. Feasibility is checked by ensuring no letter dominates the remaining length and that not all remaining characters match the one we just placed.

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    string s;
    cin >> s;
    vector<long long> freq(26, 0);
    for (char c : s) freq[c - 'A']++;
    long long n = s.size();
    if (*max_element(freq.begin(), freq.end()) > (n + 1) / 2) {
        cout << -1 << "\n";
        return 0;
    }
    string ans;
    int prev = -1;
    for (long long placed = 0; placed < n; ++placed) {
        bool okPick = false;
        for (int ch = 0; ch < 26; ++ch) {
            if (freq[ch] == 0 || ch == prev) continue;
            freq[ch]--;
            long long remain = n - placed - 1;
            long long most = *max_element(freq.begin(), freq.end());
            if (most <= (remain + 1) / 2 && !(remain > 0 && freq[ch] == remain)) {
                ans.push_back(char('A' + ch));
                prev = ch;
                okPick = true;
                break;
            }
            freq[ch]++;
        }
        if (!okPick) {
            cout << -1 << "\n";
            return 0;
        }
    }
    cout << ans << "\n";
    return 0;
}
```

\
#pagebreak()


== Grid Path Description

\
#link("https://cses.fi/problemset/task/1625")[Question - Grid Path Description]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1625")[Backup Link]


\

*Intuitive Explanation* : 

We explore all possible paths consistent with the string by recursive backtracking. Pruning is essential: whenever the path hits a cell where it would split the grid into two disconnected regions, we can stop exploring that branch immediately. The classic CSES pruning checks for forced turns by verifying whether moving vertically or horizontally would trap us.

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

string pattern;
bool visited[7][7];
int answer = 0;
const int dr[4] = {0, 0, -1, 1};
const int dc[4] = {1, -1, 0, 0};
const char moves[4] = {'R', 'L', 'U', 'D'};

bool blocked(int r, int c) {
    return r < 0 || r >= 7 || c < 0 || c >= 7 || visited[r][c];
}

void dfs(int step, int r, int c) {
    if (r == 6 && c == 0) {
        if (step == 48) answer++;
        return;
    }
    if (step == 48) return;
    bool up = blocked(r - 1, c);
    bool down = blocked(r + 1, c);
    bool left = blocked(r, c - 1);
    bool right = blocked(r, c + 1);
    if ((up && down && !left && !right) || (left && right && !up && !down)) return;
    char want = pattern[step];
    for (int dir = 0; dir < 4; ++dir) {
        if (want != '?' && want != moves[dir]) continue;
        int nr = r + dr[dir];
        int nc = c + dc[dir];
        if (blocked(nr, nc)) continue;
        visited[nr][nc] = true;
        dfs(step + 1, nr, nc);
        visited[nr][nc] = false;
    }
}

int main() {
    cin >> pattern;
    visited[0][0] = true;
    dfs(0, 0, 0);
    cout << answer << "\n";
    return 0;
}
```

\
#pagebreak()
