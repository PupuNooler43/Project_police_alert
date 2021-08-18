import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:project_policealert/utility/myconstant.dart';
import 'package:project_policealert/widgets/showimage.dart';
import 'package:project_policealert/widgets/showtitle.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            buildImage(size),
            buildText1(),
            buildText2(),
            SizedBox(
                height: 20,
              ),
            otptextfeild(),
            buildVerify(size),

          ],),
        ),
      ),
    );
  }

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.5,
          margin: EdgeInsets.only(top: 60),
          child: ShowImage(path: Mycon.iconlogo),
        ),
      ],
    );
  }

  ShowTitle buildText1() => ShowTitle(
        title: 'ยืนยันรหัส OTP',
        textStyle: Mycon().h1Style(),
      );

  ShowTitle buildText2() => ShowTitle(
        title: 'กรอกรหัส OTP 6 หลัก',
        textStyle: Mycon().h2Style(),
      );

   Widget otptextfeild() {
    return OtpTextField(
      numberOfFields: 6,
      fieldWidth: 50,
      enabledBorderColor: Color(0xffa98274),
      focusedBorderColor: Color(0xff4b2c20),
      showFieldAsBox: true,
      onCodeChanged: (String code) {
        //handle validation or checks here
      },
      //runs when every textfield is filled
      onSubmit: (pin) {
        print("Completed: " + pin);
      }, // end onSubmit
    );
  }

  Row buildVerify(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 30),
          width: size * 0.6,
          child: ElevatedButton(
            style: Mycon().myButtonStyle(),
            onPressed: () => Navigator.pushNamed(context, Mycon.routeLogin),
            child: Text('Verify'),
          ),
        ),
      ],
    );
  }
}
