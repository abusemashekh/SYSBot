import 'package:flutter/material.dart';

import '../config/colors.dart';
import 'gradient_text.dart';

class LevelUpDialog1Widget extends StatelessWidget {
  const LevelUpDialog1Widget({super.key, required this.title});
  final String title;

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
              GradientText(
                  gradientColors: getTextGradient(title),
                  textWidget: Text(title.toUpperCase(), style: TextStyle(fontFamily: 'ReservationWide', fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.white))
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/arrow-up.png', width: 7),
                  Text(' LEVEL UP', style: TextStyle(fontFamily: 'ReservationWide', fontSize: 12, fontStyle: FontStyle.italic, fontWeight: FontWeight.w900, color: AppColors.white)),
                ],
              ),
              const SizedBox(height: 16),
              Image.asset(getBottomImage(title), width: 78),
              const SizedBox(height: 30),
              Text(textAlign: TextAlign.center, 'Congrats!\nYou level\'d up!', style: TextStyle(fontFamily: 'ReservationWide', fontSize: 12, color: AppColors.white, fontStyle: FontStyle.italic, fontWeight: FontWeight.w900)),
            ],
          ),
        ),
      ),
    );
  }
}


String getTopImage(String input) {
  switch (input.toLowerCase()) {
    case 'flex factor':
      return 'assets/images/flex-factor-icon.png';
    case 'drip check':
      return 'assets/images/drip-check-icon.png';
    case 'juice level':
      return 'assets/images/juice-level-icon.png';
    case 'pickup game':
      return 'assets/images/pickup-game-icon.png';
    case 'goal digger':
      return 'assets/images/goal-digger-icon.png';
    case 'overall':
      return 'assets/images/100-icon.png';
    default:
      return 'assets/images/flex-factor-icon.png';
  }
}


String getBottomImage(String input) {
  switch (input.toLowerCase()) {
    case 'flex factor':
      return 'assets/images/flex-factor-level-up.png';
    case 'drip check':
      return 'assets/images/drip-check-level-up.png';
    case 'juice level':
      return 'assets/images/juice-level-up.png';
    case 'pickup game':
      return 'assets/images/pickup-game-level-up.png';
    case 'goal digger':
      return 'assets/images/goal-digger-level-up.png';
    case 'overall':
      return 'assets/images/overall-level-up.png';
    default:
      return 'assets/images/flex-factor-level-up.png';
  }
}

List<Color> getTextGradient(String input) {
  switch (input.toLowerCase()) {
    case 'flex factor':
      return [Color(0xffF9D423), Color(0xffFF4E50)];
    case 'drip check':
      return [Color(0xff00C6FB), Color(0xff005BEA)];
    case 'juice level':
      return [Color(0xff2AF598), Color(0xff009EFD)];
    case 'pickup game':
      return [Color(0xffFF5858), Color(0xffF09819)];
    case 'goal digger':
      return [Color(0xffDCAA07), Color(0xffDFA579)];
    case 'overall':
      return [Color(0xffFF2929), Color(0xffFF2929)];
    default:
      return [Color(0xffF9D423), Color(0xffFF4E50)];
  }
}