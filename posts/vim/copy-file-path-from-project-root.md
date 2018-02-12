---
date: "2018-02-13T00:11:00+07:00"
title: "Vim Copy File Path From Project Root"
description: "How to copy file path from project root"
tags: ["vim", "productivity"]
---

I often found myself typing file path manually when explaining code implementation and its use cases to my teammates.
The task to type file path manually is very daunting and I hate it so much when I mistyped.
The file path I mentioned is relative from project root. Let's say you have this structure


```swift
▾ Yomu/
  ▸ API/
  ▸ DataStructures/
  ▾ Screens/
  ┊ ▾ ChapterList/
  ┊ ┊ ┊ Chapter.swift
  ┊ ┊ ┊ ChapterCell.swift
  ┊ ┊ ┊ ChapterCell.xib
  ┊ ┊ ┊ ChapterCollectionHeader.swift
  ┊ ┊ ┊ ChapterCollectionHeader.xib
  ┊ ┊ ┊ ChapterCollectionViewController.swift
  ┊ ┊ ┊ ChapterCollectionViewController.xib
  ┊ ┊ ┊ ChapterCollectionViewModel.swift
  ┊ ┊ ┊ ChapterViewModel.swift
  ┊ ┊ ┊ ReadChapterRealm.swift
  ....
▸ YomuTests/
```

and you want to point out to someone an implementation in `ChapterViewModel.swift`, you would type this

```sh
Yomu/Screens/ChapterList/ChapterViewModel.swift
```

I did that a lot!


<p class="image-container">
  <img
    src="http://s2.quickmeme.com/img/71/71c3931c1edc4353a0c03ec549753b965872a2c343c09255617f4470cbd924ed.jpg" alt="We got a badass here"
    class="medium-size">
</p>


I knew there's a better way to do this.  There's a built-in function in vim that returns the relative path (from project root) of a file in active buffer.

```
expand('%')
```

Of course we can do better than that! It'll handy if we can copy the file path to system clipboard.


```
" Register relative file path of current buffer
" from project root to system clipboard
nnoremap <F10> :let @+ = expand("%")<CR>
```

Now everytime you press `F10` in normal mode, it will automatically register file path to current active file
in buffer to your system clipboard.
