import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/colors.dart';
import '../../widgets/custom_button.dart';
import 'level_up_your_rizz.dart';


class CoreDatingSkills extends StatelessWidget {
  CoreDatingSkills({super.key});

  final Map<String, String> skillsItems = {
    'Flex Factor' : 'assets/images/flex-factor-icon.png',
    'Drip Check' : 'assets/images/drip-check-icon.png',
    'Juice Level' : 'assets/images/juice-level-icon.png',
    'Pickup Game' : 'assets/images/pickup-game-icon.png',
    'Goal Digger' : 'assets/images/goal-digger-icon.png'
  };

  final RxString selectedItem = "Flex Factor".obs;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff0A0A0A),
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/top-gradient-bg.png'), fit: BoxFit.cover
            )
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 36),
                Image.asset('assets/images/user-icon-with-5.png', width: 30),
                const SizedBox(height: 6),
                Text('Core Dating Skills',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'ReservationWide',
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        color: AppColors.white,
                        fontSize: 20)),
                const SizedBox(height: 20),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'ReservationWide',
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      color: AppColors.white,
                      fontSize: 13,
                    ),
                    children: [
                      TextSpan(text: 'Studies show that to reset your dating life you need to improve the below '),
                      TextSpan(
                        text: '5 core skills.',
                        style: TextStyle(color: AppColors.lime),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: skillsItems.entries.map((entry) {
                    final isSelected = selectedItem.value == entry.key;
                    return GestureDetector(
                      onTap: () {
                        selectedItem.value = entry.key;
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6), // spacing between items
                        width: 45,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.lime : AppColors.charcoalPurple,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.black, width: 2.8),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(4.18, 4.18),
                              color: AppColors.charcoalPurple,
                              blurRadius: 0,
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Center(
                          child: Image.asset(
                            entry.value,
                            width: 20,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )),
                const SizedBox(height: 50),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6), // spacing between items
                  width: width*0.75,
                  height: 262,
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.darkCharcoal, width: 3),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(3, 4),
                        color: AppColors.darkCharcoal,
                        blurRadius: 0,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 45),
                      Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(getSkillImagePath(selectedItem.value), width: 22),
                          const SizedBox(width: 2),
                          Text(selectedItem.value, style: TextStyle(fontSize: 24, fontFamily: 'ReservationWide', color: AppColors.lime, fontWeight: FontWeight.w900))
                        ],
                      )),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Obx(() => Text(getSkillDescription(selectedItem.value), textAlign: TextAlign.center, style: TextStyle(fontFamily: 'ReservationWide', fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.lightGrey))),
                      )
                    ],
                  ),
                ),
                const Spacer(flex: 2),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomButton(
                      onTap: () async{
                        await precacheImage(AssetImage('assets/images/left-gradient-bg.png'), context);
                        Get.to(LevelUpYourRizz());
                      },
                      btnWidth: 150,
                      txtSize: 12,
                      title: 'Continue'),
                ),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getSkillDescription(String skillName) {
    switch (skillName) {
      case 'Flex Factor':
        return 'Measures your ability to stay poised and self assured in social settings, projecting confidence without arrogance.';
      case 'Drip Check':
        return 'Evaluates your style, grooming, and physical presence to ensure you’re making a strong first impression.';
      case 'Juice Level':
        return 'Reflects your charisma and ability to connect, captivate, and stand out in group dynamics.';
      case 'Pickup Game':
        return 'Scores your creativity, humor, and ability to spark chemistry in flirty, engaging interactions.';
      case 'Goal Digger':
        return 'Assesses your ambition and drive, showcasing how you pursue personal or professional growth.';
      default:
        return 'Measures your ability to stay poised and self assured in social settings, projecting confidence without arrogance.';
    }
  }

  String getSkillImagePath(String skillName) {
    switch (skillName) {
      case 'Flex Factor':
        return 'assets/images/flex-factor-icon.png';
      case 'Drip Check':
        return 'assets/images/drip-check-icon.png';
      case 'Juice Level':
        return 'assets/images/juice-level-icon.png';
      case 'Pickup Game':
        return 'assets/images/pickup-game-icon.png';
      case 'Goal Digger':
        return 'assets/images/goal-digger-icon.png';
      default:
        return 'assets/images/flex-factor-icon.png';
    }
  }


}
