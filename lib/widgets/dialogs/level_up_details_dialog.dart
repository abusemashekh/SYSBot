import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:sysbot3/widgets/custom_button.dart';

import '../../config/colors.dart';

Future<dynamic> levelUpDetailsDialog(BuildContext context) {
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
                  Image.asset('assets/images/persons-group-icon.png', width: 46),
                  const SizedBox(height: 10),
                  StrokeText(text: 'Level Up'.toUpperCase(), textAlign: TextAlign.center, strokeWidth: 1.5, strokeColor: AppColors.themeClr, textStyle: TextStyle(fontFamily: 'ReservationWide', fontSize: 24, color: AppColors.white, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
                  SizedBox(height: 25),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/play-button.png', width: 40),
                      const SizedBox(width: 16),
                      Expanded(child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'ReservationWide',
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: AppColors.white,
                          ),
                          children: [
                            const TextSpan(text: 'Tap the '),
                            TextSpan(
                              text: 'Play',
                              style: TextStyle(
                                color: AppColors.lime,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const TextSpan(text: ' icon on a micro quest to begin challenge & chat with ShootYourShot Bot'),
                          ],
                        ),
                      )
                      )

                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/leaderboard-button.png', width: 40),
                      const SizedBox(width: 16),
                      Expanded(child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'ReservationWide',
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: AppColors.white,
                          ),
                          children: [
                            const TextSpan(text: 'Tap '),
                            TextSpan(
                              text: 'Leaderboard',
                              style: TextStyle(
                                color: AppColors.lime,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const TextSpan(text: ' to view detailed Rizz Games rankings'),
                          ],
                        ),
                      )
                      )

                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/point-button.png', width: 40),
                      const SizedBox(width: 16),
                      Expanded(child: Text('Earn 1pt for every 15min micro quest completed for that category', style: TextStyle(fontFamily: 'ReservationWide', color: AppColors.white, fontSize: 12, fontWeight: FontWeight.w900)))
                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/lock-button.png', width: 40),
                      const SizedBox(width: 16),
                      Expanded(child: Text('To unlock the next level, new challenges & earn a badge, complete all micro-quest within your current level', style: TextStyle(fontFamily: 'ReservationWide', color: AppColors.white, fontSize: 12, fontWeight: FontWeight.w900)))
                    ],
                  ),
                  SizedBox(height: 24),
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