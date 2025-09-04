import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_sliver_list/super_sliver_list.dart';
import 'package:sysbot3/model/user_model.dart';
import 'package:sysbot3/provider/bottom_nav_bar_provider.dart';
import 'package:sysbot3/provider/chatProvider.dart';
import 'package:sysbot3/screens/main_screens/leaderboard.dart';
import 'package:sysbot3/screens/main_screens/voice_chat_screen.dart';
import 'package:sysbot3/widgets/custom_button.dart';
import 'package:get/get.dart';

import '../../backend/local_storage/local_storage.dart';
import '../../config/colors.dart';
import '../../utils/functions/common_fun.dart';
import '../../widgets/linear_progress_bar.dart';
import '../../widgets/dialogs/level_up_details_dialog.dart';
import '../../widgets/dialogs/locked_time_up_dialog.dart';

class LevelUpScreen extends StatelessWidget {
  LevelUpScreen({super.key});

  final RxString currentLevel = 'Rizzler'.obs;
  final userData = LocalStorage().getUserData.data;
  final ListController _listController = ListController();
  final ScrollController _scrollController = ScrollController();

  // Helper method to get level name by index
  String getLevelName(int levelIndex) {
    switch (levelIndex) {
      case 1:
        return 'Rizzler';
      case 2:
        return 'Rizz King';
      case 3:
        return 'Rizz God';
      case 4:
        return 'Hall of Game';
      default:
        return 'Rizzler';
    }
  }

  // Helper method to get icon path by level name
  String getIconPath(String levelName) {
    switch (levelName) {
      case "Rizz King":
        return 'assets/images/shields-2.png';
      case "Rizz God":
        return 'assets/images/shields-3.png';
      case "Hall of Game":
        return 'assets/images/shields-4.png';
      default:
        return 'assets/images/shield-icon.png';
    }
  }

  // Helper method to get level data from userData
  List<ItemData>? getLevelData(int levelIndex) {
    switch (levelIndex) {
      case 1:
        return userData?.tierData?.level1;
      case 2:
        return userData?.tierData?.level2;
      case 3:
        return userData?.tierData?.level3;
      case 4:
        return userData?.tierData?.level4;
      default:
        return null;
    }
  }

  Map<String, Map<String, dynamic>> _buildLevels(TierData? tierData) {
    if (tierData == null) return {};

    final levelNames = [
      "Rizzler",
      "Rizz King",
      "Rizz God",
      "Hall of Game",
    ];

    final levelDataList = [
      tierData.level1 ?? [],
      tierData.level2 ?? [],
      tierData.level3 ?? [],
      tierData.level4 ?? [],
    ];

    Map<String, Map<String, dynamic>> result = {};

    for (int i = 0; i < levelNames.length; i++) {
      final quests = levelDataList[i];
      bool isLevelLocked = i == 0 ? false : true;

      // check if previous level is fully complete
      if (i > 0) {
        final prevQuests = levelDataList[i - 1];
        isLevelLocked = !prevQuests.every((q) => q.value >= 15);
      }

      List<Map<String, dynamic>> questsList = [];
      for (int j = 0; j < quests.length; j++) {
        final quest = quests[j];

        bool isLocked = false;
        if (i == 0 && j == 0) {
          // first quest of first level always unlocked
          isLocked = false;
        } else if (j > 0) {
          // unlocked only if previous quest completed
          isLocked = quests[j - 1].value < 15;
        } else {
          // first quest of non-first levels locked until level unlocks
          isLocked = isLevelLocked;
        }

        questsList.add({
          "title": quest.label,
          "name": quest.catLabel,
          "minutesCompleted": quest.value,
          "isLocked": isLocked,
        });
      }

      result[levelNames[i]] = {
        "isLocked": isLevelLocked,
        "questsCompleted": quests.where((q) => q.value >= 15).length,
        "totalQuests": quests.length,
        "quests": questsList,
      };
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Build levels from local storage
    final Map<String, Map<String, dynamic>> levels =
        _buildLevels(userData?.tierData);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentLevel(levels);
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
                    Text('Level Up',
                        style: TextStyle(
                            fontFamily: 'ReservationWide',
                            color: AppColors.white,
                            fontSize: 28,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w900)),
                    GestureDetector(
                      onTap: () {
                        levelUpDetailsDialog(context);
                      },
                      child: Image.asset('assets/images/persons-group-icon.png',
                          width: 35),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: width,
                height: 132,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.shadowClr, width: 3),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.shadowClr,
                          spreadRadius: 0,
                          blurRadius: 0,
                          offset: const Offset(3, 4))
                    ],
                    image: DecorationImage(
                        image: AssetImage('assets/images/dotted-bg2.png'),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Rizz Games".toUpperCase(),
                              style: TextStyle(
                                  fontFamily: 'ReservationWide',
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20)),
                          CustomButton(
                              onTap: () => Get.to(Leaderboard()),
                              title: 'Leaderboard',
                              btnWidth: width * 0.43,
                              txtClr: AppColors.lime,
                              txtSize: 14,
                              iconWidth: 19,
                              iconPath: 'assets/images/grow-icon.png')
                        ],
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/crown-icon.png',
                              width: 45),
                          const SizedBox(height: 5),
                          Text('Your Position',
                              style: TextStyle(
                                  fontFamily: 'ReservationWide',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white)),
                          Selector<BottomNavBarProvider, int>(
                            selector: (_, provider) => provider.currentUserRank,
                            builder: (context, value, child) {
                              return Text(getOrdinalSuffix(value),
                                  style: TextStyle(
                                      fontFamily: 'SFProRound',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white));
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 70,
                child: SuperListView.builder(
                  listController: _listController,
                  controller: _scrollController,
                  padding: const EdgeInsets.only(left: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: levels.length,
                  itemBuilder: (BuildContext context, int index) {
                    final levelEntry = levels.entries.toList()[index];
                    final levelName = levelEntry.key;
                    final levelData = levelEntry.value;
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          currentLevel.value = levelName;
                        },
                        child: Obx(() => Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              height: 37,
                              margin: EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                  color: levelName == currentLevel.value
                                      ? AppColors.lime
                                      : AppColors.shadowClr,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: AppColors.black, width: 2.75),
                                  boxShadow: [
                                    BoxShadow(
                                        color: levelName == currentLevel.value
                                            ? AppColors.white
                                            : AppColors.shadowClr,
                                        offset: const Offset(4.18, 4.18),
                                        spreadRadius: 0)
                                  ]),
                              child: Row(
                                children: [
                                  Visibility(
                                    visible: levelData['isLocked'] == true,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 4, bottom: 2),
                                      child: Image.asset(
                                          'assets/images/lock-icon.png',
                                          width: 16),
                                    ),
                                  ),
                                  Text(
                                      'Road to $levelName (${levelData['questsCompleted']}/${levelData['totalQuests']})',
                                      style: TextStyle(
                                          fontFamily: 'ReservationWide',
                                          color: levelName == currentLevel.value
                                              ? AppColors.black
                                              : AppColors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900))
                                ],
                              ),
                            )),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
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
              Obx(() {
                final currentLevelData = levels[currentLevel.value];
                if (currentLevelData == null ||
                    currentLevelData["quests"].isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'No quests available for this level',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontFamily: 'ReservationWide',
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: currentLevelData["quests"].length,
                  itemBuilder: (BuildContext context, int index) {
                    final quest = currentLevelData["quests"][index];
                    final List<Map<String, dynamic>> allQuests =
                        List<Map<String, dynamic>>.from(
                      currentLevelData["quests"] ?? [],
                    );
                    return GestureDetector(
                      onTap: () {
                        if (quest['isLocked'] == false ||
                            quest['isLocked'] == null) {
                          final chatProvider =
                              Provider.of<ChatProvider>(context, listen: false);
                          chatProvider.updateSelectedCategory(quest['name']);

                          Get.to(VoiceChatScreen(
                              iconPath: getIconPath(currentLevel.value),
                              quests: allQuests,
                              currentQuest: quest['title']));
                        } else {
                          lockedTimeUpDialog(context);
                        }
                      },
                      child: LinearProgressBar(
                          text: quest['title'],
                          isLocked: quest['isLocked'] ?? false,
                          minutesCompleted:
                              (quest['minutesCompleted'] ?? 0).toDouble()),
                    );
                  },
                );
              }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ));
  }

  void _scrollToCurrentLevel(Map<String, Map<String, dynamic>> levels) {
    final index = levels.keys.toList().indexOf(currentLevel.value);
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
