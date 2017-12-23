---
date: "2016-07-04T22:58:59+07:00"
title: "RxSwift Race Condition on Cells"
description: "RxSwift race condition while doing asynchronous operations on collection cells"
tags: ["swift", "rxswift", "macOS"]
---

A few days ago I wrote a simple code to asynchronously load an image using [`RxMoya`](https://github.com/Moya/Moya#rxswift).
`RxMoya` is an [`RxSwift`](https://github.com/ReactiveX/RxSwift) wrapper
for [`Moya`](https://github.com/Moya/Moya). The flow is simple,
everytime collection view asks for `NSCollectionViewItem` (yes, I'm building a macOS app),
I need to load the image asynchronously. Here's a part of the implementation:

```swift
func collectionView(
  collectionView: NSCollectionView,
  itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath
) -> NSCollectionViewItem {
  let item = collectionView.makeItemWithIdentifier(
    "ChapterItem",
    forIndexPath: indexPath
  ) as! ChapterItem

  let chapter = vm[indexPath.item]
  let chapterPageVm = ChapterPagesViewModel(..)

  // Fetch manga chapter pages
  chapterPageVm.fetch()

  chapterPageVm
    .chapterPages
    .drive(onNext: { _ in
      // After chapter pages are loaded
      // we will set chapter preview here
    })
    .addDisposableTo(disposeBag)

  ...

  return item
}
```

<p class="image-container">
  <img
    src="https://i.imgflip.com/1b9y1.jpg"
    alt="Problem analysis"
    class="medium-size">
</p>

Obviously there's a problem with the implementation, how do
I make sure that after the chapter pages are loaded, the execution
context of `driveNext` is valid? In other words, how to make sure
that the cell item has not been re-used (because if it is
and I’m setting the fetched data, then there will be race condition)?

A solution that might work is by setting a `DisposeBag` to each
cell and disposing it everytime `didEndDisplayingItem` gets called.

<p class="image-container">
  <img
    src="http://id.ragegenerator.com/images/ragebuilder-faces/Happy/09.png"
    alt="The solution"
    class="medium-size">
</p>

Sounds like a perfect plan! Now I just need to find a way to set the dispose bags
and keep track of them for each cell. Luckily `RxSwift` has a great community
around it, `dpaschich` on [rxswift.slack.com](http://rxswift.slack.com/) suggested
to set `DisposeBag` on each of the cell item and disposing it using a custom method
`didEndDisplaying`

```swift
class ChapterItem: NSCollectionViewItem {
  @IBOutlet weak var chapterTitle: NSTextField!
  @IBOutlet weak var chapterNumber: NSTextField!
  @IBOutlet weak var chapterPreview: NSImageView!

  var disposeBag = DisposeBag()

  func didEndDisplaying() {
    chapterPreview.image = .None

    disposeBag = DisposeBag()
  }
}
```

```swift
func collectionView(
  collectionView: NSCollectionView,
  didEndDisplayingItem item: NSCollectionViewItem,
  forRepresentedObjectAtIndexPath indexPath: NSIndexPath
) {
  let _item = item as! ChapterItem

  _item.didEndDisplaying()
}

func collectionView(
  collectionView: NSCollectionView,
  itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath
) -> NSCollectionViewItem {
  let item = collectionView.makeItemWithIdentifier(
    "ChapterItem",
    forIndexPath: indexPath
  ) as! ChapterItem

  let chapter = vm[indexPath.item]
  let chapterPageVm = ChapterPagesViewModel(..)

  // Fetch manga chapter pages
  chapterPageVm.fetch()

  // Notice how I add disposable to item.disposeBag
  chapterPageVm
    .chapterPages
    .driveNext { _ in
      // After chapter pages are loaded
      // we will set chapter preview here
    } >>> item.disposeBag

  ...

  return item
}
```

