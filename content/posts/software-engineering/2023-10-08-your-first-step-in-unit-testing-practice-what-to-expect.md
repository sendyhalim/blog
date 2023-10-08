+++
title = "Unit Tests: Your first step in unit testing, what to expect"
date = 2023-10-08
description = "You want to get your first step right in unit testing, a good first step as foundation will help you to move forward and make better decision in unit testing investment onwards"
draft = true

[taxonomies]
tags = ["software-engineering", "unit-test", "best-practices"]
+++


# Set your mindset first
I would like to remind you that you need to understand the motivation behind unit tests,
why are you doing it? It's important that you're convinced because unit tests is an investment,
you will spend time doing it and you want to make sure that you invest properly in order
to get the yield that you want. If you're convinced that it's going to be worth it then read on.

# Concept
Unit testing is a practice of the bigger testing component. In terms of isolation there are generally 2 types of testing:
* Unit testing, focuses on the function unit. Suppose there's function `f` and it depends on `g` and `h` ,
when unit testing `f` we will assume other dependencies `g` and `h` will behave correctly, this is done through "faking" `g` and `h` behavior in
an isolated unit testing environment.
* Functional testing, focuses on testing the end user features and flows to behave as expected, it does not fake `g` and `h` behavior
but rather will expect `f` , `g` and `h` to work well together as a feature/flow.

Unit testing is generally easier to implement because you're testing your code with an isolated environment
where you can fake external service dependencies (database, redis, http API dependencies, etc).

# First Expectation and Setup
Just like programming, you'll be slow at first time writing unit tests but eventually
you'll get better and faster hence your unit test investment will start paying dividends in terms of
saving your / team time. Unit test is programming language agnostic, you can apply the practice in all languages, so
mastering unit test is a long term investment.

Your first step is to find a test library that supports unit tests, some examples
* Rust 👉 the testing component is [baked into the language](https://doc.rust-lang.org/rust-by-example/testing/unit_testing.html), so you can just write unit tests right away without an external library.
* Javascript 👉 you could install [mocha](https://mochajs.org) as the test runner and [chai](https://www.chaijs.com) to set assertions/expectations
* Swift 👉 there's [XCtest](https://www.swift.org/server/guides/testing.html) bundled with the official Swift Package Manager.
* PHP 👉 the most popular one is [PHP Unit](https://phpunit.de)


repeat the process over and over againand you’ll get better.


# Common Components in unit testing
### Testing component
#### Stub

#### Mock

#### Spy

### Integration Component
#### Automated tests

#### Test reports
