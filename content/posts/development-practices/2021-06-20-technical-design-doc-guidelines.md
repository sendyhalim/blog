+++
date = 2021-06-20T00:00:25+07:00
title = "Technical Design Doc Guidelines"
description = "Technical Design Doc Guidelines"

[taxonomies]
tags = ["technicaldesigndoc", "guidelines"]
+++


Having to write a technical design doc(TDD) is a prerequisite of a medium-high feature development/refactoring initiative at Cermati, it's a crucial part in the development process.
You need make sure that everyone is onboard with the technical plan, this is done through a design doc review by your CTO/Managers and stakeholders.
It's an essential part of the planning process because <b>it brings people together, especially to get buy in from the team and stakeholders</b> so they can provide support along the way 🍪!

The post will cover some of the general guidelines that hopefully can assist you to prepare the TDD.
The main principle is simple just like writing code, the easier it is to understand the easier it is to review.
Keep in mind that the guidelines goal is to achieve an "easy to understand" TDD. Here you go:


#### 1. Start with problem statement
Explain why you're proposing the initiative. Why does it matter?
What impact will it bring?

Some questions that maybe can help you to answer the impact:
* Will it increase company's North Star metric either directly or indirectly? By what %?
* Will it reduce cost? By what %?
* Are you investing for future needs? Why that specific investment matters? Can you make the projection?
* The current process that we have might have pain points and you want to improve it to increase employee/team productivity.


#### 2. Show the current state
This is a complementary of the problem statement, if there's a current implementation/flow then show it, make it explicit what needs to be improved from the current flow.
Assume your reviewers do not know anything about the current state or just assume they're not up to date.
Feel free to put links to other existing docs as well. Showing a diagram flow will help people to catch up quickly with the current state.
Free tools that you can use:
* [diagrams.net](https://diagrams.net)
* [MermaidJS](https://mermaid-js.github.io/mermaid/#/)


#### 3. Show the available options/solutions that we have
Show the available options that we have and mention the pros and cons of each option as well, it will clear up a lot of things, this will save time and help you get the buy in quicker.
It'll also make it easier for us to get back here quickly just in case we pursued the wrong option.


#### 4. Propose a solution
Propose a solution to solve the problem, make it clear why we're implementing that specific solution.
Why the others won't work as good as the one that you propose?


#### 5. What are the actionables & timelines
List all of the actionables/tasks and set the PIC. PIC could be a team (the team lead will delegate the tasks) or an individual contributor.
If the project have milestones then set the deadline for each milestone, if it's not then it's ok to just put the end goal deadline,
make sure all the PICs agree with the timeline.


#### 6. What's your backup plan
Things could fail even with an almost perfect plan, what's your backup plan?

If a migration plan fails, what should we do? Is there a way to turn back? If there's a way, should we continue with the risk or is there anything that we should do?
What are the steps of the backup plan? Who's going to execute it?

Another case with product engineering, suppose it does not meet the deadline, then what are non-essentials features that we can cut? Can we move them into the next iterations?


#### 7. Gather feedback
There's no perfect plan, open a feedback session and verify reviewers concerns. Sometimes there are blind spots due to the lack of visibility/outdated product knowledge,
for example the flow that you read has changed after you prepared the plan.

Don't worry too much, that's why you should have this technical design doc review session 🖖.
