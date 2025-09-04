import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sysbot3/screens/onboarding/referral_code_screen.dart';

import '../../config/colors.dart';
import '../../provider/onboard_provider.dart';
import '../../utils/functions/open_url.dart';
import '../../widgets/custom_button.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/onboarding1-bg.png"),
                fit: BoxFit.fill)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/logo-with-text.png',
                        height: height * 0.0398),
                    Image.asset('assets/images/100k-members.png',
                        height: height * 0.0638),
                  ],
                ),
                const SizedBox(height: 15),
                Stack(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 12, top: height * 0.16),
                        child: Center(
                            child: Image.asset('assets/images/bot-image.png',
                                height: height * 0.47))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'DrukWide',
                              fontWeight: FontWeight.w700,
                              fontSize: width * 0.072,
                              color: AppColors.white,
                            ),
                            children: [
                              TextSpan(text: 'Gamified\nRizz Drills\nto '),
                              TextSpan(
                                text: 'Real Life\nDating\nSkills',
                                style: TextStyle(color: AppColors.lime),
                              ),
                            ],
                          ),
                        )),
                        Image.asset('assets/images/200k-installs.png',
                            height: height * 0.0658),
                      ],
                    ),
                  ],
                ),
                const Spacer(flex: 3),
                CustomButton(
                    title: 'Continue',
                    onTap: () {
                      final onboardProvider =
                          Provider.of<OnboardProvider>(context, listen: false);
                      onboardProvider.initializeUser();
                    }),
                const Spacer(flex: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'SFUIText',
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(
                          text: 'By tapping Continue, you agree to our ',
                        ),
                        TextSpan(
                          text: 'Terms of Service',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              openUrl(
                                  androidUrl: 'http://shootyourshot.ai/terms',
                                  iosUrl: 'http://shootyourshot.ai/terms');
                            },
                        ),
                        TextSpan(
                          text: ' and ',
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              openUrl(
                                  androidUrl: 'http://shootyourshot.ai/privacy',
                                  iosUrl: 'http://shootyourshot.ai/privacy');
                            },
                        ),
                        TextSpan(
                          text: '.',
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
