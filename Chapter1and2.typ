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
   - If (n % 2 == 1), n is odd, so multiply n by 3 and add 1

+ While Loop: Continues the process until n becomes 1.
   - The loop runs as long as n is not 1, applying the above rules in each iteration.
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
#pagebreak()

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
#pagebreak()

== Repetitions

\
#link("https://cses.fi/problemset/task/1069")[Question - Repetitions]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1069")[Backup Link]

\
*Explanation : *
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

We need to make the given array non-decreasing — that is, every element must be at least as large as the one before it. Whenever a number is smaller than the previous one, we must increase it until the condition a[i] ≥ a[i−1] holds. The problem asks for the total number of increments required to achieve this. 

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
    int n, prev;
    long long operations = 0; // total number of increments needed
    cin >> n >> prev;
    
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

    cout << operations << '\n';
    return 0;
}

```


#pagebreak()

== Permutations

\
#link("https://cses.fi/problemset/task/1618")[Question - Trailing Zeros]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1618")[Backup Link]


\

*Explanation* : 

The trick we exploit here is to first print all the numbers up to n of one parity (odd or even), and then print all the numbers of the opposite parity. This is because the difference between consecutive odd numbers is always greater than 1.

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

Imagine the grid as a layered structure where each layer wraps around the previous one. The largest of (x, y) tells you which layer you’re standing on. The starting number in the layer is given by $max(x, y) * max(x, y)$. The number in the grid square is the starting number in the layer plus the distance from the starting square. 

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;
 
int main() {
    int t; // Number of test cases
    cin >> t;
    while (t--) {
        // Cell coordinates
        long long y, x; 
        cin >> y >> x;
        long long layer = max(x, y); // Layer is max(x, y)
        long long val = layer * layer - layer + 1; // Base value for layer's diagonal cell
 
        if (layer % 2 == 0) // Even layer
            if (x == layer) // Adjust for y
                cout << val - (layer - y) << "\n"; 
            else // Adjust for x
                cout << val + (layer - x) << "\n";   
                
        else // Odd layer
            if (y == layer) // Adjust for x
                cout << val - (layer - x) << "\n";
            else // Adjust for y
                cout << val + (layer - y) << "\n";
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

The sum of the first n integers is given by : $n(n+1)/2$

Only when this sum is even can the set be split evenly, i.e. $n * (n-1)$ should be divisble by four. Notice the the values of n which satisy the above condition are of the form 4n or 4n - 1 (eg : 3, 4, 7, 8, 11, 12 ....).

Every time the numbers can be paired off symmetrically: {n, n−3} balancing {n−1, n−2}. Anything leftover (the magical trio 1,2,3) slots in with a final tidy arrangement. This pattern ensures the two sets always weigh the same, no matter how large n grows.

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;
 
int main() {
    int n;
    cin >> n;
    
    // Check if the total sum n*(n+1)/2 is even (i.e., divisible by 2 after halving),
    // which requires n*(n+1) to be divisible by 4. If not, impossible to split.
    if (n*(n+1) % 4 != 0) cout<<"NO";
    
    else {
        cout<<"YES"<<endl;
        
        // Vectors to store the two sets.
        vector<int> a, b;
        
        // Process numbers in groups of 4 from largest to smallest,
        // assigning to sets such that each group adds equal sum to both.
        while (n > 3 && n > 0) {
                a.push_back(n);
                a.push_back(n-3);
 
                b.push_back(n-1);
                b.push_back(n-2);
                
                n = n - 4;
        }
        
        // Handle the remaining 3 numbers if n % 4 == 3 (balanced assignment).
        if (n == 3) {
            a.push_back(3);
            
            b.push_back(2);
            b.push_back(1);
        }
        
        // Output size and elements 
        cout << a.size()<<endl;
        for (int num : a)
            cout << num << " ";
 
        cout << b.size()<<endl;
        for (int num : b)
            cout << num << " ";
    }
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

Each of the n positions can be either 0 or 1, so the answer is simply $2^n$. We compute the power iteratively while taking remainders modulo 1e9+7 to avoid overflow.

\

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

int main() {
    const long long MOD = 1e9 + 7;
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

`Eg` : n = 27
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

To move n disks, first move the top n−1 disks to the helper peg, then move the largest disk to the destination, and finally move the stack from the helper to the destination. This recursion yields 2^n − 1 moves and provides the lexicographical simple solution.

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

In c++ there is a very useful function called 'next_permutation' which helps us tackle this exact question. This function can be used to generate the next lexicographical sequence for a string or a vector.

It returns false when no other greater permutations exists, otherwise it rearranges the string or the vector.

Note : Apurva add your explanation to the next permutation question...

Note : explain meaning of lexicographical down below

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

int main() {
    int n;
    cin >> n;

    vector<int> v(n);
    long long total = 0;

    // Read weights and compute total sum.
    for (int i = 0; i < n; i++) {
        cin >> v[i];
        total += v[i];
    }

    // ans = minimum possible difference between the two groups.
    long long ans = total;

    // Enumerate all subsets using bitmasks from 0 to (2^n - 1).
    // Each mask chooses some apples for the first group;
    // the rest naturally fall into the second group.
    for (int mask = 0; mask < (1 << n); mask++) {

        long long sum = 0;

        // Compute sum of elements included in this subset.
        for (int i = 0; i < n; i++) {
            if (mask & (1 << i)) {
                sum += v[i];
            }
        }

        // If subset sum is S, the other group's sum is total - S.
        // Difference is |(total - S) - S| = |total - 2S|.
        ans = min(ans, llabs(total - 2 * sum));
    }

    cout << ans;
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

*Explanation* : 

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

= Sorting and Searching

== Distinct Numbers

*Question*

#link("https://cses.fi/problemset/task/1621")[Question - Distinct Numbers]
#h(0.5cm)
#link("https://web.archive.org/web/20250717130805/https://www.cses.fi/problemset/task/1621/")[Backup Link]

*Explanation*

Accept all the numbers and insert them into a set. Then report the size of the set. This works due to the fact that a set only stores unique elements and removes duplicates.

//TODO: Add link to more about sets in the context part
More about sets can be found here.

*Solution*

```cpp 

#include <bits/stdc++.h>
using namespace std;

int main(){
	ios_base::sync_with_stdio(0);
	cin.tie(0);
	cout.tie(0);

	int n;
	cin >> n;
	set<int> s;
	for(int i = 0; i < n; i++){
		int x;
		cin >> x;
		s.insert(x);
	}
	cout << s.size() << endl;
	return 0;
}
```
#pagebreak()
== Apartments

\
#link("https://cses.fi/problemset/task/1084")[Question - Apartments]
#h(0.5cm)
#link("https://web.archive.org/web/20250805032036/https://cses.fi/problemset/task/1084")[Backup Link]


\

*Explanation : * 

The algorithm sorts both applicants and apartments, then uses a two pointer approach to match each applicant with the smallest available apartment whose size differs by at most `k`.
If an apartment is too small, move to the next apartment; if it’s too large, move to the next applicant.
This greedy method ensures the maximum number of matches efficiently.

\

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;
 
int main() {
    int n, m, k;
    cin >> n >> m >> k;
    
    vector<int> applicants(n), apartments(m);
    
    // Read applicant preferences
    for (int i = 0; i < n; i++)
        cin >> applicants[i];

    // Read apartment sizes
    for (int i = 0; i < m; i++)
        cin >> apartments[i];
    
    // Sort both arrays
    sort(applicants.begin(), applicants.end());
    sort(apartments.begin(), apartments.end());
    
    int count = 0;
    int i = 0, j = 0;
    
    // Two-pointer approach to match applicants to apartments
    while (i < n && j < m) {
        // Check if current apartment fits current applicant's preference
        if (abs(applicants[i] - apartments[j]) <= k) {
            count++;
            i++;
            j++;
        } 
        // If apartment is too small, try next apartment
        else if (applicants[i] - apartments[j] > k) {
            j++;
        }
        // If apartment is too big, try next applicant
        else {
            i++;
        }
    }
    
    cout << count << endl;
    return 0;
}

```
#pagebreak()

== Ferris Wheel

\
#link("https://cses.fi/problemset/task/1090")[Question - Ferris Wheel]
#h(0.5cm)
#link("https://web.archive.org/web/20250810185820/https://cses.fi/problemset/task/1090")[Backup Link]


\

*Explanation : *

The algorithm sorts all weights, then uses two pointer, one at the lightest and one at the heaviest person, to form pairs without exceeding the limit. If they can share a gondola, both are removed; otherwise, the heavier one goes alone. This greedy pairing minimizes the total number of gondolas.

\

*Code :*

```cpp  
#include <bits/.stdc++.h>
using namespace std;
 
int main() {
    int n, x;
    cin >> n >> x;
    
    vector<int> weights(n);
    for (int i = 0; i < n; i++) {
        cin >> weights[i];
    }
    
    // Sort the weights
    sort(weights.begin(), weights.end());
    
    int gondolas = 0;
    int left = 0, right = n - 1;
    
    while (left <= right) {
        // If heaviest and lightest can share a gondola
        if (weights[left] + weights[right] <= x) {
            left++;
            right--;
        }
        // Otherwise, heaviest gets their own gondola
        else {
            right--;
        }
        gondolas++;
    }
    
    cout << gondolas << endl;
    
    return 0;
}


```
#pagebreak()
== Concert Tickets

\
#link("https://cses.fi/problemset/task/1091")[Question - Concert Tickets]
#h(0.5cm)
#link("https://web.archive.org/web/20250810225423/https://cses.fi/problemset/task/1091")[Backup Link]


\

*Intuitive Explanation* : 

Store all ticket prices in a multiset to keep them sorted and allow duplicates. For each customer budget, find the first ticket strictly greater than their offer using `upper_bound`; the valid choice is the previous ticket (largest price not exceeding the budget). If no such ticket exists, print -1, otherwise sell it and remove it from the multiset to avoid reuse.

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
    multiset<int> tickets;
    for (int i = 0; i < n; i++) {
        int price;
        cin >> price;
        tickets.insert(price);
    }

    for (int i = 0; i < m; i++) {
        int offer;
        cin >> offer;

        // First element strictly greater than offer
        auto it = tickets.upper_bound(offer);
        if (it == tickets.begin()) {
            cout << -1 << "\n"; // no ticket affordable
        } else {
            --it;                // best affordable ticket
            cout << *it << "\n";
            tickets.erase(it);   // remove sold ticket
        }
    }
    return 0;
}

```
#pagebreak()
== Restaurant Customers

\
#link("https://cses.fi/problemset/task/1619")[Question - Restaurant Customers]
#h(0.5cm)
#link("https://web.archive.org/web/20250810190946/https://cses.fi/problemset/task/1619/")[Backup Link]

\
*Explanation* : 

The algorithm sorts all arrival and departure times, then uses two pointers to simulate guests entering and leaving. Each arrival increases the current count, and each departure decreases it. The maximum value reached during this sweep gives the peak number of guests present simultaneously.

\

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;
 
int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
 
    int n;
    cin >> n;
    vector<int> arrivals(n), departures(n);
    for (int i = 0; i < n; ++i) {
        cin >> arrivals[i] >> departures[i];
    }

    // Sort arrival and departure times
    sort(arrivals.begin(), arrivals.end());
    sort(departures.begin(), departures.end());

    int i = 0, j = 0, curr = 0, ans = 0;
    // Sweep through both arrays to find maximum overlap
    while (i < n && j < n) {
        if (arrivals[i] < departures[j]) {
            curr++;      // new guest arrives
            ans = max(ans, curr);
            i++;
        } else {
            curr--;      // a guest departs
            j++;
        }
    }

    cout << ans << '\n'; // maximum guests present at once
    return 0;
}


```
#pagebreak()
== Movie Festival

\
#link("https://cses.fi/problemset/task/1629")[Question - Movie Festival]
#h(0.5cm)
#link("https://web.archive.org/web/20250810185808/https://cses.fi/problemset/task/1629")[Backup Link]


\

*Intuitive Explanation* : 

We store each movie as a pair of (end_time, start_time) and sort by end_time so we can always consider the earliest finishing movie first. The greedy approach works because picking the movie that ends earliest leaves maximum time for future movies.

We iterate through all movies, watching one only if it starts after the previous one ends. Each time we do, we increment our count and update the latest end time, ensuring the optimal number of movies are chosen.


*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n; 
    cin >> n;

    // Store each movie as a pair (end_time, start_time)
    vector<pair<int, int>> movies(n);
    for (int i = 0; i < n; ++i) {
        int start, end;
        cin >> start >> end;
        movies[i] = {end, start};
    }

    // Sort movies by their ending time (greedy choice)
    sort(movies.begin(), movies.end());

    int maxMovies = 0;
    int currentEnd = 0;  // The end time of the last watched movie

    // Iterate through all movies
    for (auto [end, start] : movies) {
        // If the current movie starts after or exactly when the previous one ended
        if (start >= currentEnd) {
            maxMovies++;       // Watch this movie
            currentEnd = end;  // Update the end time to this movie's end
        }
    }

    cout << maxMovies << endl; // Output the result
    return 0;
}


```
#pagebreak()
== Sum of Two Values

\
#link("https://cses.fi/problemset/task/1640")[Question - Sum of Two Values]
#h(0.5cm)
#link("https://web.archive.org/web/20250810185011/https://cses.fi/problemset/task/1640")[Backup Link]


\

*Explanation* : 

The algorithm sorts all numbers, then uses two pointers—one starting at the smallest and one at the largest value—to find a pair that sums to the target. If the sum is too small, the left pointer moves right; if too large, the right pointer moves left.
This efficiently finds the correct pair in linear time after sorting.


\
*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n, target;
    cin >> n >> target;

    // Store each number along with its original index
    vector<pair<int, int>> nums(n);
    for (int i = 0; i < n; i++) {
        // number value
        cin >> nums[i].first;
        
        // original position (1-based index)   
        nums[i].second = i + 1; 
    }

    // Sort numbers by value to apply two-pointer technique
    sort(nums.begin(), nums.end());

    int left = 0, right = n - 1;
    while (left < right) {
        int sum = nums[left].first + nums[right].first;

        // If target sum found, print their original indices
        if (sum == target) {
            cout << nums[left].second << " " << nums[right].second;
            return 0;
        }
        // Move pointers based on comparison with target
        else if (sum < target) left++;
        else right--;
    }

    // If no valid pair found
    cout << "IMPOSSIBLE";
    return 0;
}


```
#pagebreak()
== Maximum Subarray 

\
#link("https://cses.fi/problemset/task/1643")[Question - Maximum Subarray Sum]
#h(0.5cm)
#link("https://web.archive.org/web/20250810203355/https://cses.fi/problemset/task/1643")[Backup Link]

\

*Intuitive Explanation* : 

The algorithm finds the maximum possible sum of a continuous sequence in an array. It begins by assuming the first element is the best sum. Then, as it moves through the array, it decides whether to keep adding to the current streak or start fresh from the current number. At each step, it updates the overall best sum found so far, ensuring the final answer is the largest contiguous total.

\

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n;
    cin >> n;

    vector<long long> arr(n);
    for (int i = 0; i < n; i++) {
        cin >> arr[i];  
    }

    // max_current = maximum subarray sum ending at the current index
    // max_global = overall maximum subarray sum found so far
    long long max_current = arr[0];
    long long max_global = arr[0];

    // Iterate through the array
    for (int i = 1; i < n; i++) {
        // Either start a new subarray at arr[i] or extend the existing one
        max_current = max(arr[i], max_current + arr[i]);

        // Update the global maximum if needed
        max_global = max(max_global, max_current);
    }

    // Output the maximum subarray sum
    cout << max_global << endl;
    return 0;
}



```
#pagebreak()
== Stick Lengths

\
#link("https://cses.fi/problemset/task/1074")[Question - Stick Lengths]
#h(0.5cm)
#link("https://web.archive.org/web/20250810205806/https://cses.fi/problemset/task/1074")[Backup Link]


\

*Intuitive Explanation* : 

The program minimizes the total adjustment cost to make all sticks equal in length. It sorts the stick lengths and picks the median as the target length since the median minimizes the sum of absolute differences. Unlike the mean, which minimizes squared differences, the median ensures minimal total movement for all sticks.

That might sound technical and complicated, so here’s an easier way to picture it:

Intuitively, the median balances the values — half the sticks are shorter and half are longer — so adjusting everything toward it requires the least total effort. If you chose the mean, extreme stick lengths would pull the target toward them, increasing the total distance everyone else has to adjust, whereas the median stays steady and fair, unaffected by outliers.


*Code :*


```cpp  
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n;
    cin >> n;

    vector<int> v(n);
    for (int i = 0; i < n; i++)
        cin >> v[i];

    // Sort the array in ascending order
    sort(v.begin(), v.end());

    // Choose the middle element (median) as the central value
    int c = v[v.size() / 2];

    long long ans = 0;
    // Calculate the total distance of all elements from the median
    for (int i = 0; i < n; i++) 
        ans += abs(v[i] - c);

    // Output the minimum total distance
    cout << ans;
}

```
#pagebreak()
== Missing Coin Sum

\
#link("https://cses.fi/problemset/task/2183")[Question - Missing Coin Sum]
#h(0.5cm)
#link("https://web.archive.org/web/20250810195049/https://cses.fi/problemset/task/2183")[Backup Link]


\

*Intuitive Explanation* : 


Sorting the Coins: By sorting the coins in non-decreasing order, we can process them greedily. 

Greedy Approach:
Initialize a variable `sumSoFar` to 0, representing the maximum sum we can create with the coins processed so far.

For each coin value `currCoin` :
If `currCoin` is greater than `sumSoFar + 1`, it means we cannot create the sum `sumSoFar + 1` (since all remaining coins are too large). Thus, `sumSoFar` + 1 is the answer. Otherwise, add `currCoin to sumSoFar`, as we can now create all sums up to `sumSoFar + currCoin` by including or excluding `currCoin` in subsets.

If we process all coins without finding a gap, the smallest sum we cannot create is current_max + 1.

Why This Works:
If we can create all sums from 0 to `sumSoFar`, and the next coin `currCoin` is at most `sumSoFar + 1`, we can extend the range of creatable sums to `sumSoFar + currCoin`. 
A gap occurs when a coin is too large to fill the next sum (`sumSoFar + 1`), making that sum impossible to form.

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

    vector<long long> coins(n);
    for (int i = 0; i < n; i++) cin >> coins[i];
    sort(coins.begin(), coins.end());

    long long sumSoFar = 0;  
    // We can currently form all sums from 1 to sumSoFar.

    for (long long currCoin : coins) {

        // If the next needed sum is sumSoFar + 1 and currCoin is bigger,
        // we cannot fill that gap.
        if (currCoin > sumSoFar + 1) {
            cout << sumSoFar + 1 << "\n";
            return 0;
        }

        // Otherwise, currCoin helps us extend reachable sums.
        sumSoFar += currCoin;
    }

    // If all coins processed and no gap found, next unreachable sum is sumSoFar + 1.
    cout << sumS

```
#pagebreak()

== Collecting Numbers

\
#link("https://cses.fi/problemset/task/2216")[Question - Collecting Numbers]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/2216")[Backup Link]


\

*Explanation* : 

The array is a permutation of 1…n. Reading the numbers in increasing order takes one pass, but every time the position of i+1 appears before the position of i we need an extra round. Counting such inversions between consecutive numbers and adding one gives the total number of passes required.

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
    vector<int> pos(n + 1);
    for (int i = 1; i <= n; ++i) {
        int x;
        cin >> x;
        pos[x] = i;
    }
    int rounds = 1;
    for (int v = 1; v < n; ++v) {
        if (pos[v] > pos[v + 1]) rounds++;
    }
    cout << rounds << "\n";
    return 0;
}
```
#pagebreak()

== Collecting Numbers II

\
#link("https://cses.fi/problemset/task/2217")[Question - Collecting Numbers II]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/2217")[Backup Link]


\

*Explanation* : 

The answer depends only on the order of consecutive values: each pair (v, v+1) adds one round if position[v] > position[v+1]. Swapping two elements changes only the pairs around those values, so we adjust the count locally before and after the swap instead of recomputing from scratch.

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
    vector<int> p(n + 1), pos(n + 1);
    for (int i = 1; i <= n; ++i) {
        cin >> p[i];
        pos[p[i]] = i;
    }

    auto contributes = [&](int v) -> int {
        if (v < 1 || v >= n) return 0;
        return pos[v] > pos[v + 1];
    };

    int rounds = 1;
    for (int v = 1; v < n; ++v) rounds += contributes(v);

    while (m--) {
        int a, b;
        cin >> a >> b;
        int x = p[a], y = p[b];

        vector<int> vals = {x - 1, x, y - 1, y};
        for (int v : vals) rounds -= contributes(v);

        swap(p[a], p[b]);
        pos[x] = b;
        pos[y] = a;

        for (int v : vals) rounds += contributes(v);

        cout << rounds << "\n";
    }
    return 0;
}
```
#pagebreak()

== Playlist

\
#link("https://cses.fi/problemset/task/1141")[Question - Playlist]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/1141")[Backup Link]


\

*Explanation* : 

The trick is to slide a window across the array while keeping all its elements distinct. A set tracks which songs are currently inside the window: if the next song is already present, we shrink the window from the left until the duplicate disappears. Otherwise we extend the window to include it. As the window grows and shrinks, we keep updating the maximum length, which becomes the length of the longest playlist with all unique songs.


\
*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n;
    cin >> n;

    // Read the array
    vector<int> v(n);
    for (int i = 0; i < n; i++) {
        cin >> v[i];
    }

    // Sliding window to find the longest subarray with all distinct elements.
    set<int> window;     // stores current distinct elements inside the window
    int left = 0;        // left pointer of the window
    int right = 0;       // right pointer of the window
    int bestLen = 0;     // maximum size found

    // Expand the window using 'right'
    while (right < n) {
        // If v[right] already exists, shrink the window from the left
        // until v[right] can be inserted without duplicates.
        if (window.count(v[right])) {
            window.erase(v[left]);
            left++;
        } 
        else {
            // Element is unique in the window — include it
            window.insert(v[right]);

            // Update max length
            bestLen = max(bestLen, right - left + 1);

            // Move right pointer forward
            right++;
        }
    }

    cout << bestLen;
    return 0;
}

```
#pagebreak()

== Towers

\
#link("https://cses.fi/problemset/task/1073")[Question - Towers]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/1073")[Backup Link]


\

*Explanation* : 

Keep the top block of every tower in a multiset. For each block, place it on the tower with the smallest top strictly greater than the block (found via `upper_bound`); if none exists, start a new tower. The multiset size after all placements is the answer.

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
    multiset<int> tops;
    for (int i = 0; i < n; ++i) {
        int x;
        cin >> x;
        auto it = tops.upper_bound(x);
        if (it != tops.end()) tops.erase(it);
        tops.insert(x);
    }
    cout << tops.size() << "\n";
    return 0;
}
```
#pagebreak()

== Traffic Lights

\
#link("https://cses.fi/problemset/task/1618")[Question - Trailing Zeros]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1618")[Backup Link]

\

*Intuitive Explanation* : 

The program simulates cutting a stick of length `a` at `b` given positions. It uses a multiset ms to store all cut points and another multiset lens to track segment lengths. After each cut, it removes the old segment and adds two new ones. Finally, it prints the length of the largest segment remaining after each cut.

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;
 
int main() {
    int a, b, x;
    cin >> a >> b;
 
    multiset<int> ms, lens; // ms stores all cut positions, lens stores all segment lengths
    ms.insert(a); // rightmost boundary
    ms.insert(0); // leftmost boundary
    lens.insert(a); // initially one segment of length 'a'
    
    for (int i = 0; i < b; i++) {
        cin >> x;
 
        // Insert the new cut position and find its neighbors
        auto mid = ms.insert(x);
        auto first = prev(mid);
        auto last = next(mid);
 
        // Remove the old segment and add the two new smaller segments
        lens.erase(lens.find(*last - *first));
        lens.insert(*last - *mid);
        lens.insert(*mid - *first);
 
        // Output the largest segment length after each cut
        cout << *lens.rbegin() << " ";
    }
}


```


#pagebreak()

== Room Allocation

\
#link("https://cses.fi/problemset/task/1164")[Question - Room Allocation]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/1164")[Backup Link]


\

*Explanation* : 

Sort all bookings by start time. Use a priority queue of (end_time, room_id) to free the earliest-finished room that is available when a new booking starts; otherwise assign a new room. Track assignments for each original booking and the maximum rooms used.

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
    vector<tuple<int,int,int>> intervals(n);
    for (int i = 0; i < n; ++i) {
        int s, e;
        cin >> s >> e;
        intervals[i] = {s, e, i};
    }
    sort(intervals.begin(), intervals.end());

    priority_queue<pair<int,int>, vector<pair<int,int>>, greater<pair<int,int>>> pq;
    vector<int> room(n);
    int roomsUsed = 0;

    for (auto [s, e, idx] : intervals) {
        if (!pq.empty() && pq.top().first < s + 1) {
            auto [endTime, id] = pq.top();
            pq.pop();
            room[idx] = id;
            pq.push({e, id});
        } else {
            int id = ++roomsUsed;
            room[idx] = id;
            pq.push({e, id});
        }
    }

    cout << roomsUsed << "\n";
    for (int i = 0; i < n; ++i) {
        cout << room[i] << (i + 1 == n ? '\n' : ' ');
    }
    return 0;
}
```
#pagebreak()

== Factory Machines

\
#link("https://cses.fi/problemset/task/1620")[Question - Factory Machines]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/1620")[Backup Link]


\

*Explanation* : 

Binary search the smallest time `t` such that the sum of `t / time[i]` across all machines is at least the required product count. The predicate is monotonic, so doubling the upper bound until it works and then searching between bounds yields the minimal feasible time.

\
*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n;
    long long target;
    cin >> n >> target;
    vector<long long> m(n);
    for (int i = 0; i < n; ++i) cin >> m[i];

    auto can = [&](long long time) {
        long long made = 0;
        for (long long t : m) {
            made += time / t;
            if (made >= target) return true;
        }
        return false;
    };

    long long lo = 0, hi = 1;
    while (!can(hi)) hi <<= 1;
    while (lo < hi) {
        long long mid = lo + (hi - lo) / 2;
        if (can(mid)) hi = mid;
        else lo = mid + 1;
    }
    cout << lo << "\n";
    return 0;
}
```
#pagebreak()

== Tasks and Deadlines

\
#link("https://cses.fi/problemset/task/1630")[Question - Tasks and Deadlines]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/1630")[Backup Link]


\

*Explanation* : 

The total reward is `sum(deadline) - sum(completion_time)`, so maximizing reward is minimizing the sum of completion times. Sorting tasks by duration and processing in that order keeps the running finish time as small as possible and thus maximizes the final reward.

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
    vector<pair<long long,long long>> tasks(n);
    for (int i = 0; i < n; ++i) cin >> tasks[i].first >> tasks[i].second;

    sort(tasks.begin(), tasks.end());

    long long time = 0, reward = 0;
    for (auto [duration, deadline] : tasks) {
        time += duration;
        reward += deadline - time;
    }
    cout << reward << "\n";
    return 0;
}
```
#pagebreak()

== Reading Books

\
#link("https://cses.fi/problemset/task/1631")[Question - Reading Books]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/1631")[Backup Link]


\

*Explanation* : 

Two readers can work in parallel, so the minimal finishing time is the larger of the total sum of pages and twice the size of the longest book. If the biggest book dominates, the other reader waits for it; otherwise the total workload dictates the time.

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
    long long sum = 0, mx = 0;
    for (int i = 0; i < n; ++i) {
        long long x;
        cin >> x;
        sum += x;
        mx = max(mx, x);
    }
    cout << max(sum, 2 * mx) << "\n";
    return 0;
}
```
#pagebreak()

== Sum of Three Values

\
#link("https://cses.fi/problemset/task/1641")[Question - Sum of Three Values]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/1641")[Backup Link]


\

*Explanation* : 

Sort all numbers with their original indices. For each first element, use the two-pointer technique on the remaining range to find two more elements that complete the target sum. If found, print their original 1-based indices; otherwise the task is impossible.

\

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n;
    long long target;
    cin >> n >> target;
    vector<pair<long long,int>> a(n);
    for (int i = 0; i < n; ++i) {
        cin >> a[i].first;
        a[i].second = i + 1;
    }
    sort(a.begin(), a.end());

    for (int i = 0; i < n; ++i) {
        long long need = target - a[i].first;
        int l = i + 1, r = n - 1;
        while (l < r) {
            long long sum = a[l].first + a[r].first;
            if (sum == need) {
                cout << a[i].second << " " << a[l].second << " " << a[r].second << "\n";
                return 0;
            } else if (sum < need) l++;
            else r--;
        }
    }
    cout << "IMPOSSIBLE\n";
    return 0;
}
```
#pagebreak()

== Sum of Four Values

\
#link("https://cses.fi/problemset/task/1642")[Question - Sum of Four Values]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/1642")[Backup Link]


\

*Explanation* : 

Store all pair sums formed entirely before the current index. When considering a new pair (i, j), look for a previously stored pair whose sum completes the target and whose indices are all distinct. Using a map from sum to list of earlier pairs ensures we find a valid quadruple if one exists.

\

*Code :*

```cpp  
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n;
    long long target;
    cin >> n >> target;
    vector<long long> a(n);
    for (int i = 0; i < n; ++i) cin >> a[i];

    unordered_map<long long, vector<pair<int,int>>> sums;

    for (int i = 0; i < n; ++i) {
        for (int j = i + 1; j < n; ++j) {
            long long need = target - (a[i] + a[j]);
            if (sums.count(need)) {
                for (auto [p, q] : sums[need]) {
                    if (p != i && p != j && q != i && q != j) {
                        cout << p + 1 << " " << q + 1 << " " << i + 1 << " " << j + 1 << "\n";
                        return 0;
                    }
                }
            }
        }
        for (int j = 0; j < i; ++j) {
            sums[a[i] + a[j]].push_back({j, i});
        }
    }
    cout << "IMPOSSIBLE\n";
    return 0;
}
```
#pagebreak()

== Nearest Smaller Values

\
#link("https://cses.fi/problemset/task/1618")[Question - Trailing Zeros]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1618")[Backup Link]


\

*Intuitive Explanation* : 

We use a set of pairs (value, index) to maintain a sorted collection of elements seen so far. The lower_bound function efficiently locates the first element not smaller than the current value, allowing quick access to the previous smaller element by moving one step back. After each iteration, larger or equal elements are erased to maintain order and correctness.

*Code :*

```cpp  

#include <bits/stdc++.h>
using namespace std;
using ll = long long;

int main() {
    ll n, a;
    cin >> n;
    set<pair<ll,ll>> s;  // Stores pairs of (value, index) in sorted order by value

    for (int i = 0; i < n; i++) {
        cin >> a;

        // Find the first element in the set whose value >= current value 'a'
        auto it = s.lower_bound({a, -1});

        // If there's no smaller value, output 0
        if (it == s.begin()) cout << "0 ";
        else {
            // Otherwise, go one step back to get the last smaller element
            --it;
            cout << it->second + 1 << " ";  // Output its index (1-based)
        }

        // Remove all elements with value >= 'a' (not needed anymore)
        auto it2 = s.lower_bound({a, -1});
        s.erase(it2, s.end());

        // Insert current element (value, index)
        s.insert({a, i});
    }
}


```
