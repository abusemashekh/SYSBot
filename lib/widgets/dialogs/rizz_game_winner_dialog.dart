import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sysbot3/backend/local_storage/local_storage.dart';
import 'package:sysbot3/utils/functions/common_fun.dart';
import 'package:sysbot3/widgets/gradient_text.dart';

Future rizzGameWinnerDialog({required String title}) async {
  ConfettiController confettiController =
      ConfettiController(duration: const Duration(seconds: 1));
  confettiController.play();
  final userImage = LocalStorage().getUserData.data?.profileImage;

  return Get.dialog(Center(
    child: Material(
      color: Colors.transparent,
      child: SizedBox(
        height: 600,
        width: 280,
        child: Stack(
          children: [
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 280,
                  height: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color:
                                const Color(0xff582AFF).withValues(alpha: 0.4),
                            spreadRadius: 0,
                            blurRadius: 40,
                            offset: const Offset(0, 2))
                      ],
                      border: Border.all(color: Color(0xff434343), width: 1),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff2f2f2f),
                          Color(0xff101010),
                          Color(0xff000000)
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      )),
                  child: Column(
                    children: [
                      SizedBox(height: 75),
                      GradientText(
                          textWidget: Text(
                            title.toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'LuckiestGuy',
                              fontSize: 32,
                              color: Colors.white,
                            ),
                          ),
                          gradientColors: [
                            Color(0xffFF867A),
                            Color(0xffFF8C7F),
                            Color(0xffF99185),
                            Color(0xffCF556C),
                            Color(0xffB12A5B)
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("LEVEL UP ",
                              style: TextStyle(
                                  fontFamily: 'LuckiestGuy',
                                  fontSize: 22,
                                  color: Colors.white)),
                          Image.asset('assets/images/arrow-up-icon.png',
                              width: 11)
                        ],
                      ),
                      const SizedBox(height: 20),
                      Image.asset(
                          title.toLowerCase() == 'rizz king'
                              ? 'assets/images/rizz-king-shield.png'
                              : title.toLowerCase() == 'rizz god'
                                  ? 'assets/images/rizz-god-shield.png'
                                  : title.toLowerCase() == 'hall of gamer'
                                      ? 'assets/images/hall-of-game-shield.png'
                                      : 'assets/images/rizzler-shield.png',
                          width: title.toLowerCase() == 'rizz king'
                              ? 131
                              : title.toLowerCase() == 'rizz god'
                                  ? 123
                                  : title.toLowerCase() == 'hall of gamer'
                                      ? 123
                                      : 88),
                      const SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Congratulations 🎉\nYou are an official',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'SFCompactRounded',
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w300)),
                      ),
                      Text("$title!".toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'SFCompactRounded',
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w900)),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Center(
                child: Image.asset('assets/images/crown-with-circle.png',
                    width: 127),
              ),
            ),
            Positioned(
                top: 40,
                left: 18,
                right: 0,
                child: Center(
                    child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: manipulateImage(userImage), fit: BoxFit.cover),
                  ),
                ))),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: confettiController,
                blastDirection: 3.14 / 2,
                // downwards
                emissionFrequency: 1,
                numberOfParticles: 20,
                gravity: 0.5,
                shouldLoop: false,
                blastDirectionality: BlastDirectionality.explosive,
                maxBlastForce: 10,
                minBlastForce: 5,
              ),
            ),
          ],
        ),
      ),
    ),
  ));
}
