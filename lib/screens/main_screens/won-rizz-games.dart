import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sysbot3/utils/functions/open_url.dart';

import '../../config/colors.dart';

import '../../widgets/custom_button.dart';

class WonRizzGames extends StatelessWidget {
  const WonRizzGames({super.key});

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
                image: AssetImage('assets/images/top-gradient-bg.png'),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2),
              Image.asset('assets/images/congrats-you-win-text.png',
                  width: width * 0.8),
              const Spacer(),
              Image.asset('assets/images/winner.png', height: height * 0.55),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RichText(
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
                      TextSpan(
                          text: 'You did it!',
                          style: TextStyle(color: AppColors.lime)),
                      TextSpan(
                        text:
                            ' Now take this W into real life. Use what you’ve learned or ',
                      ),
                      TextSpan(
                          text: 'Keep Going',
                          style: TextStyle(color: AppColors.lime)),
                      TextSpan(text: ' to run up your Rizz Report scores.'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: CustomButton(
                            onTap: () {
                              openUrl(
                                  androidUrl:
                                      'https://play.google.com/store/apps/details?id=com.shootyourshot&hl=en',
                                  iosUrl:
                                      'https://apps.apple.com/us/app/shoot-your-shot-dating-app/id1497413070?platform=iphone');
                            },
                            title: 'Download Shoot Your Shot',
                            txtSize: width * 0.0319)),
                    const SizedBox(width: 15),
                    Expanded(
                      child: CustomButton(
                          onTap: () => Get.back(),
                          txtSize: width * 0.0319,
                          btnClr: AppColors.lime,
                          txtClr: AppColors.black,
                          title: 'Keep Going'),
                    ),
                  ],
                ),
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
