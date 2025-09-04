import 'package:flutter/material.dart';

import '../config/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.shadowClr, this.iconPath, this.iconWidth, this.btnWidth, this.btnHeight, this.txtSize, this.txtClr, this.btnClr, required this.title, this.onTap});
  final String title;
  final double? btnWidth;
  final double? btnHeight;
  final Color? btnClr;
  final Color? txtClr;
  final double? txtSize;
  final VoidCallback? onTap;
  final String? iconPath;
  final double? iconWidth;
  final Color? shadowClr;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: btnWidth ?? width,
        height: btnHeight ?? 42,
        decoration: BoxDecoration(
          color: btnClr ?? AppColors.themeClr,
          borderRadius: BorderRadius.circular(6),
            border: Border(
              bottom: BorderSide(
                color: AppColors.black,
                width: 2.8,
              ),
              right: BorderSide(
                color: AppColors.black,
                width: 2.8,
              ),
            ),
          boxShadow: [
            BoxShadow(
              color: shadowClr ?? AppColors.white,
              offset: const Offset(4.18, 4.18),
              spreadRadius: 0,
              blurRadius: 0
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(fontFamily: 'ReservationWide', fontWeight: FontWeight.w900, fontSize: txtSize ?? 16, color: txtClr ?? AppColors.white)),
            if(iconPath!= null)
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Image.asset(iconPath!, width: iconWidth ?? 23),
            )
          ],
        ),
      ),
    );
  }
}
