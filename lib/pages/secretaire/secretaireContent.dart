import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_app/pages/patient/PatientHomePage.dart';
import 'package:health_app/pages/profile_page.dart';
import 'package:health_app/pages/secretaire/secretaireHomePage.dart';

class SecretaireContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SecretaireContentState();
}

class SecretaireContentState extends State<SecretaireContent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> _pages = [
    SecretaireHomePage(),
    Scaffold(
      body: DefaultTextStyle(
          style: TextStyle(color: Colors.blue, fontSize: 20),
          child: Text("meeting screen")),
    ),
    Scaffold(
      body: DefaultTextStyle(
          style: TextStyle(color: Colors.blue, fontSize: 20),
          child: Text("add calendar")),
    ),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          key: _scaffoldKey,
          body: _pages[selectedIndex],
          bottomNavigationBar: SizedBox(
            height: 70,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color(0xFF0857de),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withOpacity(.60),
              selectedFontSize: 14,
              unselectedFontSize: 14,
              currentIndex: selectedIndex,
              onTap: _onItemTapped,
              items: [
                BottomNavigationBarItem(
                  label: 'home',
                  icon: FaIcon(FontAwesomeIcons.house),
                ),
                BottomNavigationBarItem(
                  label: 'meeting',
                  icon: FaIcon(FontAwesomeIcons.clock),
                ),
                BottomNavigationBarItem(
                  label: 'calender',
                  icon: FaIcon(FontAwesomeIcons.calendar),
                ),
                BottomNavigationBarItem(
                  label: 'profile',
                  icon: FaIcon(FontAwesomeIcons.user),
                ),
              ],
            ),
          )
        
          ),
    );
  }
}
