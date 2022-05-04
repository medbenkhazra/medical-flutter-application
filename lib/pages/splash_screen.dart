import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:health_app/pages/login_page.dart';

import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  late AnimationController _medicaleController;
  @override
  void initState() {
    super.initState();
    _medicaleController = AnimationController(vsync: this);
    _medicaleController.addStatusListener((status) {
      if (_medicaleController.value > 0.7) {
        _medicaleController.stop();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  final colorizeColors = [
  
  Colors.red,
  Colors.white
];

final colorizeTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Horizon',
);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Theme.of(context).accentColor, Colors.blue[400] as Color],
            begin: FractionalOffset(0, 0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          children: [
            SizedBox(
              height: 150.0,
            ),
              Lottie.asset("assets/lottie/91148-vital-signs.json",
              
              controller: _medicaleController, onLoaded: (Composition) {
            _medicaleController
              ..duration = Composition.duration
              ..forward();
          }),
          Row(
  mainAxisSize: MainAxisSize.min,
  children: <Widget>[
    
    DefaultTextStyle(
      style: TextStyle(fontSize: 43.0,
        fontFamily: 'Horizon' ),
      child: const Text(
        'HealthCare',
        
        ),
      ),
    
   
  ],
)
          ],
           
        ),
      ),
    );
  }
}
