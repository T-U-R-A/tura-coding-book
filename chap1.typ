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

*Solution:*

The problem asks: for each board size $k times k$ (from $k = 1$ to $k = n$), count the number of ways to place two knights such that they do not attack each other.

*Step 1: Count all possible placements*

First, we count the total number of ways to place two knights on a $k times k$ board without any restrictions. There are $k^2$ squares, and we need to choose 2 of them. This is simply:

$ "Total placements" = binom(k^2, 2) = (k^2 (k^2 - 1)) / 2 $

*Step 2: Subtract attacking pairs*

Now we subtract the number of placements where the two knights attack each other. A knight attacks in an "L-shape": it moves 2 squares in one direction and 1 square perpendicular to that.

The key insight is that *two knights that attack each other always fit inside a $2 times 3$ or $3 times 2$ rectangle*. Within each such rectangle, there are exactly *2 pairs* of squares that attack each other (the two diagonal corners of the "L").

#align(center)[
  #figure(
    caption: "The 2 pairs of same coloured knights attack each other from the corners.",
    grid(
      columns: 2,
      align: center,
      column-gutter: 2cm,
      board(
        position(
          "N.n",
          "n.N"
        )
      ),
      board(
        position(
          "Nn",
          "..",
          "nN"
        )
      ),
    ) 
  )
]

*Step 3: Count the rectangles*

- Number of $2 times 3$ rectangles in a $k times k$ board: $(k - 1) times (k - 2)$
- Number of $3 times 2$ rectangles in a $k times k$ board: $(k - 2) times (k - 1)$

Each rectangle contains 2 attacking pairs, so:

$ "Attacking pairs" = 2 times (k-1)(k-2) + 2 times (k-2)(k-1) = 4(k-1)(k-2) $

*Final Formula:*

$ "Answer" = (k^2 (k^2 - 1)) / 2 - 4(k-1)(k-2) $

#pagebreak()

*Examples:*

- *k = 1*: Only 1 square, so 0 ways to place two knights. Answer = $0$.

- *k = 2*: Total = $binom(4,2) = 6$ placements. No $2 times 3$ or $3 times 2$ rectangles fit, so 0 attacking pairs. Answer = $6$.

- *k = 3*: Total = $binom(9,2) = 36$ placements. Attacking pairs = $4 times 2 times 1 = 8$. Answer = $36 - 8 = 28$.

- *k = 4*: Total = $binom(16,2) = 120$ placements. Attacking pairs = $4 times 3 times 2 = 24$. Answer = $120 - 24 = 96$.

\

*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
  int n;
  cin >> n;

  for (long long k = 1; k <= n; ++k) {
    long long total = k * k;

    // Total ways to place 2 knights on k×k board
    long long ways = total * (total - 1) / 2;

    // Subtract attacking pairs (only exist when k > 2)
    if (k > 2)
      ways -= 4 * (k - 1) * (k - 2);

    cout << ways << "\n";
  }

  return 0;
}
```

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

*Hint:*

Trying listing out the solution for $n = 1$, then for $n = 2$ and $n = 3$. Try to see if there is any pattern from the previous smaller sequences to the larger ones. You might even find a pattern just by looking at any one value of $n$. 

=== Solution 1

The first pattern you may have spotted when you attempt to solve the question was the way the sequences of a longer Gray code build up on the sequence of smaller Gray code. 

Take the Gray code for $n = 2$:

$
00
\
01
\
11
\
10
$

If you now look at the Gray code for $n = 3$, you'll notice that the gray code for $n = 2$ appears in the list:

$
0#text(fill: red)[00]
\
0#text(fill: red)[01]
\
0#text(fill: red)[11]
\
0#text(fill: red)[10]
\
1#text(fill: blue)[10]
\
1#text(fill: blue)[11]
\
1#text(fill: blue)[01]
\
1#text(fill: blue)[00]
$

The first 4 strings in the Gray code for $n = 3$ is just the Gray code for $n = 2$ (Shown in #text(fill:red)[red]) with 0 prepended to it. The last 4 string in the Gray code for $n = 3$ is just the gray code for $n = 2$ but backwards (Shown in #text(fill:blue)[blue]). This pattern applies to all gray codes. 


Here's the code for this approach:

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios_base::sync_with_stdio(0);
    cin.tie(0);
    cout.tie(0);

    int n;
    cin >> n;

    vector<string> gray;
    gray.push_back("");

    for (int i = 0; i < n; i++) {
        vector<string> next;

        // Prefix "0" to all existing strings
        for (int j = 0; j < gray.size(); j++)
            next.push_back("0" + gray[j]);

        // Prefix "1" to all existing strings in reverse order
        for (int j = gray.size() - 1; j >= 0; j--)
            next.push_back("1" + gray[j]);

        gray = next;
    }

    for(int i = 0; i < gray.size(); i++)
        cout << gray[i] << '\n';
}
```

From the code, we start by saying `gray = {""}`. Then to generate the next gray code which we store in `next`, we prepend a `0` to every string in `gray` and store that in `next` and then we prepend a `1` to every element in `gray` while going backwards and sore that in `next`. Finally we update `gray` to next. 

This process is repeated until you get the $n$th Gray Code which you then output.

The time complexity of this solution is $O(n dot 2^n)$ and the space complexity is $O(n)$. While this is pretty good and will pass all the test cases within the time limit, we can do a bit better.

=== Solution 2

Let's look again at the Gray code for $n = 3$ and highlight where the bit flips occur going from 000 to the end:

$
#text(fill: luma(80))[210]
\
000
\
00#text(fill: red)[1]
\
0#text(fill: red)[1]1
\
01#text(fill: red)[0]
\
#text(fill: red)[1]10
\
11#text(fill: red)[1]
\
1#text(fill: red)[0]1
\
10#text(fill: red)[0]
$

The numbers in gray at the top, represent the index of each bit. If we list the index of which bit was flipped from on string to the other, we get: ${0, 1, 0, 2, 0, 1, 0}$. In this list, you can see that we flipped the 0#super[th] bit every 2#super[nd] bit flip, the 1#super[st] bit every 4#super[th] bit flip, and if we were to look at Gray code of $n = 4$, we would also notice that the 2#super[th] bit was flipped every 8#super[th] time.

This sequence has a pattern that can be expressed with the following expression:

$
  t_n  = log_2("lsb"(n)), #text[Where $t_n$ is the $n$#super[th] term. ]
$


See /*@lsb(Inset this in the merged book.)*/ for what LSB means.

We can use this formula to calculate the position of which bit we need to flip to generate the next string. The advantage of this method is that we don't need to compute the Gray codes for smaller values and we can just directly output the answer for the given $n$ value. 

Here's the code for this approach:

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios_base::sync_with_stdio(0);
    cin.tie(0);
    cout.tie(0);

    int n;
    cin >> n;
    string s(n, '0');// Start with all zeros

    cout << s << endl;
    for (int i = 1; i < (1 << n); i++) {
        // Find position of lowest set bit and flip the corresponding bit
        int pos = n - 1 - __builtin_ctz(i & -i);
        s[pos] = (s[pos] == '0' ? '1' : '0');// Flip the bit.
        cout << s << '\n';
    }
    return 0;
}
```

`i & -i` computes $"LSB"(n)$ and `__builtin_ctz()` computes the number of trailing zeros which is the same as `log2()` for a power of 2 which the LSB($n$) is. Finally we must subtract this from $n - 1$ to convert it to the correct index in the string because strings are indexed left to right but our formula indexes the bit's from right to left.

The time complexity of this code is $O(2^n)$ which is a bit faster than the first approach. For the last testcase of the problem on the website, the first code takes 0.03s whereas this one runs in 0.01s.

#pagebreak()

== Tower of Hanoi

\
#link("https://cses.fi/problemset/task/2165")[Question - Tower of Hanoi]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/2165")[Backup Link]


\

*Hint:*

Think about a recurrence relation that relates the solution of $n$ and $n-1$. Then you can write the code as either recursion(easy) or as a loop(hard).

*Solution:*

The recurrence relation is as follows: to move a stack of n disks from a starting pillar to the ending pillar, you must first move n-1 disks from the starting pillar to the middle pillar, then move the $n$#super[th] disk from start to end, and then finally move the n-1 disks from the middle pillar to the end pillar. 

Here's the simple recursion code which solves the question.

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
  ios_base::sync_with_stdio(0);
  cin.tie(0);
  cout.tie(0);

  int n;
  cin >> n;

  vector<pair<int, int>> moves;

  // This can also be a normal function instead of a lambda expression.
  // Make sure that the moves vector is a global for this to work.
  function<void (int, int, int, int)> solve = [&] (int n, int start, int end, int middle){
    if (n == 0) return;
    solve(n - 1, start, middle, end);
    moves.push_back({start, end});
    solve(n - 1, middle, end, start);
  };

  //output:
  solve(n, 1, 3, 2);
  cout << moves.size() << endl;
  for(int i = 0; i < moves.size(); i++)
    cout << moves[i].first << " " << moves[i].second << endl;
  return 0;
}
```

As an extra challenge to the reader, try writing the loop solution.

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

This solution uses backtracking#footnote[backtracking was explained here] to count all valid ways to place 8 queens on an 8×8 board with blocked cells.
We place exactly one queen per row, moving row by row.
For each cell, we first skip blocked positions marked by `*`.
Three boolean arrays track conflicts: columns, main diagonals (`row + col`), and anti-diagonals (`row - col + 7`).
If a position is safe, we mark these arrays and recurse to the next row.
When all 8 rows are filled, one valid arrangement is found and counted.
After recursion, we backtrack by unmarking the position to explore other possibilities.


*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

const int N = 8;

vector<string> board(N);

// Tracking used columns and diagonals
bool usedColumn[N];
bool usedMainDiag[2 * N - 1];   // row + col
bool usedAntiDiag[2 * N - 1];   // row - col + (N - 1)

int totalWays = 0;

void placeQueen(int row) {
    // All rows filled → one valid arrangement
    if (row == N) {
        totalWays++;
        return;
    }

    for (int col = 0; col < N; col++) {
        if (board[row][col] == '*') continue;

        int mainDiag = row + col;
        int antiDiag = row - col + (N - 1);

        if (usedColumn[col] || usedMainDiag[mainDiag] || usedAntiDiag[antiDiag])
            continue;

        // Place queen
        usedColumn[col] = usedMainDiag[mainDiag] = usedAntiDiag[antiDiag] = true;

        placeQueen(row + 1);

        // Backtrack
        usedColumn[col] = usedMainDiag[mainDiag] = usedAntiDiag[antiDiag] = false;
    }
}

int main() {
    for (int i = 0; i < N; i++) {
        cin >> board[i];
    }

    placeQueen(0);
    cout << totalWays << "\n";
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

For each test case, we first check feasibility: if $a + b > n$, the required outcomes exceed the number of elements, then it is impossible. If exactly one of $a$ or $b$ is zero, the conditions become invalid.

When valid, we begin by printing numbers from $1$ to $n$, representing the moves of the first player.
The second line, representing the corresponding moves of the second player, is constructed carefully to control pairwise comparisons.
The first $b$ elements are taken from the range $a+1$ to $a+b$, ensuring they are strictly larger than the next block and hence guarantee $b$ wins.
Next, the smallest $a$ elements, $1$ to $a$, are placed, ensuring wins for the first player.
The remaining elements are appended in increasing order, resulting in draws for the remaining positions.
This construction satisfies all constraints while maintaining valid permutations.


*Code :*

```cpp
#include <iostream>
using namespace std;

int main() {
    int testCases;
    cin >> testCases;

    while (testCases--) {
        int n, a, b;
        cin >> n >> a >> b;

        // Invalid if required elements exceed n
        if (a + b > n) {
            cout << "NO\n";
            continue;
        }

        // Invalid if exactly one of a or b is zero
        if ((a == 0 || b == 0) && a + b != 0) {
            cout << "NO\n";
            continue;
        }

        cout << "YES\n";

        // 1 to n
        for (int i = 1; i <= n; i++) {
            cout << i << " ";
        }
        cout << "\n";

        // First b elements after a
        for (int i = 1; i <= b; i++) {
            cout << a + i << " ";
        }

        // Next a smallest elements
        for (int i = 1; i <= a; i++) {
            cout << i << " ";
        }

        // Remaining elements
        for (int i = a + b + 1; i <= n; i++) {
            cout << i << " ";
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

We fill the grid row by row, left to right.
For each cell, we collect all values already placed to its left in the same row and above it in the same column.The cell is assigned the *mex* (smallest non-negative integer not present in those values).
Since all needed cells are already filled, this greedy process always works.


*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n;
    cin >> n;

    vector<vector<int>> grid(n, vector<int>(n, 0));

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            // Track used numbers
            vector<bool> used(2 * n, false);

            // Left in the same row
            for (int k = 0; k < j; k++) {
                used[grid[i][k]] = true;
            }

            // Above in the same column
            for (int k = 0; k < i; k++) {
                used[grid[k][j]] = true;
            }

            // Find mex
            int mex = 0;
            while (used[mex]) mex++;

            grid[i][j] = mex;
        }
    }

    // Output the grid
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            cout << grid[i][j] << (j + 1 < n ? ' ' : '\n');
        }
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

The program calculates the minimum number of knight moves needed to reach every square on an `n x n` chessboard starting from the top-left corner.

It keeps a grid where each cell stores how many moves are required to reach it, marking unreachable cells as -1.
The knight starts at position (0, 0) with zero moves taken.
From each position, all eight legal knight moves are tried.
Whenever a new square is reached for the first time, its move count is recorded as one more than the current square.
Each newly reached position is added so its moves can be explored later.

This process continues until all reachable squares have been processed.
Finally, the grid of minimum move counts is printed.


\


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

    // dist[x][y] will store the minimum number of moves needed to reach cell (x, y)
    // a value of -1 means that cell has not been reached yet
    vector<vector<int>> dist(n, vector<int>(n, -1));

    // This queue stores board positions that still need to be explored
    queue<pair<int, int>> q;

    // These arrays describe how a knight moves on a chessboard
    // Each (dx[k], dy[k]) pair represents one possible knight move
    vector<int> dx = {-2, -1, 2, 1, 2, 1, -1, -2};
    vector<int> dy = {-1, -2, 1, 2, -1, -2, 2, 1};

    // This function checks whether a position is inside the board
    // and whether it has not been visited before
    auto isValid = [&](int x, int y) {
        return x >= 0 && y >= 0 && x < n && y < n && dist[x][y] == -1;
    };

    // We begin from the top-left cell (0, 0)
    // Reaching the starting cell takes 0 moves
    dist[0][0] = 0;
    q.push({0, 0});

    // As long as there are positions left to explore, keep processing them
    while (!q.empty()) {
        // Take the oldest unexplored position from the queue
        auto [x, y] = q.front();
        q.pop();

        // Try moving the knight in all 8 possible ways from this position
        for (int k = 0; k < 8; k++) {
            int nx = x + dx[k];
            int ny = y + dy[k];

            // If the new position is valid and not visited yet
            if (isValid(nx, ny)) {
                // The distance to this cell is one more than the current cell
                dist[nx][ny] = dist[x][y] + 1;

                // Add the new position to the queue to explore later
                q.push({nx, ny});
            }
        }
    }

    // Print the minimum number of moves needed to reach each cell
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            cout << dist[i][j] << " ";
        }
        cout << endl;
    }

    return 0;
}
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

The program counts how many valid ways exist to move through a `7×7` grid using exactly 48 moves.
You start at the top-left cell and must end at the bottom-left cell without visiting any cell twice. Each move must follow the given string, where `?` allows any direction and other characters force a specific move. The code tries all allowed moves step by step while marking visited cells.

Paths that get trapped or split the grid into unreachable regions are stopped early. Every complete path that reaches the destination at exactly 48 steps is counted.

*Code :*

```cpp
using namespace std;

string path;
bool visited[7][7];          // Marks cells already used in the current path
int ans = 0;

const int dx[] = {1, -1, 0, 0};   // Change in row for each move
const int dy[] = {0, 0, 1, -1};   // Change in column for each move
const char dir[] = {'D', 'U', 'R', 'L'};  // Corresponding move letters

bool inside(int x, int y) {
    return x >= 0 && x < 7 && y >= 0 && y < 7;   // Checks grid boundaries
}

bool is_blocked(int x, int y) {
    if (!inside(x, y) || visited[x][y]) return true; // Outside grid or already used
    return false;
}

void dfs(int x, int y, int step) {
    // If we reached the target cell
    if (x == 6 && y == 0) {
        if (step == 48) ans++;  // Count only if all moves were used
        return;
    }

    // Stop early if movement is forced into a dead split
    if ((is_blocked(x + 1, y) && is_blocked(x - 1, y) &&
         !is_blocked(x, y + 1) && !is_blocked(x, y - 1)) ||
        (!is_blocked(x + 1, y) && !is_blocked(x - 1, y) &&
         is_blocked(x, y + 1) && is_blocked(x, y - 1)))
        return;

    visited[x][y] = true;   // Mark this cell as used

    for (int d = 0; d < 4; ++d) {
        int nx = x + dx[d];
        int ny = y + dy[d];

        // Enforce the given path character if it is not '?'
        if (path[step] != '?' && path[step] != dir[d]) continue;

        // Move only to valid and unused cells
        if (inside(nx, ny) && !visited[nx][ny])
            dfs(nx, ny, step + 1);
    }

    visited[x][y] = false;  // Undo the move before trying other possibilities
}

int main() {
    cin >> path;
    dfs(0, 0, 0);           // Start from top-left with zero moves taken
    cout << ans << endl;
    return 0;
}
```

\
#pagebreak()


