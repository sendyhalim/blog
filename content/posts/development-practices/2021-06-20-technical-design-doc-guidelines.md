+++
date = 2021-06-20T00:00:25+07:00
title = "Technical Design Doc Guidelines"
description = "Technical Design Doc Guidelines"

[taxonomies]
tags = ["technicaldesigndoc", "guidelines"]
+++


Writing a technical design doc(TDD) is a prerequisite of a medium-high feature development/refactoring initiative, it's a crucial part of the development process.
TDD can ease the process to get everyone on board with the plan, the doc should be reviewed by your CTO/Managers and stakeholders.
It's an essential part of the planning process because <b>it brings people together, especially to get buy-in from the team and stakeholders</b> so they can provide support along the way 🍪!

The post will cover some of the general guidelines that hopefully can assist you to prepare the TDD.
The main principle is simple just like writing code, the easier it is to understand the easier it is to review.


#### Start with background
Background section should help people understand the context, generally you can show high level
overview of how a specific feature works.

#### Current State
Showing an overview of the current state will help people understand the background a bit deeper, if there's a current implementation/flow then show it, and make it explicit what could be improved from the current flow.
Feel free to put links to other existing docs as well. A diagram flow will help people to visualize and catch up quickly.
Free tools that you can use:
* [diagrams.net](https://diagrams.net)
* [MermaidJS](https://mermaid-js.github.io/mermaid/#/)


#### Problem statement
Explain why you're proposing the initiative. Why does it matter?
What impact will it bring?

Some questions that maybe can help you to answer the impact:
* Will it increase the company's business metric either directly or indirectly? If it can save cost, any estimation by what %?
* Are you investing for future needs? Why does that specific investment matter?
* The current process that we have might have pain points and you want to improve it to increase employee/team productivity.


#### Show the available options/solutions that we have
There would be more than one solution that we can apply to solve the problem, it's preferable to lay out the available options that we have.
Each solution should have pros and cons, start with the least preferable solution and iterate to the most preferable solution.
It'll make it easier for us to get back here quickly just in case we pursued the wrong solution.


#### Propose a solution
Propose a solution to solve the problem, and make it clear why we're implementing that specific solution.
Why the others won't work as well as the one that you propose?


#### What are the action items & timelines
List all of the action items and set the PIC. PIC could be a team (the team lead will delegate the tasks) or an individual contributor.
If the project has milestones then set the deadline for each milestone, if it's not then it's ok to just put the end goal deadline,
make sure all the PICs agree with the timeline.


#### What's your backup plan
Things could fail even with an almost perfect plan, what's your backup plan?

If a migration plan fails, what should we do? Is there a way to turn back? If there's a way, should we continue with the risk or is there anything that we should do?
What are the steps of the backup plan? Who's going to execute it?

Specifically in product engineering, suppose it does not meet the deadline, then what are non-essential features that we can cut? Can we move them into the next iterations?


#### Gather feedback
There's no perfect plan, open a feedback session and verify reviewers concerns. Sometimes there are blind spots due to the lack of visibility/outdated product knowledge,
for example the flow that you read has changed after you prepared the plan.

Don't worry too much, that's why we're doing the technical design doc review session 🖖.
