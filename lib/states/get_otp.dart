import 'package:flutter/material.dart';
import 'package:project_policealert/utility/myconstant.dart';
import 'package:project_policealert/widgets/showimage.dart';
import 'package:project_policealert/widgets/showtitle.dart';

class Getotp extends StatefulWidget {
  const Getotp({Key? key}) : super(key: key);

  @override
  _GetotpState createState() => _GetotpState();
}

class _GetotpState extends State<Getotp> {
  @override
  Widget build(BuildContext context) {
     double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            buildImage(),
            buildText(),
            buildPhonenumber(size),
          ],
        ),
      ),
    );
  }

  Row buildText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: ShowTitle(
            title: 'รับรหัส OTP',
            textStyle: TextStyle(fontFamily: 'Kodchasan'),
          ),
        ),
      ],
    );
  }

  Row buildImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowImage(path: Mycon.iconlogo),
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

}
