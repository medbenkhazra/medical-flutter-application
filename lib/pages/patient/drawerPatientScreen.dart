import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:health_app/pages/patient/menuPage.dart';
import 'package:health_app/pages/patient/patientContent.dart';

class DrawerPatientScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DrawerPatientScreenState();
}

class _DrawerPatientScreenState extends State<DrawerPatientScreen> {
  MenuItem currentItem = MenuItems.home;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      style: DrawerStyle.defaultStyle,
      borderRadius: 30,
      angle: -5,
      slideWidth: MediaQuery.of(context).size.width *0.6,
      menuBackgroundColor: Color(0xFF0857de),
      showShadow: true,
      mainScreenScale: 0,
      mainScreen: getScreen()!,
      menuScreen: Builder(
        builder: (context)=>MenuPage(
      
          currentItem: currentItem,
          onSelectedItem: (item) {
            setState(() {
              currentItem=item;
            });
            ZoomDrawer.of(context)!.close();
          },
        ),
      ),
    );
  }
  Widget ?getScreen(){
    switch(currentItem){
      case  MenuItems.home:
        return PatientContent();
        
      case  MenuItems.meeting:
      PatientContentState.selectedIndex=1;
        return PatientContent();
      case  MenuItems.calendar:
      PatientContentState.selectedIndex=2;
        return PatientContent();
      case  MenuItems.profile:
      PatientContentState.selectedIndex=3;
        return PatientContent();
        default:
    }

  }
}
