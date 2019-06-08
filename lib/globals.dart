import 'package:flutter/material.dart';

// current datetime object
var now;
// true - light, false -dark
bool brightness = true;
Color dark = Color(0xFF000000),
    lightText = Color(0xFFFDFDFD),
    light = Color(0xFFFDFDFD),
    darkText = Color(0xFF303030),
    themeColor = Colors.orange;
String quirkyName = "Boss",
    greetingText = "Have a great day!";

// gradient begin colors
List<Color> gBegin = [
  Color(0xFFEB3349),
  Color(0xFF7F00FF),
  Color(0xFF396afc),
  Color(0xFF485563),
  Color(0xFF4776E6),
  Color(0xFFfc6767)
];

// gradient end colors
List<Color> gEnd = [
  Color(0xFFF45C43),
  Color(0xFFE100FF),
  Color(0xFF2948ff),
  Color(0xFF29323c),
  Color(0xFF8E54E9),
  Color(0xFFec008c)
];
