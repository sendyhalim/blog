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
Background section should help people understand the context of the document, generally you can show a high level
overview of how certain problems are currently solved, how a certain feature works, etc.

Showing an overview of the current state will help people understand the background a bit deeper, if there's a current implementation/flow then show it, and make it explicit what could be improved from the current flow.
Feel free to put links to other existing docs as well. A diagram flow will help people to visualize and catch up quickly.
Free tools that you can use:
* [diagrams.net](https://diagrams.net)
* [MermaidJS](https://mermaid-js.github.io/mermaid/#/)


#### Problem statement
This section states the problem with the current state, it should emphasize the importance of solving that problem and show why it matters.

Some key points that maybe can guide you:
* Are you solving a specific user problem where there are N users that are impacted?
* The current process might have pain points and sometimes users are just numb to the "pain" up until someone points it out.
* Will it increase the company's business metric either directly or indirectly? If it can save cost, any estimation by what %?
* Are you investing for future needs? Why does that specific investment matter?


#### Requirements
The requirements section set boundaries on the solution, it helps you to filter solutions that can be applied.
Typically there will be specific functionalities/features that the solutions must provide.


#### Show the available options/solutions that we have
There would be more than one solution that we can apply to meet the requirements, it's preferable to lay out the available options that we have.
Start with the least preferable solution and list down its pros and cons, progressive move to the most preferable solution.

Make it clear why we're implementing that specific solution, and why the others won't work as well as the one that you propose.

Showing the available solutions will make it easier for us to get back here quickly just in case we pursued the wrong solution.


#### What are the success metrics
Decide on the success metrics that can be monitored.
For example, if you're implementing a UX improvement, the success metric should be something related to the feature funnel, one thing that you could do is add trackers to the feature funnel and then query the data through an analytical database,
or just reuse existing funnel dashboard (if any).


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
