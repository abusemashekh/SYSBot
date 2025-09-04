import 'package:confetti/confetti.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LevelUpCarouselDialog extends StatefulWidget {
  final String title;
  final double percentage;
  final double overallPercentage;

  const LevelUpCarouselDialog({
    super.key,
    required this.title,
    required this.percentage,
    required this.overallPercentage,
  });

  @override
  State<LevelUpCarouselDialog> createState() => _LevelUpCarouselDialogState();
}

class _LevelUpCarouselDialogState extends State<LevelUpCarouselDialog> {
  late final PageController _carouselController;
  late final ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _carouselController = PageController();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
    _confettiController.play();
  }

  @override
  void dispose() {
    _carouselController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Stack(
        children: [
          SizedBox(
            height: 500,
            child: PageView(
              dragStartBehavior: DragStartBehavior.down,
              controller: _carouselController,
              onPageChanged: (index) {
                setState(() {});
              },
              children: [
                // LevelUpDialog1(title: widget.title),
                // LevelUpDialog2(title: widget.title, percentage: widget.percentage),
                // OverallDialog(percentage: widget.overallPercentage),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 30,
            child: Center(
              child: SmoothPageIndicator(
                controller: _carouselController,
                count: 3,
                effect: const SwapEffect(
                  activeDotColor: Color(0xFFFFFFFF),
                  dotColor: Color(0xff5B5B5B),
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 8,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: 3.14 / 2,
              emissionFrequency: 1,
              numberOfParticles: 20,
              gravity: 0.5,
              shouldLoop: false,
              blastDirectionality: BlastDirectionality.explosive,
              maxBlastForce: 10,
              minBlastForce: 5,
            ),
          )
        ],
      ),
    );
  }
}

// Updated dialog call
Future<bool> levelUpCarousel({
  required String title,
  required double percentage,
  required double overallPercentage,
}) async {
  final result = await Get.dialog<bool>(
    Center(
      child: Material(
        color: Colors.transparent,
        child: LevelUpCarouselDialog(
          title: title,
          percentage: percentage,
          overallPercentage: overallPercentage,
        ),
      ),
    ),
  );
  return result ?? false;
}
