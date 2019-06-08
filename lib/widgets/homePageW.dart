import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../globals.dart' as globals;

class HomePageW extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageWState();
  }
}

class _HomePageWState extends State<HomePageW> {


  Widget _taskTitleView() {
    return Text(
      "This is Task 1 of all the tasks that I have",
      style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w700,
          color: Colors.white
      ),
    );
  }

  Widget _taskNotesView() {
    return Text(
      "These are the notes of the task",
      style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          color: Colors.white
      ),
    );
  }

  Widget _notificationDetails() {
    return Row(
      children: <Widget>[
        Container(
          child: Icon(FontAwesomeIcons.bell, color: globals.themeColor,),
        ),
        SizedBox(
          width: 3.0,
        ),
        Container(
          child: Text("7 Aug, 8:40 PM",
            style: TextStyle(fontSize: 16.0, color: globals.lightText),),
        )
      ],
    );
  }

  Widget _repeatMode() {
    return Container(
      child: Text("Single Day",
        style: TextStyle(fontSize: 16.0, color: globals.lightText),),
    );
  }


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
      padding: EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20.0),
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _taskTitleView(),
                SizedBox(height: 3.0,),
                _taskNotesView(),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _notificationDetails(),
                    _repeatMode()
                  ],
                )
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(
                // Where the linear gradient begins and ends
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                // Add one stop for each color. Stops should increase from 0 to 1
                stops: [0.1, 0.9],
                colors: [
                  // Colors are easy thanks to Flutter's Colors class.
                  Color(0xFFEB3349),
                  Color(0xFFF45C43),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
