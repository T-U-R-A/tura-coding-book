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

#let arrayToMath(arr) = { // This function should be used only inside math blocks for it's intended effect.
  "{"
  let i = 0
  while i < arr.len() {
    str(arr.at(i))
    if i != arr.len() - 1{ 
    ", " 
    }
    i = i + 1
  }
  "}"
}

#let arrayToImage(arr) = {
  cetz.canvas({
    import cetz.draw: *

    let i = 0
    while i < arr.len() {
      content((0.35 + 0.7 * (i - 1), 0.3), [#i])
      rect((0.7*(i - 1),0),(0.7*i,-0.7), name: "box")
      content((name: "box", anchor: "center"), box(fill: white, text[#arr.at(i)]))
      i = i + 1
    }
  })
}

#let bracketIfNegative(num) = {
  if num.signum() == -1 {
    "("
    str(num)
    ")"
  } else {
    str(num)
  }
}

// Beginning of content:

#outline()

#pagebreak()

= Introductory Problems

== Concepts

=== Basic `c++` syntax

==== Question
Accept the number of students from user. Accept their names and marks. Print the Name(s) of students who scored the highest percentage. We deliberately use C++ features useful for programming contests.

Solution:
```cpp

#include <bits/stdc++.h>
using namespace std;

double calcPercent(int numerator, int denominator){
  return numerator * 100.0 / denominator;
  // An example of a single line comment
  /* An example of a multiline comment
     numerator / denominator * 100.0 will first do integer division.
     That's why we multiply by 100.0 first and then divide by the denominator. */
}

struct Student{
  string name;
  pair<int, int> marks;
  double percent;
  Student(); // this is a default constructor

  // this is a parameterized constructor
  Student(string name, pair<int, int> marks) {
    this->name = name;
    this->marks = marks;
    percent = calcPercent(marks.first, marks.second);
  }
};

// Program execution begins from here
int main() {
  int n;
  cin >> n;

  // to create an array of n Students the default constructor was neccesary
  Student arr[n];
  double maxPercentage = 0.0;

  for(int i = 0; i < n; i++){
    string name;
    pair<int, int> marks;
    cin >> name >> marks.first >> marks.second;

    // calling parameterized constructor
    arr[i] = Student(name, marks);
    maxPercentage = max(arr[i].percent, maxPercentage);
  }

  // a vector is a resizeable array with some useful functions
  // memory is automatically allocated in a vector
  vector<Student> best;

  for(int i = 0; i < n; i++)
    if(arr[i].percent == maxPercentage) {
      // push_back() adds the student to the end of the vector
      best.push_back(arr[i]);
    }

  cout << "Names, Marks and Percentages of top scorers!" << endl;
  for(int i = 0; i < best.size(); i++) {
    cout << "Name: " << best[i].name;
    cout << ", Marks: " << best[i].marks.first << "/" << best[i].marks.second;
    cout << ", Percentage: " << best[i].percent << endl;
  }

  return 0; // end code
}
```

While this isn't the only way to solve the question, the code should cover the most basic `c++ syntax`.

==== Data Types

This code contained the data types `int`(Integer which is a non decimal number) , `double` (Decimal Number), `string` (Text) and `pair<int,int>`. A `pair` is a datatype that can be a combination of 2 other data types and each individual part can be accessed with `.first` and `.second`. In this case it was 2 `int`'s but it could be a pair of `int` and `string` and much more.
==== Variables
Variables are strongly typed in `c++` which means you must specify their datatype and then their name.
==== Input/Output
Input and output is does with `cin` and `cout` and angle brackets `>>` for input and `<<` for output.
==== Conditional Statements
Conditions Statements are represented with `if`. The part inside the `if` block runs if the condition is true. You can also use `else` which triggers if the `if` block above is `false` and create if else ladders with `else if` which triggers if the above `if` and `else if` blocks were `false`.
==== Loops
A loop in the example is a `for` loop, which has 3 parts, the first part initializes a variable. The second part is the condition to determine if the loop should continue and the 3 part is what happens at the end of the loop block which is usually to update the variable initialized in the first part.
==== Classes/Structs
In this program we made a `struct` because their easier to use than a `class`. They work in nearly the same way though and the only difference really is that members in a `struct` are `public` by default but members in a `class` are `private` by default.
==== Arrays/Vectors
An array is a list of many of the same datatype. In this program we made an array of `Students` which is our own datatype. We also made a vector, which unlike an array, has a dynamic size.
==== Functions
A function is something that accepts parameters and returns a value. This includes our `calcPercent` function and the 2 constructors used to make `Student`.

More about `c++` syntax can be learned #link("https://www.w3schools.com/cpp/")[here].

=== Time Complexity<time_complexity>//chap 1

Time Complexity is simply a measure of how much longer it takes a program to run as the input size grows larger. We represent by using something called Big-O Notation. For instance, say we have a program that is $O(n)$, this means that the function is linear, i.e. if you double the input size, the program will take twice as long. A program with time complexity $O(n^2)$ will take 4 times as long for twice the input size.

Whenever you are solving a question, always calculate the time complexity of your algorithm. When you plug in the maximum input sizes into your time complexity, the amount of time it should take should be less than $10^8$ because that's usually how many operations occur in one second.

=== Pointers<pointers>//chap 1
Unlike in other higher level programs languages which you may be familiar with, `c++` allows you to have full control over how to allocate memory. This is achieved by using `pointers`.

A pointer is a variable that stores a memory location instead of the value. Here's an example of a code which uses pointers and we'll explain what it does:-

```cpp

#include <bits/stdc++.h>
using namespace std;

int main(){
  int a = 5; //made an int variable with value 5.
  int *b = new int(7);//made an integer pointer with value 7 at that memory location.
  int &c = a;//made an int variable which refers to the same memory location as a.
  int *d = &a;//made an int pointer which points to the same memory location as a.

  cout << a << " " << *b << " " << c << " " <<  *d << endl;
  c = 9;//also changes a and d
  cout << a << endl;//9
  *d = 15;// also changes a and c
  cout << a << endl;//15

  delete b;//every time you use "new" you must always "delete" the pointer to prevent memory leaks
  return 0;
}
```

While we have written comments, we'll still go deeper to explain the most important lines:

- `int a = 5` creates a variable `a` which has a value 5.
- `int *b = new int(7)` makes a pointer `b`, which at its memory location has the value 7.
- `int &c = a` makes a variable `c` which has the same value that `a` has. This means that modifying one of them will modify the other. They are the same value with 2 different names.
- `int *d = &a` makes a pointer `d` which stores the memory location of `a`. This also makes `d` the same as `a` and `c` however `d` is a memory location which at the location has the same value as `a` and `c`.
- `cout << a << " " << *b << " " << c << " " <<  *d << endl` outputs `a`, `*b` which is the value at memory location `b`, `c` and `*d` which is the value at memory location `d`.
- `c = 9` changes the values of `a` and the value at memory location `d` to 9.
- `*d = 15` changes the value at memory location `d` to 15 which also changes `a` and `c`.
- `delete b` is the most important line. *Every time you use the keyword new, you must use delete to free up the memory*. Otherwise, that memory will remain allocated to nobody after your program has ended. This is called a memory leak and the only way to free up such "leaked" memory is my restarting your computer.

To summarize the new syntax of pointers:

+ `int *x` creates a pointer which stores a memory location.
+ `*x` *dereferences* the pointer allowed you to see the value
+ `int &x` allows you to pass another variable by reference, i.e. Both variables share the same memory location.
+ `&x` gives the memory location of the variable `x`.

=== Vectors in Depth//chap 1

We're going to go into `vectors` in a little more depth. As stated before `vectors` are almost the same as arrays except they are dynamic, meaning the elements can be added and removed but only at the end. This is done by the `push_back()` and `pop_back()` functions.

The way `vectors` make this efficient time wise without wastes a lot of memory is by allocating some memory $x$ in a row. When you `push_back()` an element such that it now exceeds $x$, it moves the entire allocated memory to a new location and allocates memory worth $2x$. This means that the time complexity of inserting elements into a `vector` is close, but not quite $O(1)$. This is called amortized $O(1)$ because it looks at the average instead of each single operation and because `vector` resizes occur infrequently.

Note that `vectors` constant factors are bigger than arrays, which means for questions where every little efficiency matters to solve the question, if you don't need a `vector`, don't use one. However in every other case, it's much safer and more convenient to use `vectors` instead of arrays. The main reason being that:-
+ It's easier to initialize all values in a vector \ ```cpp vector<int> v(5,-1)//Initializes vector of size 5 filled with -1```
+ When passing an array to a function, it *always* passes by reference. Passing by reference simply means that the function can make changes to the original array. Sometimes however we wish to pass by value, meaning that a new copy is made. With vectors we have such freedom to choose.

More technical details about `vectors` can be found #link("https://en.cppreference.com/w/cpp/container/vector.html")[here].

=== Recursion//chap 1

Recursion is the concept of calling some function inside of itself. Say we want to compute the factorial of a number $n$. We can do:

```cpp

#include <bits/stdc++.h>
using namespace std;

int fact(int n){
  if(n == 1) //base case
    return 1;
  return n * fact(n - 1);//recursion
}

int main(){
  int n;
  cin >> n;
  cout << fact(n) << endl;

  return 0;
}
```

Every recursive algorithm has 2 main things:
+ A base case. Some failure point at which you must return a known value. In this code it was $n = 1$ and we returned $1$ for that base case. You can always have multiple base cases if necessary.

+ Recursion. This is the part where you call the original function on a smaller problem than the original. In this case we call `fact(n-1)` and then multiply it by `n` to get `fact(n)`.
Fun fact: It's proven that any recursion function can be written with a loop! Loops are more efficient than recursion, so if it is easier to write a loop you should. However, some programs are too hard to convert to loops so you should stick to recursion.

=== Sorting//chap 1

To sort a data structure like an array of vector, `c++` has it's own sort function for this:

```cpp
#include <bits/stdc++.h>
using namespace std;

int main(){

  int arr[] = {3,4,6,2,5,1};
  vector<int> v = {6,2,4,5,1,3};

  sort(arr, arr+6);//Sorts the array {1,2,3,4,5,6}
  sort(v.begin(), v.end());//Sorts the vector {1,2,3,4,5,6}

  return 0;
}
```

As you can see, the sort function accepts 2 pointers, the start position of the sort and one position after the end of where you want the elements sorted. `arr` is a pointer to the start of the array. You can add a number to this pointer to jump ahead that many places. `arr + 6` is one position past the end of the array because we want to sort the entire array in this case although you don't always have to. `v.begin()` is a pointer to the start of the vector and `v.end()` points one place after the last element of the vector. You can also add a value to `v.begin()` to jump to other positions in the vector to sort only a part of it.

The time complexity of `std::sort` is $O(n log n)$.

=== Binary Search//chap 1

Let's say you want to find a certain number in a list of numbers to see if it exists. Normally the way you would do this is by iterating over each element in the array and checking if it matches the element you're looking for. The time complexity of this is $O(n)$. However, if we were to first sort the array, we can find a number in $O(log n)$!

You may not have realized it, but you have probably already used binary search in your life at least once! When ever you use a dictionary, you don't search word by word to see if it matches the word you are looking for, you instead apply something similar to binary search. Say you're looking for the word "computers", you find open to the middle of the dictionary. You'll probably be in the m-n section which is too far ahead, so you jump back half way. You repeat this until you get to the c section. However, you may be in the ca section which is now behind, so you jump forward by half way forward until you reach "computers". While you may not be doing exactly this, we can use this method to find things really quickly.

The main steps are as follows:

+ Starting in the middle
+ If you are equal to the target you have found the value! Otherwise, go to 3.
+ If you are less than the target, eliminate the left and then jump to the middle of the right half then go back up to 2. If not, go to 4
+ If you are more than the target, eliminate the right half and jump to the middle of the left, then go to 2.

Let's see the algorithm in action:-

Let's say we have the following sorted array:

$
  {1, 4, 4, 5, 6, 6, 7, 9, 13, 15, 16, 18, 21, 30}
$

And let that the target number we are looking for be 18. Let the be the variables $#text(fill: blue)[left] = 0$, $#text(fill: red)[right] = 13$, and $#text(fill: green)[middle] = (#text(fill: blue)[left] +#text(fill: red)[right])/2 = (0 + 13)/2 = 6$ which is the average of #text(fill: blue)[left] and #text(fill: red)[right].

$
  {#text(fill: blue)[1], 4, 4, 5, 6, 6, #text(fill: green)[7], 9, 13, 15, 16, 18, 21, #text(fill: red)[30]}
$

Now we can compare the value of #text(fill: green)[middle] with our target 18. As you can see, #text(fill: green)[middle] < 18. This tells us that our target value lies to the right of #text(fill: green)[middle]. We can now update #text(fill: green)[middle] by first making #text(fill: blue)[left] = #text(fill: green)[middle] + 1 = 6 + 1 = 7, then make $#text(fill: green)[middle] = (#text(fill: blue)[left] +#text(fill: red)[right])/2 = (7 + 13)/2 = 10$.

$
  {1, 4, 4, 5, 6, 6, 7, #text(fill: blue)[9], 13, 15, #text(fill: green)[16], 18, 21, #text(fill: red)[30]}
$

Once again we are too low, so we set #text(fill: blue)[left] = #text(fill: green)[middle] + 1 = 10 + 1 = 11, and then $#text(fill: green)[middle] = (#text(fill: blue)[left] +#text(fill: red)[right])/2 = (11 + 13)/2 = 12$.

$
  {1, 4, 4, 5, 6, 6, 7, 9, 13, 15, 16, #text(fill: blue)[18], #text(fill: green)[21], #text(fill: red)[30]}
$

This time we're too high, so now we set #text(fill: red)[right] = #text(fill: green)[middle] - 1 = 12 - 1 = 11 and then $#text(fill: green)[middle] = (#text(fill: blue)[left] +#text(fill: red)[right])/2 = (11 + 11)/2 = 11$

$
  {1, 4, 4, 5, 6, 6, 7, 9, 13, 15, 16, #text(fill: green)[18], 21, 30}
$

Now #text(fill: green)[middle] is equal to 18 our target! And it only took us 4 steps. If we had iterated normally it would've taken 12.

Here the implementation of this, where the user will supply us a sorted list of numbers and a target value for us to find. We output whether the value exists and then it's position in the list:

```cpp

#include <bits/stdc++.h>
using namespace std;

int main(){
  ios_base::sync_with_stdio(0);
  cin.tie(0);
  cout.tie(0);

  int n, t;
  cin >> n;
  vector<int> v(n);
  for(int i = 0; i < n; i++)
    cin >> v[i];

  int l = 0, r = n - 1, m ;
  while(l <= r){
    m = (l + r)/2;
    if(v[m] == t){//if the number at m meets the target
      cout << "YES" << endl;
      cout << m << endl;
      return 0;
    }
    else if(v[m] < t)
      l = m + 1;//eliminate the left(lesser) half
    else if(v[m] > t)
      r = m - 1;//eliminate the right(greater) half
  }
  cout << "NO" << endl;
  return 0;
}
```

=== Lower Bound and Upper Bound <lbub>//chap 1

Usually whenever we do binary search, we rarely ever want to know if a value is actually there or not, rather we'd like to know 2 things:-

+ The first number in the list greater than or equal to the number. This is called finding the *lower bound*.
+ The first number in the list *strictly* greater than the number. This is called finding the *upper bound*.

To be able to compute the *lower bound* and *upper bound* of some number $t$, we only need to modify the while loop of our earlier binary search algorithm:

Lower Bound:

```cpp
int l = 0, r = n - 1, m, lb = -1;
while(l <= r){
  m = (l + r)/2;
  if(v[m] < t)
    l = m + 1;
  else if(v[m] >= t){// >= instead of > because it lower bound.
    lb = m;//we set the lower bound to the middle
    r = m - 1;// and then eliminate the right half.
  }
}

cout << lb << endl;
```

Upper Bound:

```cpp
int l = 0, r = n - 1, m, ub = -1;
while(l <= r){
  m = (l + r)/2;
  if(v[m] <= t)//< to <= the equal condition isn't missed.
    l = m + 1;
  else if(v[m] > t){
    ub = m;//we set the upper bound to the middle
    r = m - 1;//and then eliminate the right half.
  }
}

cout << ub << endl;
```

You can try the algorithm of lower bound and upper bound on an array and with a target value and see how this works.

Now lucky for you, `c++` comes with it's own upper bound and lower bound functions! Here's their use cases:

* Note: `upper_bound()` and `lower_bound()` only work properly on sorted lists in ascending order. They will output the wrong value otherwise*

```cpp
#include <bits/stdc++.h>
using namespace std;

int main(){
  ios_base::sync_with_stdio(0);
  cin.tie(0);
  cout.tie(0);

  int n, t;
  cin >> n;
  vector<int> v(n);
  for(int i = 0; i < n; i++)
    cin >> v[i];

  vector<int>::iterator lb = lower_bound(v.begin(),v.end(),t);//lower_bound() returns an iterator to the position of the lower bound of t.
  vector<int>::iterator ub = upper_bound(v.begin(),v.end(),t);//upper_bound() returns an iterator to the position of the upper bound of t.

  cout << lb - v.begin() << endl;//difference between lb and v.begin() tell you the index of the lower bound.
  cout << ub - v.begin() << endl;//difference between ub and v.begin() tell you the index of the upper bound.
  return 0;
}
```

As you can see from the code above:-
- `lower(v.begin(),v.end(),t)` returns an `iterator` to the lower bound of `t`.
- `upper(v.begin(),v.end(),t)` returns an `iterator` to the upper bound of `t`.


To get the index, we simply do `lb - v.begin()` and `ub - v.begin()` because that takes the difference in memory location.

You now might wonder, how do you get the largest element lesser than or the largest element less than or equal to. This can be achieved by subtracting 1 to the lower bound and upper bound respectively.


==== `lower_bound()` & `upper_bound()` with custom sorting.

Sometimes your `vector` may not be sorted in ascending order. Sometimes it might be descending, sometimes it could be some custom ordering. In these cases it's important to understand what `lower_bound()` and `upper_bound()` are actually doing.

`lower_bound(first, last, val, comp())` returns an iterator of the first value where `comp(*it,val)` is `false`

`upper_bound(first, last, val, comp())` returns an iterator of the first value where `comp(val,*it)` is `true`

By default, the `comp()` function is `operator<()`, however this can be changed to `greater<int>()` which returns true if the first number is more than the second number, which is needed for it to work properly on a descending list. Note however that `upper_bound()` and `lower_bound()` may not actually give the mathematical definition of lower bound and upper bound if you use it on a descending list. Apply a correction factor as needed.

=== Permutations//chap 1

Let's say you are given a string, and you wish to list out all possible permutations of the string. For instance `"abcde"`. You could probably write out all 5! = 120 possibilities on your own but what rule could you do to make a computer do it? Try listing the permutations yourself and see if you come up with sometime before reading onwards.

Alright, here's the method:

Let's first list out the permutations of a string of length 3 `"abc"`:

+ `"abc"`
+ `"acb"`
+ `"bac"`
+ `"bca"`
+ `"cab"`
+ `"cba"`

As you can see, we went through all permutations starting from the string sorted in ascending order and then in descending order. To then go from one permutation to the next, there are 3 steps:

+ Scan from right to left. The first position where you find the current element less than the next one (`str[i] < str[i+1]`). This position is the pivot.
+ Swap the element at the pivot with its upper bound to the left of it (See @lbub)
+ Reverse all elements after the pivot.

Try this out with your letter sequence and you'll see that this is probably what you do intuitively without realizing it.

Here's the code for that algorithm:

```cpp

#include <bits/stdc++.h>
using namespace std;


int main(){

  string str = "abcd";

  do {
    cout << str << endl;
  } while(next_permutation(str.begin(),str.end());

  return 0;
}
```

==== `next_permutation()`

Fortunately for you, `c++` already has a function for you that generates the next permutation! Here's the same code we wrote above but using `next_permutation()`:

```cpp

#include <bits/stdc++.h>
using namespace std;

bool permute(string &str){
  for(int i = str.length() - 2; i >= 0; i--){
    if(str[i] < str[i + 1]){//pivot finding

      int ub_idx = lower_bound(str.begin() + (i + 1), str.end(), str[i], greater<int>()) - 1 - str.begin();//finds the upper bound of element at pivot.
      swap(str[i], str[ub_idx]);//swaps the ub and the element at the pivot
      reverse(str.begin() + (i + 1), str.end());//reverses the elements after the pivot

      return true;//succesfully produced the next permutation

    }
  }

  return false;//failed to produce the next permutation. This happens when the string is in descending order because that the last permuatation.
}

int main(){

  string str = "abcd";

  do {
    cout << str << endl;
  } while(permute(str));

  return 0;
}
```

=== Backtracking//chap 1

#let board1 = board.with(square-size: 0.5cm)(position(
  "....",
  "....",
  "....",
  "....",
))

#let board2 = board.with(square-size: 0.5cm)(position(
  "Q...",
  "....",
  "....",
  "....",
))

#let board3 = board.with(square-size: 0.5cm)(position(
  ".Q..",
  "....",
  "....",
  "....",
))

#let board4 = board.with(square-size: 0.5cm)(position(
  "..Q.",
  "....",
  "....",
  "....",
))

#let board5 = board.with(square-size: 0.5cm)(position(
  "...Q",
  "....",
  "....",
  "....",
))

#let board6 = board.with(square-size: 0.5cm)(position(
  ".Q..",
  "Q...",
  "....",
  "....",
))

#let board7 = board.with(square-size: 0.5cm)(position(
  ".Q..",
  ".Q..",
  "....",
  "....",
))

#let board8 = board.with(square-size: 0.5cm)(position(
  ".Q..",
  "..Q.",
  "....",
  "....",
))

#let board9 = board.with(square-size: 0.5cm)(position(
  ".Q..",
  "...Q",
  "....",
  "....",
))

#let table1 = figure(
  table(
    columns: 4,
    [0], [1], [2], [3],
    [1], [2], [3], [4],
    [2], [3], [4], [5],
    [3], [4], [5], [6],
  ),
  caption: [First diagonal],
  supplement: none,
)

#let table2 = figure(
  table(
    columns: 4,
    [3], [2], [1], [0],
    [4], [3], [2], [1],
    [5], [4], [3], [2],
    [6], [5], [4], [3],
  ),
  caption: [Second diagonal],
  supplement: none,
)

A backtracking algorithm is one where you recursively go the all possibilities and then backtrack at invalid solutions. Let's use an example to explain this better.

Say we want to know for a $n times n$ chess board, how may ways are there to place $n$ queens, such that two queens never attack each other.#footnote[If you don't know anything about chess, 2 queens attack each other if they both lie on the same row, column, or diagonal.]

This problem can be solved by using backtracking. We can start by placing the first queen in all positions on the first row, for each of those position, see which positions you can place a queen in the second row and so on. Let's looks at some partial solutions when $n = 4$.

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    cetz.tree.tree(
      (
        board1,
        board2,
        (
          board3,
          figure(board6, supplement: none, caption: text(fill: red)[invalid]),
          figure(board7, supplement: none, caption: text(fill: red)[invalid]),
          figure(board8, supplement: none, caption: text(fill: red)[invalid]),
          figure(board9, supplement: none, caption: text(fill: green)[valid]),
        ),
        board4,
        board5,
      ),
    )
  })
]

As you can see, we start with an empty board, then we place a queen in all positions on the first row. Then we place the next queen on the next row in a valid position and then go from there.

To write the code for this. We need 4 arrays, one for every row, columns, and both diagonals. If `row[i]` is true, that means there's a queen in that row and we can't place a queen there. The indexes of the two diagonals will be a follows:


#align(center)[
  #grid(
    columns: 2,
    align: center,
    column-gutter: 2cm,
    table1, table2,
  )
]

If a queen is on row `i` and column `j`, then it will be on `row[i]`, `column[j]`, `diag1[i + j]` and on `diag[(n-1) - j + i]`. Then for the next row, a queen can't be placed on this row, columns, and diagonal.

Here's the code of the implementation for this algorithm:

```cpp

#include <bits/stdc++.h>
using namespace std;

int n, ans = 0;
vector<bool> col, diag1, diag2;

void findPositions(int i = 0){
	if(i == n){//If true, we successfully placed all the queens in an arrangement.
		ans++;
		return;
	}

	for(int j = 0; j < n; j++){
		if(col[j] || diag1[i+j] || diag2[(n-1)-j+i]) //The new queen would be attacked
      continue;
		col[j] = diag1[i+j] = diag2[(n-1)-j+i] = true;//Placing the queen on the current spot
		findPositions(i+1);
		col[j] = diag1[i+j] = diag2[(n-1)-j+i] = false;//Removing queen for the current spot
	}
}
int main(){
	ios_base::sync_with_stdio(0);
	cin.tie(0);
	cout.tie(0);

  cin >> n;
  col.resize(n);
  diag1.resize(2*n-1);
  diag2.resize(2*n-1);
  findPositions();

	cout << ans << endl;
	return 0;
}

```

The `resize()` function of a vector is used when you wish to specify the size of a `vector` after its initialization. The `findPositions()` function has a default value of `i = 0`, so if the parameter isn't supplied it assumes the value to be `0`.
Also observer that we didn't use a `row vector`, because the backtracking algorithm ensures that we are placing the new queen on a new row each time.

The complexity of this code is $O(n!)$ which grows very quickly. Solving the question for high values of $n$ takes a very long time. The highest anybody has computed is $q(27) = 234907967154122528$ and this took over a year of computing! (#link("https://github.com/preusser/q27")[See here]).

== CSES Practice Question

\
=== Weird Algorithm

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

=== Missing Number

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

=== Repetitions

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
=== Increasing Array

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

=== Permutations

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

=== Number Spiral

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

=== Two Knights

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

=== Two Sets

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


=== Bit Strings

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

=== Trailing Zeros

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

=== Coin Piles



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
=== Palindrome Reorder

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


=== Gray Code

\
#link("https://cses.fi/problemset/task/2205")[Question - Gray Code]
#h(0.5cm)
#link("https://web.archive.org/web/20250718094246/https://cses.fi/problemset/task/2205")[Backup Link]

*Hint:*

Trying listing out the solution for $n = 1$, then for $n = 2$ and $n = 3$. Try to see if there is any pattern from the previous smaller sequences to the larger ones. You might even find a pattern just by looking at any one value of $n$. 

==== Solution 1

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

==== Solution 2

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

=== Tower of Hanoi

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


=== Creating Strings

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
=== Apple Division

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


=== Chessboard and Queens

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


=== Raab Game I

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


=== Mex Grid Construction

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

=== Knight Moves Grid

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

=== Grid Coloring I

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


=== Digit Queries

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


=== String Reorder

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

=== Grid Path Description

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
