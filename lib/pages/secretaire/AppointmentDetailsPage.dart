import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_app/helpers/constant.dart';
import 'package:health_app/models/AppointmentModel.dart';
import 'package:health_app/models/doctor_model.dart';
import 'package:health_app/pages/patient/components/appointmentPage.dart';
import 'package:health_app/pages/secretaire/secretaireHomePage.dart';
import 'package:health_app/services/api_service.dart';
import 'package:health_app/theme/theme.dart';
import 'package:health_app/theme/extention.dart';
import 'package:intl/intl.dart';

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
  ApiService apiService = new ApiService();
  @override
  void initState() {
    model = widget.model;
    super.initState();
    _selectedDateTime = model!.date!;
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
                                    "Name : ${model!.patient!.nom!}",
                                    style: GoogleFonts.openSans(fontSize: 18),
                                  ),
                                  Text(
                                    "Prenom : ${model!.patient!.prenom!}",
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
                            //doctor
                            Divider(
                              thickness: .3,
                              color: LightColor.grey,
                            ),
                            Text("Doctor", style: titleStyle).vP16,
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Name : ${model!.medecin!.nom!.toString()}",
                                    style: GoogleFonts.openSans(fontSize: 18),
                                  ),
                                  Text(
                                    "Prenom : ${model!.medecin!.prenom!.toString()}",
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
                                    "Expert level : ${model!.medecin!.expertLevel!.toString()}",
                                    style: GoogleFonts.openSans(fontSize: 18),
                                  ),
                                  Text(
                                    "Num Emlpoye :  ${model!.medecin!.numEmp!.toString()}",
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
                                    "code : ${model!.medecin!.code!.toString()}",
                                    style: GoogleFonts.openSans(fontSize: 18),
                                  ),
                                  Text(
                                    "Rating : ${model!.medecin!.rating!.toStringAsFixed(2)}",
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
                                    "Number of Patients :  ${model!.medecin!.nbrPatients!.toString()}",
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
                                    "Status : ${model!.status}",
                                    style: GoogleFonts.openSans(
                                        fontSize: 20, color: Colors.red),
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
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    child: Text(
                                      "change the date",
                                      style: GoogleFonts.montserrat(
                                          color: Color(0xFF0857de)),
                                    ),
                                    onTap: () {
                                      DatePicker.showDateTimePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime.now(),
                                          maxTime: DateTime(2025, 6, 7),
                                          onChanged: (date) {
                                        print('change $date');
                                      }, onConfirm: (date) {
                                        setState(() {
                                          model!.date = date;
                                        });

                                        print(
                                            "this is the date inside the funct");
                                        print(date);
                                        print(model!.date!);
                                        print('confirm $date');
                                        setState(() {
                                          _selectedDateTime = date;
                                        });
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.en);
                                    },
                                  ),
                                  /* OutlinedButton(onPressed: (){},
                                 child: Text(
                                   "change the date",
                                   style: GoogleFonts.montserrat(
                                     color: Colors.white,
                                     fontSize: 15
                                   ),
                                 ),
                                 style: ButtonStyle(
                                   backgroundColor: MaterialStateProperty.resolveWith((states) => Color(0xFF0857de)),
                                 ),
                                 ) */
                                ],
                              ),
                            ),

                            /* Text(
                            model!.description,
                            style: TextStyles.body.subTitleColor,
                          ), */
                            //accept or not
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 5),
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextButton(
                                      onPressed: () {
                                        apiService.AcceptAppointement(model!);
                                        //  Navigator.of(context).pop(context);
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    SecretaireHomePage()));
                                      },
                                      child: Text(
                                        "Accept",
                                        style: TextStyles.titleNormal.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextButton(
                                      onPressed: () {
                                        apiService.RefuseAppointement(model!);
                                        //  Navigator.of(context).pop(context);
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    SecretaireHomePage()));
                                        /*  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                         return AppointmentPage(model: model!);
                                      }
                                      )
                                      ); */
                                      },
                                      child: Text(
                                        "Refuse",
                                        style: TextStyles.titleNormal.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5),
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextButton(
                                      onPressed: () {
                                        apiService.AdjournAppointement(model!);
                                        // Navigator.of(context).pop(context);
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    SecretaireHomePage()));
                                        /*  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                         return AppointmentPage(model: model!);
                                      }
                                      )
                                      ); */
                                      },
                                      child: Text(
                                        "Adjourn",
                                        style: TextStyles.titleNormal.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ).vP16
                          ],
                        )
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
