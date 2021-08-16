import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:project_policealert/utility/myconstant.dart';
import 'package:project_policealert/widgets/showimage.dart';
import 'package:project_policealert/widgets/showtitle.dart';

class GetOTP extends StatefulWidget {
  const GetOTP({Key? key}) : super(key: key);

  @override
  _GetOTPState createState() => _GetOTPState();
}

class _GetOTPState extends State<GetOTP> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildImage(size),
              buildText1(),
              buildText2(),
              buildPhonenumber(size),
              SizedBox(
                height: 20,
              ),
              otpField(),
            ],
          ),
        ),
      ),
    );
  }

  ShowTitle buildText1() => ShowTitle(
        title: 'รับรหัส OTP',
        textStyle: Mycon().h1Style(),
      );

  ShowTitle buildText2() => ShowTitle(
        title: 'เพื่อยืนยันหมายเลขโทรศัพท์มือถือ',
        textStyle: Mycon().h2Style(),
      );

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.5,
          margin: EdgeInsets.only(top: 30),
          child: ShowImage(path: Mycon.iconlogo),
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
              suffixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                child: Text(
                  'ส่งรหัส OTP',
                  style: Mycon().h3Style(),
                ),
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

  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 34,
      fieldWidth: 45,
      style: TextStyle(fontSize: 17),
      otpFieldStyle: OtpFieldStyle(
        borderColor: Colors.brown.shade800,
      ),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
      },
    );
  }
}
