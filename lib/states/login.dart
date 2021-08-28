import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_policealert/utility/myconstant.dart';
import 'package:project_policealert/widgets/showimage.dart';
import 'package:project_policealert/widgets/showtitle.dart';
import 'package:get_storage/get_storage.dart';
import 'maphint.dart';

class Login extends StatefulWidget {
  const Login({ Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class LoginData {
  var username;
  var fname;
  var lname;
  var tel;

  LoginData.arr(
    Map data,
  ) : username = data["username"],
   fname = data["f_name"],
   lname = data["l_name"],
   tel = data["tel"];
}

class _LoginState extends State<Login> {

  bool statusRedeye = true;

  var _login = GlobalKey<FormState>();
  var _dataStorage = GetStorage();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

   Future login() async {
    var res = await http.post(
      Uri.parse(
        "http://192.168.1.32/datacon/login.php",
      ),
      body: {
        "username": username.text,
        "password": password.text,
      },
    );

    var arr = json.decode(res.body);

  if (arr["code"] == "0") {
      Fluttertoast.showToast(
        msg: "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
      );
    } else if (arr["code"] == "1" && arr["permission_status"] == "member") {
      var data = LoginData.arr(arr);

      _dataStorage.write("username", "${data.username}");

      Fluttertoast.showToast(
        msg: "ยินดีต้อนรับเข้าสู่ระบบ ${data.fname} ${data.lname}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => new Maphint(),
        ),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode(),),
          behavior: HitTestBehavior.opaque,
          child: Form(
            key: _login,
            child: ListView(
              children: [
                buildImage(size),
                buildAppName(),
                buildUser(size),
                buildPassword(size),
                buildLogin(size),
                buildRegister(size),
              ],
            ),
          ),
        ),
        ),
    );
  }

  Row buildRegister(double size) {
     return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: size * 0.6,
                  child: ElevatedButton(
                    style: Mycon().myButtonStyle(),
                    onPressed:()=>Navigator.pushNamed(context, Mycon.routeRegister), 
                    child: Text('Register'),
                  ),
                ),
              ],
            );
  }

  Row buildLogin(double size) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(margin: EdgeInsets.only(top: 16),
                  width: size * 0.6,
                  child: ElevatedButton(
                      style: Mycon().myButtonStyle(),
                    onPressed:(){
                      if (_login.currentState!.validate()) {
                            login();
                          }
                    }, 
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
                  controller: username,
                  decoration: InputDecoration(
                    labelStyle: Mycon().h3Style(),
                    labelText: 'ชื่อผู้ใช้งาน',
                    prefixIcon: Icon(
                    Icons.account_circle_outlined,
                    color: Mycon.dark,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Mycon.light),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Mycon.dark),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "กรุณากรอกชื่อผู้ใช้";
                          }
                          return null;
                        },
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
                  controller: password,
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
                    labelText: 'รหัสผ่าน',
                    prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Mycon.dark,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Mycon.light),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Mycon.dark),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "กรุณากรอกรหัสผ่าน";
                          }
                          return null;
                        },
                ),
              ),
            ],
          );
  }

  Row buildAppName() {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShowTitle(
                title: 'PoliceAlert (Bangna)', 
                textStyle: Mycon().h2Style()),
            ],
          );
  }

  Row buildImage(double size) {
    return Row( mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(margin: EdgeInsets.only(top: 20),
            width: size*0.4,
            child: ShowImage(path: Mycon.iconlogo),),
      ],
    );
  }
}