import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:health_app/pages/login_page.dart';
import 'package:health_app/pages/patient/components/MenuWidgets.dart';
import 'package:health_app/pages/patient/components/body.dart';
import 'package:get/get.dart';
import 'package:health_app/services/api_service.dart';

class PatientHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PatientHomePageState();
}

class PatientHomePageState extends State<PatientHomePage> {
  Image? image;
  bool? _loadingInProgress;
  //ApiService apiService = new ApiService();

  //Timer? _timer;
  //late double _progress;

  @override
  void initState() {
    //stop();
    
        
      
    
   /*  getDoctors().then((Doctorsdata) {
      setState(() {
        PatientHomePageState.Doctorsdata = Doctorsdata;
      });
    }); */

    super.initState();

    // Codec<String, String> stringToBase64 = utf8.fuse(base64);

    // Uint8List _image = base64Decode(imagenJson);
    //  image = Image.memory(_image,
    // fit: BoxFit.fill,);
    /*    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    }); */
    //EasyLoading.showSuccess('Use in initState');
    // _loadingInProgress = true;
    // displayImage();
  }

  

 

  void displayImage() async {
    print("entred to displayImage");
    //delay
    /*    await Future.delayed(const Duration(seconds: 10), () async {
      print(LoginPageState.currentUserData);
      // EasyLoading.show(status: 'loading...');
      var blob = await LoginPageState.currentUserData['image_url'];
      // EasyLoading.showSuccess('Great Success!');
      print("//////////////this is the blob////");
      print(blob);
      //image =  Base64Codec().decode(blob);
      print("//////////////this is the image decoded on base 64////");
      print(image);
      // EasyLoading.dismiss();
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 7, 7, 0),
              child: FloatingActionButton.small(
                onPressed: () {},
                child: ClipOval(
                    child: Image.asset(
                  "assets/images/person.jpeg",
                )),
              ),
            ),
          ],
          backgroundColor: Color(0xFF0857de),
          elevation: 0,
          leading: MenuWidget()),
      body: Body(),
    );
  }

/*   AppBar buildAppBar() {
    return AppBar(
      actions: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 7, 7, 0),
          child: FloatingActionButton.small(
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
            child: ClipOval(
                child: Image.asset(
              "assets/images/person.jpeg",
            )),
          ),
        ),
      ],
      backgroundColor: Color(0xFF0857de),
      elevation: 0,
      leading: IconButton(
        color: Colors.white,
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {},
      ),
    );
  } */
}
