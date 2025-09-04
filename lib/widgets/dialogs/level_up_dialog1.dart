import 'package:flutter/material.dart';

import '../level_up_dialog1_widget.dart';

Future<dynamic> levelUpDialog1({required BuildContext context, required String title}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Center(
        child: Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
          child: LevelUpDialog1Widget(title: title),
        ),
      );
    },
  );
}
