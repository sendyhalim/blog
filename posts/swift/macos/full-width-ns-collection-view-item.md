---
date: "2017-03-04T23:48:35+07:00"
title: "Make NSCollectionViewItem Responsive Width and Height"
description: "How to make NSCollectionViewItem size to be responsive on window resize event"
tags: ["swift", "nscollectionview", "nscollectionviewitem", "appkit"]
---

I had a hard time figuring out how to make `NSCollectionViewItem` width to be responsive.
The problem was that I wanted my `NSCollectionViewItem` to follow its parent width.
Maybe I didn't google the right keywords, I didn't find any solution on the internet.
I found the solution after reading `NSCollectionViewDelegateFlowLayout`, it wasn't straight forward.
When the window is resized, `NSCollectionView` will follow the its parent width by default, but not the cells inside it.
Turns out that we need to invalidate the cells layout manually and tell `NSCollectionViewDelegateFlowLayout` our cells preferred size.


```swift
extension MyCollectionViewController: NSCollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: NSCollectionView,
    layout collectionViewLayout: NSCollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> NSSize {
    // Here we're telling that we want our cell width to
    // be equal to our collection view width
    // and height equals to 70
    return CGSize(width: collectionView.bounds.width, height: 70)
  }
}
```

There's one catch here, remember we need to invalidate the cells layout manually

```
class MyCollectionViewController: NSViewController {
  @IBOutlet weak var collectionView: NSCollectionView!

  // This method will be called everytime window is resized
  override func viewWillLayout() {
    super.viewWillLayout()

    // When we're invalidating the collection view layout
    // it will call `collectionView(_:layout:sizeForItemAt:)` method
    collectionView.collectionViewLayout?.invalidateLayout()
  }
}
```

There it is, hope it helps 🍪

