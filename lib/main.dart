import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_policealert/states/detail_hint.dart';
import 'package:project_policealert/states/detail_user.dart';
import 'package:project_policealert/states/loadingscreen.dart';
import 'package:project_policealert/states/login.dart';
import 'package:project_policealert/states/maphint.dart';
import 'package:project_policealert/states/register.dart';
import 'package:project_policealert/utility/myconstant.dart';

final Map<String, WidgetBuilder> map = {
  '/login':(BuildContext context)=>Login(),
  '/register':(BuildContext context)=>Register(),
  '/maphint':(BuildContext context)=>Maphint(),
  '/detailuser':(BuildContext context)=>Detailuser(),
  '/detailhint':(BuildContext context)=>Detailhint(),
  '/loadingscreen':(BuildContext context)=>Loading(),

};

String? initlalRoute;

void main() async{
  initlalRoute = Mycon.routeMapHint;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(),);
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoliceAlert (BangNa)',
      routes: map,
      initialRoute: initlalRoute,

    );
  }
}