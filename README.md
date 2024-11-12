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
<div style="display:flex; justify-content: center;">
<img src="https://github.com/Tughra/Turkiye-Regional-Map-Flutter-Widget/raw/master/example/screenshots/map_gif.gif" width="300"/>
</div>

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
      url: https://github.com/Tughra/Turkiye-Regional-Map-Flutter-Widget.git
      ref: master
```

## ❔ Usage

Import this class

```dart
import 'package:turkiye_regional_map/turkiye_regional_map.dart';
```

### If you want to pulse animation when you select a region;
##### <font color="orange"> If you want to use the ```turkeyRegionModel``` parameter, you need to create the ```TurkeyRegionModel``` model outside of the ```TurkeyRegionalMap``` widget. Do not put the object directly into the parameter. </font>
```dart
final regionModelPulse = TurkeyRegionModel(
    showIstanbulEuropeRegion: false,
    showIstanbulAnatoliaRegion: false,
    selectedWidthFactor: 3.4,
    selectedRegion: TurkeyRegionType.blackSea);
 ```    
```dart
TurkeyRegionalMap.withPulseAnimation(
mapWidth: MediaQuery.sizeOf(context).width,
selectable: true,
pulseMaxRadius: 200,
turkeyRegionModel: regionModelPulse,)
 ```
### If you dont want to pulse animation when you select a region use this;

```dart
final regionModelWithoutPulse = TurkeyRegionModel(
    showIstanbulEuropeRegion: true,
    mediterraneanColor: Colors.teal[100],
    easternAnatoliaColor: Colors.teal[200],
    southeasternAnatoliaColor: Colors.teal[300],
    centralAnatoliaColor: Colors.teal[400],
    blackSeaColor: Colors.teal[500],
    egeColor: Colors.teal[600],
    selectedRegionColor: Colors.teal,
    marmaraColor: Colors.teal[700],
    showIstanbulAnatoliaRegion: true,
    borderColor: Colors.white,
    selectedBorderColor: Colors.black,
    selectedWidthFactor: 3.4,
    selectedRegion: TurkeyRegionType.blackSea);
 ```   
```dart
TurkeyRegionalMap.onlyMap(
mapWidth: MediaQuery.sizeOf(context).width,
selectable: true,
turkeyRegionModel: regionModelWithoutPulse,)
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
### Full Example
``` dart
class MyHomePage extends StatefulWidget {


  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final regionModelPulse = TurkeyRegionModel(
      showIstanbulEuropeRegion: false,
      showIstanbulAnatoliaRegion: false,
      selectedWidthFactor: 3.4,
      selectedRegion: TurkeyRegionType.blackSea);
  final regionModelWithoutPulse = TurkeyRegionModel(
      showIstanbulEuropeRegion: true,
      mediterraneanColor: Colors.teal[100],
      easternAnatoliaColor: Colors.teal[200],
      southeasternAnatoliaColor: Colors.teal[300],
      centralAnatoliaColor: Colors.teal[400],
      blackSeaColor: Colors.teal[500],
      egeColor: Colors.teal[600],
      selectedRegionColor: Colors.teal,
      marmaraColor: Colors.teal[700],
      showIstanbulAnatoliaRegion: true,
      borderColor: Colors.white,
      selectedBorderColor: Colors.black,
      selectedWidthFactor: 3.4,
      selectedRegion: TurkeyRegionType.blackSea);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade800,
        title: Text("Turkiye Regional Map",style: TextStyle(color: Colors.white),),
      ),
      body: ListView(
        children: <Widget>[
          Center(child: Text(regionModelPulse.selectedRegion?.name??"",style: TextStyle(fontSize: 24),)),
          ColoredBox(color: Colors.blue.shade700,
            child: TurkeyRegionalMap.withPulseAnimation(
              mapWidth: MediaQuery.sizeOf(context).width,
              selectable: true,
              selectedRegionCallback: (TurkeyRegionType type, Offset hitOffset, Offset centerRegion) {
                print(type);
                print("hitOffset $hitOffset");
                print("centerRegion $centerRegion");
                setState(() {});
              },
              pulseColor: Colors.white,
              pulseMaxRadius: 200,
              turkeyRegionModel:regionModelPulse ,
            ),
          ),
          TurkeyRegionalMap.onlyMap(
            mapWidth: MediaQuery.sizeOf(context).width,
            selectable: true,
            turkeyRegionModel:regionModelWithoutPulse ,
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
``` 
## 🐛 Bugs/Requests

If you encounter any problems feel free to open an issue. If you feel the library is
missing a feature, please raise a ticket on Github and I'll look into it.
Pull request are also welcome.
