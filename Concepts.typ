#import "@preview/cetz:0.4.2"
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

#show link: underline

#show raw.where(block: true): block.with(fill: luma(240), inset: 8pt, radius: 4pt)


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

#let bracketIfNegative(num) = {
  if num.signum() == -1 {
    "("
    str(num)
    ")"
  } else {
    str(num)
  }
}

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

// Beginning of content:

#outline()

= Concepts

== Basic `c++` syntax

=== Question
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

While this isn't the only way to solve the question, the code should cover the most basic `c++ syntax`

=== Data Types

This code contained the data types `int`(Integer which is a non decimal number) , `double` (Decimal Number), `string` (Text) and `pair<int,int>`. A `pair` is a datatype that can be a combination of 2 other data types and each individual part can be accessed with `.first` and `.second`. In this case it was 2 `int`'s but it could be a pair of `int` and `string` and much more.
=== Variables
Variables are strongly typed in `c++` which means you must specify their datatype and then their name.
=== Input/Output
Input and output is does with `cin` and `cout` and angle brackets `>>` for input and `<<` for output.
=== Conditional Statements
Conditions Statements are represented with `if`. The part inside the `if` block runs if the condition is true. You can also use `else` which triggers if the `if` block above is `false` and create if else ladders with `else if` which triggers if the above `if` and `else if` blocks were `false`.
=== Loops
A loop in the example is a `for` loop, which has 3 parts, the first part initializes a variable. The second part is the condition to determine if the loop should continue and the 3 part is what happens at the end of the loop block which is usually to update the variable initialized in the first part.
=== Classes/Structs
In this program we made a `struct` because their easier to use than a `class`. They work in nearly the same way though and the only difference really is that members in a `struct` are `public` by default but members in a `class` are `private` by default.
=== Arrays/Vectors
An array is a list of many of the same datatype. In this program we made an array of `Students` which is our own datatype. We also made a vector, which unlike an array, has a dynamic size.
=== Functions
A function is something that accepts parameters and returns a value. This includes our `calcPercent` function and the 2 constructors used to make `Student`.

More about `c++` syntax can be learned #link("https://www.w3schools.com/cpp/")[here].

== Time Complexity

Time Complexity is simply a measure of how much longer it takes a program to run as the input size grows larger. We represent by using something called Big-O Notation. For instance, say we have a program that is $O(n)$, this means that the function is linear, i.e. if you double the input size, the program will take twice as long. A program with time complexity $O(n^2)$ will take 4 times as long for twice the input size.

Whenever you are solving a question, always calculate the time complexity of your algorithm. When you plug in the maximum input sizes into your time complexity, the amount of time it should take should be less than $10^10$ because that's usually how many operations occur in one second.
/*Whenever we're trying to solve a question, we need to come up with an approach that is efficient enough to solve the question within a reasonable amount of time. This can be measured using Big-O notation.

Let's say we have some code that accepts $n$ numbers of numbers from the user and stores them in an array. The amount of time this code will take can be represent as some function $f(n) = m dot n+c$. The exact values of $m$ and $c$ depend on what the compiler does, how long it takes c++ to accepts and store. The main idea however is that it's a linear function. The simpler way to state this is to say that this code has a time complexity of $O(n)$.

The formal definition of Big-O is:

$
f(n) = O(g(n)) "if:"
\
lim_(n -> infinity) f(n)/g(n) <= A  " For some contant" A
$

In simple English, this means that $f(n)$ and $g(n)$ grow at the same rate. Big-O notion is very important to note because it tells us how quickly the time it takes for our program to run grows as our input size grows. Generally you know your algorithm should run in under a second is if $O(f(n)) < 10^10$ where $O(f(n))$ is the time complexity of your function and you plug in the max value of $n$. For example, if you have a code which runs in $O(n)$, it will pass a program if the max value of $n$ is less than $10^10$. If your algorithm is $O(n^2)$, then the max value of $n$ has to be less than $10^5$.*/


== Pointers
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

== Vectors in Depth

We're going to go into `vectors` in a little more depth. As stated before `vectors` are almost the same as arrays except they are dynamic, meaning the elements can be added and removed but only at the end. This is done by the `push_back()` and `pop_back()` functions.

The way `vectors` make this efficient time wise without wastes a lot of memory is by allocating some memory $x$ in a row. When you `push_back()` an element such that it now exceeds $x$, it moves the entire allocated memory to a new location and allocates memory worth $2x$. This means that the time complexity of inserting elements into a `vector` is close, but not quite $O(1)$. This is called amortized $O(1)$ because it looks at the average instead of each single operation and because `vector` resizes occur infrequently.

Note that `vectors` constant factors are bigger than arrays, which means for questions where every little efficiency matters to solve the question, if you don't need a `vector`, don't use one. However in every other case, it's much safer and more convenient to use `vectors` instead of arrays. The main reason being that:-
+ It's easier to initialize all values in a vector \ ```cpp vector<int> v(5,-1)//Initializes vector of size 5 filled with -1```
+ When passing an array to a function, it *always* passes by reference. Passing by reference simply means that the function can make changes to the original array. Sometimes however we wish to pass by value, meaning that a new copy is made. With vectors we have such freedom to choose.

More technical details about `vectors` can be found #link("https://en.cppreference.com/w/cpp/container/vector.html")[here].

== Recursion

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

== Lambda expressions

Lambda expressions are a way to write functions in line without having to write them separately. For example:


```cpp
#include <bits/stdc++.h>
using namespace std;

int main(){

  int n;
  cin >> n;

  function<int (int)> fact = [&] (int num){ // defining the lambda expression
    if(num == 1)
      return 1;
    return num * fact(num-1);
  };

  cout << fact(n) << endl;

  return 0;
}
```
As you can see we've defined a function within the main function. The first part `function<int (int)>` says that you're making a function with return type int and one int parameter. Then after the equal to the `[&]` part allows you to access variables in the scope of the outer function by reference. `[=]` would allow you to access them by value and `[]` wouldn't allow any access. Then you write the actual contents of the function inside the braces.

Lambda expressions are also useful to just make temporary functions without having to make it into a variable. You'll see this used properly in the next section.

== Sorting

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

=== Sorting with a custom sorting order.

Say you with to sort a `vector` in descending order, or you have something more complicated in mind. Well the `sort()` function has an extra parameter to supply your own sorting order.

```cpp
#include <bits/stdc++.h>
using namespace std;

int main(){

  int arr[] = {3,4,6,2,5,1};
  vector<int> v = {6,2,4,5,1,3};

  sort(arr, arr+6, greater<int>());//Sorts the array {6,5,4,3,2,1}
  sort(v.begin(), v.end(), greater<int>());//Sorts the vector {6,5,4,3,2,1}

  return 0;
}
```

The `greater<int>()` function returns true when for the 2 inputs `a` and `b`, `a > b`. Using sort this way ensure that all elements make your comparator function `true`.

Let's say you want to sort a `vector<pair<int,int>>` such that the second element is sorted in ascending order and only if they are equal are the first elements sorted in descending order. Here's how you could go about it, this will also demonstrate how to use lambda expressions:

```cpp
#include <bits/stdc++.h>
using namespace std;

int main(){

  int n;
  cin >> n;
  vector<pair<int,int>> v;
  for(int i = 0; i < n; i++)
    cin >> v[i];

  sort(v.begin(), v.end(), [](const pair<int,int> &a, const pair<int,int> &b){
    return a.second < b.second || a.second == b.second && a.first > b.first)
  });

  return 0;
}
```
//todo: Write about merge sort.

== Binary Search

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

== Lower Bound and Upper Bound <lbub>

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


=== `lower_bound()` & `upper_bound()` with custom sorting.

Sometimes your `vector` may not be sorted in ascending order. Sometimes it might be descending, sometimes it could be some custom ordering. In these cases it's important to understand what `lower_bound()` and `upper_bound()` are actually doing.

`lower_bound(first, last, val, comp())` returns an iterator of the first value where `comp(*it,val)` is `false`

`upper_bound(first, last, val, comp())` returns an iterator of the first value where `comp(val,*it)` is `true`

By default, the `comp()` function is `operator<()`, however this can be changed to `greater<int>()` which returns true if the first number is more than the second number, which is needed for it to work properly on a descending list. Note however that `upper_bound()` and `lower_bound()` may not actually give the mathematical definition of lower bound and upper bound if you use it on a descending list. Apply a correction factor as needed.

== Sets <set>

A `set` in a data structure in `c++`, which has the following properties:

+ A new element can be added to a `set` in $O(log n)$ time.
+ An element can be found in $O(log n)$ time.
+ An element can be removed in $O(log n)$ time.
+ All elements are sorted in ascending order.
+ All elements in a `set` are unique

Here's a quick problem, whose solution will explain how to use sets:-


Accept numbers from a user. Then check if a number exists in the list, if it does, print `YES` followed by removing that number from the list, otherwise print `NO`. At the end print the new list in ascending order.

Solution:

```cpp
#include <bits/stdc++.h>
using namespace std;

int main(){

  int n, q;
  cin >> n >> q;
  set<int> s;

  for(int i = 0; i < n; i++){
    int x;
    cin >> x;
    s.insert(x);//Inserts a value into the set.
  }

  for(int i = 0; i < q; i++){
    int x;
    cin >> x;
    if(s.find(x) != s.end()){//s.find(x) returns the position of x in the set.
      cout << "YES" << endl;
      s.erase(x);//s.erase(x) removes x from the set
    }
    else
      cout << "NO" << endl;
  }

  for(set<int>::iterator it = s.begin(); it != s.end(); it++){
    cout << *it << " ";
  }
  return 0;
}
```

In the solution, we can see that
- `s.insert(x)` inserts `x` into the `set s`. This will ensure that `s` will remain sorted by inserting it into the correct place.
- `s.find(x)` returns the position of `x` in `s`. If `x` doesn't exist, it will return `s.end()` which is a pointer at one place past the position of the last element in the set.
- `s.erase(x)` removes `x` from `s`.

Finally we end up printing all values that are currently in `s`. However, you may notice that instead of the traditional loop with a variable `i` that increase, we're using a `set<int>::iterator`. An iterator is simply a pointer that is used the go over a data structure that is not traditionally indexed. You can very much use the same syntax with vectors too, but it's not necessary.

=== `lower_bound` and `upper_bound`

Unlike for vectors, if you try to use the `lower_bound()` and `upper_bound()` functions, it won't execute binary search and will instead search through them in linear time. The reason for this is that set iterators are not random access, i.e. you can't just say `it + 5` and get the element 5 places ahead of `it`. Instead, you must run a loop to do `it++` 5 times. Fortunately, `set's` have their own implementation of `lower_bound()` and `upper_bound()`. If you have a `set<int> s`, then s.lower_bound(t) will return an iterator to the lower bound of `t` and `s.upper_bound(t)` will return an iterator to the upper bound of `t`.

=== `multiset`

A `multiset` is exactly like a set except that it can store multiple of the same elements, whereas a `set` does not store duplicates. The syntax for using a `multiset` is identical to a `set`, just write `multiset` instead of set

=== `unordered_set`

An `unordered_set` works a bit different then a set. It supports the following operations

+ A new element can be added to a `unordered_set` in $O(1)$\* time.
+ An element can be found in $O(1)$\* time.
+ An element can be removed in $O(1)$\* time.
+ The order of elements are random.
+ All elements in a `unordered_set` are unique

Notice how it almost identical to a set other than the fact that it faster with the downside of no sorted order. This looks as if it would be useful to use an `unordered_set` instead of a `set` if you just want to check if elements exists or not due to their $O(1)$ vs the much slower $O(log n)$. However, this $O(1)$ is not guaranteed and for large test cases that you may expect during questions, it usually ends being the much worse $O(n)$ which will lead to a Time Limit Exceeded(TLE). This is why you should always use a `set` over an `unordered_set` even if you don't care about the sorting order.

=== `unordered_multiset`
Again, it's the same as an `unordered_set` except that it can store multiple of the same element. This also has $O(1)$ operations with the caveat that its worse case is $O(n)$. So you should use `multiset` over `unordered_multiset`.

== Permutations

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

=== `next_permutation()`

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

== Greedy algorithms

//Variables required for Greedy.
#let arr1 = (("1", "3"), ("2", "5"), ("4", "6"), ("3", "8"), ("7", "10"))

A greedy algorithm is a type of algorithm where the solution for a smaller sub-part of the question also applies to the whole question. A greedy algorithm never goes back and corrects it's previous decision. Let's take a look at a question that can be solve with a greedy algorithm:

Question: You are given a list of events. Every event has a start time and an end time. You can only attend one event at a time. Your goal is to pick events in such a way so that you can attend the maximum number of events.

The algorithm to solve this question is to pick an event which ends the earliest and then pick the next non overlapping event that ends the earliest and so on. This always ensures that you can pick the largest number of events.

The reason for this is to think of the opposite. If you were to pick an event the ends later, at best case you can still pick the same number of new events. However at worst you will overlap some events that you could have picked. Let's look at the following example:


#align(center)[
  #table(
    columns: 2,
    [start], [end],
    ..for interval in arr1{
      interval
    }
  )
]

Here's the visualization of all the events:

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    line((0, 0), (10, 0), name: "numline")
    let i = 0
    while i <= 10{
      content((name: "numline", anchor: i), box(fill: white, text[#i]))
      i = i + 1
    }
    
    i = 0
    while i < arr1.len() {
      rect((int(arr1.at(i).at(0)), -0.5-i), (int(arr1.at(i).at(1)), -1-i), fill: luma(240))
      i = i + 1
    }
  })
]

These events are currently sorted in ascending order of their end times. Let's say instead of following the strategy by picking the first event ${1,3}$, you were to pick the second event ${2,5}$ which has a later start time. The only new event you can also attend is ${7,10}$. If you were to pick ${1,3}$, you can pick ${7,10}$, but can also pick ${4,6}$. This is why it's always better to pick event's which end earlier because you have nothing to loose and everything to gain.

There are many other questions where you can use a greedy approach and you'll understand how to use them by solving such questions.

(Add tag to Tasks and deadlines when documents are merged)

== Backtracking

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



#grid(
  columns: (1fr, 1fr),
  align: center,
  column-gutter: -7cm,
  table1, table2,
)

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

== Negative Numbers

In a computer, all numbers are stored in binary. For an `int`, the computer allocated 32 bits. The number 5 stored in an `int` actually looks like:

$
  00000000000000000000000000000101
$

Now for an `unsigned int`, the largest number you can store would be $2^32 - 1 = 4,294,967,295$, which in binary would be:

$
  11111111111111111111111111111111
$

However regular `int` need the capability to store negative numbers. If we start from 0 and then subtract 1, we roll back and reach -1 which would be:

$
  11111111111111111111111111111111
$

Going back one more place give's -2:


$
  11111111111111111111111111111110
$

And so on. until $-2^31 = -2147483648$:

$
  10000000000000000000000000000000
$

if you subtract one from this you go to $2^31 -1 = 2147483647$

$
  01111111111111111111111111111111
$

The way to convert from binary to decimal using this signed format is the realised the rightmost bit represents $-2^31$ instead of positive $2^31$. So to write a negative number in binary, you can set the rightmost bit to 1 and then find what number you need to add to $-2^31$ to get $-n$. This would be $2^31 - n$. Finding this is a pain however, so there's a much better way:


Say we want to find out what is -9 in binary. First we must take the *1's complement* of positive 9. This simply means we flip every bit (0's become 1's and 1's become 0's):

$
  9 = & 00000000000000000000000000001001 \
      & 11111111111111111111111111110110 = -10
$

If you positive number was $n$, this will give you $-n-1$. To get $-n$, you must add 1. This is called taking the *2's complement*. This would give you:

$
  -9 = 11111111111111111111111111110111
$

== Bit Operations

In `c++`, you can perform binary operations on individual bits. This may sound confusing, so let's look at some examples.

=== AND `(&)`

Let's say I have the numbers 5 and 7. The question is what would be the output to `cout << (5 & 7);`?

First we write 5 and 6 in binary, which become 0101 and 0110. Then we perform the `and` operation on each bit to get a new number in binary:

$
             & 0101 \
  #text[`&`] & 0110 \
             & #line(length: 2em) \
             & 0100
$

Finally convert 0100 back to decimal, which is 4

So the code
`cout << (5 & 6);` would output `4`

=== OR (|)

Now we want to find out the output of `cout << (5 | 6) << endl`. We now perform the `or` operation on each bit


$
             & 0101 \
  #text[`|`] & 0110 \
             & #line(length: 2em) \
             & 0111
$

Which is 3 in decimal.

=== XOR (^)

Now we want to find out the output of `cout << (5 ^ 6) << endl`. We now perform the `xor` operation on each bit


$
             & 0101 \
  #text[`^`] & 0110 \
             & #line(length: 2em) \
             & 0011
$

Which is 7 in decimal.

=== NOT(\~)

The `not(~)` operator flips all the bits of a number. In the earlier examples, we we're only showing 4 bits because the numbers were small. However, the `int` type has a total of 32 bits. So if you want to find the output of `cout << (~5) << endl` The answer would be:

$
  \~ & 00000000000000000000000000000101 \
     & #line(length: 16em) \
     & 11111111111111111111111111111010
$

Which is #strike[`4294967290`] `-6`. This is because `~` generates the 1's complement which for some positive $n$ will give you $-n-1$.

=== Left shift(`<<`) and right shift(`>>`)

Left shifting is moving all the bits some number of places to the left. Each left shift is just multiplying the number by 2. So `cout << (3 << 4);` would be $000011 -> 000110 -> 001100 -> 011000 -> 110000$ which is $3 times 2^4 = 3 times 16 = 48$. Right shifting works in the exact opposite manner. Each right shift gives you the floor of the number divided by 2 ($floor(n/2)$). So `cout << (57 >> 3);` is $111001 -> 011001 -> 001100 -> 000110 = 6$.

=== Least Significant Set Bit (LSSB) <lssb>

The least significant bit is the value of the rightmost bit of a binary number. This bit contributes the least to the number. For example, the number 20 in binary is 10100. The right most bit is in the second position from the left (0-indexed). The value it represents is $100 = 2^2 = 4$ which means the LSSB(20) = 4.

*Note: Do not confuse this with Least Significant Bit(LSB). The least significant bit is always the leftmost digit of a binary number.*


If you want to find the $"LSSB"(n)$, all you have to do is `n & -n`.

Why does this work? For that, you must first break up `-n` into `~n+1` because that's taking the 2's complement. When you take the 1's complement of $n$ (`~n`) the rightmost 1 becomes the rightmost 0. All bit to the right of this 0 are 1's.

If you now add 1 to get the 2's complement. All the ones up to the right most 0 become 0's and the rightmost 0 become a 1. So now when you take the `and` of `n` and `-n`, the bits just before the rightmost one have all been flipped, so `&` will make them all 0's. Only the rightmost bit is 1 in both `n` and `-n` so it will be preserved. This will give you a new number in binary which is the $"LSSB"(n)$.

Here's how it looks on 20:

$
      20 = & 00000000000000000000000000010#text(fill: red)[1]00 \
  \& -20 = & 11111111111111111111111111101#text(fill: red)[1]00 \
           & #line(length: 16em) \
           & 00000000000000000000000000000#text(fill: red)[1]01
$

== Bitmask

Bitmasking is the technique of using the binary representation of numbers to represent subsets of the question. Let's look at a problem which can be solved using bitmasks.

Say your given an array and want to return all possible subsets of that array. Here's the code on how to do that and then we'll go through the code:

```cpp

#include <bits/stdc++.h>
using namespace std;

int main(){

  int n = 3;
  vector<int> v = {5, 4, 7};

  for(int mask = 0; mask < (1 << n); mask++){//mask takes all values from 0 - 2^n-1.

    cout << "{ ";

    for(int i = 0; i < n; i++){
      if(mask & (1 << i)//checking if the ith of the mask is 1
        cout << v[i] << " ";
    }

    cout << "}" << endl;
  }

  return 0;
}
```

In the code, the variable `mask` goes through all subsets, where each subset is numbered from 0 to $2^n-1$. In this case $n = 3$ so `mask` goes from 0 to 7. Then for each value of mask, you output all the elements `v[i]` where the `i`th bit(from right to left) is true. This will generate the following output.

```
{ }
{ 5 }
{ 4 }
{ 5 4 }
{ 7 }
{ 5 7 }
{ 4 7 }
{ 5 4 7 }
```

== Prefix sum
//Variables required for Prefix sum.

// #let arr2 = (5, 6, 4, 3, 9, 6, 1, 3) positive only variation in case of spacing issues
#let arr2 = (5, -6, 4, 3, 12, 6, -7, -3)
#let arr3 = ((4, 7), (2, 5), (1, 3))

#let pref = ()

#let i = 0
#while i < arr2.len() {
  pref.push(arr2.at(i))
  if i > 0 {
    pref.at(i) = pref.at(i) + pref.at(i - 1)
  }
  i = i + 1
}

Let's say your asked this question. You're given an array of numbers, and then your given some queries. Each query will give you a range. Your goal is to output the sum of all numbers in that range. For example, let's say you have the following array:

$
  arrayToMath(arr2)
$

// And now you're told to find the sum of elements from index #arr3.at(0).at(0)-#arr3.at(0).at(1), index #arr3.at(1).at(0)-#arr3.at(1).at(1), index #arr3.at(2).at(0)-#arr3.at(2).at(1). The answers to that would be:
And now you're told to find the sum of elements from index 
#for (l, r) in arr3{
  "index "
  str(l)
  "-"
  str(r)
  if(l != arr3.last().at(0)){
  ", "
  } else {
    "."
  }
}
The answers to that would be:

$
  #for (l, r) in arr3{
    let i = l
    let total = 0
    while i <= r{
      total = total + arr2.at(i)
      str(arr2.at(i)) 
      if(i != r) {
        " + "
      } else {
        " = "
      }
      i = i + 1
    }
    str(total)
    linebreak()
  }
$

Note that indices are 0-indexed.

You could solve this questions by simply iterating through all elements in each range and then adding them up. However, each of these operations is amortized $O(n)$. If there are $q$ queries, your complexity would be $O(n q)$. If $n$ and $q$'s limits are $2 times 10^5$, $O(n q)$ would be too slow.

The must faster way would be to compute a *prefix sum* array. This means that every element `pref[i]` sore the sum of all elements from `v[0]` to `v[i]`. Now let's say you want to know the sum from index `a` to `b`. You only have to compute `pref[b] - pref[a-1]` to get the answer. Using our example, the prefix sum array would be:


$
    "original array" & arrayToMath(arr2) \
  "prefix sum array" & arrayToMath(pref)
$

Now the answers to the 3 queries are:

$
  #for (l, r) in arr3{
    bracketIfNegative(pref.at(r))
    $ - $
    bracketIfNegative(pref.at(l - 1))
    $ = $
    str(pref.at(r) - pref.at(l - 1))
    linebreak()
  }
$

You get the correct answer by only having to subtract 2 numbers rather than having to add an entire array.

Here's the code for the implementation of prefix sum:

```cpp
#include <bits/stdc++.h>
using namespace std;

int main(){

  int n, q;
  cin >> n >> q;

  vector<int> v(n);
  for(int i = 0; i < n; i++)
    cin >> v[i];

  vector<int> pref(n);
  pref[0] = v[0];

  for(int i = 1; i < n; i++)
    pref[i] = v[i] + pref[i-1];

  for(int i = 0; i < q; i++){
    int a, b;
    cin >> a >> b;

    if(a != 0)
      cout << (pref[b] - pref[a-1]) << endl;
  }

  return 0;
}

```

Sample input:


#raw(
  str(arr2.len()) + " " + str(arr3.len()) 
+ 
" 
" 
+ 
  for x in arr2 {
    str(x) + " " 
  } 
  +
  for (l, r) in arr3{
"
"
  str(l) + " " + str(r)
}, 

  block: true,
)


Output:

#raw(
  for (l, r) in arr3{
    str(pref.at(r) - pref.at(l - 1))
    if l != arr3.last().at(0) {
"
"
    }
  },
  block: true,
)

The space complexity is $O(n)$ and both update and query operations run in $O(log n)$ time.


== Binary Indexed Tree

Let's say for the question in the previous section, we not only want the ability to find the sum in a given range, we also want to update an element in the array. This means that we need to be able to both change values in the array and output the sum in any given range quickly.

Our earlier approach of maintaining a prefix sum fails, because even though we can output the sum of elements in a range in $O(1)$. If we even change a single value, the time it takes to generate the whole array is amortized $O(n)$. For the constraints of $n <= 2*10^5, q <= 2*10^5$, this is too slow.

There is a data structure which can help us do updates and sums in $O(n log(n))$. This is called a *binary indexed tree(BIT)* or a *Fenwick tree*. In a Fenwick tree, each element is 1-indexed. The $i$th value in the Fenwick tree stores the sum of all elements in the original array from $i - "LSSB(i)" + 1$ to $i$. (see @lssb for meaning of LSSB).


To understand this better, let's look at the array from our previous example and the Fenwick tree that's made from the array.


$
arrayToMath(arr2)
$


#let fenw = () 

/*
#let add(x, k) = {
  while x < fenw.len() {
    fenw.at(x) = fenw.at(x) + k
    x = x + x.bit-and(-x)
  }
}

#let prefSum(x) = {
  let ans = 0
  while x > 0 {
    ans = ans + fenw.at(x)
    x =  x - x.bit-and(-x)
  } 
  ans
}

  #let build() = {
    fenw.push(0)
    
    let i = 0
    while i <= arr2.len(){
      fenw.push(0)
      i = i + 1
    } 
    
    i = 0
    while i < arr2.len(){
      add(i + 1, arr2.at(i))  
      i = i + 1
    }
  } 
*/

#fenw.push(0)

#let i = 0
#while i < arr2.len(){
  fenw.push(0)
  i = i + 1
} 

#let i = 0
#while i < arr2.len(){
  let x = i+1
  while x < fenw.len() {
    fenw.at(x) = fenw.at(x) + arr2.at(i)
    x = x + x.bit-and(-x)
  }
  i = i + 1
}

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    let i = 1
    while i < fenw.len() {
      content((0.35 + 0.7 * (i - 1), 0.3), [#i])
      rect((0.7*(i - 1),0),(0.7*i,-0.7), name: "box")
      content((name: "box", anchor: "center"), box(fill: white, text[#fenw.at(i)]))
      i = i + 1
    }

    set-style(mark: (end: ">"))

    i = 1
    while i <= arr2.len() {
      let lssb = i.bit-and(-i)
      line((0.35 + 0.7 * (i - 1),-0.7 - 0.7*(calc.log(lssb,base:2) + 1)),(0.35 + 0.7 * (i - 1),-0.7))
      i = i + 1
    }

    i = 1
    while i <= arr2.len(){
      let lssb = i.bit-and(-i)
      rect((0.7 * i, -1.4 - 0.7*(calc.log(lssb,base:2) + 1)),(0.7 * (i - lssb), -0.7 - 0.7*(calc.log(lssb,base:2) + 1)), stroke: none, name: "box")
      content((name: "box", anchor: "center"), 
        {
          let j = i - lssb
          while j < i {
            str(arr2.at(j))
            if j != i - 1 {
              " + "
            }
            j = j + 1 
          }
        },
        frame: "rect",
        padding: 0.15cm,
        fill: luma(240),
      )
      i = i + 1
    }

  })
]

Note that the values in a fenwick tree are one-indexed, so there we be an empty element at `fenw[0]`.

#let idx1 = 5
#let val = 4
#let idx2 = 7 
#let i = idx1

Hopefully the image made it clearer on how data is stored.  The reason for storing data like this is because if you want to add a value to 1 element in the original array, you only need to update $O(log n)$ values in the Fenwick tree. And after doing this, you can find the sum in $O(log n)$. Say we wish to add #val to the #str(idx1)th index (one-indexed), we only need to update the 
#while i <= fenw.len(){
  str(i)+"th"
  if i + i.bit-and(-i) <= fenw.len() {
    ", "
  }
  i = i + i.bit-and(-i)
}

#let i = idx2

index. If you now want to compute the prefix sum of the array from index #idx2, you only need to add the values in the 
#while i > 0{
  str(i)+"th"
  if i - i.bit-and(-i) > 0 {
    ", "
  }
  i = i - i.bit-and(-i)
}
index.

Here's a diagram to illustrate the changes:

Add #val to the #str(idx1)th index:

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    let i = 1
    let check = idx1
    while i < fenw.len() {
      content((0.35 + 0.7 * (i - 1), 0.3), [#i])
      rect((0.7*(i - 1),0),(0.7*i,-0.7), name: "box")
      if i == check {
        content((name: "box", anchor: "center"), box(fill: white, text(fill: red)[#(fenw.at(i) + 4)]))
        check = check + check.bit-and(-check)
      }
      else {
      content((name: "box", anchor: "center"), box(fill: white, text[#fenw.at(i)]))
      }
      i = i + 1
    }

    set-style(mark: (end: ">"))

    i = 1
    while i <= arr2.len() {
      let lssb = i.bit-and(-i)
      line((0.35 + 0.7 * (i - 1),-0.7 - 0.7*(calc.log(lssb,base:2) + 1)),(0.35 + 0.7 * (i - 1),-0.7))
      i = i + 1
    }

    i = 1
    while i <= arr2.len(){
      let lssb = i.bit-and(-i)
      rect((0.7 * i, -1.4 - 0.7*(calc.log(lssb,base:2) + 1)),(0.7 * (i - lssb), -0.7 - 0.7*(calc.log(lssb,base:2) + 1)), stroke: none, name: "box")
      content((name: "box", anchor: "center"), 
        {
          let j = i - lssb
          while j < i {
            if j == idx1 - 1 {
              text(fill:red)[#(arr2.at(j) + 4)] 
            } else {
              str(arr2.at(j))
            }
            if j != i - 1 {
              " + "
            }
            j = j + 1 
          }
        },
        frame: "rect",
        padding: 0.15cm,
        fill: luma(240),
      )
      i = i + 1
    }

  })
]

Prefix sum at the #str(idx2)th index:

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    let i = fenw.len() - 1
    let check = idx2
    while i > 0 {
      content((0.35 + 0.7 * (i - 1), 0.3), [#i])
      rect((0.7*(i - 1),0),(0.7*i,-0.7), name: "box")
      if i == check {
        content((name: "box", anchor: "center"), box(fill: white, text(fill: red)[#fenw.at(i)]))
        check = check - check.bit-and(-check)
      }
      else {
      content((name: "box", anchor: "center"), box(fill: white, text[#fenw.at(i)]))
      }
      i = i - 1
    }

    set-style(mark: (end: ">"))

    i = 1
    while i <= arr2.len() {
      let lssb = i.bit-and(-i)
      line((0.35 + 0.7 * (i - 1),-0.7 - 0.7*(calc.log(lssb,base:2) + 1)),(0.35 + 0.7 * (i - 1),-0.7))
      i = i + 1
    }

    i = arr2.len()
    check = idx2
    while i > 0{
      let lssb = i.bit-and(-i)
      rect((0.7 * i, -1.4 - 0.7*(calc.log(lssb,base:2) + 1)),(0.7 * (i - lssb), -0.7 - 0.7*(calc.log(lssb,base:2) + 1)), stroke: none, name: "box")
      content((name: "box", anchor: "center"), 
        {
          let j = i - lssb
          while j < i {
            if i == check {
              text(fill:red)[#arr2.at(j)]
              if j != i - 1 {
                text(fill:red)[ \+ ] 
              }
            }
            else {
              str(arr2.at(j))
              if j != i - 1 {
                " + "
              }
            }
            j = j + 1 
          }
          if(i == check){
            check = check - check.bit-and(-check)  
          }
        },
        frame: "rect",
        padding: 0.15cm,
        fill: luma(240),
      )
      i = i - 1
    }

  })
]

If you can caculate the prefix sum at some index $i$ in $O(log n )$, you can then do `sum(b) - sum(a-1)` to find the sum of numbers in the sub array `a` to `b`.

Here's the code for the Fenwick tree implementation:

```cpp

#include <bits/stdc++.h>
using namespace std;

int n;
vector<int> fenw;

void add(int x, int k){
  for(; x <= n ; x += x & -x)// x & -x is the LSSB(x)
    fenw[x] += k;
}

int sum(int x){
  int ans = 0;
  for(; x > 0; x -= x & -x)// x & -x is the LSSB(x)
    ans += fenw[x];
  return ans;
}

int sum(int a, int b){
  return sum(b) - sum(a - 1);
}

int main(){
  int q;
  cin >> n >> q;
  fenw.resize(n + 1, 0);
  for(int i = 1; i <= n; i++){
    int x;
    cin >> x;
    add(i, x);
  }
  
  for(int i = 0; i < q; i++){
    int t;
    cin >> t;
    if(t == 1){// addition queries
      int x, k;
      cin >> x >> k;
      add(x, k);
    }
    else if(t == 2){// range sum queries
      int a, b;
      cin >> a >> b;
      int ans = sum(a, b);
      cout << sum(a, b) << endl;
    }
  }
  return 0;
}
```

Sample Input:

```
8 6
5 -6 4 3 12 6 -7 -3
2 4 7
1 5 4
2 4 7
2 1 3
1 3 -8
2 2 7
```
Output:

```
14
18
3
8
```

=== Fenwick Tree's as Indexed Sets

A Fenwick tree can also be used as an indexed set. In @set, a set was explained to be a data structure that lets you insert, find, and erase elements in $O(log n)$ time. It was also sorted and contained unique elements. However, it's not possible to simply access the 2nd, or 5th, or 12th, value in a set unless you iterate all the way from the beginning to that position. That makes accessing elements at a specific index $O(n)$.

If you also want to be able to access elements at specific indexes in a set, you can use a Fenwick tree as a frequency table. This means that at `fewn[x]`, you store the of times element `x` occurs in your original data. Of course `fewn[x]` will actually store the sum of frequencies from `x - LSSB(x) + 1` to `x` but you get the point. This makes is sorted by default because it describes how many times 1 appears, followed by how many times 2 appears and so on. 

Now if you want to add an element `a` to the set, you simply do `add(a,1)` in the Fenwick tree to increase it's frequency by 1. If you want to remove an element `b`, you do `add(b, -1)` to decrease it's frequency by 1. If you want to find the index of the last occurrence of an element `c`, do `sum(c)`, if you want to find the index of the first occurrence of `c` do `sum(c-1) + 1`. And finally, the main difference is the ability to find what element is at position `i`. This requires a new function.

Here's the code of the search function:

```cpp
int search(int idx){
  int ans = 0;

  for(int k = floor(log2(n)); k >= 0; k--){//go through the powers of 2.
    if(1 << k <= n && fenw[ans + (1 << k)] < idx){//this element is before the idx.
      ans += 1 << k;//update the answer.
      idx -= fenw[ans];//account for all indices upto fenw[ans].
    }
  }

  return ans + 1;//ans was the value that was before idx, so one value ahead of that is at idx.
}
```

In the code of the search function, you start with `k = floor(log2(n))` where $2^k$ is the largest power of 2 less than or equal to $n$. Then for each value, you check to see if it's index (`fenw[ans + 1 << k]`) is less than the `idx`. If it is, you add $2^k$ to the answer and then subtract `idx` by the indexes covered (`fenw[ans]`). 

Since `ans` store the number that is definitely before index, `ans + 1` tells you what number is exactly at `idx`. The reason why you can't find the index directly is because the Fenwick tree frequency table can have multiple of the same numbers, so you can't guarantee that you will find what value is there at your exact `idx`.
  
/*
 * TODO:
 * Graph Representations
 * BFS
 * Linked List
 */
