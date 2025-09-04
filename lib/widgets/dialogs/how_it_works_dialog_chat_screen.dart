import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:sysbot3/widgets/custom_button.dart';

import '../../config/colors.dart';

Future<dynamic> howItWorksDialogChatScreen(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)),
        child: IntrinsicHeight(
          child: Center(
            child: Container(
              padding: EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 12),
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
                  Image.asset('assets/images/fa-question-circle-icon.png', width: 63),
                  const SizedBox(height: 20),
                  StrokeText(text: 'How it Works'.toUpperCase(), textAlign: TextAlign.center, strokeWidth: 1, strokeColor: AppColors.themeClr, textStyle: TextStyle(fontFamily: 'ReservationWide', fontSize: 24, color: AppColors.white, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
                  Text('REAL-TIME COACHING SESSIONS'.toUpperCase(), style: TextStyle(fontFamily: 'ReservationWide', fontSize: 10, color: AppColors.lime, fontWeight: FontWeight.w900,)),
                  SizedBox(height: 25),
                  Text(textAlign: TextAlign.center, '🗣️ Tap Shoot to talk and Stop to pause the timer.\n\n⏳ You have 30 minutes of coaching per week. Timer resets every Monday\n\n🏆 You’ll gain 1 Rizz Point for every 15 minutes spent per category\n\n📊 Coaching time is credited to the category the session was launched from', style: TextStyle(fontFamily: 'ReservationWide', fontSize: 12, color: AppColors.white, fontWeight: FontWeight.w900)),
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