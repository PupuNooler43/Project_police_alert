import 'package:flutter/material.dart';
import 'package:project_policealert/states/maphint.dart';
import 'package:project_policealert/utility/myconstant.dart';

class Detailuser extends StatefulWidget {
  const Detailuser({ Key? key }) : super(key: key);

  @override
  _DetailuserState createState() => _DetailuserState();
}

class _DetailuserState extends State<Detailuser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Account'),
        centerTitle: true,
        backgroundColor: Mycon.dark,
      ),
      
    );
  }
}