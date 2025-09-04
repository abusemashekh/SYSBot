import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:sysbot3/widgets/custom_button.dart';

import '../../config/colors.dart';

Future<dynamic> howItWorksDialogCoaching(BuildContext context) {
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
                      Image.asset('assets/images/duck-icon.png', width: 48),
                      const SizedBox(height: 20),
                      StrokeText(text: 'How it Works'.toUpperCase(), textAlign: TextAlign.center, strokeWidth: 1, strokeColor: AppColors.themeClr, textStyle: TextStyle(fontFamily: 'ReservationWide', fontSize: 24, color: AppColors.white, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
                      Text('Choose Your Own Path'.toUpperCase(), style: TextStyle(fontFamily: 'ReservationWide', fontSize: 10, color: AppColors.lime, fontWeight: FontWeight.w900,)),
                      SizedBox(height: 25),
                      Text(textAlign: TextAlign.center, 'Explore all categories and take on mini-quests in any order.\n\nPerfect for leveling up specific skills or getting extra practice between levels.', style: TextStyle(fontFamily: 'ReservationWide', fontWeight: FontWeight.w900, fontSize: 12, color: AppColors.white)),
                      SizedBox(height: 32),
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
                      Text(textAlign: TextAlign.center, "🧠 Pick a category that fits what you want to work on 🎯\n\nComplete micro-quests to earn Rizz Points\n\n📈 Progress still counts toward badges and your leaderboard rank\n\n🔓 Some quests are locked according to your badge level. Once you level up, new quests unlock automatically.\n\n🔥 Hot Topics are always unlocked. These cover real-life dating scenarios and don’t require a badge. While Hot Topics aren't tied to your skill scorecard, you still earn 1 point for every 15 minutes spent. Those points go toward your overall leaderboard score.", style: TextStyle(fontFamily: 'ReservationWide', fontSize: 10, color: AppColors.white, fontWeight: FontWeight.w900)),
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