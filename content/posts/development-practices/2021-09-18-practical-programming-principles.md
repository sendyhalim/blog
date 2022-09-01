+++
title = "Practical Programming Principles"
date = 2021-09-18T00:00:25+07:00
description = "Practical Programming Principles"

[taxonomies]
tags = ["programming", "principles", "tips"]
+++


There are many programming paradigms, many approaches to code, new tools and frameworks, well things are moving fast 🏎 💨!

I hope this post can be something to be held on when considering programming and development standard.
Usually the considerations will be useful when starting a new project, when there are arguments on
how to approach things in development,, which tool/framework to use. Pick whatever you think is suitable for your project & team, take it with a grain of salt.

Having these principles in mind has helped my team to:
* Make programming decisions: how to structure code, how to handle errors.
* Decide when should we opt-in for a hack and what's the minimum proper way to apply a "quickfix".
* Decide when to invest more in documentations.

### Readability
Readability means it's easy to understand, not just easy to read. `Easy to understand` meaning might vary
because each company/team has their own engineering skills standard. Having a readability standard set earlier will boost
team productivity in the longer run, it'll cut communication cost, reduce time needed to understand the code and hence improve engineer onboarding process.

##### [Readability] Static type
If possible it might be worth the investment to use statically typed language. Code is meant to be read more than it is written,
static typing will improve readability. Compiler will help you eliminate most of the compile-time type errors, this would simplify unit testing, you don't need to test data type unless your project requires you to do a lot runtime type check which is might be another sign of a problem.

##### [Readability] Code comment
Code comment meant to be used as explanation of some approach, usually explaining "why" certain logic is set that way.
The goal is to help your peers and "future you" to understand the code either in code review or when we want to revisit the code in the future. Cases where code comment is beneficial:
A. Complex logic.
B. Motivation regarding unorthodox approach.
C. Hack/quickfix, this would reduce confusion a lot and make it explicit that the approach that's considered a "hackfix" is intended.

##### [Readability] Be explicit enough
Be explicit enough, set the acceptable standard of explicitness with your team.
Obvious examples would be related with variable naming:
A. Use plural for list, vector or array type.
```rust
let emails: Vec<String>;
let users: Vec<User>;
let people: Vec<Person>;
```

B. Use `{value}_by_{type}` naming pattern for key-value data structure (hashmap, btreemap, dictionary, etc)
```rust
// You'll get a user given an email
let userByEmail: HashMap<String, User>;

// You'll get users given a name, maybe you're grouping users by their first name
let usersByFirstName: HashMap<String, Vec<User>>;
```

##### [Readability] Limit on maximum number of characters per line.
Imagine you're reading a book, you need to scroll both vertically & horizontally
to read a paragraph because there's no maximum number of characters per line,
would it be a good user experience? The same goes for writing code, imagine a line of code
that you need to scroll both directions a lot, easier to just scroll vertically right?


### Modularity
Modular means it's easy to plug & change something because there's a _balanced abstraction_. Note that in practice, you do not have to abstract everything,
too much abstraction would be make it less readable and harder to understand. It
would make the most sense to put abstraction on top of something that would likely to change or
something that already has/will have multiple implementations.

One easy example: suppose we want to send
SMS(maybe for MFA use cases - OTP) to our users, putting an interface on top of the actual vendor
implementation might be a good idea, why? Let's start with the business use case, MFA is a critical security feature, having a good OTP delivery rate is crucial for the user experience, we
can't rely only to 1 vendor, it's important to have at least another SMS vendor backup in case the the primary vendor is down or there are other problems (latency drops or the delivery rate drops).
If we put an interface for it, it's easy to switch. The switch strategy might vary, it could be via a circuit breaker mechanism or just a simple remote config to decide which SMS vendor to use.
A bit intermezzo, use [TOTP might be more secure than OTP](https://jumpcloud.com/blog/totp-sms-2fa).

There's a signal that you could use to measure modularity, if it's _relatively easy_
to write unit tests then most probably your code is modular enough because it's easy
to inject dependencies (mock objects in unit test context) and hence will make it easier to refactor things if needed.

### Debuggability
Please note that this part needs to be supported with observability which is part of
system monitoring and outside the scope of this post, this section assumes you have reasonable observability of your system. No one wants their code to throw errors, but life happens.
The easier it is to debug the error, the faster it is to resolve the problem.
Some of the key points to measure your debuggability:
* How easy is it to be alerted when there are errors. Do you know your error rate in production?
* How easy is it to prioritize error? We should be able to separate errors by its severity, errors that block users to do payment should be more important than errors related with changing username.
* Error handling, do we let errors go into limbo? Do we have a clear separation on what's actually considered as an error?
* Error message, do we construct meaningful error message? or is it just printing `"System Error"`?
