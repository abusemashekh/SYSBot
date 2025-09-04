import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:sysbot3/screens/onboarding/rizz_quiz/rizz_quiz.dart';

import '../../config/colors.dart';
import '../../widgets/custom_button.dart';


class ShowLove extends StatelessWidget {
  const ShowLove({super.key});

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
                image: AssetImage('assets/images/left-gradient-bg.png'), fit: BoxFit.cover
            )
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () => Get.to(RizzQuiz()),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset('assets/images/close-icon-circle.png', width: 30)),
                  ),
                  Image.asset('assets/images/user-with-heart.png', width: 48),
                  const SizedBox(height: 6),
                  Text('Help us help you',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'ReservationWide',
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          color: AppColors.white,
                          fontSize: 20)),
                  const SizedBox(height: 30),
                  Image.asset('assets/images/100k-members2.png', width: 180),
                  const SizedBox(height: 20),
                  Text('Shoot Your Shot Bot was built for people like you who want to master real-world dating skills.\n\nA quick 5-star rating helps us drop new quests, keep the price low, & provide you future benefits.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                    fontFamily: 'ReservationWide',
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                    fontSize: 12,
                  )),
                  const SizedBox(height: 40),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      List<String> images = ['assets/images/dummy-user.png', 'assets/images/dummy-user2.png', 'assets/images/dummy-user3.png', 'assets/images/dummy-user4.png'];
                      List<String> titles = ['Jason, SYS Bot user since 24', 'Kyle, SYS Bot user since 24’', 'Evan, SYS Bot user since 24’', 'Drew, SYS Bot user since 24’'];

                      List<Widget> reviewWidgets = [
                        RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'ReservationWide',
                            color: AppColors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                          children: [
                            const TextSpan(text: "“I tried the pickup line and screenshot apps but they were a "),
                            const TextSpan(
                              text: "temporary fix",
                              style: TextStyle(color: AppColors.lime),
                            ),
                            const TextSpan(text: ".\n\nI think the reason Shoot Your Shot Bot worked for me was because it builds up your "),
                            const TextSpan(
                              text: "skills",
                              style: TextStyle(color: AppColors.lime),
                            ),
                            const TextSpan(text: ". You actually become a skilled dater IRL, u don't have to fake or pretend. Now im dating and not needing to pull out my phone to figure out what to say. The girls I date actually like me for me and not a script.”"),
                          ],
                        ),
                      ),
                        RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'ReservationWide',
                            color: AppColors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                          children: [
                            const TextSpan(text: "“I was looking for an "),
                            const TextSpan(
                              text: "affordable dating coach ",
                              style: TextStyle(color: AppColors.lime),
                            ),
                            const TextSpan(text: "or a dating self improvement program. This app provided me with both on a budget. The Roadmap and gamification is unlike any other dating wingman app in the appstore. It feels "),
                            const TextSpan(
                              text: "like im playing a video game ",
                              style: TextStyle(color: AppColors.lime),
                            ),
                            const TextSpan(text: " with a dopamine hit for every quest I complete while at the same time improving my skillset”"),
                          ],
                        ),
                      ),
                        RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'ReservationWide',
                            color: AppColors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                          children: [
                            const TextSpan(text: "“If you are not using the Bot to level up your game you are truly missing out. Just in a few weeks my "),
                            const TextSpan(
                              text: "confidence level is at an all time high",
                              style: TextStyle(color: AppColors.lime),
                            ),
                            const TextSpan(text: ", it’s like dating on steroids lol deff an unfair advantage that’ll give you the upper hand you need to separate yourself from the competition and win over your crush”"),
                          ],
                        ),
                      ),
                        RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'ReservationWide',
                            color: AppColors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                          children: [
                            const TextSpan(text: "“This app helped me gain much more "),
                            const TextSpan(
                              text: "courage",
                              style: TextStyle(color: AppColors.lime),
                            ),
                            const TextSpan(text: " as a man to talk to girls. It’s literally like having a personal coach available 24/7. I use it on a daily basis!”"),
                          ],
                        ),
                      ),
                      ];

                      return Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.only(bottom: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.black, width: 2.5),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.white.withValues(alpha: 0.18),
                              offset: const Offset(3, 3.5),
                              blurRadius: 0,
                              spreadRadius: 1
                            )
                          ]
                        ),
                       child: Column(
                         children: [
                           reviewWidgets[index],
                           const SizedBox(height: 16),
                           Row(
                             children: [
                               const SizedBox(width: 8),
                               Image.asset(images[index], width: 26),
                               const SizedBox(width: 12),
                               Expanded(child: Text(titles[index], style: TextStyle(fontFamily: 'ReservationWide', fontWeight: FontWeight.w900, fontSize: 9, color: AppColors.lightGrey)))
                             ],
                           )
                         ],
                       )
                      );
                    },
                  ),
                  const SizedBox(height: 110),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        width: width,
        height: 120,
        padding: EdgeInsets.only(bottom: 20, left: width*0.125),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.75),
              blurRadius: 30,
              offset: const Offset(0, 20)
            )
          ]
        ),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: CustomButton(onTap: () async{
              final InAppReview inAppReview = InAppReview.instance;
              if (await inAppReview.isAvailable()) {
              inAppReview.requestReview();
              }
            }, title: 'Show Love', btnWidth: 150)),
      ),
    );
  }
}
