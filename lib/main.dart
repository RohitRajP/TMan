
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './pages/homepage.dart';
import './pages/settingsPage.dart';
import './pages/addTaskPage.dart';
import './globals.dart' as globals;
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  static const platform = const MethodChannel('com.tmft.tman');

  Future<String> addTask(String tName, String tNote, String tDate,
      String tTime) async {
    String value;

    try {
      value = await platform.invokeMethod("addTask",
          {"tName": tName, "tNote": tNote, "tDate": tDate, "tTime": tTime});
      return value;
    } catch (e) {
      print(e);
      return "Error at Dart addTask()";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserData();
  }

  void refreshApp() {
    setState(() {});
  }

  void _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _userBrightness = prefs.getBool('brightness');
    if (_userBrightness != null) {
      globals.brightness = _userBrightness;
      setStatusBarColor();
      refreshApp();
    }
  }

  void setStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
      (globals.brightness == true) ? globals.light : globals.dark,
      statusBarIconBrightness:
      (globals.brightness == true) ? Brightness.dark : Brightness.light,
      statusBarBrightness:
      (globals.brightness == true) ? Brightness.dark : Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TMan",
      home: HomePage(refreshApp),
      theme: ThemeData(
        fontFamily: 'Ubuntu',
        primarySwatch: Colors.orange,
        brightness:
        (globals.brightness == true) ? Brightness.light : Brightness.dark,
      ),
      routes: {
        '/settingsPage': (context) =>
            SettingsPage(refreshApp, setStatusBarColor),
        '/addTaskPage': (context) => AddTaskPage(addTask)
      },
    );
  }
}
