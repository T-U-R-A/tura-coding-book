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

The program stores the index of each number in the order it appears. It then scans numbers from 1 to n and checks whether a number appears before its predecessor. Whenever this happens, a new round is required. The final count represents the total number of rounds needed.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n;
    cin >> n;

    vector<int> position(n + 1);
    for (int i = 0; i < n; i++) {
        int value;
        cin >> value;
        position[value] = i;
    }

    int rounds = 1;
    for (int i = 2; i <= n; i++) {
        if (position[i] < position[i - 1]) {
            rounds++;
        }
    }

    cout << rounds;
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

This problem works with a permutation of numbers from 1 to n and asks how many rounds are needed to collect the numbers in increasing order. A new round is required whenever the position of a number x appears after the position of x+1 in the array. Initially, we scan the array and count how many such “breaks” exist to compute the number of rounds.

For each query, two positions in the array are swapped. A full recount after every swap would be too slow, so the key idea is to only update the parts of the array that are affected. Swapping two values only changes the order relations involving those values and their immediate neighbors (x-1, x, x+1). Before performing the swap, we subtract any existing breaks caused by these values. After the swap, we recompute and add back the new breaks.

By maintaining an array that stores the current position of each value, each check can be done in constant time. This allows every query to be processed efficiently, keeping the total complexity fast even for large inputs.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int n, m;
vector<int> arr;   // Stores the permutation
vector<int> pos;   // pos[x] = index where value x is currently located

// Checks whether x and x+1 form a "break"
// A break means x appears after x+1 in the array
bool isBreak(int x) {
    if (x < 1 || x >= n) return false;   // Out of valid range
    return pos[x] > pos[x + 1];
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    cin >> n >> m;

    arr.resize(n);
    pos.resize(n + 2);

    // Read the permutation and record positions of each value
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
        pos[arr[i]] = i;
    }

    // Initially, at least one round is needed
    int rounds = 1;

    // Count how many times x comes after x+1
    // Each such case increases the number of rounds
    for (int x = 1; x < n; x++) {
        if (isBreak(x)) {
            rounds++;
        }
    }

    // Process each swap query
    while (m--) {
        int a, b;
        cin >> a >> b;
        a--; 
        b--;   // Convert to 0-based indexing

        int u = arr[a];
        int v = arr[b];

        // Only these values can affect the number of breaks
        // because other relative orders remain unchanged
        set<int> affected = {
            u - 1, u, u + 1,
            v - 1, v, v + 1
        };

        // Remove old breaks before swapping
        for (int x : affected) {
            if (isBreak(x)) {
                rounds--;
            }
        }

        // Perform the swap in the array
        swap(arr[a], arr[b]);

        // Update positions of the swapped values
        swap(pos[u], pos[v]);

        // Add new breaks after swapping
        for (int x : affected) {
            if (isBreak(x)) {
                rounds++;
            }
        }

        // Output the current number of rounds
        cout << rounds << '\n';
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

This code uses a sliding window to count subarrays with all distinct elements. The right pointer expands the window, while a frequency map tracks duplicates. If a duplicate appears, the left pointer shrinks the window until all elements are unique again.At each position, the number of valid subarrays ending there is added to the answer.

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n;
    cin >> n;

    vector<int> a(n);
    for (int i = 0; i < n; i++) {
        cin >> a[i];
    }

    // Frequency map for elements in the current window
    map<int, int> freq;

    int left = 0;          // Left pointer of the sliding window
    long long answer = 0;  // Total number of valid subarrays

    for (int right = 0; right < n; right++) {
        freq[a[right]]++;  // Add current element to the window

        // Shrink window until all elements are distinct
        while (freq[a[right]] > 1) {
            freq[a[left]]--;
            left++;
        }

        // Number of distinct subarrays ending at 'right'
        answer += (right - left + 1);
    }

    cout << answer;
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

For each distinct value with `occ` occurrences, we have `(occc + 1)` choices: exclude it (0 copies) or choose 1 of the `occ` identical copies to include.
Multiplying choices for all distinct numbers gives total possible combinations including the empty subsequence.
Subtract 1 to remove the empty subsequence case, leaving the count of all distinct-value subsequences.

*Example :*

For the array [1, 3, 5, 2, 9, 3, 2]
\
\

The frequency table stores - 
\

#table(
  columns: 2,

  fill: (x, y) => if (y == 0) { red.lighten(60%) },

  [Key], [Value],
  [1], [1],
  [2], [2],
  [3], [2],
  [5], [1],
  [9], [1],
)

The number of distinct value subsequences 

$ 
&= (1 + 1) dot (2 + 1) dot (2 + 1) dot (1 + 1) dot (1 + 1)
\

&= 2 dot 3 dot 3 dot 2 dot 2
\

&= 72
$


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

    // Count frequency of each distinct value
    map<ll, ll> freq;
    for (int i = 0; i < n; i++) {
        int x;
        cin >> x;
        freq[x]++;
    }

    // For each distinct value, we can include 0, 1, 2, ..., or occ copies
    // This gives (occ + 1) choices per value; multiply all choices together
    ll ans = 1;
    for (auto [num, occ] : freq) {
        ans = (ans * (occ + 1)) % MOD;
    }

    // Subtract 1 to exclude the empty subsequence
    ans = (ans - 1 + MOD) % MOD;
    cout << ans << '\n';

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

We store all people in a linked list, for efficient deletions while moving forward. An iterator walks through the list, skipping one person each time. When the iterator reaches the end, it wraps back to the beginning. Each erased element is printed in order.

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


Solution Overview:
- Uses a Fenwick Tree (Binary Indexed Tree) to efficiently track which positions are still active
- Each position is initially marked as "1" (active), and changed to "0" when removed

*Key Operations*:
1. update(idx, delta): Marks a position as active (+1) or removed (-1)
2. query(idx): Returns count of active elements from position 1 to idx
3. findKth(k): Uses binary search on the Fenwick Tree to find the k-th active element in O(log n) time

*Algorithm Flow*:
- Start with all n positions active
- In each iteration, move k steps forward in the circular list of remaining elements
- Use `findKth` to map from the circular index to the actual position
- Output that position and mark it as removed
- Repeat until all elements are removed

*Complexity*: O(n log n) - n removals, each taking O(log n) for finding and updating

\
*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

class FenwickTree {
    vector<int> tree;
    int n;
public:
    FenwickTree(int n) : n(n), tree(n + 1, 0) {}
    
    // Add delta to position idx (used to mark elements as active/inactive)
    void update(int idx, int delta) {
        for (; idx <= n; idx += idx & -idx)
            tree[idx] += delta;
    }
    
    // Get count of active elements in range [1, idx]
    int query(int idx) {
        int sum = 0;
        for (; idx > 0; idx -= idx & -idx)
            sum += tree[idx];
        return sum;
    }
    
    // Binary search to find the k-th active element (1-indexed)
    int findKth(int k) {
        int pos = 0, bit = 1;
        // Find the highest power of 2 <= n
        while (bit <= n) bit <<= 1;
        bit >>= 1;
        
        // Binary search from highest bit to lowest
        for (; bit > 0; bit >>= 1) {
            if (pos + bit <= n && tree[pos + bit] < k) {
                k -= tree[pos + bit];
                pos += bit;
            }
        }
        return pos + 1;
    }
};

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int n, k;
    cin >> n >> k;
    
    // Initialize Fenwick Tree and mark all positions as active
    FenwickTree ft(n);
    for (int i = 1; i <= n; i++) 
        ft.update(i, 1);
    
    int remaining = n;  // Track how many elements are still active
    int idx = 0;        // Current position in the circular arrangement
    
    while (remaining > 0) {
        // Move k steps forward in circular manner
        idx = (idx + k) % remaining;
        
        // Find the actual position of the (idx+1)-th active element
        int pos = ft.findKth(idx + 1);
        cout << pos << " ";
        
        // Mark this position as removed
        ft.update(pos, -1);
        remaining--;
    }
    
    cout << "\n";
    return 0;
}
```

#pagebreak()

== Nested Ranges Check

\
#link("https://cses.fi/problemset/task/2168/")[Question - Nested Ranges Check]
#h(0.5cm)
#link("https://web.archive.org/web/20250125134618/https://cses.fi/problemset/task/2168/")[Backup Link]

\

*Solution: *

The algorithm uses a clever sorting trick: ranges are stored as ((l, -r), index) so that when sorted, ranges with the same left endpoint have larger right endpoints first. This ordering is crucial for the sweep line approach.

For detecting "contained" ranges, it sweeps left to right tracking the maximum right endpoint seen so far. If the current range's right endpoint is ≤ maxRight, it means this range is contained by a previous one (since they have l_current ≥ l_previous and r_current ≤ r_previous).

For detecting "contains" ranges, it sweeps right to left tracking the minimum right endpoint. If the current range's right endpoint is ≥ minRight, it contains at least one subsequent range (the range extends at least as far right as some range with a greater or equal left endpoint).

The time complexity is O(n log n) due to sorting, and space complexity is O(n). The key insight is that the special sorting allows both containment checks to be done in linear time after sorting.


```cpp
#include <bits/stdc++.h>
using namespace std;
int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n;
    cin >> n;
    vector<pair<pair<int,int>, int>> ranges(n);
    for (int i = 0; i < n; i++) {
        int l, r;
        cin >> l >> r;
        ranges[i] = {{l, -r}, i};
    }
    sort(ranges.begin(), ranges.end());
    vector<int> contains(n, 0), contained(n, 0);
    int maxRight = INT_MIN;
    for (auto &[p, idx] : ranges) {
        int r = -p.second;
        if (r <= maxRight)
            contained[idx] = 1;
        maxRight = max(maxRight, r);
    }
    int minRight = INT_MAX;
    for (int i = n - 1; i >= 0; i--) {
        int r = -ranges[i].first.second;
        int idx = ranges[i].second;
        if (r >= minRight)
            contains[idx] = 1;
        minRight = min(minRight, r);
    }
    for (int x : contains) cout << x << " ";
    cout << "\n";
    for (int x : contained) cout << x << " ";
    cout << "\n";
}

```

#pagebreak()


== Nested Ranges Count

\
#link("https://cses.fi/problemset/task/2169")[Question - Nested Ranges Count]
#h(0.5cm)
#link("https://web.archive.org/web/20250418092433/https://cses.fi/problemset/task/2169/")[Backup Link]

\

*Hint: *

Try sorting the intervals in ascending order of left index and descending order of right index. What algorithm could you come up with where you only have to iterate once through the list to get the answer? Think about why this sorting method was mentioned and what advantages it has. 

*Solution: *

The problem asks us to find two values for each range: the number of other ranges it contains, and the number of other ranges that contain it.
A naive solution comparing every pair would be too slow ($O(n^2)$). We'll need a better approach.

Say we were to sort every interval in ascending order of their left index and in descending order of their right index. This seems pretty random, however if you think about the first range in the sorted list, you can guarantee that any range that comes after it will be inside it simply by checking if it's right index is less than the right index of the first range. 

This applies to all ranges in the sorted list i.e. for any range $i$, any subsequent range $j$ will be contained by $i$ if the right index of range $j$ is less than $i$.

Likewise, the converse also applies, for any range $i$, the *count* of ranges that $i$ is *contained* by is all ranges $j$, where $j < i$, such that right index of $j$ is more than right index of $i$.

Let's look at an example to understand this better:

Say we're given the following ranges, for now they're going to be sorted in the order we want

$
{{1, 10}, {2, 8}, {2, 6}, {5, 7}}
$

Now the first range cannot be contained by anyone, because so the answer for range 0 is 0.

Range 1 is contained by Range 0 because $10 > 8$, so the answer for range 1 is 1.

Range 2 is contained by both range 0 and 1 because $10 > 6 "and" 8 > 6$. Therefore the answer for range 2 is 2.

Lastly range 3 is contained by ranges 0 and 1 but *not* by range 2 because $10 > 7$, $8 > 7$, but $6 < 7$. Therefore the answer for range 3 is 2.

The output of the second line for the question hence would be $0, 1, 2, 2$

This however only ends up solving half the question, we still need to find out for every range $i$, how many ranges it contains.

For this we can use the same sorting order, just iterate in reverse. The reasoning is the same as before: for any range $i$, the *count* of ranges that $i$ *contains* is the number of ranges $j$, where $j > i$ such that right index of $j$ is less than the right index of $i$.

Using the ranges given previously, range 3 can contain no other ranges, therefore it's answer is 0.

Range 2 does *not* contain Range 3 because $7 > 6$. Therefore its answer is 0.

Range 1 contains both range 2 and range 3 because $6 < 8$ and $7 < 8$. Therefore its answer is 2.

Lastly range 0 contains range 1, range 2, and range 3, because $8 < 10$, $6 < 10$, and $7 < 10$. Therefore it's answer is 3.

While the approach seems logical, how can we efficiently find out how many ranges have a right end point less than the current range or greater than the current range. For that, we can use a Fenwick tree as an indexed set. You can add the right index of all ranges either succeeding or preceding and then find the how many right indexes are more or less than the current range.

Looking at the code should make it much clearer:

```cpp
#include <bits/stdc++.h>
using namespace std;

vector<int> fen;

struct Range{
	int l, r, idx; 

  bool operator<(const Range& ran){
    return l < ran.l || l == ran.l && r > ran.r;
  }
};

void add(int x, int k){
	for(; x < fen.size(); x += x & -x)
		fen[x] += k;
}

int sum(int x){
	int ans = 0;
	for(; x > 0; x -= x & -x)
		ans += fen[x];
	return ans;
}

int main(){
	ios_base::sync_with_stdio(0);
	cin.tie(0);
	cout.tie(0);
	//freopen("NestedRangesCount.in","r",stdin);
	//freopen("NestedRangesCount.out","w",stdout);
	int n;
	cin >> n;

	vector<Range> v(n);
	vector<int> comp;

	for(int i = 0; i < v.size(); i++){
		cin >> v[i].l >> v[i].r;
		v[i].idx = i;
		comp.push_back(v[i].r);
	}
  
  //Index compression for the right endpoints:
  sort(comp.begin(), comp.end()); 
  comp.erase(unique(comp.begin(), comp.end()), comp.end());

  for(int i = 0; i < v.size(); i++)
    v[i].r = lower_bound(comp.begin(), comp.end(), v[i].r) - comp.begin() + 1; 

  sort(v.begin(), v.end()); 
  fen.resize(comp.size() + 1);

	vector<int> c(n), d(n);// c[i] is the number of ranges v[i] contains, d[i] is the number of ranges that v[i] is contained by.

	for(int i = v.size()-1; i >= 0; i--){
    // for every range, add the number of ranges with r < v[i].r. l > v[i].r because of the sorting order.
    // if l = v[i].l , then the smaller ranges will get added first to correctly find c[i] because of the sorting order.
    // sum(v[i].r) - 1 gives that number.
		add(v[i].r,1);
		c[v[i].idx] = sum(v[i].r) - 1;
	}

  //Resetting the Fewnick tree.
	fen.clear();
	fen.resize(comp.size() + 1);

	for(int i = 0; i < v.size(); i++){
    // for every range, add the number of ranges with r > v[i].r. l < v[i].l because of the sorting order.
    // if l = v[i].l , then the larger ranges will get added first to correctly find d[i] because of the sorting order.
    // sum(fen.size() - 1) - sum(v[i].r-1) - 1 gives that number.
		add(v[i].r,1);
		d[v[i].idx] = sum(fen.size()-1) - sum(v[i].r-1) - 1;
	}

	for(int i = 0; i < c.size(); i++)
		cout << c[i] << " ";
	cout << endl;

	for(int i = 0; i < d.size(); i++)
		cout << d[i] << " ";
	cout << endl;

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

We iterate through the array while maintaining a running prefix sum. A map stores how many times each prefix sum has appeared so far. At each position, if a previous prefix sum equals `currentSum` − `targetSum`, a subarray with the required sum exists. We add its frequency to the answer and then record the current prefix sum.
This counts all valid subarrays in linear time.

\

*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

using ll = long long;

int main() {
    ll n, targetSum;
    cin >> n >> targetSum;

    vector<ll> array(n);
    for (int i = 0; i < n; i++) {
        cin >> array[i];
    }

    // prefixSumCount[s] = how many times prefix sum 's' has occurred
    map<ll, ll> prefixSumCount;
    prefixSumCount[0] = 1;   // empty prefix

    ll currentSum = 0;
    ll subarrayCount = 0;

    for (int i = 0; i < n; i++) {
        currentSum += array[i];

        // count subarrays ending here with sum = targetSum
        subarrayCount += prefixSumCount[currentSum - targetSum];

        // record current prefix sum
        prefixSumCount[currentSum]++;
    }

    cout << subarrayCount << '\n';
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

We use prefix sums modulo `n` to count subarrays whose sum is divisible by `n`. Each element is first reduced modulo `n` to keep values small.
As we iterate, we maintain the current prefix sum modulo `n`. A map stores how many times each modulo value has appeared so far. If the same modulo appears again, the subarray between them has sum divisible by `n`. We add the frequency of the current modulo to the answer and update the map.


\

*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    long long n;
    cin >> n;

    vector<long long> arr(n);
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
        arr[i] %= n;                 // keep values within modulo n
    }

    unordered_map<long long, long long> frequency;
    frequency[0] = 1;               // empty prefix sum

    long long prefixSum = 0;
    long long result = 0;

    for (int i = 0; i < n; i++) {
        prefixSum = (prefixSum + arr[i]) % n;
        if (prefixSum < 0) prefixSum += n;

        result += frequency[prefixSum];
        frequency[prefixSum]++;
    }

    cout << result;
    return 0;
}
```
#pagebreak()

== Distinct Values Subarrays II

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
    long long n, k;
    cin >> n >> k;

    vector<long long> v(n);
    for (int i = 0; i < n; i++) {
        cin >> v[i];
    }

    map<long long, int> freq;          // frequency of each element in current window
    long long left = 0, ans = 0, distinct = 0;

    for (int right = 0; right < n; right++) {
        // add right element to window
        if (++freq[v[right]] == 1) {
            distinct++;
        }

        // shrink window until we have at most k distinct elements
        while (distinct > k) {
            freq[v[left]]--;
            if (freq[v[left]] == 0) {
                distinct--;
            }
            left++;
        }

        // all subarrays ending at right with start in [left, right] are valid
        ans += (right - left + 1);
    }

    cout << ans << "\n";
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

The movies are sorted by ending time so earlier-finishing movies are considered first. A multiset stores when each of the k watchers becomes free. For each movie, we find the latest watcher free at or before its start time. If such a watcher exists, we assign the movie and update their free time. This greedy process maximizes the total number of movies watched.

\

*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n, k;
    cin >> n >> k;

    // movies[i] = {end_time, start_time}
    vector<pair<int, int>> movies(n);
    for (int i = 0; i < n; i++) {
        cin >> movies[i].second >> movies[i].first;
    }

    // Sort movies by ending time (classic interval scheduling)
    sort(movies.begin(), movies.end());

    // Each element represents when a watcher becomes free
    multiset<int> freeAt;
    for (int i = 0; i < k; i++) {
        freeAt.insert(0);
    }

    int watched = 0;

    for (auto [endTime, startTime] : movies) {
        // Find a watcher who is free at or before startTime
        auto it = freeAt.upper_bound(startTime);

        if (it == freeAt.begin()) {
            // No watcher available
            continue;
        }

        // Assign this movie to the latest possible free watcher
        freeAt.erase(--it);
        freeAt.insert(endTime);
        watched++;
    }

    cout << watched;
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

The code finds the maximum subarray sum whose length lies between `a` and `b`. It first builds a prefix sum array so any subarray sum can be computed in O(1). A multiset stores candidate prefix sums that can serve as valid subarray starts. As the right end moves forward, new valid prefixes are added to the set.
Prefixes that would make the subarray longer than b are removed. The smallest prefix in the set gives the maximum possible subarray ending at the current index. The answer is updated by comparing all such valid subarrays efficiently.

\

*Code :*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    int n, minLen, maxLen;
    cin >> n >> minLen >> maxLen;

    vector<long long> values(n);
    for (int i = 0; i < n; i++) {
        cin >> values[i];
    }

    // Prefix sums: prefix[i] = sum of first i elements
    vector<long long> prefix(n + 1, 0);
    for (int i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + values[i];
    }

    multiset<long long> candidates;
    long long bestSum = LLONG_MIN;

    for (int right = minLen; right <= n; right++) {
        // Add prefix corresponding to subarrays of length >= minLen
        candidates.insert(prefix[right - minLen]);

        // Remove prefix that would make subarray length > maxLen
        if (right > maxLen) {
            candidates.erase(candidates.find(prefix[right - maxLen - 1]));
        }

        // Best subarray ending at 'right'
        bestSum = max(bestSum, prefix[right] - *candidates.begin());
    }

    cout << bestSum << '\n';
    return 0;
}

```
#pagebreak()

