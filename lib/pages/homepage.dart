import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';

import '../widgets/homePageW.dart';
import '../widgets/drawerW.dart';
import '../globals.dart' as globals;

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: (globals.brightness == true)?globals.light:globals.dark,
        statusBarIconBrightness: (globals.brightness == true)?Brightness.dark:Brightness.light
    ));
    globals.now = new DateTime.now();
    int hour = globals.now.hour;
    (hour >= 0 && hour < 12)?globals.greetingText = "Good Morning!":
      (hour >= 12 && hour < 17)?globals.greetingText = "Good Afternoon!":
        (hour >= 17 && hour < 20)?globals.greetingText = "Good Evening!":
          (hour >= 20 && hour <= 23)?globals.greetingText = "Good Night!":globals.greetingText = "Have a good day!";
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerW(0),
        appBar: AppBar(
          backgroundColor: (globals.brightness == true)?globals.light:globals.dark,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          leading: IconButton(
              icon: Icon(FontAwesomeIcons.alignLeft),
              color: (globals.brightness == true)?globals.darkText:globals.lightText,
              onPressed: (){
            _scaffoldKey.currentState.openDrawer();
          }),
          title: Text(
            "Lists",
            style: TextStyle(
                color: (globals.brightness == true)?globals.darkText:globals.lightText,
                fontWeight: FontWeight.bold,
                fontFamily: 'Ubuntu',
                fontSize: 30.0),),
        ),
        body: Container(
          color: (globals.brightness == true)?globals.light:globals.dark,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: HomePageW(),
        ),
      ),
    );
  }
}