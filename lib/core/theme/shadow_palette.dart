import 'package:flutter/material.dart';

class ShadowPalette {
  static const tableElevation = [
    BoxShadow(
      color: Colors.grey,
      offset: Offset(0.0, 1.0), //(x,y)
      blurRadius: 6.0,
    ),
  ];
  static const formElevation = [
    BoxShadow(
      color: Colors.grey,
      offset: Offset(
        5.0,
        5.0,
      ),
      blurRadius: 10.0,
      spreadRadius: 2.0,
    ), //BoxShadow
    BoxShadow(
      color: Colors.white,
      offset: Offset(0.0, 0.0),
      blurRadius: 0.0,
      spreadRadius: 0.0,
    ), //BoxShadow
  ];
}
