import 'package:flutter/material.dart';
import 'package:project_policealert/utility/myconstant.dart';
import 'package:project_policealert/widgets/showimage.dart';
import 'package:project_policealert/widgets/showtitle.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

bool statusRedeye = true;

class _RegisterState extends State<Register> {
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
                    onPressed:()=>Navigator.pushNamed(context, Mycon.routeLogin), 
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
