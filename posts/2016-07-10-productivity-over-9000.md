---
date: "2016-07-10T00:49:40+07:00"
title: "Coding Productivity Over 9000"
description: "Why you should learn and use vim keybindings"
tags: ["vim", "productivity"]
---

<p class="image-container">
  <img
    src="https://media.giphy.com/media/XIqCQx02E1U9W/giphy.gif" alt="Over 9000"
    class="medium-size">
</p>

Why you should learn and use vim keybindings.

It started 2 years ago when I decided to invest in vim.
The first weeks with vim were hell, I wasn't productive at all.
So I consider it as an investment, and it pays well.
Let me show you a simple example, let's say I have this code (written in `Swift`).

```swift
func add(x: Int, y: Int) -> Int {
  return x + y;
}
```

and I want to add another function, that is a `multiply` function

```swift
func multiply(x: Int, y: Int) -> Int {
  return x * y;
}
```


## The old days

In the old days, I would need around 10-12 seconds by doing these:

1. Move my right hand off the keyboard towards my mouse
2. Select the `add` function
3. Press `⌘ + c`
4. Move my right hand to the keyboard again, press arrow down then `⌘ + v`
5. Use my mouse to place the cursor at `+` operator and replace it with `*`
6. Double click `add` function name and replace it with `multiply`


## Vim's way

Let's see with the approach that I would've take with vim, this time it takes around 7-8 seconds:

1. Go to visual mode with `v` then press `%` to block all the `add` function
2. `ctrl + c` (yes I have a custom mapping for copy)
3. Go to the bottom line of `buffer` with `G`
4. `ctrl + v` (custom mapping for paste)
5. Press `kf+s*<ctrl>-{`
   - `k` move cursor 1 line up.
   - `f+` find `+` operator and move the cursor to it
   - `s*` replace `+` with `*`
   - `<ctrl>-{` back to normal mode
6. Press `kHwcw` then type `mutiply`
   - `k` move cursor 1 line up
   - `H` (custom mapping) move to the first character at the current line
   - `w` move 1 word (to `add` function name)
   - `cw` and type `multiply` will replace `add` with `mutiply`

Step 1-6 combined would take 7-8 seconds for me (let's make it 8 seconds).
There it is, I just saved 2-4 seconds of my life. I think it's really worth it.
The previous example is a simple one, consider these coding-related operations:

- Jump between lines
- Move code from line x-y to line z
- Change code inside curly braces (in vim you can use `ci{`, yes that's only 3 strokes)
- Etc..

**Note**: You can cheat on step 5 and 6 if you use [Vim Easymotion](https://github.com/easymotion/vim-easymotion).

I don't know how much time I've saved for myself, but indeed the investment pays really well.
Some people will tell you that you should use a real `IDE` and I couldn't agree more with them, I would tell you the same.
With vim in your toolbox, you can install a vim keybindings plugin for your IDE, so you'll get
the power of IDE and vim keybindings.

<p class="image-container">
  <img
    src="https://media.giphy.com/media/138o38B4EmLjGw/giphy.gif" alt="Make It Over 9000"
    class="medium-size">
</p>

Personally I use [XVim](https://github.com/XVimProject/XVim) for XCode,
[Ideavim](https://github.com/JetBrains/ideavim) for [Jetbrains](https://www.jetbrains.com).
Sometimes depending on my mood, I use [Spacemacs](https://github.com/syl20bnr/spacemacs)
(Pre-configured emacs with a lot of useful packages) with vim keybindings for other stuffs.
Feel free to see/copy my [vimrc](https://github.com/sendyhalim/dotfiles/tree/master/vimrc).
