import 'package:flutter/material.dart';

class Responsive {
  /*
    height: Responsive.height(50, context) => 50% height of device
    width: Responsive.width(100, context) => 100% width of device
  */
  static width(double p, BuildContext context) {
    return MediaQuery.of(context).size.width * (p / 100);
  }

  static height(double p, BuildContext context) {
    return MediaQuery.of(context).size.height * (p / 100);
  }
}