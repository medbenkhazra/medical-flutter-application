

import 'package:flutter/material.dart';

class SecretaireHomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>_SecretaireHomePageState();

}
class _SecretaireHomePageState extends State<SecretaireHomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text(
          "Secretaire homePage",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20
          ),
        ),
      ),
    );
  }

}