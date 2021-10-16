import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Color(0xff9F5B06);
  Color primaryColor = Color(0xffaf9064);
  Color lightColor = Color(0xffe2c092);

  TextStyle redBoldStyle() =>
      TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold);

  Widget showLogo() => Image.asset('images/logo.png');

  Widget titleH1(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: darkColor,
        ),
      );

  Widget titleH2(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: darkColor,
        ),
      );

  Widget titleH2While(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      );

  Widget titleH3(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 16,
          //fontWeight: FontWeight.bold,
          color: darkColor,
        ),
      );

  Widget titleH3While(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 16,
          //fontWeight: FontWeight.bold,
          color: Colors.white54,
        ),
      );

  MyStyle();
}
