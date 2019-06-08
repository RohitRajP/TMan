import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../globals.dart' as globals;
import '../widgets/addTaskPageW.dart' as homePageW;
import 'package:tman/databaseHelper.dart';

class AddTaskPage extends StatefulWidget {
  Function addTask;

  AddTaskPage(this.addTask);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddTaskPageState();
  }
}

class _AddTaskPageState extends State<AddTaskPage> {
  int choice = 0;
  DateTime _nDate;
  int _repeatChoice = 1;
  bool _autoValidate = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _taskTitle, _taskNote;

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  void _insert() async {
    // false - single day, true - all day
    bool tFreq = false;
    if (_taskNote == null || _taskNote.length == 0) {
      _taskNote = "No task note added";
    }
    if (_repeatChoice == 2) tFreq = true;
    // row to insert
    var _date = (tFreq == false) ? _nDate.toString() : "null";
    String value = await widget.addTask(
        _taskTitle, _taskNote, _date, _nDate.toString());
    print(value);
    if (value.compareTo("Inserted") == 0) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Yaay! New task added'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ));
    }
    else if (value.compareTo("Could not insert") == 0) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Apologies! Task already exsists'),
        backgroundColor: Colors.deepOrange,
        duration: Duration(seconds: 2),
      ));
    }
    else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Apologies! An error occured during insertion'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ));
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nDate = DateTime.now().add(Duration(hours: 2));

  }

  Future _selectTime() async {
    TimeOfDay picked = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(_nDate));
    if (picked != null) {
      setState(() {
        _nDate = new DateTime(
            _nDate.year, _nDate.month, _nDate.day, picked.hour, picked.minute);
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
    return (_repeatChoice == 1)
        ? InkWell(
      onTap: () {
        _selectDate();
      },
      child: Text(
        homePageW.getMonth(_nDate.month) +
            " " +
            _nDate.day.toString() +
            ", ",
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    )
        : null;
  }

  Widget _timeBtn() {
    int _hour = (_nDate.hour > 12) ? _nDate.hour - 12 : _nDate.hour;
    String minute = _nDate.minute.toString();
    if (_nDate.minute < 10) minute = "0" + minute;
    String amPm = (_nDate.hour > 12) ? "PM" : "AM";
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
              borderRadius: BorderRadius.circular(5.0)),
          child: FlatButton(
            textColor:
            (_repeatChoice == 1) ? globals.lightText : globals.darkText,
            onPressed: () {
              setState(() {
                _repeatChoice = 1;
              });
            },
            child: Text(
              "Single Day",
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
              borderRadius: BorderRadius.circular(5.0)),
          child: FlatButton(
              textColor:
              (_repeatChoice == 2) ? globals.lightText : globals.darkText,
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

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      _insert();
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Widget _taskTitleField() {
    return Form(
      key: _formKey,
      child: TextFormField(
        autovalidate: _autoValidate,
        validator: (String arg) {
          if (arg.length <= 0)
            return 'Can\'t create a task without a name right?';
          else
            return null;
        },
        decoration: InputDecoration(
            labelText: 'What are you planning?',
            labelStyle: TextStyle(color: Colors.grey)),
        style: TextStyle(fontSize: 25.0),
        onSaved: (String value) {
          _taskTitle = value;
        },
        maxLines: 3,
        maxLength: 200,
        maxLengthEnforced: true,
      ),
    );
  }

  Widget _notesField() {
    return Flexible(
      child: new TextField(
        style: TextStyle(fontSize: 20),
        decoration: const InputDecoration.collapsed(hintText: "Add note"),
        onChanged: (String value) {
          _taskNote = value;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton.extended(
            foregroundColor: (globals.brightness == true)
                ? globals.lightText
                : globals.darkText,
            heroTag: 'createTaskFABHero',
            icon: Icon(Icons.add),
            label: Text("Add Task"),
            backgroundColor: (globals.brightness == true)
                ? globals.themeColor
                : Colors.white,
            onPressed: () {
              _validateInputs();
              _autoValidate = true;
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
                child: _taskTitleField(),
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
                    Container(child: _notesField())
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
