import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_policealert/states/maphint.dart';
import 'package:project_policealert/utility/myconstant.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_policealert/widgets/showimage.dart';

class Detailuser extends StatefulWidget {
  const Detailuser({Key? key}) : super(key: key);

  @override
  _DetailuserState createState() => _DetailuserState();
}

class _DetailuserState extends State<Detailuser> {
  File? file;

  var _dataStorage = GetStorage();

  TextEditingController _fname = TextEditingController();
  TextEditingController _lname = TextEditingController();
  TextEditingController _tel = TextEditingController();
  TextEditingController _email = TextEditingController();

  Future update() async {
    var res = await http.post(
      Uri.parse(
        "http://192.168.1.32/datacon/update.php",
      ),
      body: {
        "username": _dataStorage.read('username'),
        "f_name": _fname.text,
        "l_name": _lname.text,
        "tel": _tel.text,
        "email": _email.text,
      },
    );

    var arr = json.decode(res.body);

    if (arr["code"] == "0") {
      Fluttertoast.showToast(
        msg: "บันทึกข้อมูลล้มเหลว",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
      );
    } else if (arr["code"] == "1") {
      Fluttertoast.showToast(
        msg: "บันทึกข้อมูลเรียบร้อย",
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

//image picker
  Future<Null> chooseImage(ImageSource source) async {
    try {
      var result = await ImagePicker()
          .pickImage(source: source, maxWidth: 800, maxHeight: 800);
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Account'),
        centerTitle: true,
        backgroundColor: Mycon.dark,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => new Maphint(),
              ),
            );
          },
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: CircleAvatar(
              maxRadius: size * 0.2,
              backgroundColor: Colors.transparent,
              child: file == null
                  ? ShowImage(path: Mycon.avatar)
                  : Image.file(file!),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                child: ElevatedButton(
                    style: Mycon().myButtonStyle3(),
                    child: Icon(Icons.camera_alt_sharp),
                    onPressed: () => chooseImage(ImageSource.camera)),
              ),
              Container(
                margin: EdgeInsets.only(top: 40, left: 30),
                child: ElevatedButton(
                  style: Mycon().myButtonStyle3(),
                  child: Icon(Icons.upload),
                  onPressed: () => chooseImage(ImageSource.gallery),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 10, left: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 10, top: 30),
                    child: TextFormField(
                      controller: _fname = TextEditingController(
                          text: _dataStorage.read("fname")),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "ชื่อ",
                        isDense: true,
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "กรุณากรอกชื่อ";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, top: 30),
                    child: TextFormField(
                      controller: _lname = TextEditingController(
                          text: _dataStorage.read("lname")),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "นามสกุล",
                        isDense: true,
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "กรุณากรอกนามสกุล";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, right: 10, left: 10),
            child: TextFormField(
              controller: _tel =
                  TextEditingController(text: _dataStorage.read("tel")),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "เบอร์โทรศัพท์",
                isDense: true,
              ),
              autofocus: false,
              keyboardType: TextInputType.number,
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
                } else if (value.length < 9) {
                  return "กรุณากรอกหมายเลขโทรศัพท์ให้ครบถ้วน";
                }
                return null;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, right: 10, left: 10),
            child: TextFormField(
              controller: _email = TextEditingController(
                text: _dataStorage.read('email'),
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
                isDense: true,
              ),
              autofocus: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "กรุณากรอกEmail";
                }
                return null;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  style: Mycon().myButtonStyle(),
                  child: Text(
                    "บันทึกข้อมูล",
                  ),
                  onPressed: () {
                    update();
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40, left: 30),
                width: 110,
                child: ElevatedButton(
                  style: Mycon().myButtonStyle2(),
                  child: Text(
                    "ยกเลิก",
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Maphint()));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
