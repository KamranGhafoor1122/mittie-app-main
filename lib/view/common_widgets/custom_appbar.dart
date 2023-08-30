import 'package:flutter/material.dart';

Widget customAppbar({@required String text,Widget icon,List<Widget> trailingItems,Color bgColor,Color textColor}){
  return AppBar(
    title: Text(
      text,
      style: TextStyle(
        color: textColor ??Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w800
      ),
    ),
    elevation: 0,
    centerTitle: false,
    leading: icon,
    backgroundColor: bgColor??Colors.white,
    actions: trailingItems,
  );
}