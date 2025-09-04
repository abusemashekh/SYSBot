import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sysbot3/screens/onboarding/rizz_quiz/see_result.dart';

import '../../../config/colors.dart';
import '../../../model/rizz_quizz_model.dart';
import '../../../provider/onboard_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/gradient_text.dart';

class GiveQuiz extends StatelessWidget {
  GiveQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final onBoardProvider =
        Provider.of<OnboardProvider>(context, listen: false);
    onBoardProvider.onScreenOpen();

    return Scaffold(
      backgroundColor: Color(0xff0A0A0A),
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/left-gradient-bg.png'),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Consumer<OnboardProvider>(
            builder: (context, provider, child) {
              var categories = provider.rizzQuizzData?.data!.categories;
              var flexFactor = categories?.flexFactorScore?.options ?? [];
              var dripCheck = categories?.dripCheckScore?.options ?? [];
              var juiceLevel = categories?.juiceLevelScore?.options ?? [];
              var pickupGame = categories?.pickupGameScore?.options ?? [];
              var goalDigger = categories?.goalDiggerScore?.options ?? [];

              return Column(
                children: [
                  const SizedBox(height: 36),
                  // Fixed page indicator at top
                  SmoothPageIndicator(
                    controller: provider.carouselController,
                    count: 5,
                    effect: SwapEffect(
                      activeDotColor: AppColors.lime,
                      dotColor: AppColors.lightGrey.withValues(alpha: 0.38),
                      dotHeight: 8,
                      dotWidth: width * 0.158,
                      spacing: 8,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Expanded PageView to take remaining space
                  Expanded(
                    child: PageView(
                      dragStartBehavior: DragStartBehavior.down,
                      controller: provider.carouselController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        provider.updateIndex(index);
                      },
                      children: [
                        skillWidget(
                            selectedItems: provider.selectedFlexFactors,
                            allItems: flexFactor,
                            title: 'Flex Factor',
                            imagePath: 'assets/images/flex-factor-icon.png',
                            subtitle:
                                'At a party, you spot someone you like. Your next move is to...',
                            provider: provider),
                        skillWidget(
                            selectedItems: provider.selectedDripCheck,
                            allItems: dripCheck,
                            title: 'Drip Check',
                            imagePath: 'assets/images/drip-check-icon.png',
                            subtitle: 'For a big date, your go-to look is...',
                            provider: provider),
                        skillWidget(
                            selectedItems: provider.selectedJuiceLevel,
                            allItems: juiceLevel,
                            title: 'Juice Level',
                            imagePath: 'assets/images/juice-level-icon.png',
                            subtitle:
                                'In a group, your way to stand out is to...',
                            provider: provider),
                        skillWidget(
                            selectedItems: provider.selectedPickupGame,
                            allItems: pickupGame,
                            title: 'Pickup Game',
                            imagePath: 'assets/images/pickup-game-icon.png',
                            subtitle:
                                'You see your crush and walk over. Your first words are...',
                            provider: provider),
                        skillWidget(
                            selectedItems: provider.selectedGoalDigger,
                            allItems: goalDigger,
                            title: 'Goal Digger',
                            imagePath: 'assets/images/goal-digger-icon.png',
                            subtitle: 'Your free time is spent working on...',
                            provider: provider),
                      ],
                    ),
                  ),
                  // Fixed bottom section
                  Container(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Select 3 answers',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'ReservationWide',
                                color: AppColors.mediumGrey)),
                        const SizedBox(height: 30),
                        Builder(builder: (context) {
                          bool isButtonEnabled = _getSelectionValidation(
                              provider, provider.currentIndex);
                          return CustomButton(
                              onTap: isButtonEnabled
                                  ? () async {
                                      provider
                                          .updateRizzQuizApiFromCarouselPage();
                                    }
                                  : null,
                              txtClr: isButtonEnabled
                                  ? null
                                  : AppColors.white.withValues(alpha: 0.52),
                              btnClr: isButtonEnabled
                                  ? null
                                  : const Color(0xff493E77),
                              title: provider.currentIndex == 4
                                  ? 'Get Score'
                                  : 'Next',
                              btnWidth: 150,
                              txtSize: 12);
                        }),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  bool _getSelectionValidation(OnboardProvider provider, int index) {
    switch (index) {
      case 0:
        return provider.selectedFlexFactors.length == 3;
      case 1:
        return provider.selectedDripCheck.length == 3;
      case 2:
        return provider.selectedJuiceLevel.length == 3;
      case 3:
        return provider.selectedPickupGame.length == 3;
      case 4:
        return provider.selectedGoalDigger.length == 3;
      default:
        return false;
    }
  }

  Widget skillWidget({
    required List<Options> selectedItems,
    required List<Options> allItems,
    required String imagePath,
    required String title,
    required String subtitle,
    required OnboardProvider provider,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          Row(
            children: [
              Image.asset(imagePath, width: 24),
              const SizedBox(width: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'ReservationWide',
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  color: AppColors.white,
                  fontSize: 26,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            subtitle,
            style: TextStyle(
              fontFamily: 'ReservationWide',
              fontWeight: FontWeight.w700,
              color: AppColors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8.0,
            runSpacing: 12,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: allItems.map((item) {
              final isSelected =
                  selectedItems.any((element) => element.text == item.text);
              return GestureDetector(
                  onTap: selectedItems.length < 3 || isSelected
                      ? () {
                          if (isSelected) {
                            selectedItems.removeWhere(
                                (element) => element.text == item.text);
                          } else {
                            selectedItems.add(item);
                          }
                          provider.notifyListeners();
                        }
                      : null,
                  child: IntrinsicWidth(
                    child: Container(
                      height: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? AppColors.lime : AppColors.shadowClr,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.black, width: 2.5),
                        boxShadow: [
                          BoxShadow(
                            color: isSelected
                                ? AppColors.black
                                : AppColors.shadowClr,
                            offset: const Offset(4.18, 4.18),
                            blurRadius: 0,
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          item.text ?? '',
                          style: TextStyle(
                            color:
                                isSelected ? AppColors.black : AppColors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'ReservationWide',
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  ));
            }).toList(),
          ),
          const SizedBox(height: 40), // Extra bottom padding for scroll
        ],
      ),
    );
  }
}
