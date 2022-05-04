

import 'package:flutter/material.dart';

class DoctorHomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>_DoctorHomePageState();

}
class _DoctorHomePageState extends State<DoctorHomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text(
          "Doctor homePage",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20
          ),
        ),
      ),
    );
  }

}