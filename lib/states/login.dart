import 'package:flutter/material.dart';
import 'package:project_policealert/utility/myconstant.dart';
import 'package:project_policealert/widgets/showimage.dart';
import 'package:project_policealert/widgets/showlocate.dart';
import 'package:project_policealert/widgets/showtitle.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            buildImage(size),
            buildAppName(),
            buildAppLocate()
          ],
        ),
        ),
    );
  }

  Row buildAppLocate() {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShowLocate(locate: Mycon.appLocate, textStyle: Mycon().h2Style()),
            ],
          );
  }

  Row buildAppName() {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShowTitle(
                title: Mycon.appName, 
                textStyle: Mycon().h1Style()),
            ],
          );
  }

  Row buildImage(double size) {
    return Row( mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: size*0.5,
            child: ShowImage(path: Mycon.image3)),
      ],
    );
  }
}