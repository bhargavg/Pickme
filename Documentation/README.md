# Configuration
Pickme can be configured by using `Configuration` object.
```swift
public struct Configuration {

  // Minimum scale for the item
  public var minScale: CGFloat = 1.0

  // Maximum scale for the item
  public var maxScale: CGFloat = 2.0

  // Spacing between each items
  public var itemSpacing: CGFloat = 10.0

  // Size of each item
  public var itemSize: CGSize = CGSize(width: 50, height: 50)

  // Cell identifier of collection view cell
  public var cellIdentifier: String = "Cell"

  // Hide scrollbar for collection view
  public var hideScrollbar: Bool = true

  // Defines how many cells participate in scaling
  public var flowDistance: CGFloat = 50.0
}
```

`flowDistance` parameter is an important configuration parameter that defines how your items will be scaled. It is the distance from center of collection view on either side. The item will participate in scaling, only if its center lies with in flowDistance from center of collection view.


# API
### Initializers
Pickme can be initialized in following ways:

```swift
// Initialize with default configuration
Pickme(with: collectionView, items: ["a", "b"])
```

```swift
// Initialize with configuration block
Pickme(with: collectionView, items: ["a", "b"]) { config in
  config.itemSpacing = 15.0
  config.itemSize = CGSize(width: 50.0, height: 50.0)
  config.flowDistance = 50.0
}
```

```swift
// Initialize with existing configuration
Pickme(with: collectionView, items: ["a", "b"], configuration: configuarion)
```

### `reload(withItems: [String])`
Reloads table view with new items

### `selectItem(at:animation:)`
Selects the item at index with optional animation. Default value for animation is `true`.

### `selectedIndex`
Get the index of selected item
