import 'package:fitness_app/config/index.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'alert_button.dart';

class PopupAlert {
  PopupAlert._();

  static Alert open({
    required BuildContext context,
    String? title,
    String? desc,
    List<AlertButton>? buttons,
  }) {
    List<DialogButton> alertButtons = [];

    buttons?.forEach((AlertButton element) {
      alertButtons.add(
        DialogButton(
          onPressed: element.onPressed,
          color: Palette.accent,
          child: Text(
            element.text,
            style: const TextStyle(
              fontFamily: Fonts.secondaryRegular,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: Palette.primary,
            ),
          ),
        ),
      );
    });

    return Alert(
      context: context,
      closeIcon: const Icon(
        Icons.close,
        color: Palette.accent,
      ),
      title: title,
      desc: desc,
      style: const AlertStyle(
        titleStyle: TextStyle(
          fontFamily: Fonts.primarySemiBold,
          fontSize: 20.0,
        ),
        titleTextAlign: TextAlign.start,
        descStyle: TextStyle(
          fontFamily: Fonts.primaryRegular,
          fontSize: 16.0,
        ),
        descTextAlign: TextAlign.start,
      ),
      buttons: alertButtons,
    );
  }
}
