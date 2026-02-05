#import "@preview/cetz:0.4.2"
#import "@preview/board-n-pieces:0.7.0": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#import "@preview/cetz:0.2.2": canvas
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

= Dynamic Programming

\
== Dice Combinations

\
#link("https://cses.fi/problemset/task/1633")[Question - Dice Combinations]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1633")[Backup Link]

\
*Explanation* :

There is exactly one way to get a 0, by not throwing. Now, to reach any sum, we imagine the last move we took. If the last move was `dice`, then we must have already reached `sum − dice`. All the ways to reach `sum − dice` automatically become valid ways to reach sum. By adding these possibilities for all dice values from 1 to 6, we grow the solution from smaller sums to larger ones. This approach avoids repeated work and makes the counting process both efficient and intuitive, while the modulo simply prevents numbers from growing too large.





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

    // dp[i] = number of ways to reach sum i
    vector<int> dp(n + 1, 0);
    dp[0] = 1;  // Base case: one way to make sum 0

    for (int sum = 1; sum <= n; sum++) {
        for (int dice = 1; dice <= 6; dice++) {
            if (sum - dice >= 0) {
                dp[sum] = (dp[sum] + dp[sum - dice]) % MOD;
            }
        }
    }

    cout << dp[n] << '\n';
    return 0;
}
```
#pagebreak()

== Minimizing Coins

\
#link("https://cses.fi/problemset/task/1634")[Question - Minimizing Coins]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1634")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

const int INF = 1e9;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, target;
    cin >> n >> target;

    vector<int> coins(n);
    for (int i = 0; i < n; i++) {
        cin >> coins[i];
    }

    // dp[i] = minimum number of coins needed to make sum i
    vector<int> dp(target + 1, INF);
    dp[0] = 0;

    for (int sum = 1; sum <= target; sum++) {
        for (int coin : coins) {
            if (coin <= sum && dp[sum - coin] != INF) {
                dp[sum] = min(dp[sum], dp[sum - coin] + 1);
            }
        }
    }

    if (dp[target] == INF) {
        cout << -1 << '\n';
    } else {
        cout << dp[target] << '\n';
    }

    return 0;
}
```
#pagebreak()

== Coin Combinations I

\
#link("https://cses.fi/problemset/task/1635")[Question - Coin Combinations I]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1635")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Coin Combinations II

\
#link("https://cses.fi/problemset/task/1636")[Question - Coin Combinations II]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1636")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Removing Digits

\
#link("https://cses.fi/problemset/task/1637")[Question - Removing Digits]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1637")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Grid Paths I

\
#link("https://cses.fi/problemset/task/1638")[Question - Grid Paths I]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1638")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Book Shop

\
#link("https://cses.fi/problemset/task/1158")[Question - Book Shop]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1158")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Array Description

\
#link("https://cses.fi/problemset/task/1746")[Question - Array Description]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1746")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Counting Towers

\
#link("https://cses.fi/problemset/task/2413")[Question - Counting Towers]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/2413")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Edit Distance

\
#link("https://cses.fi/problemset/task/1639")[Question - Edit Distance]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1639")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Longest Common Subsequence

\
#link("https://cses.fi/problemset/task/3403")[Question - Longest Common Subsequence]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/3403")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Rectangle Cutting

\
#link("https://cses.fi/problemset/task/1744")[Question - Rectangle Cutting]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1744")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Minimal Grid Path

\
#link("https://cses.fi/problemset/task/3359")[Question - Minimal Grid Path]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/3359")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Money Sums

\
#link("https://cses.fi/problemset/task/1745")[Question - Money Sums]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1745")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Removal Game

\
#link("https://cses.fi/problemset/task/1097")[Question - Removal Game]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1097")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Two Sets II

\
#link("https://cses.fi/problemset/task/1093")[Question - Two Sets II]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1093")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Mountain Range

\
#link("https://cses.fi/problemset/task/3314")[Question - Mountain Range]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/3314")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Increasing Subsequence

\
#link("https://cses.fi/problemset/task/1145")[Question - Increasing Subsequence]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1145")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Projects

\
#link("https://cses.fi/problemset/task/1140")[Question - Projects]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1140")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Elevator Rides

\
#link("https://cses.fi/problemset/task/1653")[Question - Elevator Rides]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1653")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Counting Tilings

\
#link("https://cses.fi/problemset/task/2181")[Question - Counting Tilings]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/2181")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Counting Numbers

\
#link("https://cses.fi/problemset/task/2220")[Question - Counting Numbers]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/2220")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()

== Increasing Subsequence II

\
#link("https://cses.fi/problemset/task/1748")[Question - Increasing Subsequence II]
#h(0.5cm)
#link("https://web.archive.org/web/20251230000000/https://cses.fi/problemset/task/1748")[Backup Link]

\
*Explanation* :

[To be added]

\
*Code :*

```cpp
// To be added
```
#pagebreak()