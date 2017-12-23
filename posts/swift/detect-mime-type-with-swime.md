---
title: "Swift MIME Type Detection with Swime"
date: "2017-04-26T23:00:44+07:00"
description: "Easy MIME Type detection with Swift"
tags: ["swift", "mimetype", "libraries", "swime"]
---

A month ago I found myself scouring GitHub for a Swift plugin
to detect mime type based on magic bytes. I did find [MimeType](https://github.com/onevcat/MimeType),
unfortunately it extracts the mime type from a file path or url extension.
Knowing that no one hadn't created a mime type checking library for Swift, I set
a to-do list to learn about mime type checking, hoping that I could contribute to the open source
community. My first attempt was to understand how to read file bytes in Swift.
Below is my best attempt after going through Apple docs and some examples from stackoverflow.

```swift
let path = "/path/to/file"
let url = URL(fileURLWithPath: path, isDirectory: false)
let data = try! Data(contentsOf: url)
```

Okay now I've got the file represented in `Data` struct, how do I read the bytes?
It turns out we need to allocate an array of `UInt8` as the bytes container
then pass it to `Data.copyBytes(to:count:)`

```swift
let bytesCount = 10

// Bytes need to mutable.
var bytes = [UInt8](repeating: 0, count: bytesCount)

// Copy file bytes to `bytes` variable
data.copyBytes(to: &bytes, count: bytesCount)
```

Next is the hard part, some of the [magic bytes specification](https://en.wikipedia.org/wiki/List_of_file_signatures)
need to be treated differently, for example we need to read bytes 0-3 then jump to bytes 30-57 to check
for `application/epub+zip`.
[Swime](https://github.com/sendyhalim/swime) comes to aid this. I took the awesome implementation of
Sindresorhus [file type](https://github.com/sindresorhus/file-type) library and rewrote it in Swift with
some added features.

A typical mime type check operation with Swime would look like this

```swift
import Swime

let path = "/path/to/some-file.jpg"
let url = URL(fileURLWithPath: path, isDirectory: false)
let data = try! Data(contentsOf: url)
let mimeType = Swime.mimeType(data: data)

mimeType?.type == .jpg // true
mimeType! // MimeType(mime: "image/jpeg", ext: "jpg", type: .jpg)

switch mimeType?.type {
  case .jpg?:
    ....
  case .png?:
    ....
  case .wmv?:
    ....

  case ...
}
```

Please feel free to open an issue or pull request if there's a feature
that would be a great addition to [Swime](https://github.com/sendyhalim/swime)!

<p class="image-container">
  <img
    src="https://media.giphy.com/media/Zw3oBUuOlDJ3W/giphy.gif" alt="Beer Toast!"
    class="medium-size">
</p>

