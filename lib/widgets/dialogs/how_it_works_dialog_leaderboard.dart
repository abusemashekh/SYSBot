import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:sysbot3/widgets/custom_button.dart';

import '../../config/colors.dart';
import '../gradient_text.dart';

Future<dynamic> howItWorksDialogLeaderboard(BuildContext context) {
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 12),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/baloon-icon.png', width: 22),
                      const SizedBox(height: 20),
                      StrokeText(text: 'How it Works'.toUpperCase(), textAlign: TextAlign.center, strokeColor: AppColors.themeClr, strokeWidth: 1, textStyle: TextStyle(fontFamily: 'ReservationWide', fontSize: 24, color: AppColors.white, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
                      Text('EARN A BADGE'.toUpperCase(), style: TextStyle(fontFamily: 'ReservationWide', fontSize: 10, color: AppColors.lime, fontWeight: FontWeight.w900,)),
                      SizedBox(height: 25),
                      Text(textAlign: TextAlign.center, 'Complete all micro-quets within a level to earn a badge.', style: TextStyle(fontFamily: 'ReservationWide', fontWeight: FontWeight.w900, fontSize: 12, color: AppColors.white)),
                      SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('BADGE', style: TextStyle(fontFamily: 'AudioWide', fontSize: 13, color: AppColors.white)),
                          Text('QUEST', style: TextStyle(fontFamily: 'AudioWide', fontSize: 13, color: AppColors.white)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 7,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.lime
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          children: [
                            Text('Rizzler', style: TextStyle(fontFamily: 'ReservationWide', fontSize: 16, color: AppColors.white, fontWeight: FontWeight.w900)),
                            const SizedBox(width: 5),
                            Image.asset('assets/images/shield-icon.png', width: 22),
                            const Spacer(),
                            GradientText(
                                textWidget: Text("8",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.white,
                                        fontFamily: 'SFProRound')))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 20),
                        child: Row(
                          children: [
                            Text('Rizz King', style: TextStyle(fontFamily: 'ReservationWide', fontSize: 16, color: AppColors.white, fontWeight: FontWeight.w900)),
                            const SizedBox(width: 5),
                            Image.asset('assets/images/shield-icon.png', width: 22),
                            Image.asset('assets/images/shield-icon.png', width: 22),
                            const Spacer(),
                            GradientText(
                                textWidget: Text("8",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.white,
                                        fontFamily: 'SFProRound')))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          children: [
                            Text('Rizz God', style: TextStyle(fontFamily: 'ReservationWide', fontSize: 16, color: AppColors.white, fontWeight: FontWeight.w900)),
                            const SizedBox(width: 5),
                            Image.asset('assets/images/shield-icon.png', width: 22),
                            Image.asset('assets/images/shield-icon.png', width: 22),
                            Image.asset('assets/images/shield-icon.png', width: 22),
                            const Spacer(),
                            GradientText(
                                textWidget: Text("8",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.white,
                                        fontFamily: 'SFProRound')))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 20),
                        child: Row(
                          children: [
                            Text('Hall of Game', style: TextStyle(fontFamily: 'ReservationWide', fontSize: 16, color: AppColors.white, fontWeight: FontWeight.w900)),
                            const SizedBox(width: 5),
                            Image.asset('assets/images/shield-icon.png', width: 22),
                            Image.asset('assets/images/shield-icon.png', width: 22),
                            Image.asset('assets/images/shield-icon.png', width: 22),
                            Image.asset('assets/images/shield-icon.png', width: 22),
                            const Spacer(),
                            GradientText(
                                textWidget: Text("7",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.white,
                                        fontFamily: 'SFProRound')))
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("FAQ'S", style: TextStyle(fontFamily: 'AudioWide', fontSize: 13, color: AppColors.white))),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 47,
                          height: 1,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(height: 25),
                      Text(textAlign: TextAlign.center, '📈 You will earn 1 Rizz PT for the category of the mini-quest you have completed (15 min spent per quest).\n\n💯 Once you hit 100 Rizz pts, your score resets to 50 to keep the competition fresh on the leaderboard.\n\n✅ Badges (MAX of 4) are permanent and won’t be affected by your leaderboard score.', style: TextStyle(fontFamily: 'ReservationWide', fontSize: 10, color: AppColors.white, fontWeight: FontWeight.w900)),
                      SizedBox(height: 30),
                      CustomButton(title: 'Got it', btnWidth: 135, txtSize: 16, onTap: () => Get.back())
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}