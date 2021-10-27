+++
title = "Hack Fix / Quick Fix Considerations"
date = 2021-10-17T00:00:25+07:00
description = "Things to consider when applying hack-fix/quick-fix"
draft = true

[taxonomies]
tags = ["programming", "principles", "tips"]
+++

A hackfix/quickfix in general means we're quickly "band-aid" something, engineering wise or process wise "just to make it work first".
Let's face it, we've been there, there were errors popping and we're urged to apply hackfix or quickfix, sometimes we don't have time to think (imagine the situation happens in late night), sometimes we have a bit of time to think before applying the fix.

I would like to have this post as a structure before applying a quickfix,
the goal is to have give it a split second thought what to consider when applying hackfix/quickfix.
This is based on my experience hands-on the quickfix and based on my observations as well.
We'll have have some quickfix key points and then I'll try to write an example case for each keypoints.

Quickfix key points/to consider:
A. Is the error/bug impacting critical metric negatively?
   If yes then just fix it first. Example: The business is an ecommerce and users can not transact due to a bug then just fix it quickly.
B. Will the error/bug eventually, in short time, going to point A?
   If yes then just fix it first. Example: There's a cpu utilization alert after deployment,
   it's exceeding 80% utilization (threshold set at 80%), after you take a look at your monitoring system it seems like there's some process
   that's slowing down the DB, out of memory error in this service meaning outage and you'd
C. Will the error/bug make some users complain? How many users impacted?
   Let's say you have 100k users, there's only 10 user impacted and it does not blocks critical product flow, do you think it's worth it for a quickfix?

The reason why it's a good practice to think those scenarios before quickfix is because
sometimes the quickfix that we applied would break other features, unless you have
a really good regression testing and you're convinced with the regression process then
better be safe to apply the quickfix safely.
