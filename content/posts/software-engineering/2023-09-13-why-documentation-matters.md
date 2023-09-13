+++
title = "Why Documentation Matters"
date = 2023-09-13
description = "Documentation really matters and it's actually can save your team time."

[taxonomies]
tags = ["software-engineering", "documentation"]
+++

Imagine buying a washing machine but it has no manual book, would you be happy?
You'd do fine if you have prior experience with a similar machine, but what if you don't?

# Software Engineering Documentation
Same as software engineering/software product it matters a lot. Many years ago, I used to think that
documentation was not really valuable, I was naive. Up until we added more people to the team,
everyone started to wonder why the code was written that way and how would we test the code.

Let's start with the most obvious example, suppose there are new joiners in your team
and they want to set up a work laptop, they will ask you since there's no documentation on what to set up.
How long would it take for you to help them? 5 minutes on average per new joiner?
If you have 10 new joiners it'll add up to maybe ~30-50 minutes, if you're loyal
maybe you'll go through an employee turnover cycle and there will be more new joiners.
It would be a lot easier if you had a document on how to set up a work laptop, bonus point
if you can automate it because it will save more time for your team members as well, you still
need to document how to run the automation though and add a common troubleshooting guide.

So documentation is kind of a leverage for you and other people, when done right it saves a lot of time!

# Is It Worth Documenting?
Documentation is an investment, you need to choose which one to invest, not everything is worth documenting.
I have my own personal heuristics on things that are worth to document:
* Repetitive manual work that cannot be automated/need manual intervention. It's a lot easier to delegate if you have documentation.
* Things that are less likely to change but often being asked. For example, high level guides of
  service common components (secret engine, query layer, business logic layer, etc.) that explain how
  the components interact with each other.
* Post mortem docs, past mistakes and incidents because mostly we can learn something from it
  and something in the past is constant.
* Things that are commonly asked by my collagues. For example
  * Who owns service X? I have an excel contains a service ownership map.
  * Do you have a link to Y? I have an excel that contains common bookmarks a.k.a the yellow page.
* Troubleshooting guide. If you have an on-call process then it's a must to have a troubleshooting guide so people who are on-call can troubleshoot by themselves.


# Documentation Mental Model
* Not everything is worth documenting, look at the pattern in your workplace and decide on things that are worth documenting.
* The more you defer documentation, the more you'll get dragged by other people, the same goes both ways.
* Outdated documentation is the same, if not worse than having no documentation. It misleads people.
* The more detailed your documentation is, the more likely it'll go outdated, pick a balance.
* If it's a critical part of the software then be as detailed as possible, you need to balance with risk of outdated documentation.
  Software critical parts usually have more than 1 person who knows about it, so you can cover each other to make sure the documentation is up to date.
