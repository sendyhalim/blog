+++
title = "Writing tests, is it worth it?"
date = 2020-04-14T00:37:00+07:00
description = "Writing tests, is it worth it?"

[taxonomies]
tags = ["development", "practice"]
+++

Lately I've been really questioning myself, is it really worth it to write test cases?
So far, there are practical and impractical reasons why I write tests:
* It's easy to fix bugs and refactor some of the internal logics.
* It feels like something is missing when I don't have tests to back me up,
  this drives me really impractical in some cases. I always write them if I have time,
  just to scratch the itch even if I know it's impractical in
  <a
    href="https://github.com/sendyhalim/jab/blob/dadce438db4f2b4be3a27ff95862adfcc1c242c2/src/lib/git.rs#L227-L237"
    target="_blank"
  >some cases</a>.

<p class="image-container">
  <img
    src="https://i.imgflip.com/3zwlv.jpg"
    alt="Lonely"
    class="medium-size"
  >
</p>

Recently our <a href="https://www.linkedin.com/in/osumampouw/" target="_blank">CTO</a> forwarded a github security alert for one of the company's
open source project called <a href="https://github.com/cermati/satpam" target="_blank">satpam</a>,
then my collague <a href="https://www.linkedin.com/in/albert-stevelino-970180102/" target="_blank">Albert Stevelino</a>
submitted a pull request to bump some of the project [dependencies](https://github.com/cermati/satpam/pull/100/files).

This might seem trivial, but for those of you that have dived into the dependencies
ecosystem know that even a minor patch could pop bugs anywhere,
a simple job to bump dependencies could drag down your entire weekend *evil laughs.

Satpam has <a href="https://travis-ci.org/github/cermati/satpam/builds/671509439" target="_blank">test cases</a>
baked into it, doesn't have 100% coverage though, but the tests are at "enough" level to
cover standard positive cases and negative cases. Plus Albert is bumping the project version,
so people should be aware of the changes. How do we make sure the project is fine?

<p class="image-container">
  <img
    src="https://i.imgflip.com/3wh8u7.jpg"
    alt="Run the tests luke"
    class="medium-size"
  >
</p>

How do we make sure the project is fine on a specific node version?

<p class="image-container">
  <img
    src=" https://i.imgflip.com/3wh8zw.jpg"
    alt="Use the CI luke"
    class="medium-size"
  >
</p>

Moral of the story, just write tests if you have time, pay your taxes and you should do fine.
