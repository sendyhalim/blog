+++
title = "Software Engineering Day to Day Best Practices"
date = 2023-09-19
description = "A compilation of software engineering/developer day to day best practices"

[taxonomies]
tags = ["software-engineering", "day-to-day", "best-practices"]
+++

## Background
The software engineering day to day practice is not related directly to programming, there are
many programming best practices out there, but not many sharing the day to day best practices.

I'm opinionated on how engineer should do things, the list is mostly based on my personal and professional
experience either good or bad (usually related with engineering incidents), the list
will be maintained.


## Database Operation
#### Always ask your collague to review
Anytime you need to update/delete data, make sure that someone has reviewed your sql query,
based on my experience it prevents many bad things to happen on prod.

#### Write `where` statement first
Always write the `where` clause (filtering) first whenever you're in a situation where there's no one reviewing your query,
this will prevent you accidentally executing query without filter.
```sql
-- Write this first
... where id = x

-- Instead of
update users set email = 'yyyyy' ....
```

## Development
#### Unit test is a good investment if done properly
Investing in unit tests will eventually save your time if done properly, but not all
unit tests are worth to invest. Considering the limited time, I would prioritize to invest
in unit tests that fulfilled these first:
* Unit tests that proved my code has fulfilled the product requirements.
* Unit tests related with security check.
* Unit tests that cover negative cases that are most likely to happen.
* The rest are low-normal priority unit tests so it depends on how much I'm willing to invest.

#### Do not aim perfect unit test coverage
100% test coverage doesn't mean your code is bug-free, it depends whether you have the correct
logic and branchinng (`if else`, `switch`, etc). Trying to be perfect in unit test coverage generally
will yield a diminishing returns, your time might be better used to invest in other
development.

#### Measure your feature
Make sure you know how to measure your feature / test your code in remote environment (staging, production),
especially in production. I have seen many software engineers that deliver things fast but
they never check their feature on prod, they don't even know whether the feature
works or not ☹️.


## Code Review
#### Test your code
Always test your code before submitting for code review, even in a hurry. Not many
people have time to do detailed code review, so it's your main responsibility to
make sure that it works and doesn't make any problem.


#### Re-review your code
Please always review your code before asking someone to review it. Suppose you have
a PR that's ready to be reviewed and it takes around 20 minutes to review,
imagine if there are 2 people reviewing your code, it'll take 40 minutes of man hour,
best case is your code is approved, but what if it's not, it'll take more man hour right?

What you can do is to review your code first, make sure it fulfills the requirements and
have followed the team standard practice.
