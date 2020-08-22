+++
title = "What I would have done differently - system integration"
date = 2020-08-22T00:00:00+07:00
description = "What I would have done differently when doing system integration"

[taxonomies]
tags = ["development", "practice", "integration", "tips"]
+++


Recently we just had intense integrations with our business partners.
We have a whitelabel product where registered whitelabel partners can use our core engine
and put their brand as the label.

<p class="image-container">
  <img
    src="https://images.unsplash.com/photo-1556484687-30636164638b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1567&q=80"
  >
</p>

The development was very intense because there are some parts that need to be customized for each partners.
We do the development both ways, partners also allocated engineering resource on their side to help with the integration.
During this intense moment, we made some mistakes, both engineering related and non engineering. This post is about
what I would do differently. This post will be updated regularly as the learning process continues, stay tuned!

<hr>

##### Unix timestamp for all datetime API parameters
As of now we're using [iso datetime format](https://www.iso.org/iso-8601-date-and-time-format.html)
for datetime fields, it's very likely that your API clients are using a different
programming language / library and the tool that they choose is going to behave differently.
At the end unixtimestamp is the most general way to pass datetime data.


##### snake_case instead of camelCase for API fields
We had multiple integration problems when partners had typo. Let's face it,
everyone has this experience where you mistype the `camelCase` format,
e.g. `someField` -> `somefield`. Using `snake_case` should reduce the possibility
of the problem thus would save your client's time and your time when doing integration.


##### Use "sprint" as the development estimation time unit
Never say that it's going to take `n` days or `n` hours to develop new features,
always use `n` sprint. The new feature takes 4 hours to complete? Set the estimation to 1 sprint,
if it takes > 50% sprint time then say it 2 sprints. Development is not just
about code-complete, it's about delivering the features that meet the expectation
with minimum bugs and 0 critical bug, probably you need to update your API doc too.
