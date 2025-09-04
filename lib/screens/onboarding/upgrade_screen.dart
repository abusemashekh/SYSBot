import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';
import 'package:sysbot3/utils/functions/open_url.dart';

import '../../config/colors.dart';
import '../../provider/upgrade_provider.dart';

class UpgradeScreen extends StatelessWidget {
  UpgradeScreen({super.key});

  final carouselController = PageController();
  final RxInt currentIndex = 0.obs;
  final RxBool isTrialEnabled = false.obs;
  final RxString selectedPlan = ''.obs;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff0C1018),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            SizedBox(
              height: height * 0.4,
              child: PageView(
                dragStartBehavior: DragStartBehavior.down,
                controller: carouselController,
                onPageChanged: (index) {
                  currentIndex.value = index;
                },
                children: [
                  carouselWidget(
                      title: 'Talk 1-on-1 With Your\nAI Wingman',
                      imagePath: 'assets/images/upgrade-hero-image1.png'),
                  carouselWidget(
                      title: 'Know Your Score\nGrow Your Game',
                      imagePath: 'assets/images/upgrade-hero-image2.png'),
                  carouselWidget(
                      title: 'Climb the Rizz Games\nLeaderboard',
                      imagePath: 'assets/images/upgrade-hero-image3.png'),
                ],
              ),
            ),
            SmoothPageIndicator(
              controller: carouselController,
              count: 3,
              effect: SwapEffect(
                  activeDotColor: AppColors.lime,
                  dotColor: AppColors.mediumGrey,
                  dotHeight: 9,
                  dotWidth: 9,
                  spacing: 8,
                  strokeWidth: 2),
            ),
            const SizedBox(height: 15),
            Container(
                width: width,
                height: height * 0.0731,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.only(left: 15, right: 6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color(0xff030202),
                    border: Border.all(
                        color: Color(0xffd9d9d9).withValues(alpha: 0.6),
                        width: 3)),
                child: Row(
                  children: [
                    Expanded(
                        child: Text('Not sure yet? Enable free trial.',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: 'ReservationWide',
                                fontSize: width * 0.0333,
                                fontWeight: FontWeight.w900,
                                color: AppColors.white))),
                    Transform.scale(
                      scale: 0.8,
                      child: Obx(() => CupertinoSwitch(
                            inactiveTrackColor: const Color(0xff3F3F3F),
                            value: isTrialEnabled.value,
                            onChanged: (bool value) {
                              isTrialEnabled.value = value;
                              if (isTrialEnabled.value == true) {
                                selectedPlan.value = 'weekly';
                              }
                            },
                          )),
                    )
                  ],
                )),
            const SizedBox(height: 15),
            SizedBox(
              height: height * 0.1063,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        selectedPlan.value = 'yearly';
                        isTrialEnabled.value = false;
                      },
                      child: Obx(() => Container(
                          width: width,
                          height: height * 0.0904,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.only(left: 15, right: 6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: selectedPlan.value == 'yearly'
                                  ? Color(0xff6552FE).withValues(alpha: 0.7)
                                  : Color(0xff1C1C1C),
                              border: Border.all(
                                  color: selectedPlan.value == 'yearly'
                                      ? Color(0xff6552FE)
                                      : AppColors.black,
                                  width: 3),
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        AppColors.white.withValues(alpha: 0.17),
                                    offset: const Offset(4.18, 4.18))
                              ]),
                          child: Row(
                            children: [
                              Expanded(
                                  child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'ReservationWide',
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.white,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Yearly Access\n',
                                      style:
                                          TextStyle(fontSize: width * 0.03888),
                                    ),
                                    TextSpan(
                                      text: '\$49.99 per year',
                                      style: TextStyle(
                                          fontSize: width * 0.0305, height: 2),
                                    ),
                                  ],
                                ),
                                overflow: TextOverflow.ellipsis,
                              )),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'ReservationWide',
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.white,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '\$0.96\n',
                                      style:
                                          TextStyle(fontSize: width * 0.03888),
                                    ),
                                    TextSpan(
                                      text: 'per week',
                                      style: TextStyle(
                                          fontSize: width * 0.0305,
                                          height: 2,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ))),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 48,
                    child: Container(
                      width: 84,
                      height: 18,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text('BEST OFFER',
                              style: TextStyle(
                                  fontFamily: 'ReservationWide',
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 9))),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                selectedPlan.value = 'weekly';
              },
              child: Obx(() => Container(
                  width: width,
                  height: height * 0.0851,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(left: 15, right: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: selectedPlan.value == 'weekly'
                          ? Color(0xff6552FE).withValues(alpha: 0.7)
                          : Color(0xff1C1C1C),
                      border: Border.all(
                          color: selectedPlan.value == 'weekly'
                              ? Color(0xff6552FE)
                              : AppColors.black,
                          width: 3),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.white.withValues(alpha: 0.17),
                            offset: const Offset(4.18, 4.18))
                      ]),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Weekly Access',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'ReservationWide',
                          fontWeight: FontWeight.w900,
                          fontSize: width * 0.03888,
                          color: AppColors.white,
                        ),
                      )),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'ReservationWide',
                            fontWeight: FontWeight.w900,
                            color: AppColors.white,
                          ),
                          children: [
                            TextSpan(
                              text: '\$6.99\n',
                              style: TextStyle(fontSize: width * 0.03888),
                            ),
                            TextSpan(
                              text: 'per week',
                              style: TextStyle(
                                  fontSize: width * 0.0305,
                                  height: 2,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ))),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                final upgradeProvider = Provider.of<UpgradeProvider>(context, listen: false);
                upgradeProvider.purchaseSubscription();
              },
              child: Container(
                  width: width,
                  height: height * 0.07313,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(left: 15, right: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: AppColors.black, width: 1),
                      gradient: LinearGradient(
                          stops: [0, 0.5],
                          colors: [Color(0xff3C77FE), Color(0xff6552FE)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.white.withValues(alpha: 0.12),
                            offset: const Offset(4.18, 4.18))
                      ]),
                  child: Center(
                      child: Text('Start free trial',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'ReservationWide',
                              fontSize: width * 0.04722,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white)))),
            ),
            const SizedBox(height: 10),
            Text('CANCEL ANYTIME',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: 'ReservationWide',
                    fontSize: width * 0.0305,
                    fontWeight: FontWeight.w900,
                    color: AppColors.white)),
            const Spacer(),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.0333,
                  fontWeight: FontWeight.w400,
                  fontFamily: '',
                ),
                children: [
                  TextSpan(
                    text: 'Terms of Use',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        openUrl(
                            androidUrl: 'http://shootyourshot.ai/terms',
                            iosUrl: 'http://shootyourshot.ai/terms');
                      },
                  ),
                  const TextSpan(
                    text: '  •  ',
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        openUrl(
                            androidUrl: "http://shootyourshot.ai/privacy",
                            iosUrl: "http://shootyourshot.ai/privacy");
                      },
                  ),
                  const TextSpan(
                    text: '  •  ',
                  ),
                  TextSpan(
                    text: 'Restore',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Handle Restore tap
                      },
                  ),
                ],
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }

  Widget carouselWidget({required String title, required String imagePath}) {
    return Stack(
      children: [
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(imagePath, height: Get.height * 0.41)),
        Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'AudioWide',
                    color: AppColors.white,
                    fontSize: Get.width * 0.06388))),
      ],
    );
  }
}
