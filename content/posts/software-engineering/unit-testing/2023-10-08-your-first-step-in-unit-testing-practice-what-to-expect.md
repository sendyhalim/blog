+++
title = "Unit Testing: Your first step in unit testing, what to expect"
date = 2023-10-08
description = "You want to get your first step right in unit testing, a good first step as foundation will help you to move forward and make better decision in unit testing investment onwards"

[taxonomies]
tags = ["software-engineering", "best-practices", "unit-testing"]
+++


# Set your mindset first
I would like to remind you that you need to understand the motivation behind unit tests,
why are you doing it? It's important that you're convinced because writing unit tests is an investment,
you will spend time doing it and you want to make sure that you invest properly to get the yield that you want.
If you're convinced that it's going to be worth it then read on.

# Concept
Unit testing is a practice of the bigger testing component. In terms of isolation there are generally 2 types of testing:
* Unit testing, a testing practice that focuses on the function unit. Suppose there's function `f` and it depends on `g` and `h`,
when unit testing `f` we will assume other dependencies `g` and `h` will behave correctly, this is done through "faking" `g` and `h` behavior in
an isolated unit testing environment.
* Functional testing, a testing practice that focuses on testing the end user features and flows to behave as expected, it does not fake `g` and `h` behavior
but rather will expect `f`, `g`, and `h` to work well together as a feature/flow.

Unit testing is generally easier to implement and run faster because you're testing your code in an isolated environment
where you can fake external service dependencies (database, redis, HTTP API dependencies, etc).

# First Expectation and Setup
Just like programming, you'll be slow at first time writing unit tests but eventually,
you'll get better at choosing which unit tests are worth investing in and able to do it faster hence your unit test investment will start paying dividends in terms of
saving your / team time. Unit test is programming language agnostic, you can apply the practice in all languages, so
mastering unit test is a long-term investment, repeat the process over and over again and you’ll get better.

Your first step is to find a test library that supports unit tests, some examples
* Rust 👉 the testing component is [baked into the language](https://doc.rust-lang.org/rust-by-example/testing/unit_testing.html), so you can just write unit tests right away without an external library.
* Javascript 👉 you could install [mocha](https://mochajs.org) as the test runner and [chai](https://www.chaijs.com) to set assertions/expectations
* Swift 👉 there's [XCtest](https://www.swift.org/server/guides/testing.html) bundled with the official Swift Package Manager.
* PHP 👉 the most popular one is [PHP Unit](https://phpunit.de)


# Common Components in unit testing
Just mastering the common components will get you far in unit testing,
most of them are quite basic and should cover most of your use cases in software engineering,
expect that you'll deal mostly with these components in your unit testing journey.

### Test Doubles / Fake Dependencies
#### Stub
A stub is a dependency replacement that has been pre-programmed with a set of expectations,
they are intended to be used as test double. For a simple explanation, imagine that you have a method `calculateTax` that
depends on some configuration in a database
```java
calculateTax(TaxConfigQuery taxConfigQuery, double salary) {
  Set<TaxConfig> configs = taxConfigQuery.fetchAll();

  // calculate tax based on configs and salary
  // ....

  return tax;
}
```

In unit testing, we'll focus on testing just the logic to calculate salary, this is done by simulating the surrounding environment,
we would create an instance of pre-programmed `TaxConfigQuery` that will return predefined tax configs and inject it (pass as argument)
to the `calculateTax` method.

#### Mock
Mock is a stricter version of stub, you can set more advanced expectations on mock objects. For example
you could check how many times a method has been called or whether it's been called with specific arguments.

Based on my experience it's useful when you have expectations that some critical functions should/should not have
been called for `n` times (could be 0, 1, and so on), such expectations are critical to be verified
when testing idempotent operations or testing a logic with a retry mechanism.


#### Spy
Spy is a test double that acts like a wrapper/proxy to the real instance, it's typically used
when we want to monitor or intercept a method call and then record something before calling the real method.
I usually use them for logging and debugging purposes.


### Integration Component
#### Test reports
Test report is used to analyze and generate statistics on test results,
you would need to install an external dependency because it's usually a separate component of the test framework/library. Most common usage of test reports:
* Standard test results output, but rendered more aesthetically pleasing ✨
* Calculate how much % test coverage in your codebase

#### Automated tests
Usually unit testing framework has a CLI command to run it,
it's a common  practice to  setup a CI pipeline to run unit tests on certain events,
the most common ones:
1. Run unit tests when there's a pull request.
2. Run unit tests when a pull request is merged into the master/main/testing/production branch.

