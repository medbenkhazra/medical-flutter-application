import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_app/pages/login_page.dart';

import 'package:health_app/pages/secretaire/components/menuPageSecretaire.dart';
import 'package:health_app/pages/secretaire/secretaireContent.dart';
import 'package:health_app/services/api_service.dart';

class DrawerSecretaireScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DrawerSecretaireScreenState();
}

class DrawerSecretaireScreenState extends State<DrawerSecretaireScreen> {
  MenuItem currentItem = MenuItems.home;
  static var userData;
  static var idSecretaire;
  //static var userName;

  ApiService apiService = new ApiService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getActualUser().then((userData) {
      print("the actual user is ${userData}");
      storeUser();
      setState(() {
        LoginPageState.username;
      });
    });
  }

  void storeUser() async {
    await LoginPageState.storage
        .write(key: 'id', value: userData['id'].toString());
    await LoginPageState.storage.write(key: 'login', value: userData['login']);
    await LoginPageState.storage
        .write(key: 'firstName', value: userData['firstName']);
    await LoginPageState.storage
        .write(key: 'lastName', value: userData['lastName']);
    await LoginPageState.storage.write(key: 'email', value: userData['email']);
    await LoginPageState.storage
        .write(key: 'authorities', value: userData['authorities'].toString());

    LoginPageState.username = await LoginPageState.storage.read(key: 'login');
    LoginPageState.firstName =
        await LoginPageState.storage.read(key: 'firstName');
    LoginPageState.lastName =
        await LoginPageState.storage.read(key: 'lastName');
    print('this is the username ${LoginPageState.username}');
    print('this is the firstname ${LoginPageState.firstName}');
    print('this is the lastname ${LoginPageState.lastName}');
  }

  Future getActualUser() async {
    var res = await apiService.getMyProfile();
    userData = json.decode(res.body);

    return userData;
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      style: DrawerStyle.defaultStyle,
      borderRadius: 30,
      angle: -5,
      slideWidth: MediaQuery.of(context).size.width * 0.6,
      menuBackgroundColor: Color(0xFF0857de),
      showShadow: true,
      mainScreenScale: 0,
      mainScreen: getScreen()!,
      menuScreen: Builder(
        builder: (context) => MenuPageSecretaire(
          currentItem: currentItem,
          onSelectedItem: (item) {
            setState(() {
              currentItem = item;
            });
            ZoomDrawer.of(context)!.close();
          },
        ),
      ),
    );
  }

  Widget? getScreen() {
    switch (currentItem) {
      case MenuItems.home:
        return SecretaireContent();

      case MenuItems.meeting:
        SecretaireContentState.selectedIndex = 1;
        return SecretaireContent();
      case MenuItems.calendar:
        SecretaireContentState.selectedIndex = 2;
        return SecretaireContent();
      case MenuItems.profile:
        SecretaireContentState.selectedIndex = 3;
        return SecretaireContent();
      default:
    }
  }
}
