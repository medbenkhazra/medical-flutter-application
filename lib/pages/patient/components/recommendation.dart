import 'package:flutter/material.dart';
import 'package:health_app/helpers/constant.dart';

class Recomendation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecomendationState();
}

class _RecomendationState extends State<Recomendation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150.0,
      margin: EdgeInsets.symmetric(horizontal: 18.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Color(0xFF0857de),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 15.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Do you have symptoms\nof Brain cancer?",
                    style: kTitleStyle,
                  ),
                  Spacer(),
                  RaisedButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    color: Colors.red,
                    elevation: 2.0,
                    child: SizedBox(
                      width: 150.0,
                      height: 50.0,
                      child: Center(
                        child: Text(
                          "Contact a doctor",
                          
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Image.asset(
            "assets/images/doctor11.png",
            fit: BoxFit.contain,
          ),
          SizedBox(width: 15.0),
        ],
      ),
    );
  }
}
