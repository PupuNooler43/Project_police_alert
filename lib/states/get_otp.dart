import 'package:flutter/material.dart';
import 'package:project_policealert/Services/auth_service.dart';
import 'package:project_policealert/utility/myconstant.dart';
import 'package:project_policealert/widgets/showimage.dart';
import 'package:project_policealert/widgets/showtitle.dart';

class GetOTP extends StatefulWidget {
  const GetOTP({Key? key}) : super(key: key);

  @override
  _GetOTPState createState() => _GetOTPState();
}

class _GetOTPState extends State<GetOTP> {
  var phoneNumberController = TextEditingController();

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),
          SizedBox(
            width: 8,
          ),
          Text('Just a moment.')
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
  PhoneAuth _service = PhoneAuth();

  phoneAuthentication(number) {
    print(number);
  }

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
              SizedBox(
                height: 20,
              ),
              buildPhonenumber(size),
              SizedBox(
                height: 20,
              ),
              buildGetOTP(size),
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
          margin: EdgeInsets.only(top: 60),
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
            autofocus: true,
            maxLength: 10,
            keyboardType: TextInputType.phone,
            controller: phoneNumberController,
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

  Row buildGetOTP(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: ElevatedButton(
            style: Mycon().myButtonStyle(),
            onPressed: () {
              String number = '${phoneNumberController.text}';
              showAlertDialog(context);
              _service.verifyPhoneNumber(context, number);
            },
            child: Text('Next'),
          ),
        ),
      ],
    );
  }
}


