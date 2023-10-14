+++
title = "Unit Testing: Minimizing Logic Errors In Unit Tests"
date = 2023-10-14
description = "Logic errors at unit test level could propagate to logic errors at feature level when there's a bug in one of the functions, when this happenns typically it's found at end-to-end testing and it's more costly than unit test."

[taxonomies]
tags = ["software-engineering", "best-practices", "unit-testing"]
+++


# Buggy unit tests
Unit tests can be buggy, similar to how we write business logic code, there could be logic error in the unit tests.
Logic error is very hard to spot because it comes mostly from different expectations in business logic,
usually we find logic error by testing the feature and match the output with the feature requirements,
the other times it's found when you get bug report from QA team or from end users.

A buggy unit test is just on different layer, it's not directly visible in terms of feature requirements,
the end users and "QA" for unit tests are yourself, your teammates, and your engineering lead/manager.

Most of the logic errors in unit tests are categorized into 2 components in terms of where do we spot it:
1. In unit test results. It is easy to detect because the unit tests would be red (not passing), typically it'll look like failing unit tests, you can just fix it rightaway and rerun the test cases.
2. During end to end testing. Logic errors in unit tests are typically similar to a situation where you do not write unit tests thus if there's a bug in one of the function
it would be detected at end to end testing, it is more costly to retest end-to-end compared to reruning unit test.

# How to prevent it
There's no solution that will prevent logic errors by 100%, but I can recommend 2 things to incorporate in your unit testing workflow so you can minimize it:
1. Similar when doing a feature development task, in the task you need to understand the requirements first and start thinking from user's perspective and how
would the feature will be used. In unit tests you're testing a function (smaller unit) that's part of the feature, so you could list down the function requirements (what
do you expect from the function), write down the positive cases, negative cases, and possible edge cases, then review and write the unit tests based on the cases.
This mindset will help you write better unit tests and complete your function implementation faster.

2. I highly recommend to deliberately make your newly written unit tests fail first, this will ensure that your unit tests are asserting properly. I had experience where
the unit tests are green but it's not running assertion properly, I was lucky that I found out about it after testing the end to end feature manually.
I did like 3-4 times of end to end testing, probably I would only need to do 1-2 end to end testing if the unit tests assertions were not buggy.
