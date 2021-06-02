import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Color kGrey = Color(0xFF6c757d);
const Color kLightGrey = Color(0xFFedf2f4);
const Color kGreen = Color(0xFF1a936f);
const Color kPrimaryGreen = Color(0xFF66BB6A);
const Color kSelectedCategory = Color(0x2A1a936f);
const Color kBlue = Color(0xFF023e8a);
const Color kOrange = Color(0xFFe85d04);
const Color kYellow = Color(0xFFffba08);
const Color kPink = Color(0xFFe483eb);
const Color kUserProfileBackGround = Color(0xFF000000);
const Color kBlack = Color(0xFF000000);
const Color kBrownSoil = Color(0xFF3e3117);
const kDarkPrimaryColor = Color(0xFF212121);
const kDarkSecondaryColor = Color(0xFF373737);
const kLightPrimaryColor = Color(0xFFFFFFFF);
const kLightSecondaryColor = Color(0xFFF3F7FB);
const kAccentColor = Color(0xFFFFC107);

const kSpacingUnit = 10;

const TextStyle kGreetingsStyle = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
    fontSize: 30,
    height: 1.2,
    letterSpacing: 0.8);

const TextStyle kDefaultStyle = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w700,
  fontSize: 20,
);

const TextStyle kLoginHeading = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w700,
  fontSize: 25,
  color: Colors.black,
);

const TextStyle kTopHeadingStyle =
    TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 20);

const TextStyle kPlaceStyle = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w700,
  fontSize: 15,
  color: Colors.white,
);

const TextStyle kToolSelected = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w700,
  fontSize: 15,
  color: Colors.grey,
);

const TextStyle kToolNameStyleBlack = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w700,
  fontSize: 15,
  color: Colors.black45,
);

const TextStyle kProfileHeadersStyle = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
  fontSize: 15,
  color: Colors.black,
);

const TextStyle kProfileContent = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.normal,
  fontSize: 15,
  color: Colors.black,
);

const TextStyle kLabelStyleDefault = TextStyle(
  fontSize: 20,
  color: Colors.black,
);

final kTitleTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w600,
);

final kCaptionTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.3),
  fontWeight: FontWeight.w100,
);

final kButtonTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
  fontWeight: FontWeight.w400,
  color: kDarkPrimaryColor,
);

final kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'SFProText',
  primaryColor: kDarkPrimaryColor,
  canvasColor: kDarkPrimaryColor,
  backgroundColor: kDarkSecondaryColor,
  accentColor: kAccentColor,
  iconTheme: ThemeData.dark().iconTheme.copyWith(
        color: kLightSecondaryColor,
      ),
  textTheme: ThemeData.dark().textTheme.apply(
        fontFamily: 'SFProText',
        bodyColor: kLightSecondaryColor,
        displayColor: kLightSecondaryColor,
      ),
);

final kLightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'SFProText',
  primaryColor: kLightPrimaryColor,
  canvasColor: kLightPrimaryColor,
  backgroundColor: kLightSecondaryColor,
  accentColor: kAccentColor,
  iconTheme: ThemeData.light().iconTheme.copyWith(
        color: kDarkSecondaryColor,
      ),
  textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'SFProText',
        bodyColor: kDarkSecondaryColor,
        displayColor: kDarkSecondaryColor,
      ),
);
