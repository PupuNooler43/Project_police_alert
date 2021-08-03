import 'package:flutter/material.dart';
import 'package:project_policealert/states/detail_hint.dart';
import 'package:project_policealert/states/detail_user.dart';
import 'package:project_policealert/states/get_otp.dart';
import 'package:project_policealert/states/loadingscreen.dart';
import 'package:project_policealert/states/login.dart';
import 'package:project_policealert/states/maphint.dart';
import 'package:project_policealert/states/register.dart';
import 'package:project_policealert/states/verify_otp.dart';
import 'package:project_policealert/utility/myconstant.dart';

final Map<String, WidgetBuilder> map = {
  '/getotp':(BuildContext context)=>Getotp(),
  '/verifyotp':(BuildContext context)=>Verifyotp(),
  '/login':(BuildContext context)=>Login(),
  '/register':(BuildContext context)=>Register(),
  '/maphint':(BuildContext context)=>Maphint(),
  '/detailuser':(BuildContext context)=>Detailuser(),
  '/detailhint':(BuildContext context)=>Detailhint(),
  '/loadingscreen':(BuildContext context)=>Loading(),

};

String? initlalRoute;
void main(){
  initlalRoute = Mycon.routeLoadingscreen;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Mycon.appName,
      routes: map,
      initialRoute: initlalRoute,

    );
  }
}