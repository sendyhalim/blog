+++
title = "Unit Testing: Prioritizing Unit Test Cases"
date = 2023-10-19
description = "Writing unit tests takes times, in an ideal scenario we would be able cover most of the cases, but in reality it's better to implement the famous 80/20 rule to prioritize which unit tests to invest first"

[taxonomies]
tags = ["software-engineering", "best-practices", "unit-testing"]
+++

# Writing unit tests takes times
Writing unit tests take time, achieving 100% unit test coverage
sometimes we have a very limited time thus it’s usually worth it to prioritize the cases that the unit test will cover,
I recommend to implement the 80/20 rules (Pareto principle) in prioritizing unit tests.

# Unit test coverage and bug-free code
Unit test coverage measures how much % of the codebase that your unit tests have covered.
Achieving 100% unit test coverage does not guarantee a bug-free code and requires tremendous effort to maintain especially when the codebase is evolving over time.
I do not recommend putting _too much effort_ into achieving 100% unit test coverage, instead, it's better to spend
your time on other test cases that are more worthy of investing or spend time on other low-hanging fruit engineering work like code reviews, feature
brainstorming, you could always consult with your supervisor if you're unsure what to do next.

# High-priority unit test cases
In contrast to trying to achieve and maintain perfect unit test coverage, it's better to prioritize unit test cases that are more worth investing in:
* Positive cases are mandatory to invest, prioritize this first because positive cases will be part of the main feature requirements.
* Negative cases, there are 2 types of negative cases.
  * Negative cases that are more likely to happen, this one should be prioritized.
  * Negative cases that are less likely to happen, we should divide it first in terms of impact.
    * If it happens and the negative impact is big then u need to cover it first. For example, it's a must to check the prevention of duplicate bank transfers.
    * If it happens and has low impact and you don’t have the time to cover it then this should have lower priority than other test cases.

# Unit test cases prioritization examples
We're going to use oversimplified requirements as an example. Suppose that you're working on a task
to write a tax calculation function, given a salary, it will calculate the tax with rules:
* If salary is below than 10k then use tax rate 15%.
* If salary is within 10k-20k (`10k <= salary < 20k`) then use tax rate 20%.
* Else use tax rate 30%.

The easiest implementation is to cover negative cases when given a negative salary, and then continue to follow the requirements.
```
Double calculateTax(Double salary) {
  if (salary < 0) {
    // Throw validation error
  } else if (salary < 10k) {
    return salary * 0.15;
  } else if (salary < 20k) {
    return salary * 0.2;
  } else {
    return salary * 0.3;
  }
}
```

The negative case should have unit tests as well in an ideal situation, but suppose that you're in a very tight deadline,
what I recommend is to cover the main requirements first then you could cover the unit test for the `salary < 0` branching because
intuitively it's unlikely the end users would input a negative salary and if they do so accidentally they would notice it and can re-input the correct salary.
