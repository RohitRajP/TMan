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


Widget notificationIcon() {
  return Icon(
    FontAwesomeIcons.bell,
    color: Colors.orange,
  );
}

String getMonth(int month) {
  return _monthArr[--month];
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
