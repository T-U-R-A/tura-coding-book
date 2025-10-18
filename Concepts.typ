#set text(
  font: "New Computer Modern Math"
)

= Concepts

== Basic `c++` syntax

=== Questions
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
