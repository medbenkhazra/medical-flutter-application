import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_app/helpers/constant.dart';
import 'package:health_app/models/doctor_model.dart';
import 'package:health_app/pages/patient/components/appointmentPage.dart';
import 'package:health_app/theme/theme.dart';
import 'package:health_app/theme/extention.dart';

class DoctorDetailsPage extends StatefulWidget {
  final DoctorModel model;
  DoctorDetailsPage({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => DoctorDetailsPageState();
}

class DoctorDetailsPageState extends State<DoctorDetailsPage> {
  DoctorModel? model;
  var isfavourite = false;

  @override
  void initState() {
    model = widget.model;
    super.initState();
  }

  Widget _appbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        BackButton(
          color: Colors.white,
        ),
        IconButton(
          icon: Icon(
            isfavourite ? Icons.favorite : Icons.favorite_border,
            color: isfavourite ? Colors.red : LightColor.grey,
          ),
          onPressed: () {},
        )
      ],
    );
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                //# colors : 5c8fe6 86acec 417ee4
                color: Color(0xFF417ee4),
              ),
              child: Image.memory(
                base64Decode(model!.photo),
              ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        
                          
                           Container(
                             alignment: Alignment.topLeft,
                             margin: EdgeInsets.only(right: 50),
                             child: ListTile(
                               
                              
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Dr ${model!.nom} ${model!.prenom}",
                                    style: titleStyle,
                                  ),
                                  SizedBox(
                                    width: 10,
                           
                                  ),
                                  Icon(
                                    Icons.check_circle,
                                    size: 18,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  Spacer(),
                                ],
                              ),
                              subtitle: Text(
                                model!.type,
                                style: TextStyles.bodySm.subTitleColor.bold,
                              ),
                                                     ),
                           ),
                       
                        Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 3,horizontal: 15),
                          
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Expert level : ${model!.expertLevel}",
                                style: GoogleFonts.montserrat(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 3,horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Number of patients : ${model!.nbrPatients}",
                                style: GoogleFonts.montserrat(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 3,horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                               Text("Rating : ",
                              style: GoogleFonts.montserrat(
                                fontSize: 18
                              ),
                              ),
                              RatingBar.builder(
                                itemSize: 22,
                                initialRating: model!.rating.toDouble() ,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              )
                            ],
                          ),
                        ),
                        Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                        Container(
                          child: Text("About", style: titleStyle).vP16,
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            model!.description,
                            style: TextStyles.body.subTitleColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: LightColor.grey.withAlpha(150),
                              ),
                              child: Icon(
                                Icons.call,
                                color: Colors.white,
                              ),
                            ).ripple(
                              () {},
                              borderRadius: BorderRadius.circular(10),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: LightColor.grey.withAlpha(150),
                              ),
                              child: Icon(
                                Icons.chat_bubble,
                                color: Colors.white,
                              ),
                            ).ripple(
                              () {},
                              borderRadius: BorderRadius.circular(10),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return AppointmentPage(model: model!);
                                  }));
                                },
                                child: Text(
                                  "Make an appointment",
                                  style: TextStyles.titleNormal.white,
                                ),
                              ),
                            ),
                          ],
                        ).vP16
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
}
