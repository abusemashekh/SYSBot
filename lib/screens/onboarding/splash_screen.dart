import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sysbot3/screens/onboarding/level_up_your_rizz.dart';
import 'package:sysbot3/screens/onboarding/onboarding1.dart';
import 'package:sysbot3/screens/onboarding/referral_code_screen.dart';
import 'package:sysbot3/screens/onboarding/rizz_quiz/rizz_quiz.dart';
import 'package:sysbot3/screens/onboarding/rizz_quiz/see_result.dart';
import 'package:sysbot3/screens/onboarding/show_love.dart';
import 'package:sysbot3/widgets/custom_button.dart';
import 'package:video_player/video_player.dart';

import '../../backend/local_storage/local_storage.dart';
import '../bottom_nav_bar.dart';
import 'core_dating_skills.dart';
import 'onboarding3.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  final userData = LocalStorage().getUserData.data;
  final isUserUpgrade = LocalStorage().getIsUserUpgrade;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/splash_video.mov')
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
        _controller.addListener(_checkVideoProgress);
      });
  }

  // Check if the video has finished playing
  void _checkVideoProgress() {
    if (_controller.value.isInitialized &&
        !_controller.value.isPlaying &&
        _controller.value.position >= _controller.value.duration) {
      // Video has finished, navigate to HomeScreen
      _navigateToNextScreenAccordinlgy();
    }
  }

  // Navigate to the screens accordingly and clean up listener
  void _navigateToNextScreenAccordinlgy() {
    _controller.removeListener(_checkVideoProgress);
    _controller.dispose();
    Get.offAll(() => _manageScreens());
  }

  Widget _manageScreens() {
    final scores = [
      userData?.flexFactorScore,
      userData?.dripCheckScore,
      userData?.juiceLevelScore,
      userData?.pickupGameScore,
      userData?.goalDiggerScore,
    ];
    if (userData == null) {
      return Onboarding1();
    } else if ((userData?.overallScore ?? 0) > 0) {
      if (scores.every((score) => score != 0)) {
        // if user use the promocode then it will be true
        final isUserUsedPromocode =
            userData?.settings?.promoCodes?.contains(userData?.promoCode) ??
                false;
        if (((userData?.referredDone ?? 0) >= 3) ||
            isUserUpgrade == true ||
            isUserUsedPromocode) {
          // if user is refered 3 friends or user is upgrade or user used promocode
          // then user will be redirected to the bottom nav bar
          return BottomNavBar();
        } else {
          return SeeResult();
        }
      }
      return CoreDatingSkills();
    } else {
      return Onboarding1();
    }
  }

  @override
  void dispose() {
    // Clean up controller and listener
    _controller.removeListener(_checkVideoProgress);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0A0A0A),
      body: Stack(
        children: [
          Center(
            child: SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 20,
            child: SafeArea(
              child: CustomButton(
                title: 'Skip',
                txtSize: 12,
                btnHeight: 30,
                btnWidth: 60,
                onTap: _navigateToNextScreenAccordinlgy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
