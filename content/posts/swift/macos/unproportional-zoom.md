+++
title = "NSImageView Unproportional Zoom"
date = 2017-02-10T20:47:23+07:00
description = "How to fix NSImageView unproportional zoom in AppKit"

[taxonomies]
tags = ["swift", "nsimageview", "appkit"]
+++

I had this weird problem when I tried to implement a zoom functionality
in my hobby project, a manga reader called [Yomu](https://github.com/sendyhalim/yomu).
When I tried to zoom an `NSImageView` programmatically
it's being zoomed unproportionally, my expectation was the image should be stretched horizontally
and vertically without moving from its center point. It was like this

<h5 class="text-center">Zoom 100%</h5>
<p class="image-container">
  <img
    src="{{ asset_path(path="/assets/images/swift/image-view/unproportional-zoom/zoom-100.png") }}"
    alt="NSImageView unproportional zoom">
</p>


<h5 class="text-center">Zoom 140%</h5>
<p class="image-container">
  <img
    src="{{ asset_path(path="/assets/images/swift/image-view/unproportional-zoom/zoom-140.png") }}"
    alt="NSImageView unproportional zoom">
</p>


Damn, there was an ugly gap :( between header border and the image.
I had a hard time finding the solution, it took me almost 3 days to debug this problem (maybe because I'm a newbie).
It turns out the solution is really simple, by default apple will set image view to scale proportionally down,
changing it to proportionally up or down will fix the problem.


<h5 class="text-center">The culprit T_T</h5>
<p class="image-container">
  <img
    src="{{ asset_path(path="/assets/images/swift/image-view/unproportional-zoom/proportionally-down.png" ) }}"
    alt="NSImageView unproportional zoom"
    class="medium-size">
</p>


<h5 class="text-center">Fixing it 🍻</h5>
<p class="image-container">
  <img
    src="{{ asset_path(path="/assets/images/swift/image-view/unproportional-zoom/proportionally-up-or-down.png" ) }}"
    alt="NSImageView unproportional zoom"
    class="medium-size">
</p>

