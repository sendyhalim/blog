+++
title = "Code Review: Code Author Best Practices"
date = 2023-12-10
description = "As code or pull requet author, it's important to apply best practices so you'll get better quality feedback from reviewers as it would help you to ship higher quality code and help you to ship features faster"

[taxonomies]
tags = ["software-engineering", "best-practices", "code-review"]
+++


# Code Author
The code author or pull request(PR) author is the person who makes the changes.
Almost every engineer that I know prefer building software than doing code review,
I personally feel more productive shipping features than doing reviews.

It's in the PR author's best interest to improve the PR quality so other engineers are motivated to review the changes,
in other words, we're focusing on improving the code review UX.
The impact that we're looking for:
* Improve the code review feedback quality, good feedback quality would improve the overall feature impact as well.
* Get reviewers motivated to review your PR, ideally it's better to get feedback from more than 1 engineer.

# Submit small incremental and meaningful changes
Try to split PR into small meaningful changes. Pretty much similar to
breaking a big task into smaller tasks so it's easier to complete because we focus on smaller changes, it's also easier to review a small PR.

There are many ways to organize the PR into small and meaningful changes, some of the common ones that I've seen:
* A PR is considered small enough at max around 100 lines of code. This is completely up to team standard, set a number that the team can accept that it's small enough.
* Consider splitting a PR containing more than 100 lines of code into multiple PRs, the split could be based on:
  * Functionality. For example, the PR contains 2 new HTTP APIs to create a new user and get user details, we can split the flow to create a new user and get user details into separate 2 PRs.
  * Implementation Layer. For example, the PR contains 1 new HTTP API layer with long validation logic and a new business logic layer, we can split it into a separate PR for the new business logic layer with unit tests and another PR that contains the new API and validation logic.

Rule of thumb: the more code that needs to be reviewed, the less the code review quality.
People tend to miss some important details (including me!) when reviewing a long PR.


# Review your own changes
Reviewing your own PR/changes before requesting for review brings a lot of benefits:
* You can spot mistakes earlier and it saves a lot of time for the team, supposedly we can review our own changes quickly because we have the most context of how the code works. Suppose it takes 10 minutes for each engineer to review a PR, the author probably would take only ~4 minutes to review the PR, if self-reviewing the PR could reduce peer review time to 6 minutes then in total it would only take 16 minutes of review time. Imagine if it's summed up for all code reviews in a year! All of those numbers are assumed, I'm sure you get the idea, you can plug whatever the average review time that's spent in your company.


<div class="row mb-4">
  <div class="image-container col-12 col-md-6 mb-4">
    <i><b>Typical code review time illustration</b></i>
    <img
      src="{{ asset_path(path="/assets/images/software-engineering/code-review/code-review-code-author-best-practices/code-review-without-self-review.jpg") }}"
      alt="Code review time without self review would be longer"
    />
  </div>

  <div class="image-container col-12 col-md-6">
    <i><b>Code review time illustration with self review</b></i>
    <img
      src="{{ asset_path(path="/assets/images/software-engineering/code-review/code-review-code-author-best-practices/code-review-with-self-review.jpg") }}"
      alt="Code review time with self review would be faster"
    />
  </div>
</div>


* Engineers would be more motivated (been there) to review a PR from someone who has the reputation to always re-check PR before submission because it's more likely to be in a better review state. You get your PR reviewed quicker in turn which also means you get to ship your feature faster. Having a self-code review checklist could also help to spot your own mistakes earlier, you can follow this common checklist:
  * Make sure the PR fulfills task requirements.
  * Spot any potential security issues e.g. is there any resource that shouldn't be accessed publicly? are you using deprecated crypto algo?
  * Make sure the PR follows the team code convention and is ideally free of linter warnings.
  * Make sure complex code is documented properly.
  * Make sure hackish code is documented properly, explain why it's necessary.


# Write and update unit tests
Always write or update unit tests for any additions or changes at the business logic level.
Unit tests are intended to catch bugs earlier and they also help reviewers to understand and simulate how the PR code works. Read more about unit tests best practices [here](/tags/unit-testing)


# Write a quick/simple tutorial how to test your changes
If you can write tutorials on how to test your changes means you're testing your changes. Tutorials can be as simple as follows.
* PR containing HTTP API changes, you can provide curl examples for some of the most common cases.
* For PR containing script/worker, you can provide examples of how to run it and what's the expected high-level side effects.

Personally, manual testing helps me psychologically (read: will help you to sleep better at night) by knowing that it works and it improves confidence as well. Reviewers could also apply the PR locally and the test tutorial will help them to test it manually.
