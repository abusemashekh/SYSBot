import 'package:flutter/material.dart';
import 'package:sysbot3/screens/bottom_nav_bar.dart';
import 'package:sysbot3/screens/main_screens/leaderboard.dart';
import 'package:sysbot3/screens/main_screens/won-rizz-games.dart';
import 'package:sysbot3/screens/onboarding/core_dating_skills.dart';
import 'package:sysbot3/screens/onboarding/level_up_your_rizz.dart';
import 'package:sysbot3/screens/onboarding/onboarding1.dart';
import 'package:sysbot3/screens/onboarding/onboarding3.dart';
import 'package:sysbot3/screens/onboarding/referral_code_screen.dart';
import 'package:sysbot3/screens/onboarding/rizz_quiz/give_quiz.dart';
import 'package:sysbot3/screens/onboarding/rizz_quiz/rizz_quiz.dart';
import 'package:sysbot3/screens/onboarding/rizz_quiz/see_result.dart';
import 'package:sysbot3/screens/onboarding/show_love.dart';
import 'package:sysbot3/screens/onboarding/upgrade_screen.dart';
import 'package:sysbot3/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:sysbot3/widgets/dialogs/100-points-score-reset-to-50.dart';
import 'package:sysbot3/widgets/dialogs/how_it_works_dialog_chat_screen.dart';
import 'package:sysbot3/widgets/dialogs/how_it_works_dialog_coaching.dart';
import 'package:sysbot3/widgets/dialogs/how_it_works_dialog_leaderboard.dart';
import 'package:sysbot3/widgets/dialogs/level_up_details_dialog.dart';
import 'package:sysbot3/widgets/dialogs/level_up_dialog1.dart';
import 'package:sysbot3/widgets/dialogs/level_up_dialog2.dart';
import 'package:sysbot3/widgets/dialogs/level_up_dialog_carousel.dart';
import 'package:sysbot3/widgets/dialogs/new_level_dialog.dart';
import 'package:sysbot3/widgets/dialogs/time_up_dialog.dart';

import 'config/colors.dart';

class DummyScreen extends StatelessWidget {
  const DummyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: () => Get.to(Onboarding1()),
                      title: 'Onboarding 1'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: () => Get.to(ReferralCodeScreen()),
                      title: 'Enter Referral Code'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: () => Get.to(Onboarding3()),
                      title: 'Onboarding 3'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: () => Get.to(CoreDatingSkills()),
                      title: 'Core Dating Skills'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: () => Get.to(LevelUpYourRizz()),
                      title: 'Level Up Your Rizz'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: () => Get.to(ShowLove()),
                      title: 'Show Love'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: () => Get.to(RizzQuiz()),
                      title: 'Rizz Quiz'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: () => Get.to(GiveQuiz()),
                      title: 'Give Rizz Quiz'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: () => Get.to(SeeResult()),
                      title: 'See My Results'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: () => Get.to(UpgradeScreen()),
                      title: 'Upgrade Screen'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: () => Get.to(BottomNavBar()),
                      title: 'Home'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: () => Get.to(Leaderboard()),
                      title: 'Leaderboard'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        levelUpDetailsDialog(context);
                      },
                      title: 'How it Works (Level Up)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        howItWorksDialogChatScreen(context);
                      },
                      title: 'How it Works (Chat Screen)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        howItWorksDialogLeaderboard(context);
                      },
                      title: 'How it Works (Leaderboard)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        howItWorksDialogCoaching(context);
                      },
                      title: 'How it Works (Coaching)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return TimeUpDialog();
                          },
                        );
                      },
                      title: 'Time Up Dialog'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NewLevelDialog(level: 'Rizzler');
                          },
                        );
                      },
                      title: 'New Level Dialog (Rizzler)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NewLevelDialog(level: 'Rizz King');
                          },
                        );
                      },
                      title: 'New Level Dialog (Rizz King)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NewLevelDialog(level: 'Rizz God');
                          },
                        );
                      },
                      title: 'New Level Dialog (Rizz God)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return NewLevelDialog(level: 'Hall of Game');
                          },
                        );
                      },
                      title: 'New Level Dialog (Hall of Game)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ScoreResetTo50();
                          },
                        );
                      },
                      title: 'Score Reset to 50'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                       Get.to(WonRizzGames());
                      },
                      title: 'Won Rizz Games'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        levelUpDialog1(context: context, title: 'Flex Factor');
                      },
                      title: 'Level up (Flex Factor)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        levelUpDialog2(context: context, title: 'Flex Factor', percentage: 90);
                      },
                      title: 'Level up (Flex Factor)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        levelUpDialog1(context: context, title: 'Drip Check');
                      },
                      title: 'Level up (Drip Check)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        levelUpDialog2(context: context, title: 'Drip Check', percentage: 100);
                      },
                      title: 'Level up (Drip Check)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        levelUpDialog1(context: context, title: 'Juice Level');
                      },
                      title: 'Level up (Juice Level)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        levelUpDialog2(context: context, title: 'Juice Level', percentage: 70);
                      },
                      title: 'Level up (Juice level)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        levelUpDialog1(context: context, title: 'Pickup Game');
                      },
                      title: 'Level up (Pickup Game)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        levelUpDialog2(context: context, title: 'Pickup Game', percentage: 30);
                      },
                      title: 'Level up (Pickup Game)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        levelUpDialog1(context: context, title: 'Goal Digger');
                      },
                      title: 'Level up (Goal Digger)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        levelUpDialog2(context: context, title: 'Goal Digger', percentage: 50);
                      },
                      title: 'Level up (Goal Digger)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        levelUpDialog1(context: context, title: 'Overall');
                      },
                      title: 'Level up (Overall)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        levelUpDialog2(context: context, title: 'Overall', percentage: 25);
                      },
                      title: 'Level up (Overall)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (_) => LevelUpDialogCarousel(title: 'Flex Factor', percentage: 70, overallPercentage: 100),
                        );
                      },
                      title: 'Carousel (Flex Factor)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (_) => LevelUpDialogCarousel(title: 'Drip Check', percentage: 70, overallPercentage: 100),
                        );
                      },
                      title: 'Carousel (Drip Check)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (_) => LevelUpDialogCarousel(title: 'Juice Level', percentage: 70, overallPercentage: 100),
                        );
                      },
                      title: 'Carousel (Juice Level)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (_) => LevelUpDialogCarousel(title: 'Pickup Game', percentage: 70, overallPercentage: 100),
                        );
                      },
                      title: 'Carousel (Pickup Game)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (_) => LevelUpDialogCarousel(title: 'Goal Digger', percentage: 70, overallPercentage: 100),
                        );
                      },
                      title: 'Carousel (Goal Digger)'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CustomButton(
                      onTap: (){
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (_) => LevelUpDialogCarousel(title: 'Overall', percentage: 90, overallPercentage: 90),
                        );
                      },
                      title: 'Carousel (Overall)'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
