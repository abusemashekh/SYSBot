import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stroke_text/stroke_text.dart';

import '../../config/colors.dart';
import '../custom_button.dart';

class TimeUpDialog extends StatelessWidget {
  const TimeUpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      alignment: Alignment.center,
      backgroundColor: Colors.transparent,
      content: SizedBox(
        height: 440,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 382,
                margin: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    color: const Color(0xff00001E),
                    borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.shadowClr, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowClr,
                      offset: const Offset(3, 4),
                      spreadRadius: 0
                    )
                  ]
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 65),
                    StrokeText(text: 'Times Up'.toUpperCase(),
                        strokeColor: AppColors.themeClr,
                        textAlign: TextAlign.center,
                        strokeWidth: 1,
                        textStyle: TextStyle(
                            fontFamily: 'ReservationWide',
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            color: AppColors.lime)),
                    const SizedBox(height: 20),
                    Container(
                      width: 97,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.mediumGrey.withValues(alpha: 0.24),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(child: Text('00:00', style: TextStyle(fontFamily: 'SFDigital', color: AppColors.white, fontSize: 32))),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(textAlign: TextAlign.center, 'You’ve reached your 30 minute max for this week. Your time will reset to 30:00 every Monday.',
                          style: TextStyle(
                              fontFamily: 'ReservationWide',
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: AppColors.white)),
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                        onTap: () => Get.back(), title: 'Got It', txtSize: 16, btnWidth: 135)
                  ],
                ),
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: SizedBox(
                    height: 392,
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset('assets/images/bot-circle.png',
                            height: 114))))
          ],
        ),
      ),
    );
  }
}
