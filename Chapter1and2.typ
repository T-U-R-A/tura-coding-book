#import "@preview/board-n-pieces:0.7.0": *

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
+ It keeps track of the maximum streak found.

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
#link("https://cses.fi/problemset/task/1163")[Question - Traffic Lights]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/1163")[Backup Link]


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

The spiral fills outward in square layers, where layer $L$ contains all cells with $max(x, y) = L$. Each layer's diagonal cell $(L, L)$ holds the value $L^2-(L-1)$ because at the $L$th layer, the value $L^2$ is at one of the edges and then to go from there to the diagonal, subtract $(L-1)$. This value serves as our anchor point.



*The key insight:*

- Even layers fill downward then leftward, while odd layers fill rightward then upward. So for even layers, if you're on the rightmost edge (x=L), you subtract how far down you are from the diagonal; otherwise you're on the top edge, so add how far left you are.

- Odd layers work inversely: if you're on the top edge (y=L), subtract your leftward distance; otherwise you're on the left edge, so add your downward distance.
This directional pattern emerges because the spiral alternates its filling direction with each layer to maintain continuity.

\

*Example:* y = 5, x = 3


#table(
  columns: 5,

  fill: (x, y) => if (x == 2 and y == 4) { green.lighten(60%) } else if (x == 4 and y == 4) {
    yellow.lighten(60%)
  } else if x == 4 or y == 4 { red.lighten(60%) },

  [1], [2], [9], [10], [25],
  [4], [3], [8], [11], [24],
  [5], [6], [7], [12], [23],
  [16], [15], [14], [13], [22],
  [17], [18], [19], [20], [21],
)
\

*Algorithm (Step by Step Flow):*

+ As $max(5, 3) = 5$, It is on the 5th layer.

+ $L^2 - (L - 1)$ = $25 - (5 - 1)$ = $21$. 21 serves as our anchor point.

+ It is important to keep it mind that we are on an odd layer(as 5 is odd).

+ And as we have to go two cells to the left from our anchor point we subtract our leftward distance. Thus, answer $= 21 - 2 = 19$.


\
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

We start by counting the frequency of each letter. If there is an even number of characters, odd frequencies are not allowed, since a palindrome would be impossible. If there is an odd number of characters, only one letter with an odd frequency is allowed, as it can be placed in the center (for example, “aba”). Otherwise, the program builds the palindrome by placing characters symmetrically from both ends and putting any leftover odd-frequency character in the middle. The final constructed string is then printed, completing the rearrangement.

*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    string s;
    cin >> s; // Read input string

    int arr[26] = {}; // frequency array for letters A–Z (all initialized to 0)

    // Count how many times each character appears
    for (char c : s)
        arr[c - 'A']++;

    // Count how many characters have odd frequencies
    int oddCount = 0;
    for (int i = 0; i < 26; i++)
        if (arr[i] % 2 != 0)
            oddCount++;

    // Palindrome rule:
    // - If string length is even → no odd frequencies allowed
    // - If string length is odd  → exactly one odd frequency allowed
    if (oddCount > 1 && s.size() % 2 == 1) {
        cout << "NO SOLUTION"; // too many odd-count letters
        return 0;
    }
    else if (oddCount > 0 && s.size() % 2 == 0) {
        cout << "NO SOLUTION"; // even-length string with odd-count letters
        return 0;
    }
    else {
        // Container to build the palindrome result
        vector<char> str(s.length());
        int left = 0, right = s.length() - 1;

        // Fill symmetric pairs from both sides
        for (int i = 0; i < 26; i++) {
            while (arr[i] >= 2) {
                str[left++] = (char)('A' + i);   // place letter on left side
                str[right--] = (char)('A' + i);  // place same letter on right
                arr[i] -= 2; // remove two occurrences
            }
        }

        // If one odd-count character remains, put it in the middle
        for (int i = 0; i < 26; i++)
            if (arr[i] == 1)
                str[left] = (char)('A' + i);

        // Convert vector<char> back to a string
        s = string(str.begin(), str.end());

        // Print the final palindrome
        cout << s << endl;
        return 0;
    }
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

The problem asks you to split the apples into two groups so that their total weights differ as little as possible. By checking every subset with bitmasks, you compute the sum of one group and compare it with the other using `abs(total − 2*sum)`. The smallest such difference across all subsets is the optimal answer.

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

This is a clear implementation of a Breadth-First Search (BFS#footnote[Breadth-First Search Algorithim was previously explained and is used in multiple areas in competitive programming]) algorithm to find the minimum number of knight moves required to reach a target position on a chessboard from the starting position (0, 0). The BFS algorithm ensures that we explore all possible moves level by level, guaranteeing the shortest path to the target.

A visual understanding of the algorithm can be found in the image below:

#board(
  fen("n1n5/2nn4/1n6/3n4/n1n5/8/8/8 w - - 0 1"),

  arrows: ("a8 b6", "a8 c7", "b6 a4", "b6 c4", "b6 d5", "b6 d7", "b6 c8"),
  display-numbers: true,

  white-square-fill: rgb("#e9f3ea"),
  black-square-fill: rgb("#278bc4"),
  white-mark: marks.cross(paint: rgb("#2bcbC6")),
  black-mark: marks.cross(paint: rgb("#2bcbC6")),
  arrow-fill: rgb("#f4a338df"),
  arrow-thickness: 0.25cm,

  stroke: 0.8pt + black,
)

You move from the knight to all unvisited grid. This approach guarantess the shortest path to the target.

\

*Code :*

```cpp
#include <bits/stdc++.h>

using namespace std;

int main() {
    int n;
    cin >> n;

    // Initialize distance matrix with -1 (unvisited)
    vector<vector<int>> dist(n, vector<int>(n, -1));

    // Queue for BFS traversal
    queue<pair<int, int>> q;

    // Knight move offsets (8 possible L-shaped moves)
    vector<int> dx = {-2, -1, 2, 1, 2, 1, -1, -2};
    vector<int> dy = {-1, -2, 1, 2, -1, -2, 2, 1};

    // Check if position is within bounds and unvisited
    auto isValid = [&](int x, int y) {
        return x >= 0 && y >= 0 && x < n && y < n && dist[x][y] == -1;
    };

    // Start BFS from top-left corner
    dist[0][0] = 0;
    q.push({0, 0});

    // BFS traversal
    while (!q.empty()) {
        auto [x, y] = q.front();
        q.pop();

        // Explore all 8 knight moves
        for (int k = 0; k < 8; k++) {
            int nx = x + dx[k];
            int ny = y + dy[k];

            if (isValid(nx, ny)) {
                dist[nx][ny] = dist[x][y] + 1;
                q.push({nx, ny});
            }
        }
    }

    // Output the distance matrix
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            cout << dist[i][j] << " ";
        }
        cout << endl;
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

For each cell maintain an array of 4 booleans tracking which colors (A-D) are available. Now there are three conditions:

+ Mark the current cell's original color as invalid.
+ Mark the color of the cell above it in the `ans` grid as invalid.
+ Mark the color of the cell to the left of it in the `ans` grid as invalid.

Now we can greedily assign the first available color to the ans grid. As there are 4 colors and
only 3 conditions, we can always find a valid color.

*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n, m;
    cin >> n >> m;

    vector<string> v(n);        // Input grid
    char ans[n][m];             // Output grid with adjusted characters

    // Read the input grid
    for (int i = 0; i < n; i++)
        cin >> v[i];

    // Construct the output grid
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {

            // Tracks whether letters A, B, C, D are allowed at this cell
            bool isValid[4] = {true, true, true, true};

            // Block the original character in this position
            isValid[v[i][j] - 'A'] = false;

            // Block the character above (if exists)
            if (i > 0)
                isValid[ans[i - 1][j] - 'A'] = false;

            // Block the character to the left (if exists)
            if (j > 0)
                isValid[ans[i][j - 1] - 'A'] = false;

            // Choose the first valid character using your four ifs
            if (isValid[0])
                ans[i][j] = 'A';
            else if (isValid[1])
                ans[i][j] = 'B';
            else if (isValid[2])
                ans[i][j] = 'C';
            else if (isValid[3])
                ans[i][j] = 'D';
        }
    }

    // Print the final grid
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++)
            cout << ans[i][j];
        cout << "\n";
    }
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

The trick is to notice that numbers form blocks by digit-length: 1–9 (1-digit), 10–99 (2-digit), 100–999 (3-digit), and so on. Each block contributes a predictable number of digits, so the code keeps subtracting whole blocks until the target digit falls inside one specific block. Once the block is located, it directly computes which exact number contains the digit, converts that number to a string, and extracts the correct character. This avoids generating any sequence and keeps the solution fast even for huge positions.


*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int q;
    cin >> q;

    while (q--) {
        ll n;
        cin >> n;

        ll count = 9;     // how many numbers exist with current digit-length
        ll len = 1;       // current digit-length
        ll start = 1;     // first number of current digit-length

        // skip full digit-blocks (e.g., 1–9, then 10–99, then 100–999...)
        while (n > count * len) {
            n -= count * len;  // remove whole block worth of digits
            start *= 10;       // move to next block's starting number
            count *= 10;       // next block has 10× more numbers
            len++;             // numbers now have one more digit
        }

        // find the exact number containing the nth digit
        ll num = start + (n - 1) / len;

        // pick the specific digit inside that number
        string s = to_string(num);
        cout << s[(n - 1) % len] << "\n";
    }
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

The program rearranges a string so that no two adjacent characters are the same while keeping the result lexicographically smallest.
It maintains a frequency array of remaining letters and builds the answer one character at a time.

At each step, it checks whether a valid rearrangement is still possible by ensuring no character occurs more than half of the remaining length.

If a character is too frequent, it is forced to be chosen immediately to avoid failure.
Otherwise, the smallest lexicographically valid character different from the previous one is selected.

If at any point no valid choice exists, the program outputs -1

*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

// Returns the lexicographically smallest valid next character index
// freq[] stores remaining frequencies of letters A–Z
// prev = -1 means no previous character (first position)
// prev >= 0 means index of previous character used
int minLexPossible(int freq[], int prev) {
    int maxLetter = 0, sum = 0;        // maxLetter = highest frequency, sum = total remaining letters
    int minLetter = -1, maxIndex = 0; // minLetter = smallest valid choice, maxIndex = most frequent letter

    // Find the smallest lexicographically valid letter different from prev
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0 && i != prev) {
            minLetter = i;
            break;
        }
    }

    // Compute total remaining letters and the letter with maximum frequency
    for (int i = 0; i < 26; i++) {
        sum += freq[i];
        if (freq[i] > maxLetter) {
            maxLetter = freq[i];
            maxIndex = i;
        }
    }

    // If any letter appears too often, rearrangement is impossible
    if (maxLetter * 2 > sum + 1) return -1;

    // If the most frequent letter must be placed now to avoid failure, force it
    if (maxLetter * 2 > sum) return maxIndex;

    // Otherwise, choose the smallest lexicographically valid letter
    return minLetter;
}

int main() {
    string s, ans = "";   // s = input string, ans = constructed result
    cin >> s;

    int freq[26] = {0};  // Frequency array for letters A–Z
    for (char c : s) freq[c - 'A']++;

    // Choose the first character (no previous restriction)
    int idx = minLexPossible(freq, -1);
    if (idx == -1) {
        cout << "-1";    // Impossible to form valid string
        return 0;
    }

    ans += char(idx + 'A'); // Append chosen character
    freq[idx]--;            // Decrease its frequency

    // Build the rest of the string character by character
    for (int i = 1; i < s.size(); i++) {
        // Previous character index is ans[i - 1] - 'A'
        idx = minLexPossible(freq, ans[i - 1] - 'A');
        if (idx == -1) {
            cout << "-1"; // No valid continuation
            return 0;
        }
        ans += char(idx + 'A'); // Append next character
        freq[idx]--;            // Update frequency
    }

    cout << ans; // Output the lexicographically smallest valid arrangement
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
#include <bits/stdc++.h>
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

Store all ticket prices in a multiset to keep them sorted and allow duplicates. Each customer gives an offer, and you use `upper_bound` to find the first price strictly greater than that offer, then step one step back to get the best affordable ticket. If such a ticket exists, print it and remove it; otherwise print –1. This algorithm neatly handles each request without iterating through the whole list.


\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n, m, input;
    cin >> n >> m;

    // Multiset to store ticket prices in sorted order
    multiset<int> prices;

    // Store the m offers from customers
    vector<int> offers(m);

    // Insert the n ticket prices into the multiset
    for (int i = 0; i < n; i++) {
        cin >> input;
        prices.insert(input);
    }

    // Read all offers
    for (int i = 0; i < m; i++)
        cin >> offers[i];

    // For each offer, try to find the best possible ticket
    for (int i = 0; i < m; i++) {

        // Find the first price strictly greater than the offer
        auto it = prices.upper_bound(offers[i]);

        // If upper_bound points to begin(), no ticket <= offer exists
        if (it == prices.begin()) {
            cout << "-1" << endl;
        }
        else {
            // Move iterator to the largest price <= offer
            --it;

            // Output that price
            cout << *it << endl;

            // Remove that ticket so it can't be reused
            prices.erase(it);
        }
    }
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
    cout << sumSoFar + 1 << "\n";
    return 0;
}

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

The idea is to maintain the top blocks of all towers in a multiset. For each new block, place it on the leftmost tower whose top is strictly greater; if no such tower exists, you start a new one. This greedy strategy works because always using the smallest possible valid tower keeps future placements flexible. The number of towers equals the size of the multiset.


\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n;
    cin >> n;

    multiset<int> tops; // stores the current top element of each tower

    for (int i = 0; i < n; i++) {
        int x;
        cin >> x;

        // Find first tower whose top > x (we can place x on that tower)
        auto it = tops.upper_bound(x);

        if (it != tops.end()) {
            // Reuse this tower: remove old top and replace with x
            tops.erase(it);
        }
        // Start a new tower or update reused one with top = x
        tops.insert(x);
    }

    // Number of towers equals the number of distinct tops
    cout << tops.size() << '\n';

    return 0;
}

```
#pagebreak()

== Traffic Lights

\
#link("https://cses.fi/problemset/task/1163")[Question - Traffic Lights]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/1163")[Backup Link]

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

== Distinct Values Subarrays

\
#link("https://cses.fi/problemset/task/2162")[Question - Distinct Values Subarrays]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/2162")[Backup Link]

\

*Explanation* :

The problem asks for the number of subarrays where all elements are distinct. We can use a sliding window approach (two pointers). For each right endpoint `r`, we want to find the smallest valid left endpoint `l` such that the subarray `arr[l...r]` has no duplicates. To do this efficiently, we track the last seen position of each element. If `arr[r]` was last seen at `last_pos`, the new valid left bound must be at least `last_pos + 1`. We update our global left pointer to be the maximum of its current value and this new constraint. Then, all subarrays ending at `r` starting from `l` to `r` are valid, contributing `r - l + 1` to the total count.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n;
    cin >> n;
    vector<int> a(n);
    for (int i = 0; i < n; i++) cin >> a[i];

    map<int, int> last_idx;
    ll ans = 0;
    int l = 0;
    for (int r = 0; r < n; r++) {
        if (last_idx.count(a[r])) {
            l = max(l, last_idx[a[r]] + 1);
        }
        last_idx[a[r]] = r;
        ans += (r - l + 1);
    }
    cout << ans << "\n";
    return 0;
}
```
#pagebreak()

== Distinct Values Subsequences

\
#link("https://cses.fi/problemset/task/3421")[Question - Distinct Values Subsequences]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/3421")[Backup Link]

\

*Explanation* :

We need to count the number of subsequences with all distinct elements. Let `dp[i]` be the number of distinct subsequences using a subset of the first `i` elements. When we consider the element `x` at index `i`:
1. We can append `x` to all previous valid subsequences (including the empty one), doubling the count: `2 * dp[i-1]`.
2. However, if `x` has appeared before at index `last[x]`, the subsequences formed by appending the *previous* `x` are already counted. We must subtract those to avoid duplicates. The number of such duplicates is exactly the number of distinct subsequences ending before the previous occurrence, which is `dp[last[x]-1]`.
So, `dp[i] = 2 * dp[i-1] - dp[last[x]-1]`. The final answer is `dp[n] - 1` (excluding the empty subsequence).

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;
const int MOD = 1e9 + 7;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n;
    cin >> n;
    vector<int> x(n);
    for (int i = 0; i < n; i++) cin >> x[i];

    vector<ll> dp(n + 1);
    dp[0] = 1; // Empty subsequence
    map<int, int> last; // value -> 1-based index

    for (int i = 1; i <= n; i++) {
        dp[i] = (2 * dp[i - 1]) % MOD;
        if (last.count(x[i - 1])) {
            int prev = last[x[i - 1]];
            dp[i] = (dp[i] - dp[prev - 1] + MOD) % MOD;
        }
        last[x[i - 1]] = i;
    }

    cout << (dp[n] - 1 + MOD) % MOD << "\n";
    return 0;
}
```
#pagebreak()

== Josephus Problem I

\
#link("https://cses.fi/problemset/task/1624")[Question - Josephus Problem I]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/1624")[Backup Link]

\

*Explanation* :

We store all people in a list, for efficient deletions while moving forward. An iterator walks through the list, skipping one person each time. When the iterator reaches the end, it wraps back to the beginning. Each erased element is printed in order.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n;
    cin >> n;

    list<int> circle;
    for (int i = 1; i <= n; i++)
        circle.push_back(i);

    auto it = circle.begin();

    while (!circle.empty()) {
        // move to the next person (skip one)
        it++;
        if (it == circle.end())
            it = circle.begin();

        cout << *it << " ";

        // erase returns iterator to next element
        it = circle.erase(it);

        if (it == circle.end() && !circle.empty())
            it = circle.begin();
    }

    return 0;
}
```
#pagebreak()

== Josephus Problem II

\
#link("https://cses.fi/problemset/task/1625")[Question - Josephus Problem II]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/1625")[Backup Link]

\

*Explanation* :

Here `k` children are skipped (or we remove the `(k+1)`-th child). Since `k` is large, simple simulation is too slow. We use an Order Statistic Tree (Policy-Based Data Structure) which supports `find_by_order` (find the element at a specific index) and `erase` in O(log n) time.
We maintain the children in the tree. We track the current removal index, updating it as `idx = (idx + k) % current_size` at each step to determine who gets removed next.

\
*Code :*

```cpp
#include <bits/stdc++.h>
#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>
using namespace std;
using namespace __gnu_pbds;

typedef tree<int, null_type, less<int>, rb_tree_tag, tree_order_statistics_node_update> ordered_set;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, k;
    cin >> n >> k;
    ordered_set s;
    for (int i = 1; i <= n; i++) s.insert(i);

    int idx = 0;
    while (!s.empty()) {
        idx = (idx + k) % s.size();
        auto it = s.find_by_order(idx);
        cout << *it << " ";
        s.erase(it);
    }
    cout << "\n";
    return 0;
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

We use a greedy algorithm by sorting customers by their arrival time. For each customer, we check if any previously used room has become free (i.e., its last guest departed before the current guest arrives). We use a multiset to efficiently track rooms by their end times - if a suitable free room exists, we reuse it; otherwise, we allocate a new room. This greedy choice is optimal because assigning an available room to the earliest arriving customer never leads to a worse solution than leaving it empty.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n;
    cin >> n;

    // Store each customer's booking: {start_time, end_time, original_index}
    vector<tuple<int, int, int>> bookings(n);

    for (int i = 0; i < n; i++) {
        int start, end;
        cin >> start >> end;
        bookings[i] = {start, end, i};
    }

    // Sort bookings by start time
    sort(bookings.begin(), bookings.end());

    // Track available rooms: {end_time, room_number}
    // Sorted by end_time to find rooms that become free earliest
    multiset<pair<int, int>> availableRooms;

    vector<int> assignedRoom(n);
    int totalRooms = 0;

    for (const auto& [start, end, originalIndex] : bookings) {
        int roomNumber;

        // Find a room that's free before this booking starts
        // upper_bound finds first room with end_time > start
        // We want the room with end_time <= start, so we go one back
        auto it = availableRooms.upper_bound({start, INT_MAX});

        if (it == availableRooms.begin()) {
            // No available room found - need a new room
            roomNumber = ++totalRooms;
        } else {
            // Reuse an existing room that's now free
            --it;
            roomNumber = it->second;
            availableRooms.erase(it);
        }

        // Mark this room as occupied until 'end' time
        availableRooms.insert({end, roomNumber});
        assignedRoom[originalIndex] = roomNumber;
    }

    // Output results
    cout << totalRooms << "\n";
    for (int room : assignedRoom) {
        cout << room << " ";
    }
    cout << "\n";

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

The key idea is that the number of items produced increases monotonically with time, so we can binary-search the minimum time needed to make at least `t` items. For any guessed time `mid`, we compute how many items all machines together can produce by summing $mid / v[i]$. If the total is ≥ t, we try a smaller time; otherwise, we increase the time. This guarantees we find the earliest moment when production meets the target.


\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;

int main() {

    ll n, t;
    cin >> n >> t;

    // v[i] = time taken by machine i to produce ONE item
    vector<ll> v(n);
    for (int i = 0; i < n; i++) {
        cin >> v[i];
    }

    // Binary search on time.
    // low  = minimum possible time
    // high = a very large upper bound (1e18 works for all constraints)
    ll low = 1, high = 1e18, ans = -1;

    while (low <= high) {
        ll mid = (low + high) / 2;

        // Count how many items all machines can produce in 'mid' time
        ll total = 0;
        for (int i = 0; i < n; i++) {
            total += mid / v[i];

            // If already enough, stop early (avoid overflow + speedup)
            if (total >= t) break;
        }

        // If we can produce at least t items in 'mid' time,
        // try to find an even smaller valid time.
        if (total >= t) {
            ans = mid;
            high = mid - 1;
        }
        else {
            // Not enough items — need more time.
            low = mid + 1;
        }
    }

    cout << ans << "\n";
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

In this problem, we must schedule tasks to maximize total reward, where each task gives a reward only if completed before its deadline.

The intuitive greedy approach is to always prioritize tasks with the shortest durations first, because choosing a long task early delays all subsequent tasks and reduces their chances of meeting deadlines. By sorting tasks by duration and maintaining a timeline, we ensure we fit the maximum number of tasks in the shortest possible time. Whenever adding a new task would exceed its deadline, we can replace the longest task in our schedule with it if it has a smaller duration.
Thus, the algorithm minimizes wasted time and maximizes the number of completed tasks for optimal total reward.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;

int main() {
    int n;
    cin >> n;

    // jobs[i] = {duration, deadline}
    vector<pair<int, int>> jobs(n);
    for (int i = 0; i < n; i++) {
        cin >> jobs[i].first >> jobs[i].second;
    }

    // Sort by duration (or by first element), ensures earliest finishing attempts first
    sort(jobs.begin(), jobs.end());

    ll time_elapsed = 0;   // running sum of durations
    ll total_reward = 0;   // accumulated reward

    for (int i = 0; i < n; i++) {
        time_elapsed += jobs[i].first;              // finish this job at this time
        total_reward += jobs[i].second - time_elapsed;  // reward = deadline - completion time
    }

    cout << total_reward;
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

If one book takes more than half the total time, one child will be forced to wait while the other finishes that long book. Otherwise, they can optimally interleave their reading with no idle time. Thus, the answer is $max("total_time", 2 * "longest_book")$.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n;
    cin >> n;

    vector<long long> books(n);
    long long total = 0, max_book = 0;

    // Read book times, track:
    // 1) total time of all books
    // 2) the longest single book
    for (int i = 0; i < n; i++) {
        cin >> books[i];
        total += books[i];
        max_book = max(max_book, books[i]);
    }

    // Minimum total time is governed by:
    // - total (one person reading sequentially)
    // - OR twice the largest book (two-person parallel reading constraint)
    // The answer is the max of these two.
    cout << max(total, 2 * max_book) << "\n";

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

This solution finds three numbers that sum to the target by first sorting the array and then fixing one element at a time. For each fixed element, it uses a two-pointer scan on the remaining range to efficiently search for a complementary pair. Sorting allows the sum to guide pointer movement, reducing the search from cubic to quadratic time. If no valid triple exists, the answer is declared impossible, keeping the logic clean and deterministic.

\

*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n, target;
    cin >> n >> target;

    // Store {value, original_index}
    vector<pair<int, int>> v(n);

    for (int i = 0; i < n; i++) {
        cin >> v[i].first;
        v[i].second = i + 1;  // keep original 1-based index
    }

    // Sort by value so we can use the two-pointer trick
    sort(v.begin(), v.end());

    // Fix one element v[i], then find two others using two pointers
    for (int i = 0; i < n - 2; i++) {
        int l = i + 1;       // left pointer
        int r = n - 1;       // right pointer

        while (l < r) {
            int sum = v[i].first + v[l].first + v[r].first;

            if (sum == target) {
                // Output original positions (not sorted ones)
                cout << v[i].second << " " << v[l].second << " " << v[r].second;
                return 0;
            }
            else if (sum < target) {
                l++;         // need a larger sum → move left pointer right
            }
            else {
                r--;         // need a smaller sum → move right pointer left
            }
        }
    }

    // If no triple found
    cout << "IMPOSSIBLE";
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

If you understood the above three sum algorithm, four sum simply extends this by fixing two elements instead of one. You iterate through all pairs (i, j), then for each pair, use the same two-pointer technique to find the remaining two numbers that complete the target sum.


\

*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n, target;
    cin >> n >> target;

    // Store (value, original_index)
    vector<pair<int, int>> nums(n);

    for (int i = 0; i < n; i++) {
        cin >> nums[i].first;
        nums[i].second = i + 1;   // 1-based indexing as required by CSES
    }

    // Sort by value to enable two-pointer scanning later
    sort(nums.begin(), nums.end());

    // Fix first two values using indices i and j
    for (int i = 0; i < n - 3; i++) {
        for (int j = i + 1; j < n - 2; j++) {

            int left = j + 1;
            int right = n - 1;

            // Two-pointer search for remaining pair
            while (left < right) {
                long long sum = nums[i].first
                + nums[j].first
                + nums[left].first
                + nums[right].first;

                if (sum == target) {
                    // Output original positions
                    cout << nums[i].second << " "
                    << nums[j].second << " "
                    << nums[left].second << " "
                    << nums[right].second;
                    return 0;
                }

                // Adjust pointers based on sum size
                if (sum < target) {
                    left++;
                } else {
                    right--;
                }
            }
        }
    }

    cout << "IMPOSSIBLE";
    return 0;
}

```
#pagebreak()

== Nearest Smaller Values

\
#link("https://cses.fi/problemset/task/1645")[Question - Nearest Smaller Values]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/1645")[Backup Link]


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
#pagebreak()

== Subarray Sums I

\
#link("https://cses.fi/problemset/task/1660")[Question - Subarray Sums I]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/1660")[Backup Link]

\

*Explanation* :

All numbers are positive, so we keep a sliding window: expand the right end, and whenever the sum exceeds x we shrink from the left until it fits. Each time the window sum equals x we have one valid subarray.

\

*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;

int main() {
    ll n, x;
    cin >> n >> x;

    vector<int> v(n);
    for (int i = 0; i < n; i++) {
        cin >> v[i];
    }

    ll curr = 0;   // current window sum
    ll count = 0;  // number of subarrays equal to x
    ll l = 0;      // left pointer of sliding window

    for (int r = 0; r < n; r++) {
        curr += v[r];               // expand window to the right

        // shrink window from the left while sum exceeds x
        while (curr > x) {
            curr -= v[l];
            l++;
        }

        // if current window sum matches x, count it
        if (curr == x) count++;
    }

    cout << count;
}

```
#pagebreak()

== Subarray Sums II

\
#link("https://cses.fi/problemset/task/1661")[Question - Subarray Sums II]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/1661")[Backup Link]

\

*Explanation* :

With negative numbers allowed, we switch to prefix sums. For each position we store how many earlier prefixes have value `current − x`; each such prefix starts a subarray ending here that sums to x. An unordered_map keeps counts in O(1) expected time.

\

*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n;
    long long x;
    cin >> n >> x;
    vector<long long> a(n);
    for (int i = 0; i < n; i++) cin >> a[i];

    unordered_map<long long, long long> freq;
    freq.reserve(2 * n);
    freq.max_load_factor(0.7);
    freq[0] = 1;

    long long pref = 0, ans = 0;
    for (long long v : a) {
        pref += v;
        if (freq.count(pref - x)) ans += freq[pref - x];
        freq[pref]++;
    }
    cout << ans << "\n";
    return 0;
}
```
#pagebreak()

== Subarray Divisibility

\
#link("https://cses.fi/problemset/task/1662")[Question - Subarray Divisibility]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/1662")[Backup Link]

\

*Explanation* :

Two prefixes with the same remainder modulo n define a subarray whose sum is divisible by n. We track counts of each remainder as we scan the array and add the current remainder’s frequency to the answer.

\

*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n;
    cin >> n;

    // Read array and reduce each element modulo n (helps avoid overflow)
    vector<long long> arr(n);
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
        arr[i] %= n;
    }

    // freq[x] = how many prefix sums have remainder x mod n
    map<long long, long long> freq;
    freq[0] = 1;  // Empty prefix considered as remainder 0

    long long sum = 0;
    long long count = 0;

    // Loop over all elements and compute prefix sums
    for (int i = 0; i < n; i++) {
        sum += arr[i];

        // Compute positive modulo n (handles negative sums)
        long long mod = ((sum % n) + n) % n;

        // Any previous prefix with same modulo forms a valid subarray
        count += freq[mod];

        // Increase frequency for this remainder
        freq[mod]++;
    }

    // Total count of subarrays whose sum is divisible by n
    cout << count << endl;
}

```
#pagebreak()

== Subarray Distinct Values

\
#link("https://cses.fi/problemset/task/2428")[Question - Subarray Distinct Values]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/2428")[Backup Link]

\

*Explanation* :

Use a sliding window with a frequency map. Expand the right end; if the number of distinct elements exceeds k, shrink from the left until it doesn’t. Every position contributes `window_length` new subarrays ending there, so we add that to the answer.

\

*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, k;
    cin >> n >> k;
    vector<int> a(n);
    for (int i = 0; i < n; i++) cin >> a[i];

    unordered_map<int, int> freq;
    freq.reserve(2 * n);
    freq.max_load_factor(0.7);

    int left = 0, distinct = 0;
    long long ans = 0;
    for (int right = 0; right < n; right++) {
        if (freq[a[right]] == 0) distinct++;
        freq[a[right]]++;

        while (distinct > k) {
            freq[a[left]]--;
            if (freq[a[left]] == 0) distinct--;
            left++;
        }
        ans += right - left + 1;
    }
    cout << ans << "\n";
    return 0;
}
```
#pagebreak()

== Array Division

\
#link("https://cses.fi/problemset/task/1085")[Question - Array Division]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/1085")[Backup Link]

\

*Explanation* :

This solution minimizes the largest subarray sum when dividing the array into `k` consecutive subarrays using binary search. It establishes bounds where the answer lies between the largest element and the total sum of the array. For each candidate sum (mid), it checks if it's possible to split the array into at most `k` subarrays without any subarray exceeding that sum. If possible, a lower sum is attempted; otherwise, a higher sum is tested. Finally, the smallest feasible maximum subarray sum is output as the answer.


\

*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, k;
    cin >> n >> k;
    vector<int> a(n);

    ll left = 0, right = 0;
    // 'left' = minimum possible max sum (largest single element)
    // 'right' = maximum possible max sum (sum of all elements)

    for (int i = 0; i < n; i++) {
        cin >> a[i];
        left = max(left, (ll)a[i]);
        right += a[i];
    }

    ll ans = right;   // Best answer found via binary search

    while (left <= right) {
        ll mid = (left + right) / 2;

        // Try to split into <= k subarrays where no subarray sum exceeds 'mid'
        int subarrays = 1;
        ll current_sum = 0;
        bool possible = true;

        for (int i = 0; i < n; i++) {
            // If adding this element exceeds 'mid', start a new subarray
            if (current_sum + a[i] > mid) {
                subarrays++;
                current_sum = a[i];

                // Too many subarrays ⇒ mid is too small
                if (subarrays > k) {
                    possible = false;
                    break;
                }
            } else {
                current_sum += a[i];
            }
        }

        if (possible) {
            ans = mid;        // mid works ⇒ try to lower the maximum sum
            right = mid - 1;
        } else {
            left = mid + 1;   // mid too small ⇒ increase
        }
    }

    cout << ans << endl;
    return 0;
}

```
#pagebreak()

== Sliding Median

\
#link("https://cses.fi/problemset/task/1076")[Question - Sliding Median]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/1076")[Backup Link]

\

*Explanation* :

Maintain two multisets: `low` holds the smaller half (including the median) and `high` holds the larger half. After each insert/remove we rebalance so that `low` is never smaller than `high` and differs by at most one element. The median is always the largest element of `low`.

\

*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

multiset<int> lowSet, highSet;

void rebalance() {
    if (lowSet.size() > highSet.size() + 1) {
        highSet.insert(*lowSet.rbegin());
        auto it = lowSet.end();
        --it;
        lowSet.erase(it);
    } else if (lowSet.size() < highSet.size()) {
        lowSet.insert(*highSet.begin());
        highSet.erase(highSet.begin());
    }
}

void add(int x) {
    if (lowSet.empty() || x <= *lowSet.rbegin()) lowSet.insert(x);
    else highSet.insert(x);
    rebalance();
}

void remove_one(int x) {
    auto it = lowSet.find(x);
    if (it != lowSet.end()) lowSet.erase(it);
    else {
        it = highSet.find(x);
        highSet.erase(it);
    }
    rebalance();
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, k;
    cin >> n >> k;
    vector<int> a(n);
    for (int i = 0; i < n; i++) cin >> a[i];

    for (int i = 0; i < k; i++) add(a[i]);
    cout << *lowSet.rbegin();

    for (int i = k; i < n; i++) {
        add(a[i]);
        remove_one(a[i - k]);
        cout << " " << *lowSet.rbegin();
    }
    cout << "\n";
    return 0;
}
```
#pagebreak()

== Sliding Cost

\
#link("https://cses.fi/problemset/task/1077")[Question - Sliding Cost]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/1077")[Backup Link]

\

*Explanation* :

As in Sliding Median, keep two multisets split around the median but also track their sums. The total cost is `median * |low| − sumLow + sumHigh − median * |high|`. After each insertion/removal we rebalance and recompute using the maintained sums in O(1).

\

*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;

multiset<int> lowSet, highSet;
ll sumLow = 0, sumHigh = 0;

void rebalance() {
    if (lowSet.size() > highSet.size() + 1) {
        int x = *lowSet.rbegin();
        sumLow -= x;
        lowSet.erase(prev(lowSet.end()));
        highSet.insert(x);
        sumHigh += x;
    } else if (lowSet.size() < highSet.size()) {
        int x = *highSet.begin();
        sumHigh -= x;
        highSet.erase(highSet.begin());
        lowSet.insert(x);
        sumLow += x;
    }
}

void add(int x) {
    if (lowSet.empty() || x <= *lowSet.rbegin()) {
        lowSet.insert(x);
        sumLow += x;
    } else {
        highSet.insert(x);
        sumHigh += x;
    }
    rebalance();
}

void remove_one(int x) {
    auto it = lowSet.find(x);
    if (it != lowSet.end()) {
        sumLow -= x;
        lowSet.erase(it);
    } else {
        it = highSet.find(x);
        sumHigh -= x;
        highSet.erase(it);
    }
    rebalance();
}

ll cost() {
    int med = *lowSet.rbegin();
    return med * 1LL * lowSet.size() - sumLow + sumHigh - med * 1LL * highSet.size();
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, k;
    cin >> n >> k;
    vector<int> a(n);
    for (int i = 0; i < n; i++) cin >> a[i];

    for (int i = 0; i < k; i++) add(a[i]);
    cout << cost();
    for (int i = k; i < n; i++) {
        add(a[i]);
        remove_one(a[i - k]);
        cout << " " << cost();
    }
    cout << "\n";
    return 0;
}
```
#pagebreak()

== Movie Festival II

\
#link("https://cses.fi/problemset/task/1632")[Question - Movie Festival II]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/1632")[Backup Link]

\

*Explanation* :

Sort movies by ending time. Keep a multiset of viewers’ current end times. For each movie, try to find the viewer who becomes free latest but still not after the movie starts (largest end time ≤ start). Reassign that viewer to the current movie; if none exist and we still have spare viewers, start a new one. Each successful assignment increases the count.

\

*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, k;
    cin >> n >> k;
    vector<pair<int, int>> movies(n);
    for (int i = 0; i < n; i++) {
        int a, b;
        cin >> a >> b;
        movies[i] = {b, a}; // sort by end
    }
    sort(movies.begin(), movies.end());

    multiset<int> endTimes;
    int watched = 0;
    for (auto [end, start] : movies) {
        auto it = endTimes.upper_bound(start);
        if (it == endTimes.begin()) {
            if ((int)endTimes.size() < k) {
                endTimes.insert(end);
                watched++;
            }
        } else {
            --it;
            endTimes.erase(it);
            endTimes.insert(end);
            watched++;
        }
    }
    cout << watched << "\n";
    return 0;
}
```
#pagebreak()

== Maximum Subarray Sum II

\
#link("https://cses.fi/problemset/task/1644")[Question - Maximum Subarray Sum II]
#h(0.5cm)
#link("https://web.archive.org/web/20250815000000/https://cses.fi/problemset/task/1644")[Backup Link]

\

*Explanation* :

Let `pref[i]` be the sum of the first i elements. For each end index i we need the smallest prefix value among starts that keep the subarray length in [a, b]; the answer candidate is `pref[i] − minPrefix`. A multiset over the valid prefix window supports O(log n) insert/erase as we slide i forward.

\

*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, a, b;
    cin >> n >> a >> b;
    vector<ll> pref(n + 1, 0);
    for (int i = 1; i <= n; i++) {
        ll x;
        cin >> x;
        pref[i] = pref[i - 1] + x;
    }

    multiset<ll> window;
    ll ans = LLONG_MIN;
    for (int i = a; i <= n; i++) {
        window.insert(pref[i - a]);
        if (i - b - 1 >= 0) {
            window.erase(window.find(pref[i - b - 1]));
        }
        ans = max(ans, pref[i] - *window.begin());
    }

    cout << ans << "\n";
    return 0;
}
```
#pagebreak()


