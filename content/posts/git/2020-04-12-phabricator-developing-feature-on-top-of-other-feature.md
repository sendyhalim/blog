+++
title = "Phabricator: developing feature on top of other feature"
date = 2020-04-12T22:37:00+07:00
description = "Phabricator: developing feature on top of other feature"
draft = true

[taxonomies]
tags = ["git", "phabricator"]
+++

NOTE: This post assumes that you've already know `git rebase` and `phabricator` terms.

We use phabricator as our code review tool at `Cermati`. A typical workflow for submitting & merging your feature:
1. Create new branch based on `master` branch and develop and commits `git commit` locally from there.
2. Submit code review `arc diff` when we're done.
3. Do `arc land` to merge our diff to remote `master` branch

Phabricator will squash all of our commits into 1 commit on our feature branch, it will use diff title and description as the commit message when we do `arc land`. A simple overview of how it looks like, note that I'm guessing the steps based on the side effect & git stdout:
1. `git checkout master` to make sure local master branch is up to date.
2. `git checkout <feature-branch>`
3. `git rebase master -i` and squash all of the `<feature-branch>` commits into 1 commit on top of `master` branch.
4. Merge your rebased & squashed feature branch to remote master.
5. Checkout to master and pull origin master.

This typical flow works if you just work on separate features at the same time, but it could fail if you try to develop feature on top of other feature that still in code review (submitted to phabricator). There are many cases of this failure could happen, one of the frequent one is when you submit branch `feature-a` then develop `feature-b` on top of `feature-a`. Let's simulate this.

### Simulation
M = master
S = Squash
E = Edit
P = Pick
FA = feature a
FB = feature b

`mx<n>` = commit on master branch
`ax<n>` = commit on feature-a branch
`bx<n>` = commit on feature-b branch

We have 3 commits on master branch
We have 2 commits on feature-a branch
We have 4 commits on feature-b branch

```bash
mx1--mx2--mx3--> [M]
           |--ax1--ax2--> [FA]
                    |--bx1--bx2--bx3--bx4--> [FB]
```

### Arc land feature-a branch
It'll squash commits `ax1` and `ax2` into 1 commit

```bash
# Process view
# --------------------
mx1--mx2--mx3--> [M]
           |        |--bx1--bx2--bx3--bx4--> [FB]
           |--ax1--ax2--> [FA]
               |    |
               S    S
# End result
# There's a new commit ax that represents commit ax1 and ax2.
# --------------------
mx1--mx2--mx3--ax--> [M]
           |--ax1--ax2--bx1--bx2--bx3--bx4--> [FB]
           |
```

Now if you see that feature-b is "kind of" detached. It will fail if you've submitted `feature-b` for code review and do `arc land`, the reason is because it could not merge "cleanly". The fix is actually pretty easy, you need to point commit `bx1` to `ax`. We will do `git rebase` to rewrite the history, note that **please backup** `feature-b` first before you do this, you can do it by checkout out from `feature-b` to another branch.

```
git checkout feature-b

# For safety
git checkout -b feature-b-backup
```

### Rewriting history

Now you need to make sure that you're on feature-b. Run below command
```bash
# We do not need commit ax1 and ax2 here, so just rebase bx1, bx2, bx3 and bx4
# onto master.
# --------------------
git rebase --onto master bx1 bx4
```

Now your `feature-b` should point to the latest commit on local `master` branch, you can verify this via git log or use a GUI tool.
```bash
git log --oneline --decorate --color --graph

# End result
# --------------------
mx1--mx2--mx3--ax--> [M]
               |--bx1--bx2--bx3--bx4--> [FB]
```

I hope that helps you guys. I wish there's an easier way.
