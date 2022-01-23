import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

//*** STRINGS ***//
//Error Messages
const String kLoginErrorHeaderString =
    "Nom d'utilisateur ou mot de passe incorrect";
const String kLoginErrorBodyString =
    "Le nom d'utilisateur ou mot de passe saisi est incorrect.";
const String kNetworkErrorHeaderString = "Erreur réseau";
const String kNetworkErrorBodyString =
    "La connexion ne peut pas être établie avec le serveur.";

//AppBar
const String kAppBarPreviewString = 'Programme de la semaine';

//Login Page
const String kLoginPageHeaderString = "Connecte toi";
const String kLoginHintString = "Nom d'utilisateur";
const String kPasswordHintString = "Mot de passe";
const String kSignUpButtonString = "S'inscrire";
const String kSignInButtonString = "Se connecter";
const String kPasswordForgottenString = "Mot de passe oublié";
const String kForgottenPasswordUrlString = "https://i.imgflip.com/2mskjg.jpg";
const String kCreateAccountUrlString = "https://i.imgflip.com/2mskjg.jpg";
const String kLoginAlertButtonString = "OK";

//*** LITERALS ***//
const Color kPrimaryColor = Color(0xFFCD994C);
const Color kPrimaryDarkColor = Color(0xFF242424);
const Color kShadeDarkColor = Colors.black54;
const Color kTintDarkColor = Color(0xFF3A3A3A);

//*** STYLES ***//
//Login
const InputDecoration kLoginTextFieldStyle = InputDecoration(
  filled: true,
  fillColor: kShadeDarkColor,
  contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
  border: OutlineInputBorder(
      borderSide: BorderSide(color: kShadeDarkColor, width: 1.0)),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(30.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(30.0),
    ),
  ),
);

const TextStyle kLoginTextStyle = TextStyle(
  fontFamily: 'Abel',
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
);

const TextStyle kLoginHeaderStyle = TextStyle(
  fontSize: 25.0,
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.bold,
);

const TextStyle kLoginErrorHeaderStyle = TextStyle(
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.bold,
  fontSize: 20.0,
);

const TextStyle kLoginErrorBodyStyle = TextStyle(
  fontFamily: 'OpenSans',
  fontSize: 16.0,
);

const AlertStyle kLoginAlertStyle = AlertStyle(
  titleStyle: kLoginErrorHeaderStyle,
  titleTextAlign: TextAlign.start,
  descStyle: kLoginErrorBodyStyle,
  descTextAlign: TextAlign.start,
);

const TextStyle kAppBarTextStyle = TextStyle(
  fontSize: 20.0,
  fontFamily: 'OpenSans',
  color: Colors.white,
);

//Preview
const TextStyle kPreviewTitleTextStyle = TextStyle(
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.bold,
  fontSize: 22.0,
);

const TextStyle kPreviewSubtitleTextStyle = TextStyle(
  fontFamily: 'Abel',
  fontStyle: FontStyle.italic,
  fontSize: 19.0,
);

const TextStyle kPreviewBlocTitleTextStyle = TextStyle(
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const TextStyle kPreviewBlocSubtitleTextStyle = TextStyle(
  fontFamily: 'Abel',
  fontWeight: FontWeight.normal,
  fontStyle: FontStyle.italic,
  fontSize: 18.0,
);

const TextStyle kPreviewBlocContentTextStyle = TextStyle(
  fontFamily: 'OpenSans',
  fontSize: 16.0,
);

ButtonStyle kProgramButtonTextStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(0.0),
        topRight: Radius.circular(4.0),
        bottomLeft: Radius.circular(8.0),
        bottomRight: Radius.circular(0.0),
      ),
    ),
  ),
);
