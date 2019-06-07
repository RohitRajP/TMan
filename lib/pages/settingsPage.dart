import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart' as globals;

class SettingsPage extends StatefulWidget {
  Function refreshApp, setStatusBarColor;

  SettingsPage(this.refreshApp, this.setStatusBarColor);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SettingsPageState();
  }
}

class _SettingsPageState extends State<SettingsPage> {
  void _setBrightnessPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('brightness', globals.brightness);
    widget.setStatusBarColor();
  }

  Widget _messageDevBtn() {
    return Container(
        child: SizedBox(
      width: double.infinity,
      child: FlatButton.icon(
        padding: EdgeInsets.all(20.0),
        textColor:
            (globals.brightness == true) ? globals.darkText : globals.lightText,
        onPressed: () {
          globals.brightness = !globals.brightness;
          widget.refreshApp();
          //setStatusBarColor();
        },
        color: Colors.transparent,
        icon: Icon(FontAwesomeIcons.commentAlt),
        label: Text(
          "Message Developer",
          style: TextStyle(fontSize: 17.0),
        ),
      ),
    ));
  }

  Widget _reportBugBtn() {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: SizedBox(
          width: double.infinity,
          child: FlatButton.icon(
            padding: EdgeInsets.all(20.0),
            textColor: (globals.brightness == true)
                ? globals.darkText
                : globals.lightText,
            onPressed: () {
              globals.brightness = !globals.brightness;
              widget.refreshApp();
              //setStatusBarColor();
            },
            color: Colors.transparent,
            icon: Icon(FontAwesomeIcons.bug),
            label: Text(
              "Report Bug",
              style: TextStyle(fontSize: 17.0),
            ),
          ),
        ));
  }

  Widget _supportSTitle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 60.0),
      child: Text(
        "Support",
        style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.normal,
            color: Colors.orange),
      ),
    );
  }

  Widget _darkModeBtn() {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: SizedBox(
          width: double.infinity,
          child: FlatButton.icon(
            padding: EdgeInsets.all(20.0),
            textColor: (globals.brightness == true)
                ? globals.darkText
                : globals.lightText,
            onPressed: () {
              globals.brightness = !globals.brightness;
              _setBrightnessPrefs();
              widget.refreshApp();
              // setStatusBarColor();
            },
            color: Colors.transparent,
            icon: (globals.brightness == true)
                ? Icon(FontAwesomeIcons.solidMoon)
                : Icon(FontAwesomeIcons.solidSun),
            label: (globals.brightness == true)
                ? Text("Switch to inky dark mode",
                    style: TextStyle(fontSize: 17.0))
                : Text(
                    "Switch to beaming light mode",
                    style: TextStyle(fontSize: 17.0),
                  ),
          ),
        ));
  }

  Widget _generalSTitle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 60.0),
      child: Text(
        "General",
        style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.normal,
            color: Colors.orange),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //setStatusBarColor();
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
    return SafeArea(
      child: Scaffold(
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
            "Settings",
            style: TextStyle(
                color: (globals.brightness == true)
                    ? globals.darkText
                    : globals.lightText,
                fontWeight: FontWeight.bold,
                fontFamily: 'Ubuntu',
                fontSize: 30.0),
          ),
        ),
        body: Container(
          color: (globals.brightness == true) ? globals.light : globals.dark,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              _generalSTitle(),
              _darkModeBtn(),
              _supportSTitle(),
              _reportBugBtn(),
              _messageDevBtn()
            ],
          ),
        ),
      ),
    );
  }
}
