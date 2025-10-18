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

This code contained the data types `int`(Integer which is a non decimal number) , `double` (Decimal Number), `string` (Text) and `pair<int,int>`. A `pair` is a datatype that can be a combination of 2 other data types. In this case it was 2 `int`'s but it could be a pair of `int` and `string` and much more. 
=== variables
Variables are strongly typed in `c++` which means you must specify their datatype and then their name;
=== input/output 
Input and output is does with `cin` and `cout` and angle brackets `>>` for input and `<<` for output. 
=== conditional statements
=== loops
=== arrays
=== classes/structs
=== functions




= Questions
