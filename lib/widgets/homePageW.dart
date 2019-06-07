import 'package:flutter/material.dart';

import '../globals.dart' as globals;

class HomePageW extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageWState();
  }
}

class _HomePageWState extends State<HomePageW>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: (globals.brightness == true) ? globals.light : globals.dark,
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: EdgeInsets.all(20.0),
      child: Text("Hi"),
    );
  }
}