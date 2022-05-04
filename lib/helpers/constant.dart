import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  Constants._();
  static const BASE_URL = 'http://10.0.2.2:8080/api';

  // Colors that we use in our app
  static const kPrimaryColor = Color(0xFF0C9869);
  static const kTextColor = Color(0xFF3C4046);
  static const kBackgroundColor = Color(0xFFF9F8FD);

  static const double kDefaultPadding = 20.0;
}
const kGrey1Color = Color(0xFFF3F3F3);
const kGrey2Color = Color(0xFFA9A8A8);
const kBlue1Color = Color(0xFF40BEEE);
const kBlue2Color = Color(0xFFD9F2FC);
const kRedColor = Color(0xFFED5568);
const kYellowColor = Color(0xFFFFB755);
const kGreenColor = Color(0xFFDBF3E8);
const kGreen2Color = Color(0xFF58c697);

var kTitleStyle = GoogleFonts.lato(
  textStyle: TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
);
var kSubtitleStyle = GoogleFonts.lato(
  textStyle: TextStyle(
    fontSize: 16.0,
    color: kGrey2Color,
  ),
);
var kButtonStyle = GoogleFonts.lato(
  textStyle: TextStyle(
    fontSize: 13.0,
    color: Colors.white,
  ),
);
var kCategoryStyle = GoogleFonts.lato(
  textStyle: TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w300,
    color: Colors.black,
  ),
);
var kRatingStyle = GoogleFonts.lato(
  textStyle: TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w400,
    color: kGrey2Color,
  ),
);
var kSubtitle2Style = GoogleFonts.lato(
  textStyle: TextStyle(
    fontSize: 14.0,
  ),
);
class LightColor {
  static const Color background = Color(0XFFfefefe);

  static const Color titleTextColor = const Color(0xff1b1718);
  static const Color subTitleTextColor = const Color(0xffb9bfcd);

  static const Color skyBlue = Color(0xff71b4fb);
  static const Color lightBlue = Color(0xff7fbcfb);
  static const Color extraLightBlue = Color(0xffd9eeff);

  static const Color orange = Color(0xfffa8c73);
  static const Color lightOrange = Color(0xfffa9881);

  static const Color purple = Color(0xff8873f4);
  static const Color purpleLight = Color(0xff9489f4);
  static const Color purpleExtraLight = Color(0xffb1a5f6);

  static const Color grey = Color(0xffb8bfce);

  static const Color iconColor = Color(0xffcbd0db);
  static const Color green = Color(0xff4cd1bc);
  static const Color lightGreen = Color(0xff5ed6c3);

  static const Color black = Color(0xff20262C);
  static const Color lightblack = Color(0xff5F5F60);
}
/* extension TextStyleHelpers on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get white => copyWith(color: Colors.white);
  TextStyle get subTitleColor => copyWith(color: LightColor.subTitleTextColor);
} */
class FontSizes {
  static double scale = 1.2;
  static double get body => 14 * scale;
  static double get bodySm => 12 * scale;
  static double get title => 16 * scale;
  static double get titleM => 18 * scale;
  static double get sizeXXl => 28 * scale;
}

class TextStyles {
  static TextStyle get title =>TextStyle(fontSize: FontSizes.title);
  static TextStyle get titleM =>TextStyle(fontSize: FontSizes.titleM);
  static TextStyle get titleNormal => title.copyWith(fontWeight: FontWeight.w500);
  static TextStyle get titleMedium => titleM.copyWith(fontWeight: FontWeight.w300);
  static TextStyle get h1Style => TextStyle(fontSize: FontSizes.sizeXXl, fontWeight: FontWeight.bold);
 
  static TextStyle get body => TextStyle(fontSize: FontSizes.body, fontWeight: FontWeight.w300);
  static TextStyle get bodySm => body.copyWith(fontSize: FontSizes.bodySm);
}
/* extension PaddingHelper on Widget {
  Padding get p16 => Padding(padding: EdgeInsets.all(16), child: this);

  /// Set padding according to `value`
  Padding p(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  /// Horizontal Padding 16
  Padding get hP4 =>
      Padding(padding: EdgeInsets.symmetric(horizontal: 4), child: this);
  Padding get hP8 =>
      Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: this);
  Padding get hP16 =>
      Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: this);
  Padding get hP20 =>
      Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: this);

  /// Vertical Padding 16
  Padding get vP16 => Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: this,
      );
  Padding get vP8 => Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: this,
      );
  Padding get vP4 => Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: this,
      );
} */
