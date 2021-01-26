import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Native Code',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('flutter.dev/battery');

  int _batteryLevel = 1;

  Future<void> _getBatteryLevel() async {
    try {
      final batteryLevel = await platform.invokeMethod('getBatteryLevel');
      setState(() {
        _batteryLevel = batteryLevel;
      });
    } on PlatformException catch (e) {
      setState(() {
        _batteryLevel = 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getBatteryLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Native Code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Battery: $_batteryLevel'),
            OutlineButton.icon(
              icon: Icon(Icons.refresh),
              onPressed: _getBatteryLevel,
              label: Text('Refresh'),
              shape: StadiumBorder(),
              highlightColor: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
