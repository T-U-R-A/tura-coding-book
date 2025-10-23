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
*Intuitive Explanation* : 

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

\
#pagebreak()
== Missing Number

\
#link("https://cses.fi/problemset/task/1083")[Question - Missing Number]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1083")[Backup Link]

\
*Intuitive Explanation* : 

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

\
== Repetitions

\
#link("https://cses.fi/problemset/task/1069")[Question - Repetitions]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1069")[Backup Link]

\
*Intuitive Explanation* : 

- Read the string from left to right and keep a *counter* for the block you are currently inside.
- If the current character equals the previous one, increase counter by one. 
- If it differs, *reset* the counter to `1` (the new character starts a fresh block).
- Track the maximum value of the counter as you go.

This is classic *run-length* reasoning: every position either continues the current run or starts a new one.

*Why it works?*

- *current* = length of the run that *ends at the current index*.
- *maxLen* = maximum run length seen *anywhere up to now*.

At each new character:
- If it matches the previous one, `current += 1`; otherwise `current = 1`.
- Update `maxLen = max(maxLen, current)` so it always reflects the best seen.

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
== Increasing Array

\
#link("https://cses.fi/problemset/task/1094")[Question - Increasing Array]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1094")[Backup Link]

\
*Intuitive Explanation* :  

Imagine walking along a staircase. Each step should take you higher or keep you level, but never lower.  
If suddenly one step is carved too deep, you must *fill it up with blocks* until it matches the height of the step before.  
This problem is nothing more than counting the total number of blocks you need to pour in to make the staircase climb smoothly.

\

*Key Idea:*  

- A non-decreasing array is like a staircase that never dips:  
  `a[i] >= a[i-1]`.  
- Whenever `a[i] < a[i-1]`, the gap `(a[i-1] - a[i])` tells you how much you must “fill in” to raise it.  
- Add all these gaps together → that’s the answer.

\

*Algorithm (Step by Step Flow):*  

1. Take the first element as your *baseline height*.  
2. Start walking through the array, element by element.  
3. At each step:  
   - If the current number is tall enough (≥ previous), move on.  
   - If not, *pour in increments* until it matches the previous height.  
   - Count how much you poured.  
4. By the end, your total poured blocks = minimum operations required.

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

== Trailing Zeros

\
#link("https://cses.fi/problemset/task/1618")[Question - Trailing Zeros]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1618")[Backup Link]


\

*Intuitive Explanation* : 

The problem asks for the number of trailing zeros in n factorial (n!). Zeros come from pairs of 2s and 5s, and since 5s are scarcer, the number of 5s limit the number of zeroes, hence they determine the number of zeros.

Each multiple of 5 (5, 10, 15, …) contributes one 5, multiples of 25 contribute 2 5s, multiples of 125 contribute 3 5s, and so on. The code loops through powers of 5 (5, 25, 125...), summing $floor(n/i)$, until $floor(n/i)$ = 0. The result is the number of trailing zeros.

Here the int variable helps us find the floor of $(n/i)$ easily without any other function.

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

\
