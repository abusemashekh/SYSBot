import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/colors.dart';
import '../gradient_text.dart';

class NewLevelDialog extends StatelessWidget {
  const NewLevelDialog({super.key, required this.level});
  final String level;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      alignment: Alignment.center,
      backgroundColor: Colors.transparent,
      content: SizedBox(
        height: 390,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 312,
                margin: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    color: const Color(0xff00001E),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.shadowClr, width: 3),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.shadowClr,
                          offset: const Offset(3, 4),
                          spreadRadius: 0
                      )
                    ]
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    GradientText(gradientColors: const [Color(0xffFF8177), Color(0xffFF867A), Color(0xffFF8C7F), Color(0xffF99185), Color(0xffCF556C), Color(0xffB12A5B)] ,textWidget: Text(level.toUpperCase(), style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: AppColors.white, fontFamily: 'ReservationWide'))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/arrow-up.png', width: 7),
                        Text(' LEVEL UP', style: TextStyle(fontFamily: 'ReservationWide', fontSize: 12, fontStyle: FontStyle.italic, fontWeight: FontWeight.w900, color: AppColors.white)),
                      ],
                    ),
                    const Spacer(),
                    Image.asset(level == 'Rizz King' ? 'assets/images/2-shields.png' : level == 'Rizz God' ? 'assets/images/3-shields.png' : level == 'Hall of Game' ? 'assets/images/4-shields.png' : 'assets/images/shield-icon.png', height: level == 'Rizz King' ? 57 : level == 'Rizz God' ? 67 : level == 'Hall of Game' ? 80 : 70),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'ReservationWide',
                            fontSize: 13,
                            height: 1.25,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                          children: [
                            const TextSpan(text: 'Congrats!\nYou’re an official\n'),
                            TextSpan(
                              text: level != 'Hall of Game' ? '$level!' : 'Hall of Gamer!',
                              style: const TextStyle(fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: SizedBox(
                  height: 200,
                  width: Get.width * 0.3,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.only(right: 8),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 18,
                                    right: 0,
                                    top: 40,
                                    child: Center(
                                      child: Container(
                                        width: 105,
                                        height: 105,
                                        decoration: BoxDecoration(
                                            shape:
                                            BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/dummy-user-img.png'),
                                                fit: BoxFit
                                                    .cover)),
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                      'assets/images/user-level-up-circle-crown.png',
                                      width: 127,
                                      height: 144),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),)
          ],
        ),
      ),
    );
  }
}
