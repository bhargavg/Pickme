# Pickme [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
Pickme turns your boring `UICollectionView` into an awesome 3D picker view.

## Talk is cheap, show me GIFS 💫 ✨
### Scale single item:
![Scaling single item](Documentation/gifs/single_item_scale.gif)
```swift
Pickme(with: collectionView, items: items) { config in
  config.itemSpacing = 15.0
  config.itemSize = CGSize(width: 50.0, height: 50.0)
  config.flowDistance = 50.0
}
```

### Scale multi item:
![Scaling multi item](Documentation/gifs/multi_item_scale.gif)
```swift
Pickme(with: collectionView, items: items) { config in
  config.itemSpacing = 15.0
  config.itemSize = CGSize(width: 50.0, height: 50.0)
  config.flowDistance = 150.0
}
```

### Simple Picker:
![Simple Picker](Documentation/gifs/simple_picker.gif)
```swift
Pickme(with: collectionView, items: items)
```

## Documentation
You can find more documentation [here](/Documentation/api.md)

## Todo:
- [ ] CocoaPods Support
- [ ] SwiftPM Support
- [ ] Watch, TvOS Targets

## Contribution
Found a bug? Want a new feature? Please feel free to report any issue or raise a Pull Request.
