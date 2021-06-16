import 'package:flutter/material.dart';
import 'package:accuracy_setting/accuracy_setting.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: TextButton(
            child: Text(
              'Get Accuracy Setting',
            ),
            onPressed: () async {
              AccuracySettingMode mode =
                  await AccuracySetting.getAccuracySetting();
              print(mode);

              if (await AccuracySetting.getProviderEnabled(
                  LocationProvider.GPS)) {
                print("GPS Active");
              }

              if (await AccuracySetting.getProviderEnabled(
                  LocationProvider.NETWORK)) {
                print("Network Active");
              }
            },
          ),
        ),
      ),
    );
  }
}
