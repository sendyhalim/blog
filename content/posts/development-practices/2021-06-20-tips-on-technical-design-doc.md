+++
title = "Tips on Technical Design Doc"
date = 2021-06-20T00:00:25+07:00
description = "Tips on Writing Technical Design Doc"

[taxonomies]
tags = ["technicaldesigndoc", "tips"]
+++


Having to write a technical design doc(TDD) is a prerequisite of a medium-high feature development/refactoring initiative at Cermati, it's part of the planning process.
You need make sure that the team & stakeholders agree on the plan, this is done through a design doc review process by your CTO/Managers/Stakeholders.
It's an essential part of the planning process because <b>it brings people together, especially the team and stakeholders to agree on the initiative & plan</b>. Get the buy in, distribute the tasks, execute the plan and have cookies 🍪🍪!

The post will cover some of the tips that hopefully will help you write better TDD so your team and the reviewers.
Just like writing code, the easier it is to understand, the easier it is to review, happy team & happy stakeholders 🍻.


#### 1. Show the current state in the Background section
Assume your reviewers does not know anything about the current state or just assume they're not up to date.
Feel free to put links to other existing docs as well. I find it using diagram flow helps a lot to get people catch up with the current state.
Free tools that you can use:
* [diagrams.net](https://diagrams.net)
* [MermaidJS](https://mermaid-js.github.io/mermaid/#/)


#### 2. Continue with problem statement
Explain why you're proposing the initiative. Why does it matter to do it?
What impact will it bring? Maybe answering any of the below question would help you to set the impact:
* The current process that we have might impose pain points and you want to improve it to increase employee/team productivity.
* Will it increase company's North Star metric either directly or indirectly?
* Will it reduce cost of a current tooling that we use?
* Are you investing for future needs? Why that specific investment matters?


#### 3. Show the available options/solutions that we have
Researching the available options that we have and mentioning pros and cons of each option will clear up a lot of things and indirectly answer
questions from your readers. This will save up a lot of time and get the buy in quicker.
The available options also make it easier for us to get back here quickly in case we chose to pursue the wrong option.


#### 4. What are the actionables & timelines
Each team have different missions, even though the end goals should align company's goals, mentioning all of the actionables/tasks give more
accurate timeline estimation. Set the PIC as well, it could be a team(in which the team lead will delegate the tasks) or an individual contributor.
Make sure all the PICs agree on the timeline.


#### 5. What's your backup plan
Things could fail even with an almost perfect plan, what's your revert/backup plan?

If a migration plan fails, what should we do? Is there a way to turn back? If there's a way should we continue with the risk or is there anything that we should do?
What's the step of the revert/backup plan? Who's going to execute it?

Another case with product engineering, if what we plan does not meet timeline, for whatever reason, what non-essentials features can we cut and move them into the next iterations?

#### 6. Gather feedback
There's no perfect plan, open feedback session and verify their concerns. It's not uncommon for the planner to miss some things due to lack of visibility and deadline to write the plan,
the lack of visibility usually comes due to fast moving parts within certain parts of the process, for example you're reading a code that's under development by other team.
Don't worry too much, that's why you should have the technical design doc review meeting 🖖.

