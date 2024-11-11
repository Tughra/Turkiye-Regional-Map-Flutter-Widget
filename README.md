<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->
# 🇹🇷 Turkiye Regional Map Flutter Widget

A widget that helps you select and mark geographic regions of Turkey.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## 💻 Installation

In the dependencies: section of your pubspec.yaml, add the following line:

```yaml
dependencies:
  turkiye_regional_map: <latest version>
```
To use the latest changes:

```yaml
  turkiye_regional_map:
    git:
      url: https://github.com/Tughra/draggable_expandable_fab.git
      ref: master
```

## ❔ Usage

Import this class

```dart
import 'package:turkiye_regional_map/turkiye_regional_map.dart';
```

### If you want to pulse animation when you select a region;

```dart
TurkeyRegionalMap.withPulseAnimation(
  mapWidth: MediaQuery.sizeOf(context).width,
  selectable: true,
  pulseMaxRadius: 200,
  turkeyRegionModel: TurkeyRegionModel(
  showIstanbulEuropeRegion: false,
  showIstanbulAnatoliaRegion: false,
  selectedWidthFactor: 3.4,
  selectedRegion: TurkeyRegionType.blackSea),)
 ```    
### If you dont want to pulse animation when you select a region use this;


Full Implementation

```dart
TurkeyRegionalMap.onlyMap(
  mapWidth: MediaQuery.sizeOf(context).width,
  selectable: true,
  turkeyRegionModel: TurkeyRegionModel(
  showIstanbulEuropeRegion: false,
  mediterraneanColor: Colors.teal[100],
  easternAnatoliaColor: Colors.teal[200],
  southeasternAnatoliaColor: Colors.teal[300],
  centralAnatoliaColor: Colors.teal[400],
  blackSeaColor: Colors.teal[500],
  egeColor: Colors.teal[600],
  selectedRegionColor: Colors.teal,
  marmaraColor: Colors.teal[700],
  showIstanbulAnatoliaRegion: false,
  borderColor: Colors.white,
  selectedBorderColor: Colors.black,
  selectedWidthFactor: 3.4,
  selectedRegion: TurkeyRegionType.blackSea),
)
 ```   
If you want to select Istanbul's europe or anatolia region you need to set ```true ``` ```showIstanbulAnatoliaRegion``` or ```showIstanbulEuropeRegion``` inside of ```TurkeyRegionModel```.
If you do not want to initial selected region set ```selectedRegion:null``` inside of ```TurkeyRegionModel```.

```OnSelectRegionCallBack``` is a callback that contains hit exact position, selected region type and center position of selected region. 
```dart
TurkeyRegionalMap.withPulseAnimation(
mapWidth: MediaQuery.sizeOf(context).width,
selectable: true,
selectedRegionCallback: (TurkeyRegionType type, Offset hitOffset, Offset centerRegion) {
  print(type);
  print("hitOffset $hitOffset");
  print("centerRegion $centerRegion");
},)
```  


## 🐛 Bugs/Requests

If you encounter any problems feel free to open an issue. If you feel the library is
missing a feature, please raise a ticket on Github and I'll look into it.
Pull request are also welcome.
