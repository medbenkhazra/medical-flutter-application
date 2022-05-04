import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_app/pages/patient/PatientHomePage.dart';
import 'package:health_app/pages/patient/menuPage.dart';
import 'package:health_app/pages/profile_page.dart';

final drawerController = new ZoomDrawerController();

class PatientContent extends StatefulWidget {
  


  @override
  State<StatefulWidget> createState() => PatientContentState();
}

class PatientContentState extends State<PatientContent> {
 // static int selectedMenuItemIndex=0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
   
    // TODO: implement initState
    super.initState();
  }

  List<Widget> _pages = [
   /*  Scaffold(
      body: ZoomDrawer(
        style: DrawerStyle.style1,
        angle: -10,
        borderRadius: 50,
        slideWidth: MediaQuery.of(context).size.width * 0.8,
        drawerShadowsBackgroundColor: Colors.orangeAccent,
        controller: drawerController,
        mainScreen: PatientHomePage(),
        menuScreen: MenuPage(),
        menuBackgroundColor: Color(0xFF0857de),
      ),
    ), */
    PatientHomePage(),
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
