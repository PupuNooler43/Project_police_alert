import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_policealert/states/detail_user.dart';
import 'package:project_policealert/states/login.dart';
import 'package:project_policealert/utility/myconstant.dart';
import 'package:get_storage/get_storage.dart';

class Maphint extends StatefulWidget {
  const Maphint({Key? key}) : super(key: key);

  @override
  _MaphintState createState() => _MaphintState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Police Alert'),
        backgroundColor: Mycon.dark,
      ),
      body: FutureBuilder(
        future: _getLocation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(userLocation.latitude, userLocation.longitude),
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
      drawer: Drawer(
        child: Material(
          color: Mycon.primary,
          child: ListView(
            padding: padding,
            children: <Widget>[
              const SizedBox(height: 49),
              buildMenuItem(
                text: '${_dataStorage.read('fname')} ${_dataStorage.read('lname')}',
                icon: Icons.account_circle,
              ),
              const SizedBox(height: 16),
              buildMenuItem(
                text: 'Edit Account',
                icon: Icons.account_circle,
                onclicked: ()=> selectedItem(context, 0),
              ),
              const SizedBox(height: 24),
              Divider(color: Colors.white70),
              const SizedBox(height: 24),
              const SizedBox(height: 5),
              buildMenuItem(
                text: 'Log out',
                icon: Icons.logout,
                onclicked: ()=> selectedItem(context, 1)
                ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onclicked,
  }){
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

    switch (index){
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
