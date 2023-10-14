+++
title = "Unit Testing: The Point of Unit Tests"
date = 2023-10-07
description = "We often heard of writing unit tests as part of the best practices, doing unit tests will save your time and helps you to write modular code"

[taxonomies]
tags = ["software-engineering", "best-practices", "unit-testing"]
+++

Most likely you've heard the term `unit tests` if you're in software engineering or fields related to it.
This post is a short introduction to the unit testing practice, starting with what is it and what's the point
of doing it from my view, it's not meant to be super technical.


# What is Unit Testing
Like the term itself, unit testing is a practice of _writing code_ to test _your code_ as a "unit",
it focuses on the unit logic and _mocks_ the I/O operations and the side effects.

For simplicity, suppose you have a function `calculateInvoiceAmount(order)` that calculates the invoice amount based on
the given order and delivery fee data from a database. The code would look something like this
```
double calculateInvoiceAmount(Order order) {
  deliveryFee = this.fetchDeliveryFeeFromDb();

  return order amount + delivery fee;
}
```

In unit testing, we'll mock (fake) `fetchDeliveryFeeFromDb` so it returns predefined data because we want to test the calculation logic and trust
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

#### Unit tests ease effort for code improvements
Having unit tests properly invested will encourage engineers to improve or refactor a specific functionality.
Improvements vary from dependency upgrades, optimizing approaches taken in a specific function, and many more.

With properly invested unit tests, it's a lot easier to catch breaking changes in the local machine
before it gets deployed on remote environments (staging, production, etc). This would implicitly improve your code quality
because engineers would have more confidence refactoring code that has unit tests compared to one that does not have it,
they know that as long as the existing unit tests (assuming it's invested properly) are green
then most likely the behavior and output are fulfilling the expectations.

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
