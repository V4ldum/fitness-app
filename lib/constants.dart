import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

//*** STRINGS ***//
const String kLoginErrorHeaderString =
    "Nom d'utilisateur ou mot de passe incorrect";
const String kLoginErrorBodyString =
    "Le nom d'utilisateur ou mot de passe saisi est incorrect.";
const String kNetworkErrorHeaderString = "Erreur réseau";
const String kNetworkErrorBodyString =
    "La connexion ne peut pas être établie avec le serveur.";

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
const Color kSecondaryColor = Color(0x00000000); //TODO choisir ou retirer
const Color kSecondaryDarkColor = Colors.black54;

//*** STYLES ***//
const InputDecoration kLoginTextFieldStyle = InputDecoration(
  filled: true,
  fillColor: kSecondaryDarkColor,
  contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
  border: OutlineInputBorder(
      borderSide: BorderSide(color: kSecondaryDarkColor, width: 1.0)),
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
  fontFamily: "Abel",
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
