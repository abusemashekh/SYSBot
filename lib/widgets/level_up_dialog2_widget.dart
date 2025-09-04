import 'package:flutter/material.dart';

import '../config/colors.dart';
import 'gradient_circular_progress_bar.dart';
import 'level_up_dialog1_widget.dart';

class LevelUpDialog2Widget extends StatelessWidget {
  const LevelUpDialog2Widget({super.key, required this.title, required this.percentage});
  final String title;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Center(
        child: Container(
          padding: EdgeInsets.only(left: 16, top: 24, bottom: 20, right: 12),
          width: MediaQuery.of(context).size.width * 0.68,

          decoration: BoxDecoration(
              color: const Color(0xff00001E),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.shadowClr, width: 3),
              boxShadow: [
                BoxShadow(
                    color: AppColors.shadowClr,
                    spreadRadius: 0,
                    offset: const Offset(3, 4)),
              ]),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(getTopImage(title), width: 52),
              const SizedBox(height: 8),
              Text(title.toUpperCase(), style: TextStyle(fontFamily: 'ReservationWide', fontSize: 20, fontWeight: FontWeight.w900, color: title.toLowerCase() == "overall" ? Color(0xffFF2929) : AppColors.lime)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/arrow-up.png', width: 7),
                  Text(' LEVEL UP', style: TextStyle(fontFamily: 'ReservationWide', fontSize: 12, fontStyle: FontStyle.italic, fontWeight: FontWeight.w900, color: AppColors.white)),
                ],
              ),
              const SizedBox(height: 16),
              GradientCircularProgress(percentage: percentage, size: 96, innerSize: 72, textSize: 16, colors: title.toLowerCase() == "overall" ? [Color(0xffFF2929), Color(0xffFF2929)] : null),
              const SizedBox(height: 30),
              Text(textAlign: TextAlign.center, 'Congrats!\nYou level\'d up!', style: TextStyle(fontFamily: 'ReservationWide', fontSize: 12, color: AppColors.white, fontStyle: FontStyle.italic, fontWeight: FontWeight.w900)),
            ],
          ),
        ),
      ),
    );
  }
}
