import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
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
  ) : 
   fname = data["f_name"],
   lname = data["l_name"],
   tel = data["tel"],
   email = data["email"];
}

class _MaphintState extends State<Maphint> {
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

  @override
  void initState() {
    data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        Positioned(
          bottom: 50,
          right: 140,
          child: ElevatedButton(
            style: Mycon().myButtonStyle(),
              onPressed: () {
                AlertDialog alertBox = AlertDialog(
                            title: Text("AlertDialog"),
                            content: Column(
                              children: [
                                TextField(
                                    ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                child: Text(
                                  "ยืนยัน",
                                ),
                                onPressed: () {
                                  
                                },
                              ),
                              TextButton(
                                child: Text(
                                  "ยกเลิก",
                                ),
                                onPressed: () {},
                              ),
                            ],
                          );

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alertBox;
                            },
                          );

              },
              child: Text('กรอกรายละเอียด'),
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
