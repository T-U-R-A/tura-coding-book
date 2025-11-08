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
  ios_base::sync_with_stdio(0);
  cin.tie(0);
  cout.tie(0);
  
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

#pagebreak()

Note that `vectors` constant factors are bigger than arrays, which means for questions where every little efficiency matters to solve the question, if you don't need a `vector`, don't use one. However in every other case, it's much safer and more convenient to use `vectors` instead of arrays. The main reason being that:-
+ It's easier to initialize all values in a vector \ ```cpp vector<int> v(5,-1)//Initializes vector of size 5 filled with -1```
+ When passing an array to a function, it *always* passes by reference. Passing by reference simply means that the function can make changes to the original array. Sometimes however we wish to pass by value, meaning that a new copy is made. With vectors we have such freedom to choose.

More technical details about `vectors` can be found #link("https://en.cppreference.com/w/cpp/container/vector.html")[here].


== Sorting

To sort a data structure like an array of vector, `c++` has it's own sort function for this:

```cpp
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

//todo: Write about merge sort.

#pagebreak()

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

And let that the target number we are looking for be 18. Let the be the variables $#text(fill:blue)[left] = 0$, $#text(fill:red)[right] = 13$, and $#text(fill:green)[middle] = (#text(fill:blue)[left] +#text(fill:red)[right])/2 = (0 + 13)/2 = 6$ which is the average of #text(fill:blue)[left] and #text(fill:red)[right].

$
{#text(fill:blue)[1], 4, 4, 5, 6, 6, #text(fill:green)[7], 9, 13, 15, 16, 18, 21, #text(fill:red)[30]}
$

Now we can compare the value of #text(fill:green)[middle] with our target 18. As you can see, #text(fill:green)[middle] < 18. This tells us that our target value lies to the right of #text(fill:green)[middle]. We can now update #text(fill:green)[middle] by first making #text(fill:blue)[left] = #text(fill:green)[middle] + 1 = 6 + 1 = 7, then make $#text(fill:green)[middle] = (#text(fill:blue)[left] +#text(fill:red)[right])/2 = (7 + 13)/2 = 10$.

$
{1, 4, 4, 5, 6, 6, 7, #text(fill:blue)[9], 13, 15, #text(fill:green)[16], 18, 21, #text(fill:red)[30]}
$

Once again we are to low, so we set #text(fill:blue)[left] = #text(fill:green)[middle] + 1 = 10 + 1 = 11, and then $#text(fill:green)[middle] = (#text(fill:blue)[left] +#text(fill:red)[right])/2 = (11 + 13)/2 = 12$. 

$
{1, 4, 4, 5, 6, 6, 7, 9, 13, 15, 16, #text(fill:blue)[18], #text(fill:green)[21], #text(fill:red)[30]}
$

This time we're to high, so now we set #text(fill:red)[right] = #text(fill:green)[middle] - 1 = 12 - 1 = 11 and then $#text(fill:green)[middle] = (#text(fill:blue)[left] +#text(fill:red)[right])/2 = (11 + 11)/2 = 11$

$
{1, 4, 4, 5, 6, 6, 7, 9, 13, 15, 16, #text(fill: green)[18], 21, 30}
$

Now #text(fill:green)[middle] is equal to 18 our target! And it only took us 4 steps. If we had iterated normally it would've taken 12.

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

=== Lower Bound and Upper Bound

Usually whenever we do binary search, we rarely ever want to know if a value is actually there or not, rather we'd like to know 2 things:-

+ The first number in the list greater than or equal to the number. This is called finding the *lower bound*.
+ The first number in the list *strictly* greater than the number. This is called finding the *upper bound*.

To be able to compute the *lower bound* and *upper bound* of some number $t$, we only need to modify the while loop of our earlier binary search algorithm:

#pagebreak()

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
== Sets

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

#pagebreak()

Notice how it almost identical to a set other than the fact that it faster with the downside of no sorted order. This looks as if it would be useful to use an `unordered_set` instead of a `set` if you just want to check if elements exists or not due to their $O(1)$ vs the much slower $O(log n)$. However, this $O(1)$ is not guaranteed and for large test cases that you may expect during questions, it usualy ends being the much worse $O(n)$ which will lead to a Time Limit Exceeded(TLE). This is why you should always use a `set` over an `unordered_set` even if you don't care about the sorting order.

=== `unordered_multiset`
Again, it's the same as an `unordered_set` except that it can store multiple of the same element. This also has $O(1)$ operations with the caveat that its worse case is $O(n)$. So you should use `multiset` over `unordered_multiset`.
/*
* TODO: 
* Explain next permutation
*/
