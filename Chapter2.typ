#set text(
  font: "New Computer Modern Math"
)
#set page(
  numbering: "1"
)
#set heading(
  numbering: "1."
)
#show link: underline

#show raw.where(block: true): block.with(fill: luma(240), inset: 8pt, radius: 4pt)

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

The algorithm sorts both applicants and apartments, then uses a *two-pointer approach* to match each applicant with the smallest available apartment whose size differs by at most `k`.
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

The algorithm sorts all weights, then uses two pointers—one at the lightest and one at the heaviest person—to form pairs without exceeding the limit. If they can share a gondola, both are removed; otherwise, the heavier one goes alone. This greedy pairing minimizes the total number of gondolas.

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


*Code :*

```cpp  
// code goes here
}

```
#pagebreak()
== Restaurant Customers

\
#link("https://cses.fi/problemset/task/1619")[Question - Restaurant Customers]
#h(0.5cm)
#link("https://web.archive.org/web/20250810190946/https://cses.fi/problemset/task/1619/")[Backup Link]


\

*Intuitive Explanation* : 


*Code :*

```cpp  
// code goes here
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


*Code :*

```cpp  
// code goes here
}

```
#pagebreak()
== Sum of Two Values

\
#link("https://cses.fi/problemset/task/1640")[Question - Sum of Two Values]
#h(0.5cm)
#link("https://web.archive.org/web/20250810185011/https://cses.fi/problemset/task/1640")[Backup Link]


\

*Intuitive Explanation* : 


*Code :*

```cpp  
// code goes here
}

```
#pagebreak()
== Maximum Subarray Sum

\
#link("https://cses.fi/problemset/task/1643")[Question - Maximum Subarray Sum]
#h(0.5cm)
#link("https://web.archive.org/web/20250810203355/https://cses.fi/problemset/task/1643")[Backup Link]


\

*Intuitive Explanation* : 


*Code :*

```cpp  
// code goes here
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


*Code :*

```cpp  
// code goes here
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


*Code :*

```cpp  
// code goes here
}

```
#pagebreak()