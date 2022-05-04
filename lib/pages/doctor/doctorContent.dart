import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_app/pages/doctor/doctorHomePage.dart';

import 'package:health_app/pages/profile_page.dart';

class DoctorContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DoctorContentState();
}

class _DoctorContentState extends State<DoctorContent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _pages = [
    DoctorHomePage(),
    Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
          child: DefaultTextStyle(
              style: TextStyle(color: Colors.blue, fontSize: 20),
              child: Text(
                "meeting screen ",
                style: GoogleFonts.openSans(),
              )),
        )]),
      ),
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
          body: _pages[_selectedIndex],
          bottomNavigationBar: SizedBox(
            height: 70,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color(0xFF0857de),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withOpacity(.60),
              selectedFontSize: 14,
              unselectedFontSize: 14,
              currentIndex: _selectedIndex,
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
                  icon: FaIcon(FontAwesomeIcons.userDoctor),
                ),
              ],
            ),
          )
          /* bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          
          items: [
            BottomNavigationBarItem(

              icon: FaIcon(FontAwesomeIcons.houseMedical),
              label: "Home",
              backgroundColor: Colors.blue[800]
               ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user),
              label: "Home",
              backgroundColor: Colors.blue[800]
               ),
          ]), */
          ),
    );
  }
}
