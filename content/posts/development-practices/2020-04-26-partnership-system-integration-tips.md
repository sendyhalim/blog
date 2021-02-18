+++
title = "Partnership System Integration Tips"
date = 2020-08-22T00:00:00+07:00
description = "Partnership System Integration Tips"

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

The development was very intense because there are some parts that need to be customized
for each partners and some of the APIs are not even 100% finished yet. We do the development both ways,
partners also allocated engineering resource on their side to help with the integration.
During this intense moment, we made some mistakes, both engineering related and non engineering.

This post is about the lessons/key takeaways from the experience.
I'll update the post regularly as the learning process continues, stay tuned!

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
There will be times where both parties agrees on to develop new features, depending on the urgency,
if it's a <b>*not a critical*</b> feature then I'd advise to always use `n` sprint as the time estimation.
The new non-critical feature takes 4 hours to complete? Set the estimation to 1 sprint,
if it takes > 50% of sprint points then say it takes 2 sprints. Development is not just
about code-complete, it's about delivering the features that meet the expectation
with minimum bugs and 0 critical bug, probably you need to update your API docs too.


##### Handling major changes/decisions
Make sure major changes/decisions will be discussed internally first, there will be different
point of views, from product, UI/UX, engineering. Anything related to the major decisions should be answered with `Let us discuss internally first, we'll get back to you by X day(s)`


##### Remember, it's a partnership
This is a partnership, it's a relationship where we will work together as a partner for
mutual benefits, it's not a stage to throw mistakes, it's a stage to perform together
and achieve great things together. Having this mindset will help your emotion and stress level in check.

