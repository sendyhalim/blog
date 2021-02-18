+++
title = "Phabricator: developing feature on top of other feature"
date = 2020-04-12T22:37:00+07:00
description = "Phabricator: developing feature on top of other feature"

[taxonomies]
tags = ["git", "phabricator"]
+++

NOTES: This post assumes that you're familiar with `git rebase` and `phabricator` terms.

We use phabricator as our code review tool. A typical workflow for submitting & merging your feature:
1. Create a new feature branch based on `master` branch, develop and `git commit` locally from there.
2. Submit code review `arc diff` when we're done.
3. Run `arc land` to merge our diff to remote `master` branch.

`arc land` will squash all of the commits into 1 commit on the feature branch, it uses diff title and description as the commit message. We can also simulate `arc land` manually, maybe not 100% exact though:
1. `git checkout master` to make sure local master branch is up to date.
2. `git checkout <feature-branch>`
3. `git rebase master -i` and squash all of the `<feature-branch>` commits into 1 commit on top of `master` branch.
4. Merge the rebased & squashed feature branch to remote master.
5. Checkout to master and pull origin master.

This typical flow works if we work on separate features at the same time, but it could fail if we try to develop feature on top of other feature that's still in code review (submitted to phabricator). There are many cases this failure could happen, one of the frequent one is when we develop `feature-b` on top of `feature-a` where `feature-a` is still in code review.

### Simulation
We'll be using [this repo](https://github.com/sendyhalim/phabricator-developing-feature-on-top-of-other-feature-code) as example.

Assumptions:

```bash
M = master
FA = feature a
FB = feature b

mx<n> = commit on master branch
ax<n> = commit on feature-a branch
bx<n> = commit on feature-b branch
```

The condition will look like below:
* `master` branch: 3 commits `mx1`, `mx2`, and `mx3`.
* `feature-a` branch: 2 commits `ax1` and `ax2`.
* `feature-b` branch: 3 commits `bx1`, `bx2` and `bx3`, it's  built on top of `feature-a`.

```bash
mx1---mx2---mx3---> [M]
               \
                ax1---ax2---> [FA]
                         \
                          bx1---bx2---bx3---> [FB]
```

### Arc land feature-a branch
Let's say that your `feature-a` is accepted via code review process and you do `arc land`, it'll squash commits `ax1` and `ax2` into 1 commit.

```bash
# Process view
# S = squash
# --------------------
mx1---mx2---mx3---> [M]
               \         /---bx1---bx2---bx3---> [FB]
                ax1---ax2---> [FA]
                 |     |
                 S     S
# End result
# There's a new commit "ax" that represents commit ax1 and ax2.
# --------------------
mx1---mx2---mx3---ax---> [M]
               \
                ax1---ax2---bx1---bx2---bx3---> [FB]
```

`feature-b` doesn't need `ax1` and `ax2` because it's already represented by `ax`. It will fail if you've submitted `feature-b` for code review and do `arc land`, the reason is because it could not merge "cleanly". The fix is actually pretty easy, you need to point commit `bx1` to `ax`. We will do `git rebase` to rewrite the history, **PLEASE BACKUP** `feature-b` first before you do this, you can do it by checking-out out from `feature-b` to another branch.

```
git checkout feature-b

# Backup for safety
git checkout -b feature-b-backup
```

### Rewriting history
First, make sure that we're on feature-b and then we will run rebase interactive to drop commits `ax1` and `ax2`.
It should be safe because both commits are already in master (represented by `ax` commit).
```bash
# Do interactive rebase onto master
# --------------------
git rebase -i master
```

There will be an editor prompt that should look like
```gitrebase
pick 233a9b8 ax1
pick 5f5e3ce ax2
pick e145774 bx1
pick 1834f7d bx2
pick 95d155a bx3
```

You have 2 options remove `ax1` and `ax2`:
A) Delete the lines
B) Replace `pick` with `drop`

You can do either one but I'll go with `drop` to make it more explicit in this post
```gitrebase
drop 233a9b8 ax1
drop 5f5e3ce ax2
pick e145774 bx1
pick 1834f7d bx2
pick 95d155a bx3
```

Save your changes and quit editor, the rebase process will continue by itself.
Now your `feature-b` should point to the latest commit on local `master` branch, you can verify this via `git log` or use a GUI tool.
```bash
git log --oneline --decorate --color --graph

# End result
# --------------------
mx1---mx2---mx3---ax---> [M]
                    \
                     bx1---bx2---bx3---> [FB]
```

That's it, now you can do `arc land` cleanly. I hope it helps, wish there's an easier way.
