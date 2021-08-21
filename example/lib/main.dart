import 'package:flutter/material.dart';
import 'package:qonvex_cast/qonvex_cast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ChromeCastController _castController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      _castController = await ChromeCastController.init(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              AirPlayButton(onRoutesOpening: () {}, onRoutesClosed: () {}),
              IconButton(
                  onPressed: () {
                    _castController.seek();
                  },
                  icon: Icon(Icons.cast))
            ],
          ),
        ),
      ),
    );
  }
}
