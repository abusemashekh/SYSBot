import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_sliver_list/super_sliver_list.dart';
import 'package:sysbot3/provider/chatProvider.dart';
import 'package:sysbot3/screens/main_screens/voice_chat_screen.dart';
import 'package:get/get.dart';

import '../../config/colors.dart';
import '../../widgets/dialogs/how_it_works_dialog_coaching.dart';
import '../../widgets/linear_progress_bar.dart';
import '../../widgets/dialogs/locked_time_up_dialog.dart';

class CoachingHub extends StatelessWidget {
  CoachingHub({super.key});

  final RxString selectedCategory = 'Hot Topics'.obs;

  //total minutes are defined as 15 in LinearProgressBar and progressbar grow on the
  // basis of total 15. You can change it from LinearProgressBar

  final Map<String, Map<String, dynamic>> levels = {
    "Hot Topics": {
      "questsCompleted": 2,
      "totalQuests": 6,
      "quests": [
        {
          "title": "❓ Ask Anything",
          "name": "Ask Anything ❓",
          "minutesCompleted": 15,
          "isLocked": false,
        },
        {
          "title": "❤️‍🔥 Win Over Your Crush",
          "name": "Win Over Crush ❤️‍‍‍",
          "minutesCompleted": 7,
          "isLocked": false,
        },
        {
          "title": "🗣️ In-Person: What Do I Say?",
          "name": "Quick, What Do I Say? 😰",
          "minutesCompleted": 3,
          "isLocked": false,
        },
        {
          "title": "🎧 Live Feedback️",
          "name": "Live Feedback 🎧",
          "minutesCompleted": 12,
          "isLocked": false,
        },
        {
          "title": "❤️‍🩹 Get Your Ex Back",
          "name": "Get Ex Back ❤️‍🩹",
          "minutesCompleted": 9,
          "isLocked": false,
        },
        {
          "title": "☁️ Get Over the Break-Up",
          "name": "Get Over Breakup ☁️",
          "minutesCompleted": 2,
          "isLocked": false,
        }
      ]
    },
    "Pickup Game": {
      "questsCompleted": 0,
      "totalQuests": 6,
      "quests": [
        {
          "title": "Pickup → Pickup Line Practice 🅿️",
          "name": "Pickup Line Practice 🅿️",
          "minutesCompleted": 12,
          "isLocked": false
        },
        {
          "title": "Pickup → Talk Yo Talk 🗣️",
          "name": "Talk Yo Talk 🗣️",
          "minutesCompleted": 1,
          "isLocked": true
        },
        {
          "title": "Pickup → Rizz Game Drill 📣",
          "name": "Rizz Game Drill 📣",
          "minutesCompleted": 15,
          "isLocked": true
        },
        {
          "title": "️Pickup → Smooth Talker Test 😏️",
          "name": "Smooth Talker Test 😏",
          "minutesCompleted": 7,
          "isLocked": true
        },
        {
          "title": "️Pickup → Flirt or Fold? ❓",
          "name": "Flirt Or Fold ❓",
          "minutesCompleted": 0,
          "isLocked": true
        },
        {
          "title": "Pickup → Mouthpiece Madness 😮‍💨",
          "name": "Mouthpiece Madness 😮‍💨",
          "minutesCompleted": 3,
          "isLocked": true
        }
      ]
    },
    "Flex Factor": {
      "questsCompleted": 0,
      "totalQuests": 6,
      "quests": [
        {
          "title": "Flex → Shot Challenge🎉",
          "name": "Shot Challenge 🎉",
          "minutesCompleted": 12,
          "isLocked": false
        },
        {
          "title": "Flex → Confidence Drills 🎬",
          "name": "Confidence Drills 🎬",
          "minutesCompleted": 15,
          "isLocked": true
        },
        {
          "title": "Flex → Big Flex Mode 😤",
          "name": "Big Flex Mode 😤",
          "minutesCompleted": 13,
          "isLocked": true
        },
        {
          "title": "Flex → Bold Moves Only 🔥",
          "name": "Bold Moves Only 🎯",
          "minutesCompleted": 7,
          "isLocked": true
        },
        {
          "title": "Flex → Risk It or Miss It 🎯",
          "name": "Risk It or Miss It ⚡️",
          "minutesCompleted": 0,
          "isLocked": true
        },
        {
          "title": "Flex → Fearless Flex Test ⏱️",
          "name": "Fearless Flex 🦁",
          "minutesCompleted": 3,
          "isLocked": true
        },
        {
          "title": "Flex → Mic Drop Moments 🎤",
          "name": "Mic Drop 🎤",
          "minutesCompleted": 9,
          "isLocked": true
        },
      ]
    },
    "Juice Level": {
      "questsCompleted": 0,
      "totalQuests": 6,
      "quests": [
        {
          "title": "Juice → Juice Check ✅",
          "name": "Juice Check ✅",
          "minutesCompleted": 13,
          "isLocked": false
        },
        {
          "title": "Juice → Vibe Check Drill 💫",
          "name": "Vibe Check Drill 💫",
          "minutesCompleted": 15,
          "isLocked": true
        },
        {
          "title": "Juice → Can You Rizz? ⁉️",
          "name": "Can You Rizz ⁉️",
          "minutesCompleted": 12,
          "isLocked": true
        },
        {
          "title": "Juice → Light Up the Room 🔦",
          "name": "Light-up The Room 🔦",
          "minutesCompleted": 7,
          "isLocked": true
        },
        {
          "title": "Juice → Electric Energy Test 🔋",
          "name": "Electric Energy Test 🔋",
          "minutesCompleted": 8,
          "isLocked": true
        },
        {
          "title": "Juice → Smooth Operator 😎",
          "name": "Smooth Operator Challenge 😎",
          "minutesCompleted": 0,
          "isLocked": true
        },
      ]
    },
    "Drip Check": {
      "questsCompleted": 0,
      "totalQuests": 6,
      "quests": [
        {
          "title": "Drip → Drip Quiz ❓",
          "name": "Drip Quiz 🧢",
          "minutesCompleted": 13,
          "isLocked": false
        },
        {
          "title": "Drip → Fit Check Challenge 🧢",
          "name": "Fit Check Challenge 👟",
          "minutesCompleted": 15,
          "isLocked": false
        },
        {
          "title": "️Drip → Outfit Vibe Check 👕",
          "name": "Outfit Vibe Check 👗",
          "minutesCompleted": 2,
          "isLocked": true
        },
        {
          "title": "Drip → Style Upgrade 🌟",
          "name": "Style Upgrade 👕",
          "minutesCompleted": 7,
          "isLocked": true
        },
        {
          "title": "Drip → Glow Up Game 👟",
          "name": "Glow Up Game 🌟",
          "minutesCompleted": 9,
          "isLocked": true
        },
        {
          "title": "Drip → Stay Sharp Workout 🏋️",
          "name": "Stay Sharp Workout 🏋🏽‍♂️",
          "minutesCompleted": 0,
          "isLocked": true
        },
      ]
    },
    "Goal Digger": {
      "questsCompleted": 0,
      "totalQuests": 6,
      "quests": [
        {
          "title": "Goal → Goal Getter Challenge 🥇",
          "name": "Goal Getter Challenge 🥇",
          "minutesCompleted": 3,
          "isLocked": false
        },
        {
          "title": "Goal → Mindset Mastery 🧠",
          "name": "Mindset Mastery 🧠",
          "minutesCompleted": 15,
          "isLocked": false
        },
        {
          "title": "Goal → Dream Big Drill 💤",
          "name": "Dream Big Drill 💤",
          "minutesCompleted": 12,
          "isLocked": true
        },
        {
          "title": "Goal → Winner’s Mentality Test 🏁",
          "name": "Winner’s Mentality Test 🏁",
          "minutesCompleted": 7,
          "isLocked": true
        },
        {
          "title": "Goal → Secure The Bag 💰",
          "name": "Secure The Bag 💰",
          "minutesCompleted": 8,
          "isLocked": true
        },
        {
          "title": "Goal → Boss Up Challenge 👔️",
          "name": "Boss Up Challenge 👔",
          "minutesCompleted": 10,
          "isLocked": true
        },
      ]
    },
  };

  final ListController _listController = ListController();
  final ScrollController _scrollController = ScrollController();

  final Map<String, String> categories = {
    "Hot Topics": "assets/images/fire-icon.png",
    "Flex Factor": "assets/images/flex-factor-icon.png",
    "Juice Level": "assets/images/juice-level-icon.png",
    "Pickup Game": "assets/images/pickup-game-icon.png",
    "Drip Check": "assets/images/drip-check-icon.png",
    "Goal Digger": "assets/images/goal-digger-icon.png"
  };

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentLevel();
    });
    return Scaffold(
        body: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/left-gradient-bg.png'),
              fit: BoxFit.cover)),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Coaching Hub',
                        style: TextStyle(
                            fontFamily: 'ReservationWide',
                            color: AppColors.white,
                            fontSize: 28,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w900)),
                    GestureDetector(
                      onTap: () {
                        howItWorksDialogCoaching(context);
                      },
                      child:
                          Image.asset('assets/images/duck-icon.png', width: 24),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Categories',
                    style: TextStyle(
                        fontFamily: 'ReservationWide',
                        fontWeight: FontWeight.w900,
                        color: AppColors.lime,
                        fontSize: 15)),
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 108,
                child: SuperListView.builder(
                  listController: _listController,
                  controller: _scrollController,
                  padding: const EdgeInsets.only(left: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: levels.length,
                  itemBuilder: (BuildContext context, int index) {
                    final RxString categoryName =
                        categories.keys.elementAt(index).obs;
                    final RxString categoryImage =
                        categories.values.elementAt(index).obs;
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          selectedCategory.value = categoryName.value;
                        },
                        child: Obx(() => Container(
                              height: 103,
                              width: 92,
                              margin: EdgeInsets.only(right: 16),
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  color: categoryName.value ==
                                          selectedCategory.value
                                      ? AppColors.lime
                                      : AppColors.black,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: categoryName.value ==
                                              selectedCategory.value
                                          ? AppColors.black
                                          : AppColors.shadowClr,
                                      width: 2.75),
                                  boxShadow: [
                                    BoxShadow(
                                        color: categoryName.value ==
                                                selectedCategory.value
                                            ? AppColors.white
                                            : AppColors.shadowClr,
                                        offset: const Offset(3.18, 3.18),
                                        spreadRadius: 0)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(categoryImage.value, width: 27),
                                  const SizedBox(height: 4),
                                  Text(categoryName.value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'ReservationWide',
                                          fontWeight: FontWeight.w900,
                                          fontSize: 12,
                                          color: categoryName.value ==
                                                  selectedCategory.value
                                              ? AppColors.black
                                              : AppColors.white))
                                ],
                              ),
                            )),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Challenges',
                    style: TextStyle(
                        fontFamily: 'ReservationWide',
                        color: AppColors.white,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w900)),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.lime,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'ReservationWide',
                    ),
                    children: [
                      const TextSpan(text: 'Tap '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Image.asset('assets/images/play-icon.png',
                            width: 12),
                      ),
                      const TextSpan(text: ' to Start'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Obx(() => ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: levels[selectedCategory.value]?["quests"].length,
                    itemBuilder: (BuildContext context, int index) {
                      final quest =
                          levels[selectedCategory.value]?["quests"][index];
                      final List<Map<String, dynamic>> allQuests =
                          List<Map<String, dynamic>>.from(
                        levels[selectedCategory.value]?["quests"] ?? [],
                      );
                      return GestureDetector(
                        onTap: () {
                          if (quest['isLocked'] == false ||
                              quest['isLocked'] == null) {
                            final chatProvider = Provider.of<ChatProvider>(
                                context,
                                listen: false);
                            chatProvider.updateSelectedCategory(quest['name']);

                            String iconPath = selectedCategory.value ==
                                    "Flex Factor"
                                ? 'assets/images/flex-factor-timer.png'
                                : selectedCategory.value == "Juice Level"
                                    ? 'assets/images/juice-level-timer.png'
                                    : selectedCategory.value == "Pickup Game"
                                        ? 'assets/images/pickup-game-timer.png'
                                        : selectedCategory.value == "Drip Check"
                                            ? 'assets/images/drip-check-timer.png'
                                            : selectedCategory.value ==
                                                    "Goal Digger"
                                                ? 'assets/images/goal-digger-timer.png'
                                                : 'assets/images/fire-icon-timer.png';
                            Get.to(VoiceChatScreen(
                                iconPath: iconPath,
                                quests: allQuests,
                                currentQuest: quest['title'],
                                iconTopPadding: 6));
                          } else {
                            lockedTimeUpDialog(context);
                          }
                        },
                        child: LinearProgressBar(
                            text: quest['title'],
                            iconPath: selectedCategory.value == "Flex Factor"
                                ? 'assets/images/flex-factor-icon.png'
                                : selectedCategory.value == "Juice Level"
                                    ? 'assets/images/juice-level-icon.png'
                                    : selectedCategory.value == "Pickup Game"
                                        ? 'assets/images/pickup-game-icon.png'
                                        : selectedCategory.value == "Drip Check"
                                            ? 'assets/images/drip-check-icon.png'
                                            : selectedCategory.value ==
                                                    "Goal Digger"
                                                ? 'assets/images/goal-digger-icon.png'
                                                : null,
                            isLocked: quest['isLocked'] ?? false,
                            minutesCompleted:
                                quest['minutesCompleted'].toDouble()),
                      );
                    },
                  )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ));
  }

  void _scrollToCurrentLevel() {
    final index = levels.keys.toList().indexOf(selectedCategory.value);
    if (index != -1) {
      _listController.animateToItem(
        index: index,
        scrollController: _scrollController,
        alignment: 0.5,
        duration: (distance) => const Duration(milliseconds: 300),
        curve: (distance) => Curves.easeInOut,
      );
    }
  }
}
