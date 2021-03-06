import 'package:flutter/material.dart';

class Mycon {
  //route

  static String routeGetOTP = '/getotp';
  static String routeVerify = '/verify';
  static String routeLogin = '/login';
  static String routeRegister = '/register';
  static String routeMapHint = '/maphint';
  static String routeDetailUser = '/detailuser';
  static String routeDetailHint = '/detailhint';
  static String routeLoadingscreen = '/loadingscreen';

  //image

  static String iconlogo = 'images/iconlogo.png';
  static String loadinglogo = 'images/loadinglogo.png';
  static String avatar = 'images/avatar.png';
  static String image = 'images/image.png';

  //color

  static Color primary = Color(0xff795548);
  static Color dark = Color(0xff4b2c20);
  static Color light = Color(0xffa98274);

  //style

  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        color: dark,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => TextStyle(
        fontSize: 16,
        color: dark,
        fontWeight: FontWeight.normal,
      );

  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );

  TextStyle h4Style() => TextStyle(
        fontSize: 12,
        color: dark,
        fontWeight: FontWeight.normal,
      );

  TextStyle h5Style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.bold,
      );

  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        primary: Mycon.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );

  ButtonStyle myButtonStyle2() => ElevatedButton.styleFrom(
        primary: Colors.red.shade800,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );
  ButtonStyle myButtonStyle3() => ElevatedButton.styleFrom(
        primary: Colors.grey.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );
}
