+++
title = "Unit Tests: The Point of Unit Tests"
date = 2023-10-07
description = "We often heard of writing unit tests as part of the best practices, doing unit tests will save your time and helps you to write modular code"

[taxonomies]
tags = ["software-engineering", "unit-test", "best-practices"]
+++

Most likely you've heard the term `unit tests` if you're in software engineering or fields related to it.
This post is intended as a short introduction to the practice, starting with what is it and what's the point
of doing it from my view, it's not meant to be super technical.


# What is Unit Testing
Just like the term, unit testing is basically _writing code_ to test _your code_ as a "unit",
it focuses only just the unit logic and _mocks_ the I/O operations and the side effects.

For simplicity, suppose you have a function `calculateInvoiceAmount(order)`, it will calculate the invoice amount based on
the given order and delivery fee data from a database. The code would look something along the lines of this
```
double calculateInvoiceAmount(Order order) {
  deliveryFee = this.fetchDeliveryFeeFromDb();

  return order amount + delivery fee;
}
```

In unit testing, we'll mock (fake) `fetchDeliveryFeeFromDb` so it returns  predefined data because we just want to test the calculation logic and trust
the DB that it will always be reliable, this way your unit tests only focus on the invoice amount calculation logic `order amount + delivery fee`.
Focusing on the logic helps us to simplify unit testing because your unit tests do not depend on the database.

# What's the point of unit tests, and why it matters?
I acknowledged that I initially just following best practices to write unit tests, no actual motivation back then.
The value was crystal clear after doing it a few times, there are 2 main values of writing unit tests:
1. It saves your time, the leverage is much larger when you have a bigger team size.
2. It helps you to write modular code.

#### It saves your time (and your team!) when done well
Writing unit tests help you to detect regression in your code. Imagine
a typical common scenario where there are functions that depend on other functions,
how do you know changing/adding logic wouldn't break the other functionalities?

Investing in unit tests will help you detect breaking changes in other parts of your code (that
have unit tests written), be it in other functions or in the existing function logic.
This will save your time to do regression tests manually and ultimately it helps you to deliver faster.

#### Unit tests help you to write modular code
Writing unit tests is hard if your code is not modular, you would want to mock
dependencies or I/O in the class/function that you're testing, generally
it's going to be a lot easier writing unit tests for a class/function where
the dependencies are easy to swap (with mock/fake implementation).

Writing code with a mental note that you want to write units for it will
indirectly forces you to make your code modular.

# Real-life example at work
In 2015, we invested in a [library](https://github.com/cermati/satpam) to do generic input validation, there are 50+ validation rules
and it's used in almost all microservices in the company.

It's not uncommon to have security notification to upgrade the library dependencies, luckily
we've already [invested in unit tests](https://github.com/cermati/satpam/tree/master/test/validators) for each of the validation rules both for negative and positive cases.
Upgrading a dependency is a matter of bumping the dependency version number and running the unit tests,
once it's all green we can proceed to push the dependency upgrade to the main codebase.
