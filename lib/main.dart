import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:health_app/animation/animation.dart';
import 'package:health_app/pages/splash_screen.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(const MyApp());
 // configLoading();
}
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 9000000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
   // ..customAnimation = CustomAnimation();
}


Color  _primaryColor=HexColor("#0857DE");
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    //  builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'health flutter application',
      theme: ThemeData(
      primaryColor: _primaryColor,
      accentColor: HexColor("#0857DE"),
      scaffoldBackgroundColor: Colors.grey.shade100,
      primarySwatch: Colors.blue,
    
      ),
      home:  SplashScreen(title: 'splash screen'),
    );
  }
}