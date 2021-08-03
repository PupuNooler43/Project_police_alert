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

  bool statusRedeye = true;
  
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: ListView(
            children: [
              buildImage(size),
              buildAppName(),
              buildAppLocate(),
              buildUser(size),
              buildPassword(size),
              buildLogin(size),
            ],
          ),
        ),
        ),
    );
  }

  Row buildLogin(double size) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(margin: EdgeInsets.symmetric(vertical: 20),
                  width: size * 0.6,
                  child: ElevatedButton(
                      style: Mycon().myButtonStyle(),
                    onPressed: () { }, 
                    child: Text('Login'),
                  ),
                ),
              ],
            );
  }

  Row buildUser(double size) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(margin: EdgeInsets.only(top: 16),
                width: size * 0.6,
                child: TextFormField( 
                  decoration: InputDecoration(
                    labelStyle: Mycon().h3Style(),
                    labelText: 'Username',
                    prefixIcon: Icon(
                    Icons.account_circle_outlined,
                    color: Mycon.dark,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Mycon.light),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Mycon.dark),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  Row buildPassword(double size) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(margin: EdgeInsets.only(top: 16),
                width: size * 0.6,
                child: TextFormField(
                  obscureText: statusRedeye, 
                  decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        statusRedeye = !statusRedeye;
                      });
                    }, 
                    icon: statusRedeye? Icon(
                      Icons.visibility, 
                      color: Mycon.dark,
                      ) : Icon(
                      Icons.visibility_off, 
                      color: Mycon.dark,
                      ),
                    ),
                    labelStyle: Mycon().h3Style(),
                    labelText: 'Passwors',
                    prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Mycon.dark,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Mycon.light),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Mycon.dark),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
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