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
#pagebreak()
== Repetitions

\
#link("https://cses.fi/problemset/task/1069")[Question - Repetitions]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1069")[Backup Link]

\
*Intuitive Explanation* : 
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

== Permutations

\
#link("https://cses.fi/problemset/task/1618")[Question - Trailing Zeros]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1618")[Backup Link]


\

*Intuitive Explanation* : 


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
        // First print all even numbers in descending order
        // This ensures that consecutive numbers differ by >= 2
        for (int i = n; i >= 1; i -= 2)
            cout << i << " ";
 
        // Then print all odd numbers in descending order
        // This also ensures no two adjacent numbers differ by 1
        for (int i = n - 1; i >= 1; i -= 2)
            cout << i << " ";
    }
}

```
#pagebreak()

== Two Sets

\
#link("https://cses.fi/problemset/task/1618")[Question - Trailing Zeros]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1618")[Backup Link]


\

*Intuitive Explanation* : 


*Code :*

```cpp  
// code goes here


```
\
#pagebreak()


== Bit Strings

\
#link("https://cses.fi/problemset/task/1618")[Question - Trailing Zeros]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1618")[Backup Link]


\

*Intuitive Explanation* : 


*Code :*

```cpp  
// code goes here


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

*Intuitive Explanation* : 

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


== Creating Strings

\
#link("https://cses.fi/problemset/task/1618")[Question - Trailing Zeros]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/1618")[Backup Link]


\

*Intuitive Explanation* : 

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