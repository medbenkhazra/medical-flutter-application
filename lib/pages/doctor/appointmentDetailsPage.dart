import 'dart:convert';

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:health_app/helpers/constant.dart';
import 'package:health_app/models/AppointmentModel.dart';


import 'package:health_app/services/api_service.dart';
import 'package:health_app/theme/theme.dart';
import 'package:health_app/theme/extention.dart';
import 'package:health_app/widgets/imageWidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class AppointmentDetailsPage extends StatefulWidget {
  final AppointmentModel model;
  
  AppointmentDetailsPage({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppointmentDetailsPageState();
}

class AppointmentDetailsPageState extends State<AppointmentDetailsPage> {
  AppointmentModel? model;
  var isfavourite = false;
  var _selectedDateTime;
  var _resultDiagnostic;
  bool _descIsVisible=false;
  ApiService apiService = new ApiService();
  File? image = File('/storage/emulated/0/Download/brain.jpg');
  VoidCallback? onImageClicked;
  ValueChanged<ImageSource>? onClicked;
  File? imageTemporary;
  @override
  void initState() {
    model = widget.model;
    super.initState();
    _selectedDateTime = model!.date!;
    ApiService apiService=new ApiService();

    setState(() {
      checkPermissions();
      print("initial onclikced");
      //onClicked= (source)=>pickImage(source);
      // this.image!.path!="/storage/emulated/0/Download/man-388104_640.jpg";
    });
  }

  void checkPermissions() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  Widget _appbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        BackButton(
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  Future pickImage(ImageSource source) async {
    print("enter to fct");
    try {
      print("enter to Block");
      final image = await ImagePicker().pickImage(source: source);
      print("image picked");
      if (image == null) {
        print("image is null");
        return;
      }
      ;
      print("image is not null");
      // final imageTemporary = File(image.path);
      imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Faild to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyles.title.copyWith(fontSize: 25).bold;
    if (AppTheme.fullWidth(context) < 393) {
      titleStyle = TextStyles.title.copyWith(fontSize: 23).bold;
    }

    return Scaffold(
      backgroundColor: LightColor.extraLightBlue,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Image.memory(
              base64Decode(model!.patient!.photo!),
            ),
            DraggableScrollableSheet(
              maxChildSize: .8,
              initialChildSize: .6,
              minChildSize: .6,
              builder: (context, scrollController) {
                return Container(
                  height: AppTheme.fullHeight(context) * .5,
                  padding: EdgeInsets.only(
                    left: 19,
                    right: 19,
                    top: 16,
                  ), //symmetric(horizontal: 19, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    controller: scrollController,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Patient", style: titleStyle).vP16,
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "First name: ${model!.patient!.nom!}",
                                    style: GoogleFonts.openSans(fontSize: 18),
                                  ),
                                  Text(
                                    "Last name: ${model!.patient!.prenom!}",
                                    style: GoogleFonts.openSans(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Code : ${model!.patient!.code!}",
                                    style: GoogleFonts.openSans(fontSize: 18),
                                  ),
                                  Text(
                                    "Address :  ${model!.patient!.adresse!}",
                                    style: GoogleFonts.openSans(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Date of Birth : ${DateFormat('yyyy-MM-dd').format(model!.patient!.dateNaissance!)}",
                                    style: GoogleFonts.openSans(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Phone :  ${model!.patient!.telephone!}",
                                    style: GoogleFonts.openSans(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: LightColor.grey,
                            ),
                            Text("Request informations", style: titleStyle)
                                .vP16,
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Code : ${model!.code.toString()}",
                                    style: GoogleFonts.openSans(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Date : ${DateFormat('yyyy-MM-dd hh:mm a').format(_selectedDateTime)}",
                                    style: GoogleFonts.openSans(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: LightColor.grey,
                            ),
                            Text("Make check", style: titleStyle).vP16,
                            Container(
                              height: 300,
                              decoration: BoxDecoration(
                                  // color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.white)),
                                    width: 400.0,
                                    height: 300.0,
                                    child: Container(
                                        child: ImageWidget(
                                            image: image!,
                                            onClicked: (source) =>
                                                pickImage(source))),
                                  )),
                            ),
                            Center(
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextButton(
                                  onPressed: () async {
                                      //AI AWS

                                    List<int> imageBytes =
                                        this.image!.readAsBytesSync();
                                        print("***************");
                                    print(imageBytes);
                                    String base64Image =base64Encode(imageBytes);
                                    print("******base64 encoded**********");
                                   // debugPrint(base64Image);
                                    print("fesf");
                                    print(base64Image);
                                    

                                    var res=await apiService.getDiagnosticResult(base64Image);
                                    print(res.statusCode);
                                    var data=json.decode(res.body);
                                    print("this is the data response");
                                    print(data);
                                    Map responseMap = json.decode(res.body);
                                    responseMap.forEach((k, v) => print('$k: $v'));
                                    setState(() {
                                      _resultDiagnostic=responseMap['description'];
                                      _descIsVisible=true;
                                    });
                                      _descIsVisible=true;


                                  },
                                  child: Text(
                                    "Diagnostic",
                                    style: TextStyles.titleNormal.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            /* Visibility(
                              visible: _descIsVisible,
                              child: */ Center(
                                child: Text(
                                  
                                  //AI AWS
                                  _resultDiagnostic==null?"...":_resultDiagnostic,
                                  style: GoogleFonts.openSans(
                                    color: Colors.red,
                                    fontSize: 30
                                  ),
                                ),
                              ),
                          //  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            _appbar(),
          ],
        ),
      ),
    );
  }

  Future<ImageSource?> showImageSource(BuildContext context) {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<ImageSource>(
          context: context,
          builder: (context) => CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                    child: Text("camera"),
                    onPressed: () =>
                        Navigator.of(context).pop(ImageSource.camera),
                  ),
                  CupertinoActionSheetAction(
                    child: Text("gallery"),
                    onPressed: () =>
                        Navigator.of(context).pop(ImageSource.gallery),
                  ),
                ],
              ));
    } else {
      return showModalBottomSheet(
          context: context,
          builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text("camera"),
                      onTap: () =>
                          Navigator.of(context).pop(ImageSource.camera)),
                  ListTile(
                      leading: Icon(Icons.image),
                      title: Text("gallery"),
                      onTap: () =>
                          Navigator.of(context).pop(ImageSource.gallery)),
                ],
              ));
    }
  }
}
