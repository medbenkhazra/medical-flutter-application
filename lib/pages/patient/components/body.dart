import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:health_app/helpers/constant.dart';
import 'package:health_app/models/data.dart';
import 'package:health_app/models/doctor_model.dart';
import 'package:health_app/pages/patient/PatientHomePage.dart';
import 'package:health_app/pages/patient/components/header_with_searchBox.dart';
import 'package:health_app/pages/patient/components/recommendation.dart';
import 'package:health_app/pages/patient/patientContent.dart';
import 'package:health_app/services/api_service.dart';
import 'package:health_app/theme/extention.dart';

import 'title_with_more_bbtn.dart';

//class Body extends StatelessWidget {
class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<DoctorModel>? doctorDataList;
  Image? image;
  ApiService apiService = new ApiService();
  var Doctorsdata;
  bool _isVisible=false;
  @override
  void initState() {

    super.initState();
    getDoctors().then((Doctorsdata) {
       Codec<String, String> stringToBase64 = utf8.fuse(base64);
      print("premier element **/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/");
      print(Doctorsdata[0]);
      print("photo de premier element **/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/");
      print(Doctorsdata[0]['photo']);
      Uint8List _image = base64Decode(Doctorsdata[0]['photo']);
      setState(() {
           // doctorDataList = Doctorsdata.map((x) => DoctorModel.fromJson(x)).toList();
           doctorDataList = (Doctorsdata as List<dynamic>).map((x) => DoctorModel.fromJson(x)).toList();
            _isVisible=!_isVisible;
        /* image = Image.memory(
          _image,
          fit: BoxFit.fill,
        ); */
      });

    } );

  }

/*   @override
  void initState() {
    doctorDataList = doctorMapList.map((x) => DoctorModel.fromJson(x)).toList();
    super.initState();
    //delay();

    getDoctors().then((value) => null);

    Future.delayed(Duration(seconds: 5)).then((value) {
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      print("premier element ");
      print(Doctorsdata[0]);
      print("photo de premier element ");
      print(Doctorsdata[0]['photo']);
      Uint8List _image = base64Decode(Doctorsdata[0]['photo']);
      setState(() {
        image = Image.memory(
          _image,
          fit: BoxFit.fill,
        );
      });
    });
  } */

  Future getDoctors() async {
    var res = await apiService.getDoctors();
    Doctorsdata = json.decode(res.body);
    print(res.statusCode);
    print("lisst od doctors !!!!!!!!!!!!!!!");
    print(Doctorsdata);
    return Doctorsdata;
  }

  void delay() async {
    await Future.delayed(const Duration(seconds: 10), () {});
  }

  Color randomColor() {
    var random = Random();
    final colorList = [
      Theme.of(context).primaryColor,
      LightColor.orange,
      LightColor.green,
      LightColor.grey,
      LightColor.lightOrange,
      LightColor.skyBlue,
      LightColor.titleTextColor,
      Colors.red,
      Colors.brown,
      LightColor.purpleExtraLight,
      LightColor.skyBlue,
    ];
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }

  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          // TitleWithMoreBtn(title: "Doctors", press: () {}),
          Recomendation(),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Doctors", style: TextStyles.title.bold),
              IconButton(
                  icon: Icon(
                    Icons.sort,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {})
              // .p(12).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
            ],
          ).hP16,
          SizedBox(
            height: 20,
          ),
          getdoctorWidgetList(),
         /*  Container(
            child: (image != null)
                ? image
                : FlutterLogo(
                    size: 20,
                  ),
          ), */

          //SizedBox(height: Constants.kDefaultPadding),
        ],
      ),
    );
  }

  Widget getdoctorWidgetList() {
    return Visibility(
      visible: _isVisible,
      child: Column(
          children: (doctorDataList!=null) ?doctorDataList!.map((x) {
        return _doctorTile(x);
      }
      ).toList(): [Text('data not loaded yet'),
    Text('data not loaded yet'),]
      ),
    );
  }

  Widget _doctorTile(DoctorModel model) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 10,
            color: LightColor.grey.withOpacity(.2),
          ),
          BoxShadow(
            offset: Offset(-3, 0),
            blurRadius: 15,
            color: LightColor.grey.withOpacity(.1),
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                //possible colors : 5c8fe6 86acec 417ee4
                color: Color(0xFF417ee4),
              ),
              child: Image.memory(
                base64Decode(model.photo),
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text("Dr ${model.nom} ${model.prenom}", style: TextStyles.title.bold),
          subtitle: Text(
            model.type,
            style: TextStyles.bodySm.subTitleColor.bold,
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ).ripple(
        () {
          Navigator.pushNamed(context, "/DetailPage", arguments: model);
        },
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}
