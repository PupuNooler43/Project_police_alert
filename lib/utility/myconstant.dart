import 'package:flutter/material.dart';

class Mycon {

  //genernal

  static String appName ='Police Alert';
  static String appLocate = '(FOR BANGNA)';

  //route

  static String routeGetOTP ='/getotp';
  static String routeVerifyOTP ='/verifyotp';
  static String routeLogin ='/login';
  static String routeRegister ='/register';
  static String routeMapHint ='/maphint';
  static String routeDetailUser ='/detailuser';
  static String routeDetailHint ='/detailhint';
  static String routeLoadingscreen = '/loadingscreen';

  //image

  static String loginlogo = 'images/loginlogo.png';
  static String logoimage = 'images/logo2.png';
  static String logoregis = 'images/logoregis.png';

  //color

  static Color primary = Color(0xffc10000);
  static Color dark = Color(0xfffc4c2e);
  static Color light = Color(0xff890000);

  //style

  TextStyle h1Style()=> TextStyle(
    fontSize: 24,
    color: dark,
    fontWeight: FontWeight.bold,
  );

   TextStyle h2Style()=> TextStyle(
    fontSize: 16,
    color: dark,
    fontWeight: FontWeight.normal,
  );

   TextStyle h3Style()=> TextStyle(
    fontSize: 14,
    color: dark,
    fontWeight: FontWeight.normal,
  );

     TextStyle h4Style()=> TextStyle(
    fontSize: 12,
    color: dark,
    fontWeight: FontWeight.normal,
  );


  ButtonStyle myButtonStyle()=>ElevatedButton.styleFrom(
                        primary: Mycon.primary,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    );
  
}