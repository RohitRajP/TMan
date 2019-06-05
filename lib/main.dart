import 'package:flutter/material.dart';


import './pages/homepage.dart';
import './globals.dart' as globals;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TMan",
      home: HomePage(),
      theme: ThemeData(
        fontFamily: 'Ubuntu',
        primarySwatch: Colors.indigo,
        brightness: (globals.brightness == true)? Brightness.light: Brightness.dark,
      ),
    );
  }
}