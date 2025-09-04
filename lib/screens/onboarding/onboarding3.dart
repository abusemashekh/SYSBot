import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;

import '../../config/colors.dart';
import '../../widgets/custom_button.dart';
import 'core_dating_skills.dart';

class Onboarding3 extends StatefulWidget {
  const Onboarding3({super.key});

  @override
  State<Onboarding3> createState() => _Onboarding3State();
}

class _Onboarding3State extends State<Onboarding3> {
  rive.Artboard? _artboard;

  @override
  void initState() {
    super.initState();
    _loadRive();
  }

  Future<void> _loadRive() async {
    final data = await rootBundle.load('assets/animations/onboarding-car.riv');
    await rive.RiveFile.initialize();
    final file = rive.RiveFile.import(data);
    final artboard = file.mainArtboard;

    final controller = rive.StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
    );
    if (controller != null) {
      artboard.addController(controller);
    }

    setState(() {
      _artboard = artboard;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff0A0A0A),
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/top-gradient-bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Transform your dating life in 30 challenges or less.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'ReservationWide',
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    color: AppColors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.6,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/city-without-car.png',
                      height: height * 0.6,
                      fit: BoxFit.cover,
                    ),
                    if (_artboard != null)
                      rive.Rive(
                        artboard: _artboard!,
                        fit: BoxFit.contain,
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'ReservationWide',
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      color: AppColors.white,
                      fontSize: 13,
                    ),
                    children: [
                      const TextSpan(text: 'Your next few weeks will be the '),
                      TextSpan(
                        text: 'most transformative period',
                        style: TextStyle(color: AppColors.lime),
                      ),
                      const TextSpan(text: ' of your life ever.'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CustomButton(
                    onTap: () => Get.to(CoreDatingSkills()),
                    btnWidth: 150,
                    txtSize: 12,
                    title: 'Start Your Engine',
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
