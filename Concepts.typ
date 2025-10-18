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
Accept the number of students from user. Accept their names and marks. Print the Name(s) of students who scored the highest percentage.

Solution:
```cpp 

#include <bits/stdc++.h> 
using namespace std;

double calcPercent(int numerator, int denominator){
  return numerator * 100.0 / denominator;
}

struct Student{
  string name;
  pair<int, int> marks;
  double percent;
  Student();
  Student(string name, pair<int, int> marks){
    this->name = name;
    this->marks = marks;
    percent = calcPercent(marks.first, marks.second);
  }
};

int main(){

  int n;
  cin >> n;
  Student arr[n];
  double maxPercentage = 0;
  for(int i = 0; i < n; i++){
    string name;
    pair<int, int> marks;
    cin >> name >> marks.first >> marks.second; 
    arr[i] = Student(name, marks);
    maxPercentage = max(arr[i].percent, maxPercentage);
  }
  
  vector<Student> best;
  for(int i = 0; i < n; i++)
    if(arr[i].percent == maxPercentage)
      best.push_back(arr[i]);
  
  cout << "Names, Marks and Percentages of top scorers!" << endl;
  for(int i = 0; i < best.size(); i++)
    cout << "Name: " << best[i].name << ", Marks: " << best[i].marks.first << "/" << best[i].marks.second << ", Percentage: " << best[i].percent << endl;
  return 0;
}
```

While this isn't the only way to solve the question, the code should cover the most basic `c++ syntax`

=== data types

This code contained the data types `int`(Integer which is a non decimal number) , `double` (Decimal Number), `string` (Text) and `pair<int,int>`. A `pair` is a datatype that can be a combination of 2 other data types and each individual part can be accessed with `.first` and `.second`. In this case it was 2 `int`'s but it could be a pair of `int` and `string` and much more. 
=== variables
Variables are strongly typed in `c++` which means you must specify their datatype and then their name;
=== input/output 
Input and output is does with `cin` and `cout` and angle brackets `>>` for input and `<<` for output. 
=== conditional statements
Conditions Statements are represented with `if`. The part inside the `if` block runs if the condition is true. You can also use `else` which triggers if the `if` block above is `false` and create if else ladders with `else if` which triggers if the above `if` and `else if` blocks were `false`.
=== loops
A loop in the example is a `for` loop, which has 3 parts, the first part initializes a variable. The second part is the condition to determine if the loop should continue and the 3 part is what happens at the end of the loop block which is usually to update the variable initialized in the first part. 
=== classes/structs
In this program we made a `struct` because their easier to use than a `class`. They work in nearly the same way though and the only difference really is that members in a `struct` are `public` by default but members in a `class` are `private` by default. 
=== arrays/vectors
An array is a list of many of the same datatype. In this program we made an array of `Students` which is our own datatype. We also made a vector, which unlike an array, has a dynamic size.
=== functions
A function is something that accepts parameters and returns a value. This includes our `calcPercent` function and the 2 constructors used to make `Student`.

More about `c++` syntax can be learned #link("https://www.w3schools.com/cpp/")[here].

== Time Complexity
Whenever we're trying to solve a question, we need to come up with an approach that is efficient enough to solve the question within a reasonable amount of time. This can be measured using Big-O notation.

Let's say we have some code that accepts $n$ numbers of numbers from the user and stores them in an array. The amount of time this code will take can be represent as some function $f(n) = m dot n+c$. The exact values of $m$ and $c$ depend on what the compiler does, how long it takes c++ to accepts and store. The main idea however is that it's a linear function. The simpler way to state this is to say that this code has a time complexity of $O(n)$. 

The formal definition of Big-O is:

$
f(n) = O(g(n)) "if:"
\
lim_(n -> infinity) f(n)/g(n) <= A  " For some contant" A
$

In simple English, this means that $f(n)$ and $g(n)$ grow at the same rate. Big-O notion is very important to note because it tells us how quickly the time it takes for our program to run grows as our input size grows. Generally you know your algorithm should run in under a second is if $O(f(n)) < 10^10$ where $O(f(n))$ is the time complexity of your function and you plug in the max value of $n$. For example, if you have a code which runs in $O(n)$, it will pass a program if the max value of $n$ is less than $10^10$. If your algorithm is $O(n^2)$, then the max value of $n$ has to be less than $10^5$.

== Vectors in Depth

We're going to go into `vectors` in a little more depth. As stated before `vectors` are almost the same as `arrays` except they are dynamic, meaning the elements can be added and removed but only at the end. This is done by the `push_back()` and `pop_back()` functions. 

The way `vectors` make this efficient time wise without wastes a lot of memory is by allocating some memory $x$ in a row. When you `push_back()` an element such that it now exceeds $x$, it moves the entire allocated memory to a new location and allocates memory worth $2x$. This means that the time complexity of inserting elements into a `vector` is close, but not quite $O(1)$. This is called amortized $O(1)$ because it looks at the average instead of each single operation and because `vector` resizes occur infrequently.

Note that `vectors` constant factors are bigger than `arrays`, which means for questions where every little efficiency matters to solve the question, if you don't need a `vector`, don't use one. However in every other case, it's much safer and more convenient to use `vectors` instead of `arrays`.

More technical details about `vectors` can be found #link("https://en.cppreference.com/w/cpp/container/vector.html")[here].
