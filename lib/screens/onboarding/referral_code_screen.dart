import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sysbot3/screens/onboarding/onboarding3.dart';
import 'package:sysbot3/screens/onboarding/rizz_quiz/rizz_quiz.dart';

import '../../config/colors.dart';
import '../../provider/onboard_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/snackbars.dart';


class ReferralCodeScreen extends StatelessWidget {
  ReferralCodeScreen({super.key});

  final String refCode = 'U4Q58R'; // dummy referral code
  final refCodeController = TextEditingController();

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
              image: AssetImage('assets/images/top-gradient-bg.png'), fit: BoxFit.cover
          )
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Spacer(),
                Text('Do you have a referral code?',
                    style: TextStyle(
                        fontFamily: 'ReservationWide',
                        fontWeight: FontWeight.w900,
                        color: AppColors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 24)),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: TextFormField(
                    controller: refCodeController,
                    cursorColor: AppColors.dimGrey,
                    style: TextStyle(
                        fontFamily: 'ReservationWide',
                        fontWeight: FontWeight.w700,
                        color: AppColors.dimGrey,
                        fontSize: 15),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        filled: true,
                        hintText: 'aR8t3c',
                        hintStyle: TextStyle(
                            fontFamily: 'ReservationWide',
                            fontWeight: FontWeight.w700,
                            color: AppColors.dimGrey,
                            fontSize: 15),
                        fillColor: AppColors.darkCharcoal.withValues(alpha: 0.68),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7))),
                  ),
                ),
                const SizedBox(height: 12),
                Text('Enter your code here or skip',
                    style: TextStyle(
                        fontFamily: 'ReservationWide',
                        fontWeight: FontWeight.w700,
                        color: AppColors.mediumGrey,
                        fontSize: 14)),
                const Spacer(flex: 6),
                CustomButton(
                    onTap: () async{
                      if (refCodeController.text.trim().isNotEmpty) {
                        // referral code is valid
                        final provider = Provider.of<OnboardProvider>(context, listen: false);
                        provider.addReferralCode(refCodeController.text);
                      } else if (refCodeController.text.trim().isEmpty) {
                        Get.offAll(() => Onboarding3());
                      } else {
                        showErrorSnackBar(text: 'Invalid Code');
                      }
                    },
                    title: 'Continue'),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }

  SnackbarController invalidCodeSnackbar() {
    return Get.snackbar('', '',
        boxShadows: [
          BoxShadow(
              offset: const Offset(3, 5),
              color: AppColors.white,
              spreadRadius: 0,
              blurRadius: 0.1
          )
        ],
        borderWidth: 1,
        borderColor: AppColors.black,
        titleText: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text('Invalid Code',
              style: TextStyle(
                  fontFamily: 'ReservationWide',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.white)),
        ),
        messageText: SizedBox(),
        colorText: AppColors.white,
        icon:
        Center(child: Image.asset('assets/images/close-icon.png', width: 16)),
        borderRadius: 12,
        backgroundColor: AppColors.red,
        shouldIconPulse: false,
        padding:
        EdgeInsets.only(left: 20, top: 12, bottom: 12));
  }

}
