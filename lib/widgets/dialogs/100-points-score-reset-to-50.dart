import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/colors.dart';
import '../gradient_circular_progress_bar.dart';
import '../gradient_text.dart';

class ScoreResetTo50 extends StatelessWidget {
  const ScoreResetTo50({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      alignment: Alignment.center,
      backgroundColor: Colors.transparent,
      content: SizedBox(
        height: 400,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 322,
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
                    const SizedBox(height: 70),
                    Text('Overall'.toUpperCase(), style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: AppColors.lime, fontFamily: 'ReservationWide')),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/arrow-up.png', width: 7),
                        Text(' LEVEL UP', style: TextStyle(fontFamily: 'ReservationWide', fontSize: 12, fontStyle: FontStyle.italic, fontWeight: FontWeight.w900, color: AppColors.white)),
                      ],
                    ),
                    const Spacer(),
                    GradientCircularProgress(percentage: 100, size: 96, innerSize: 72, textSize: 16, colors: [AppColors.lime, AppColors.themeClr, AppColors.lime]),
                    const Spacer(),
                    Text('Congrats on 100 points!\nYour scores will now\nreset to 50.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontFamily: 'ReservationWide', color: AppColors.white, fontWeight: FontWeight.w700)),
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
