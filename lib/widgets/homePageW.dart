import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/addTaskPageW.dart' as AddTaskPageW;
import '../globals.dart' as globals;

class HomePageW extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageWState();
  }
}

class _HomePageWState extends State<HomePageW> {
  List<dynamic> _taskList;
  bool _isLoading = true,
      _noContent = false;

  static const platform = const MethodChannel('com.tmft.tman');

  void _getTasks() async {
    String value;
    try {
      value = await platform.invokeMethod("getTasks");
    } catch (e) {
      print(e);
    }
    print(value.compareTo("NoData"));
    if (value.compareTo("NoData") == 0) {
      setState(() {
        _noContent = true;
        _isLoading = false;
      });
    }
    else if (value != null && value.compareTo("NoData") != 0) {
      _taskList = json.decode(value);
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _taskBuilder(BuildContext context, int index) {
    int colorNum = (index % 5 + index % 5) % 5;

    return Container(
      padding: EdgeInsets.all(20.0),
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
            globals.gBegin[colorNum],
            globals.gEnd[colorNum],
          ],
        ),
      ),
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _taskTitleView(index),
          SizedBox(
            height: 5.0,
          ),
          _taskNotesView(index),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[_notificationDetails(index), _repeatMode(index)],
          )
        ],
      ),
    );
  }

  Widget _tasksBuild() {
    return ListView.builder(
      itemBuilder: _taskBuilder,
      itemCount: _taskList.length,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTasks();
  }

  Widget _taskTitleView(int index) {
    return Text(
      _taskList[index]['taskName'],
      style: TextStyle(
          fontSize: 25.0, fontWeight: FontWeight.w700, color: Colors.white),
    );
  }

  Widget _taskNotesView(int index) {
    return Text(
      _taskList[index]['taskNote'],
      style: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.normal, color: Colors.white),
    );
  }

  Widget _notificationDetails(int index) {
    DateTime _dateTime = DateTime.parse(_taskList[index]['taskTime']);
    int _hour = (_dateTime.hour > 12) ? _dateTime.hour - 12 : _dateTime.hour;
    String _minute = _dateTime.minute.toString();
    if (_dateTime.minute < 10) _minute = "0" + _minute;
    String _amPm = (_dateTime.hour > 12) ? "PM" : "AM";

    String _dateTimeString = (_taskList[index]['taskDate'].toString().compareTo(
        "null") != 0) ? _dateTime.day.toString() + " " +
        AddTaskPageW.getMonth(_dateTime.month) +
        ", " + _hour.toString() + ":" + _minute + " " + _amPm : _hour
        .toString() + ":" + _minute + " " + _amPm;

    return Row(
      children: <Widget>[
        Container(
          child: Icon(
            FontAwesomeIcons.bell,
            color: globals.themeColor,
          ),
        ),
        SizedBox(
          width: 3.0,
        ),
        Container(
          child: Text(
            _dateTimeString,
            style: TextStyle(fontSize: 16.0, color: globals.lightText),
          ),
        )
      ],
    );
  }

  Widget _repeatMode(int index) {
    String _repeatModeString = (_taskList[index]['taskDate']
        .toString()
        .compareTo("null") != 0) ? "Single Day" : "All Days";
    return Container(
      child: Text(
        _repeatModeString,
        style: TextStyle(fontSize: 16.0, color: globals.lightText),
      ),
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
      child: (_isLoading == true)
          ? Center(
        child: CircularProgressIndicator(
          valueColor:
          new AlwaysStoppedAnimation<Color>(globals.themeColor),
        ),
      )
          : (_noContent == true) ? Center(
        child: Text("No tasks for today\nThat's a lot of free time!",
          textAlign: TextAlign.center, style: TextStyle(
              color: globals.themeColor,
              fontSize: 20.0
          ),),
      ) : _tasksBuild(),
    );
  }
}
