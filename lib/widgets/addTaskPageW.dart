import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<String> _monthArr = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "June",
  "July",
  "Aug",
  "Sept",
  "Oct",
  "Nov",
  "Dec"
];

Widget taskTitleField() {
  return TextField(
    decoration: InputDecoration(
        labelText: 'What are you planning?',
        labelStyle: TextStyle(color: Colors.grey)),
    style: TextStyle(fontSize: 25.0),
    maxLines: 3,
  );
}

Widget notificationIcon() {
  return Icon(
    FontAwesomeIcons.bell,
    color: Colors.orange,
  );
}

String getMonth(int month) {
  return _monthArr[--month];
}

Widget notesField() {
  return Flexible(
    child: new TextField(
      style: TextStyle(fontSize: 20),
      decoration: const InputDecoration.collapsed(hintText: "Add note"),
    ),
  );
}

Widget notesIcon() {
  return Icon(
    FontAwesomeIcons.stickyNote,
    color: Colors.orange,
  );
}

Widget repeatIcon() {
  return Icon(
    FontAwesomeIcons.redo,
    color: Colors.orange,
  );
}
