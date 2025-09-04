
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../config/colors.dart';
import '../../../provider/onboard_provider.dart';
import '../../../widgets/custom_button.dart';
import 'give_quiz.dart';


class RizzQuiz extends StatelessWidget {
  const RizzQuiz({super.key});

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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 36),
                Image.asset('assets/images/brain-circuit.png', width: 48),
                const SizedBox(height: 6),
                Text('Rizz Quiz',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'ReservationWide',
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        color: AppColors.white,
                        fontSize: 26)),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text('Let’s test your dating skills and see what area’s we can improve on ASAP.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'ReservationWide',
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        fontSize: 14,
                      )),
                ),
                const SizedBox(height: 12),
                Image.asset('assets/images/character-sitting-on-chair.png', height: height*0.45),
                const SizedBox(height: 8),
                CustomButton(
                    onTap: () {
                      final provider = Provider.of<OnboardProvider>(context, listen: false);
                      provider.setRizzDataToLocalStorage();
                    },
                    title: 'Take my Rizz Quiz', btnWidth: 150, txtSize: 12),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
