import 'package:flutter/material.dart';

import '../config/colors.dart';

class LinearProgressBar extends StatelessWidget {
  const LinearProgressBar({
    super.key,
    required this.text,
    required this.minutesCompleted,
    required this.isLocked,
    this.iconPath,
  });

  final String text;
  final double minutesCompleted;
  final bool isLocked;
  final String? iconPath;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Stack(
        children: [
          Container(
            height: 40,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    color: AppColors.black.withValues(alpha: 0.3), width: 2.75),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.white.withValues(alpha: 0.17),
                      offset: const Offset(4.18, 4.18),
                      spreadRadius: 0)
                ]),
            child: LinearProgressIndicator(
              value: minutesCompleted / 15,
              minHeight: 40,
              borderRadius: BorderRadius.circular(4),
              backgroundColor: AppColors.white.withValues(alpha: 0),
              color: AppColors.themeClr,
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            child: SizedBox(
              width: width - 40,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  Image.asset('assets/images/play-icon.png', width: 12),
                  const SizedBox(width: 10),
                  if(iconPath != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Image.asset(iconPath!, width: 16),
                    ),
                  Expanded(
                    child: Text(text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: 'ReservationWide',
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                            color: AppColors.white.withValues(alpha: isLocked ? 0.7 : 1))),
                  ),
                  Text('[${minutesCompleted.toInt()}m]',
                      style: TextStyle(
                          fontFamily: 'ReservationWide',
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                          color: AppColors.lime)),
                  Visibility(
                    visible: isLocked == true,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Image.asset('assets/images/lock-icon.png', width: 16),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}