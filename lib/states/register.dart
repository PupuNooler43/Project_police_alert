import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_policealert/states/login.dart';
import 'package:project_policealert/utility/myconstant.dart';
import 'package:project_policealert/widgets/showtitle.dart';

class Register extends StatefulWidget {
  final title;
  const Register({Key? key, this.title}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool statusRedeye = true;

  var _regis = GlobalKey<FormState>();

TextEditingController username = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController conpass = TextEditingController();
TextEditingController name = TextEditingController();
TextEditingController surname = TextEditingController();
TextEditingController tel = TextEditingController();

  Future regis() async {
    var res = await http.post(
      Uri.parse(
        "http://192.168.1.32/datacon/regis.php",
      ),
      body: {
        "username": username.text,
        "password": password.text,
        "conpass": conpass.text,
        "f_name": name.text,
        "l_name": surname.text,
        "tel": tel.text,
      },
    );

    var arr = json.decode(res.body);

    if (arr["code"] == "00") {
      Fluttertoast.showToast(
        msg: "รหัสผ่านไม่ตรงกัน",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
      );
    } else if (arr["code"] == "0") {
      Fluttertoast.showToast(
        msg: "ชื่อผู้ใช้ซ้ำ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
      );
    } else if (arr["code"] == "1") {
      Fluttertoast.showToast(
        msg: "คุณ${name.text}สมัครสมาชิกเรียบร้อยแล้ว",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => new Login(),
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
          onTap: () => FocusScope.of(context).requestFocus(
            FocusNode(),
          ),
          behavior: HitTestBehavior.opaque,
          child:Form(
            key: _regis,
            child: ListView(
              children: [
                buildTitleregis(),
                buildUser(size),
                buildPassword(size),
                buildConfirmPassword(size),
                buildName(size),
                buildSurname(size),
                buildPhonenumber(size),
                buildRegister(size),
                buildCencel(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildTitleregis() {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 16),
                    child: ShowTitle(
                  title: 'สมัครสมาชิก',
                  textStyle: Mycon().h1Style(),
                )),
              ],
            );
  }

  Row buildUser(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.8,
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
            inputFormatters: [
                        LengthLimitingTextInputFormatter(
                          20,
                        ),
                        FilteringTextInputFormatter.allow(
                          RegExp(
                            r"[A-Za-z0-9!@#$%^&*-_+=\/.|?]",
                          ),
                        ),
                      ],
            validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "กรุณากรอกชื่อผู้ใช้";
                          }
                          else if (value.length < 8) {
                          return "ความยาวของชื่อผู้ใช้อย่างน้อย 8 ตัวอักษร";
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
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.8,
          child: TextFormField(
            controller: password,
            obscureText: statusRedeye,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    statusRedeye = !statusRedeye;
                  });
                },
                icon: statusRedeye
                    ? Icon(
                        Icons.visibility,
                        color: Mycon.dark,
                      )
                    : Icon(
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
            inputFormatters: [
                        LengthLimitingTextInputFormatter(
                          20,
                        ),
                        FilteringTextInputFormatter.allow(
                          RegExp(
                            r"[A-Za-z0-9!@#$%^&*-_+=\/.|?]",
                          ),
                        ),
                      ],
            validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "กรุณากรอกรหัสผ่าน";
                          }
                          else if (value.length < 8) {
                          return "ความยาวของอย่างน้อย 8 ตัวอักษร";
                          }
                          return null;
                        },
          ),
        ),
      ],
    );
  }

  Row buildConfirmPassword(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.8,
          child: TextFormField(
            controller: conpass,
            obscureText: statusRedeye,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    statusRedeye = !statusRedeye;
                  });
                },
                icon: statusRedeye
                    ? Icon(
                        Icons.visibility,
                        color: Mycon.dark,
                      )
                    : Icon(
                        Icons.visibility_off,
                        color: Mycon.dark,
                      ),
              ),
              labelStyle: Mycon().h3Style(),
              labelText: 'ยืนยันรหัสผ่าน',
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
            inputFormatters: [
                        LengthLimitingTextInputFormatter(
                          20,
                        ),
                        FilteringTextInputFormatter.allow(
                          RegExp(
                            r"[A-Za-z0-9!@#$%^&*-_+=\/.|?]",
                          ),
                        ),
                      ],
            validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "กรุณายืนยันรหัสผ่าน";
                          }
                          else if (value != password.text) {
                            return "รหัสผ่านไม่ตรงกัน";
                          }
                          return null;
                        },
          ),
        ),
      ],
    );
  }

  Row buildName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.8,
          child: TextFormField(
            controller: name,
            decoration: InputDecoration(
              labelStyle: Mycon().h3Style(),
              labelText: 'ชื่อ',
              prefixIcon: Icon(
                Icons.badge_outlined,
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
                            return "กรุณากรอกชื่อ";
                          }
                          return null;
                        },
          ),
        ),
      ],
    );
  }

  Row buildSurname(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.8,
          child: TextFormField(
            controller: surname,
            decoration: InputDecoration(
              labelStyle: Mycon().h3Style(),
              labelText: 'นามสกุล',
              prefixIcon: Icon(
                Icons.badge_outlined,
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
                            return "กรุณากรอกนามสกุล";
                          }
                          return null;
                        },
          ),
        ),
      ],
    );
  }

  Row buildPhonenumber(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.8,
          child: TextFormField(
            controller: tel,
            decoration: InputDecoration(
              labelStyle: Mycon().h3Style(),
              labelText: 'หมายเลขโทรศัพท์',
              prefixIcon: Icon(
                Icons.phone,
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
            inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.allow(
                            RegExp(
                              r"[0-9]",
                            ),
                          ),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
            validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "กรุณากรอกหมายเลขโทรศัพท์";
                          }
                          return null;
                        },
          ),
        ),
      ],
    );
  }

  Row buildRegister(double size) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 16),
                  width: size * 0.6,
                  child: ElevatedButton(
                    style: Mycon().myButtonStyle(),
                    onPressed:(){
                      if (_regis.currentState!.validate()) {
                            regis();
                          }
                    }, 
                    child: Text('Register'),
                  ),
                ),
              ],
            );
  }

  Row buildCencel(double size) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: size * 0.6,
                  child: ElevatedButton(
                    style: Mycon().myButtonStyle(),
                    onPressed:()=>Navigator.pushNamed(context, Mycon.routeLogin), 
                    child: Text('Cencel'),
                  ),
                ),
              ],
            );
  }

}
