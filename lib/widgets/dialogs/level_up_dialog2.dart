import 'package:flutter/material.dart';

import '../level_up_dialog2_widget.dart';

Future<dynamic> levelUpDialog2({required BuildContext context, required String title, required double percentage}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Center(
        child: Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
          child: LevelUpDialog2Widget(title: title, percentage: percentage),
        ),
      );
    },
  );
}