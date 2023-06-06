import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:health_app/pages/login_page.dart';
import 'package:health_app/services/api_service.dart';

class MenuItem {
  final String title;
  final FaIcon icon;
  const MenuItem({
    required this.title,
    required this.icon,
  });
}

class MenuItems {
  static const home =
      MenuItem(title: 'Home', icon: FaIcon(FontAwesomeIcons.house));
  static const meeting =
      MenuItem(title: 'Meeting', icon: FaIcon(FontAwesomeIcons.clock));
  static const calendar =
      MenuItem(title: 'Calendar', icon: FaIcon(FontAwesomeIcons.calendar));
  static const profile =
      MenuItem(title: 'Profile', icon: FaIcon(FontAwesomeIcons.user));

  static var all = <MenuItem>[home, meeting, calendar, profile];
}

class MenuPageSecretaire extends StatefulWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  const MenuPageSecretaire({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => MenuPageSecretaireState(key: key,currentItem: currentItem,onSelectedItem: onSelectedItem);
}

class MenuPageSecretaireState extends State<MenuPageSecretaire> {
//class MenuPage extends StatelessWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;
    MenuPageSecretaireState({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem,
  });
  var username;
  static var userData;
  //static var userName;
  

  ApiService apiService = new ApiService();
  @override
  void initState() {
    
    super.initState();
    getActualUser().then((userData) {
      
     setState(() {
       username=userData['login'];
     });
      print("**************the actual user is ${username}");
      
      
    });

  }
   Future getActualUser() async {
    var res = await apiService.getMyProfile();
    userData = json.decode(res.body);

    return userData;
  }

  //var fullname;
 /*  const MenuPage({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem,
  }) : super(key: key); */

  void mergeNames() async {
    //  var firstname = await LoginPageState.storage.read(key: 'firstName');
    // var lastname = await LoginPageState.storage.read(key: 'lastName');
    //var firstname=LoginPageState.currentUserData['firstName'];
    //var lastname=LoginPageState.currentUserData['lastName'];
    //print("first name is $firstname");
    //print("last name is $lastname");
    // setState(() {
    //   fullname = "$firstname $lastname";
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0857de),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 70,
            ),
            Container(
              width: 150,
              height: 150,
              margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
              padding: EdgeInsets.fromLTRB(0, 5, 80, 0),
              child: FloatingActionButton.large(
                heroTag: "btn2",
                onPressed: () {},
                child: ClipOval(
                    child: 
                     FutureBuilder(
                          future: apiService.getSecretaireOfUser(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return CircularProgressIndicator();// your widget while loading
                            }

                            if (!snapshot.hasData) {
                              return Container(); //your widget when error happens
                            }

                            var res = snapshot.data; //your Map<String,dynamic>
                            var data=json.decode(res.body); 

                            return ClipOval(
                                child: Image.memory(
                              base64Decode(
                                  data['photo'].toString()),
                            )
                            ); //place your widget here
                          },
                        )
                )
                /* ClipOval(
                    child: Image.asset(
                  "assets/images/person.jpeg",
                )) */
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(17, 0, 0, 20),
              child: Text(
                (username!=null)?"${username}":"unknown user",
                style: GoogleFonts.openSans(
                  color: Colors.white60,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            //Spacer(),
            ...MenuItems.all.map(buildMenuItem).toList(),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false);
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                    side: MaterialStateProperty.all(BorderSide(
                        color: Colors.white,
                        width: 1.0,
                        style: BorderStyle.solid))),
                icon: FaIcon(
                  FontAwesomeIcons.unlock,
                  color: Colors.white,
                ),
                label: Text(
                  'LogOut',
                  style: GoogleFonts.montserrat(color: Colors.white),
                ),
              ),
            )
          ],
        ),
        /* child:  ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 5, 80, 0),
              child: FloatingActionButton.large(
                heroTag: "btn2",
                onPressed: () {},
                child: ClipOval(
                    child: Image.asset(
                  "assets/images/person.jpeg",
                )),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 15, 0, 30),
              child: Text(
                (fullname != null) ? fullname : "unknown user",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
             
              selectedTileColor: Colors.black26,
              iconColor: Colors.white,
              textColor: Colors.white,
              leading: FaIcon(FontAwesomeIcons.house),
              title: Text(
                "Home",
                style: GoogleFonts.montserrat(),
              ),
            ),
            ListTile(
              iconColor: Colors.white,
              textColor: Colors.white,
              leading: FaIcon(FontAwesomeIcons.clock),
              title: Text(
                "Meeting",
                style: GoogleFonts.montserrat(),
              ),
            ),
            ListTile(
              iconColor: Colors.white,
              textColor: Colors.white,
              leading: FaIcon(FontAwesomeIcons.calendar),
              title: Text(
                "Calendar",
                style: GoogleFonts.montserrat(),
              ),
            ),
            ListTile(
              iconColor: Colors.white,
              textColor: Colors.white,
              leading: FaIcon(FontAwesomeIcons.user),
              title: Text(
                "Profile",
                style: GoogleFonts.montserrat(),
              ),
            ),
            
          ],
        ) */
      ),
    );
  }

  

  Widget buildMenuItem(MenuItem item) => ListTileTheme(
        selectedColor: Colors.white,
        child: ListTile(
          selectedTileColor: Colors.black26,
          selected: currentItem == item,
          minLeadingWidth: 20,
          leading: item.icon,
          title: Text(item.title),
          iconColor: Colors.white,
          textColor: Colors.white,
          onTap: () {
            onSelectedItem(item);
          },
        ),
      );
}
