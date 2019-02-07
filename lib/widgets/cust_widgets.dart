import 'package:flutter/material.dart';

Widget buildTopHeader(String title,bool hasBack,bool hasMenu) {
  List<Widget> _w=[];
  _w.add(new Icon(Icons.menu, size: 32.0, color: Colors.white));
  _w.add(new Expanded(
  child: new Padding(
  padding: const EdgeInsets.only(right: 8.0),
  child: new Text(
  title,
  style: new TextStyle(
  fontSize: 20.0,
  color: Colors.white,
  fontWeight: FontWeight.w300),
  ),
  ),
  ));
  if (hasBack)
  _w.add(new Icon(Icons.arrow_forward_ios, color: Colors.white));
  return new Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
    child: new Row(
      children: _w,
    ),
  );
}