import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sysbot3/screens/onboarding/rizz_quiz/referral_code_bottom_sheet.dart';
import 'package:sysbot3/screens/onboarding/upgrade_screen.dart';

import '../../../config/colors.dart';
import '../../../widgets/custom_button.dart';
import 'give_quiz.dart';

class SeeResult extends StatelessWidget {
  SeeResult({super.key});

  final RxBool isLoading = false.obs;
  final RxBool showNoMoreInvitesTxt = false.obs;

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
                image: AssetImage('assets/images/left-gradient-bg.png'),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    Image.asset('assets/images/test-tube-icon.png', width: 48),
                    const SizedBox(height: 6),
                    Text('See Your Result',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'ReservationWide',
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            color: AppColors.white,
                            fontSize: 22)),
                    const Spacer(),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'ReservationWide',
                              fontWeight: FontWeight.w700,
                              fontSize: 12.5,
                            ),
                            children: [
                              TextSpan(
                                text: 'Your personalized Report',
                                style: TextStyle(color: AppColors.lime),
                              ),
                              TextSpan(
                                text:
                                    ' is ready. Invite 3 friends or get Shot Bot Pro to reveal',
                                style: TextStyle(color: AppColors.white),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(height: 12),
                    Image.asset('assets/images/hidden-rizz-report.png',
                        height: height * 0.5),
                    const SizedBox(height: 8),
                    CustomButton(
                      onTap: () => Get.to(UpgradeScreen()),
                      title: 'Get Shot Bot Pro',
                      iconPath: 'assets/images/raising-hand-emoji.png',
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                        onTap: () {
                          openReferralCodeBottomSheet(
                              context: context,
                              isLoading: isLoading,
                              showNoMoreInvitesTxt: showNoMoreInvitesTxt);
                        },
                        title: 'Invite 3 Friends',
                        txtClr: AppColors.black,
                        btnClr: AppColors.lime),
                    const Spacer(flex: 2)
                  ],
                ),
              ),
              Obx(() => Visibility(
                    visible: isLoading.value,
                    child: Container(
                      height: height,
                      width: width,
                      color: Colors.black.withValues(alpha: 0.7),
                      child: showNoMoreInvitesTxt.value == false
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Checking Referrals...',
                                    style: TextStyle(
                                        fontFamily: 'SFProRound',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20)),
                                const SizedBox(height: 15),
                                SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator(
                                        color: AppColors.white))
                              ],
                            )
                          : Center(
                              child: Text('Need more invites',
                                  style: TextStyle(
                                      fontFamily: 'SFProRound',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20))),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
