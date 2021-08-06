import 'package:flutter/material.dart';
import 'package:project_policealert/utility/myconstant.dart';
import 'package:project_policealert/widgets/showimage.dart';

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
              buildImage(size),
              buildUser(size),
              buildPassword(size),
              buildConfirmPassword(size),
              buildName(size),
              buildSurname(size),
              buildPhonenumber(size),
            ],
          ),
        ),
      ),
    );
  }

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          width: size * 0.35,
          child: ShowImage(path: Mycon.logoimage),
        ),
      ],
    );
  }

  Row buildUser(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 5),
          width: size * 0.6,
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
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
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

  Row buildConfirmPassword(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
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

Row buildName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            decoration: InputDecoration(
              labelStyle: Mycon().h3Style(),
              labelText: 'ชื่อ',
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

  Row buildSurname(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            decoration: InputDecoration(
              labelStyle: Mycon().h3Style(),
              labelText: 'นามสกุล',
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

  
  Row buildPhonenumber(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            decoration: InputDecoration(
              labelStyle: Mycon().h3Style(),
              labelText: 'หมายเลขโทรศัพท์',
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

}
