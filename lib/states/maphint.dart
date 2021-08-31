import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:project_policealert/states/detail_user.dart';
import 'package:project_policealert/states/login.dart';
import 'package:project_policealert/utility/myconstant.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_policealert/widgets/showimage.dart';

class Maphint extends StatefulWidget {
  const Maphint({Key? key}) : super(key: key);

  @override
  _MaphintState createState() => _MaphintState();
}

class Data {
  var fname;
  var lname;
  var tel;
  var email;

  Data.arr(
    Map data,
  )   : fname = data["f_name"],
        lname = data["l_name"],
        tel = data["tel"],
        email = data["email"];
}

class _MaphintState extends State<Maphint> {
  File? file;

  TextEditingController typedetail = TextEditingController();
  TextEditingController moredetailhint = TextEditingController();
  TextEditingController moredetailplace = TextEditingController();

  var _dataStorage = GetStorage();

  final padding = EdgeInsets.symmetric(horizontal: 20);

  var userLocation;
  var mapController;
  Set<Marker> _marker = {};

  Future _getLocation() async {
    try {
      userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      userLocation = null;
    }
    return userLocation;
  }

  //ดึงข้อมูลจาก Database
  Future data() async {
    var res = await http.post(
      Uri.parse(
        "http://192.168.1.32/datacon/selectuser.php",
      ),
      body: {
        "username": _dataStorage.read("username"),
      },
    );

    var arr = json.decode(res.body);

    if (arr["code"] == "1") {
      var data = Data.arr(arr);

      _dataStorage.write("fname", "${data.fname}");
      _dataStorage.write("lname", "${data.lname}");
      _dataStorage.write("tel", "${data.tel}");
      _dataStorage.write("email", "${data.email}");
    }
  }

  Future detailhint() async {
    var res = await http.post(
      Uri.parse(
        "http://192.168.1.32/datacon/insert_detail.php",
      ),
      body: {
        "type_detail": typedetail.text,
        "more_detail_hint": moredetailhint.text,
        "more_detail_place": moredetailplace.text,
      },
    );

    var arr = json.decode(res.body);

    if (arr["code"] == "0") {
      Fluttertoast.showToast(
        msg: "Error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
      );
    } else if (arr["code"] == "1") {
      Fluttertoast.showToast(
        msg: "แจ้งเบาะแสเรียบร้อยแล้ว",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
      );
    }
  }

  @override
  void initState() {
    data();
    super.initState();
  }

  //image picker
  Future<Null> chooseImage(ImageSource source) async {
    try {
      var result = await ImagePicker()
          .pickImage(source: source, maxWidth:200, maxHeight: 200);
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    final name = 'Police Alert';
    final area = 'FOR BANGNA';

    return Scaffold(
      appBar: AppBar(
        title: Text('Police Alert'),
        backgroundColor: Mycon.light,
      ),
      body: Stack(children: [
        FutureBuilder(
          future: _getLocation(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return GoogleMap(
                  mapType: MapType.terrain,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target:
                        LatLng(userLocation.latitude, userLocation.longitude),
                    zoom: 15,
                  ),
                  markers: _marker,
                  onMapCreated: (GoogleMapController contrller) {
                    setState(() {
                      _marker.add(
                        Marker(
                          markerId: MarkerId("1"),
                          position: LatLng(
                            13.591948396219482,
                            100.62999028707155,
                          ),
                        ),
                      );
                    });
                  });
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
          },
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 600),
            child: ElevatedButton(
              style: Mycon().myButtonStyle(),
              onPressed: () {
                AlertDialog alertBox = AlertDialog(
                  title: Text("รายละเอียดเบาะแส"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: typedetail =
                            TextEditingController(text: ""),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'ประเภทเบาะแส',
                          isDense: true,
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "กรุณากรอกประเภทเบาะแส เช่น การพนัน ยาเสพติด ฯลฯ";
                          }
                          return null;
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: TextFormField(
                          controller: moredetailhint =
                              TextEditingController(text: ""),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'รายละเอียดเบาะแสเพิ่มเติม',
                            isDense: true,
                          ),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: TextFormField(
                          controller: moredetailplace =
                              TextEditingController(text: ""),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'รายละเอียดสถานที่เพิ่มเติม',
                            isDense: true,
                          ),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: 10,
                            ),
                            child: ElevatedButton(
                              style: Mycon().myButtonStyle3(),
                              onPressed: () => chooseImage(ImageSource.camera),
                              child: Icon(Icons.camera_alt_sharp),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 16),
                            child: ElevatedButton(
                              style: Mycon().myButtonStyle3(),
                              onPressed: () => chooseImage(ImageSource.gallery),
                              child: Icon(Icons.upload),
                            ),
                          ),
                        ],
                      ),
                      Container(margin: EdgeInsets.only(top: 5),width: size * 0.2,
                        child: file == null
                            ? ShowImage(path: Mycon.image)
                            : Image.file(file!),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text(
                        "ยืนยัน",
                      ),
                      onPressed: () {
                        detailhint();
                      },
                    ),
                    TextButton(
                      child: Text(
                        "ยกเลิก",
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return alertBox;
                  },
                );
              },
              child: Text('กรอกรายละเอียดเบาะแส'),
            ),
          ),
        ),
      ]),
      drawer: Drawer(
        child: Material(
          color: Mycon.primary,
          child: ListView(
            padding: padding,
            children: <Widget>[
              buildHeader(
                name: name,
                area: area,
                text:
                    '${_dataStorage.read('fname')} ${_dataStorage.read('lname')}',
              ),
              const SizedBox(height: 16),
              buildMenuItem(
                text: 'Information',
                icon: Icons.account_circle,
                onclicked: () => selectedItem(context, 0),
              ),
              const SizedBox(height: 24),
              Divider(color: Colors.white70),
              const SizedBox(height: 24),
              const SizedBox(height: 5),
              buildMenuItem(
                  text: 'Log out',
                  icon: Icons.logout,
                  onclicked: () => selectedItem(context, 1)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader({
    required String area,
    required String name,
    required String text,
  }) =>
      InkWell(
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.transparent,
                child: ShowImage(
                  path: Mycon.iconlogo,
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    area,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    text,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onclicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onclicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Detailuser(),
        ));
        break;
      case 1:
        Fluttertoast.showToast(
          msg: "ออกจากระบบเรียบร้อยแล้ว",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
        );
        _dataStorage.erase();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Login(),
        ));
        break;
    }
  }
}
