+++
title = "Practical Programming Principles"
date = 2021-09-18T00:00:25+07:00
description = "Practical Programming Principles"

[taxonomies]
tags = ["programming", "principles", "tips"]
+++


This post is meant to be something to held on when there's a split arguments on
how to approach things in programming, whatever language, framework, tool it is. I hope it can be useful,
pick whatever you think suitable for your project/company, take it with a grain of salt.

There are many programming paradigms(functional, reactive, procedural, OOP, etc), not including the best practices that are also dynamic,
things are moving fast 🏎 💨!

Having these principles will help us to:
* Make programming decisions: how to structure code, error handling (error message) & patterns to use.
* Decide when to invest more in documentations.
* Decide When should we opt-in for hack and what's the proper way to apply "quickfix".

### Readability
Readability means it's easy to understand, not just easy to read. `Easy to understand` meaning might vary
because each company/team has their own engineering skills standard. Having readability standard earlier will help the team
to jump between codebase in the long run, including onboard new engineers. Some keypoints of readability that you could use:

##### Readability - set a limit on maximum number of characters per line.
Imagine you're reading a book, you need to scroll both vertically & horizontally
to read the paragraph because there's no maximum number of characters per line,
would it be a good user experience? The same goes for writing code, imagine a line of code
that you need to scroll both sides a lot, easier to just scroll vertically right?

##### Readability - static type
If possible it might be worth the investment to use statically typed language. Code is meant to be read more than it is written,
static typing will improve readability and combined with compiler will help you eliminate most of the compile-time type errors, this would also reduce
the amount of unit testing. Practically, you don't need to test data type, unless your project requires you to do a lot runtime type check).

#### Readability - code comment
Code comment meant to be used as explanation of some approach,  he goal is to help your peers and future you to understand your code
either in code review or when we want to revisit the code in the future. Cases where code comment would benefit the most:
A. Complex logic
B. Hack/quickfix, this would reduce confusion a lot and make it explicit that the approach that's considered a "hackfix" is intended.
```

### Modularity
Modular means it's easy to plug & change something because there's a balanced abstraction
that supports the change. Beware that in practice, you do not have to abstract everything,
too much abstraction would be make it less readable and harder to understand. It
would make the most sense to put abstraction on top of something that would likely to change or
on top of something that already has multiple implementation in beginning. One easy example: suppose we want to send
SMS(maybe for MFA use cases - OTP) to our users, putting an interface in front of the actual vendor
implementation might be a good idea, why? Let's start with the business use case, MFA is a critical security feature, having a good OTP deliver rate is crucial for the user experience, we
can't rely only to 1 vendor, it's important to have at least another SMS vendor backup in case the the primary vendor is down or there are other problems (latency drops or the delivery rate drops).
If we put an interface for it, it's easy to switch. The switch strategy might vary, it could be via a circuit breaker mechanism or just a simple remote config to decide which SMS vendor to use.

### Debuggability
No one wants their code to throw error, but life happens. The easier it is to debug the faster it is to resolve the problem.
Some of the important things that improves debuggability
* Error handling, do we let errors go into limbo? Do we have a clear separation on what's actually considered as an error?
* Error message, do we construct meaningful error message? or is it just printing `"Error"`?
* Error observability, how easy it is to notice error on production and how easy it is to see the error log? Do we have alerting of error rate?
