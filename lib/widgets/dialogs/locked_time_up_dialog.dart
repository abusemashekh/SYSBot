import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:sysbot3/widgets/custom_button.dart';

import '../../config/colors.dart';

Future<dynamic> lockedTimeUpDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)),
        child: IntrinsicHeight(
          child: Center(
            child: Container(
              padding: EdgeInsets.only(left: 16, top: 24, bottom: 32, right: 12),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: const Color(0xff00001E),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.shadowClr, width: 3),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.shadowClr,
                        offset: const Offset(3, 4)),
                  ]),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/character-with-whistle.png', width: 120),
                  const SizedBox(height: 20),
                  Center(child: StrokeText(text: 'Time out'.toUpperCase(), textAlign: TextAlign.center, strokeWidth: 1.5, strokeColor: AppColors.themeClr, textStyle: TextStyle(fontFamily: 'ReservationWide', fontSize: 24, color: AppColors.white, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic))),
                  const SizedBox(height: 20),
                  Text(textAlign: TextAlign.center, 'Not so fast my guy! Go\nstep your badge level up\nto gain access', style: TextStyle(fontFamily: 'ReservationWide', fontSize: 15, color: AppColors.white, fontWeight: FontWeight.w900)),
                  SizedBox(height: 30),
                  CustomButton(title: 'Got it', btnWidth: 135, txtSize: 16, onTap: () => Get.back())
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}