import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../globals.dart' as globals;

class DrawerW extends StatefulWidget {
  int menu;
  DrawerW(this.menu);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DrawerWState();
  }
}

class _DrawerWState extends State<DrawerW>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color: (globals.brightness == true)?Colors.transparent:Colors.black,
            padding: EdgeInsets.only(top:50.0, bottom: 40.0),
            child: Chip(
              avatar: CircleAvatar(
                radius: 50.0,
                child: Text('Hi', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
              ),
              label: Text(globals.quirkyName, style: TextStyle(fontSize: 40.0, ),),
            ),
          ),
          Container(
            color: (globals.brightness == true)?Colors.transparent:Colors.black,
            padding: EdgeInsets.only(left:15.0),
            child: Text(globals.greetingText, style: TextStyle(
                letterSpacing: 0.9,
                color: (globals.brightness == true)?globals.darkText:globals.lightText,
                fontSize: 25.0,
                fontWeight: FontWeight.bold
            ),),
          ),
          Container(
            color: (globals.brightness == true)?Colors.transparent:Colors.black,
            padding: EdgeInsets.only(left:15.0),
            child: Text("Today: "+
                globals.now.day.toString()+"/"+globals.now.month.toString()+"/"+globals.now.year.toString(), style: TextStyle(
                letterSpacing: 1.0,
                color: (globals.brightness == true)?globals.darkText:globals.lightText,
                fontSize: 20.0,
                fontWeight: FontWeight.bold
            ),),
          ),
          Container(
            color: (globals.brightness == true)?Colors.transparent:Colors.black,
            padding: EdgeInsets.only(left: 15.0, top:2.0, bottom: 15.0),
            child: Text("Your own digital secretary",
                style: TextStyle(
                    color: (globals.brightness == true)?Colors.black54:Colors.grey,
                    fontSize: 16.0
                )),
          ),
          Container(
            child: (widget.menu == 1)?null:ListTile(
              leading: Icon(FontAwesomeIcons.userAstronaut),
              subtitle: Text("Quirky details about you"),
              title: Text('About You'),
              onTap: () {
                // Update the state of the app
                // ...
              },
            ),
          ),
          Container(
            child: (widget.menu == 2)?null: ListTile(
              leading: Icon(FontAwesomeIcons.cogs),
              subtitle: Text("App settings and preferences"),
              title: Text('Settings'),
              onTap: () {
                // Update the state of the app
                // ...
              },
            ),
          ),
          Container(
            child: (widget.menu == 3)?null:ListTile(
              leading: Icon(FontAwesomeIcons.users),
              subtitle: Text("App and developer details"),
              title: Text('About Us'),
              onTap: () {
                // Update the state of the app
                // ...
              },
            ),
          ),
          Container(
            child: (widget.menu == 4)?null:ListTile(
              leading: Icon(FontAwesomeIcons.doorOpen),
              subtitle: Text("Close application"),
              title: Text('Exit'),
              onTap: () {
                // Update the state of the app
                // ...
              },
            ),
          ),
        ],
      ),
    );
  }
}