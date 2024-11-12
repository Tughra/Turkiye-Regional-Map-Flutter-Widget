import 'package:flutter/material.dart';
import 'package:turkiye_regional_map/turkiye_regional_map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

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
              pulseScaleCurve: Curves.easeInBack,
              pulseFadeCurve: Curves.bounceIn,
              pulseDuration: Duration(milliseconds: 900),
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
