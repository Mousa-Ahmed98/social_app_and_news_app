import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeScreen extends StatefulWidget {
  const NativeScreen({Key? key}) : super(key: key);

  @override
  _NativeScreenState createState() => _NativeScreenState();
}

class _NativeScreenState extends State<NativeScreen> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  String _batteryLevel = 'Unknown battery level.';

  Future<void> getBatteryLevel() async {
    platform.invokeListMethod('getBatteryLevel')
        .then((value) {
          setState(() {
            _batteryLevel = 'Battery level $_batteryLevel';
          });
    })
        .catchError((error){
          setState(() {
            _batteryLevel = "Failed to get battery level: '${error.toString()}'.";
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('Get Battery Level'),
              onPressed: getBatteryLevel,
            ),
            Text(_batteryLevel),
          ],
        ),
      ),
    );
  }
}
