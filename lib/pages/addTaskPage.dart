import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../globals.dart' as globals;
import '../widgets/addTaskPageW.dart' as homePageW;

class AddTaskPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddTaskPageState();
  }
}

class _AddTaskPageState extends State<AddTaskPage> {
  int choice = 0;
  DateTime _nDate = globals.now;
  TimeOfDay _nTime = TimeOfDay.fromDateTime(globals.now);
  int _repeatChoice = 1;

  Future _selectTime() async {
    TimeOfDay picked = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(_nDate));
    if (picked != null) {
      setState(() {
        _nTime = picked;
      });
    }
    ;
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        firstDate: DateTime.now().subtract(Duration(days: 1)),
        initialDate: _nDate,
        lastDate: DateTime(2022));
    if (picked != null) {
      setState(() {
        _nDate = picked;
      });
    }
    ;
  }

  Widget _dateBtn() {
    return InkWell(
      onTap: () {
        _selectDate();
      },
      child: Text(
        homePageW.getMonth(_nDate.month) + " " + _nDate.day.toString() + ", ",
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _timeBtn() {
    int _hour = (_nTime.hour > 12) ? _nTime.hour - 12 : _nTime.hour;
    String minute = _nTime.minute.toString();
    if (_nTime.minute < 10) minute = "0" + minute;
    String amPm = (_nTime.hour > 12) ? "PM" : "AM";
    return InkWell(
      onTap: () {
        _selectTime();
      },
      child: Text(
        _hour.toString() + ":" + minute + " " + amPm,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _repeatField() {
    return Column(
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
              color: (_repeatChoice == 1) ? Colors.orange : Colors.transparent,
              borderRadius: BorderRadius.circular(20.0)),
          child: FlatButton(
            onPressed: () {
              setState(() {
                _repeatChoice = 1;
              });
            },
            child: Text(
              "Just today",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
              color: (_repeatChoice == 2) ? Colors.orange : Colors.transparent,
              borderRadius: BorderRadius.circular(20.0)),
          child: FlatButton(
              onPressed: () {
                setState(() {
                  _repeatChoice = 2;
                });
              },
              child: Text(
                "All Days",
                style: TextStyle(fontSize: 20.0),
              )),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            foregroundColor: (globals.brightness == true)
                ? globals.lightText
                : globals.darkText,
            heroTag: 'createTaskFABHero',
            icon: Icon(Icons.add),
            label: Text("Add"),
            backgroundColor: (globals.brightness == true)
                ? globals.themeColor
                : Colors.white,
            onPressed: () {
              _selectDate();
            }),
        appBar: AppBar(
          backgroundColor:
              (globals.brightness == true) ? globals.light : globals.dark,
          elevation: 0,
          iconTheme: IconThemeData(
            color: (globals.brightness == true)
                ? globals.darkText
                : globals.lightText,
          ),
          leading: IconButton(
              padding: EdgeInsets.only(bottom: 2.0),
              icon: Icon(
                FontAwesomeIcons.caretLeft,
                size: 50.0,
              ),
              color: (globals.brightness == true)
                  ? globals.darkText
                  : globals.lightText,
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            "Add Task",
            style: TextStyle(
                color: (globals.brightness == true)
                    ? globals.darkText
                    : globals.lightText,
                fontWeight: FontWeight.bold,
                fontSize: 30.0),
          ),
        ),
        body: Container(
          color: (globals.brightness == true) ? globals.light : globals.dark,
          padding: EdgeInsets.all(40.0),
          child: ListView(
            children: <Widget>[
              Container(
                child: homePageW.taskTitleField(),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: homePageW.notificationIcon(),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Container(
                      child: _dateBtn(),
                    ),
                    Container(
                      child: _timeBtn(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    homePageW.notesIcon(),
                    SizedBox(
                      width: 30.0,
                    ),
                    Container(child: homePageW.notesField())
                  ],
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    homePageW.repeatIcon(),
                    SizedBox(
                      width: 30.0,
                    ),
                    Container(child: _repeatField())
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
