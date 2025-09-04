import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sysbot3/screens/onboarding/show_love.dart';

import '../../config/colors.dart';
import '../../widgets/custom_button.dart';

class LevelUpYourRizz extends StatefulWidget {
  const LevelUpYourRizz({super.key});

  @override
  State<LevelUpYourRizz> createState() => _LevelUpYourRizzState();
}

class _LevelUpYourRizzState extends State<LevelUpYourRizz> {
  double sliderValue = 0.0;

  List<String> features = [
    "Flex Factor",
    "Juice Level",
    "Goal Digger",
    "Pickup Game",
    "Drip Check",
    "Overall"
  ];

  String getRizzLevel(double value) {
    if (value < 20) return "Rookie";
    if (value < 40) return "Rizzler";
    if (value < 60) return "RizzKing";
    if (value < 80) return "RizzGod";
    return "H.O.G";
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(AssetImage('assets/images/rizzler-chart.png'), context);
      precacheImage(AssetImage('assets/images/rizz-king-chart.png'), context);
      precacheImage(AssetImage('assets/images/rizz-god-chart.png'), context);
      precacheImage(AssetImage('assets/images/hog-chart.png'), context);
    });
  }


  @override
  Widget build(BuildContext context) {
    double width  = MediaQuery.of(context).size.width;
    double height  = MediaQuery.of(context).size.height;
    final RxString rizzLevel = getRizzLevel(sliderValue).obs;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.black,
            image: DecorationImage(
                image: AssetImage('assets/images/top-gradient-bg.png'), fit: BoxFit.cover
            )
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 28),
              Image.asset("assets/images/user-with-arrow-up.png", width: 32),
              const SizedBox(height: 6),
              Text('Level Up Your Rizz',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'ReservationWide',
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      color: AppColors.white,
                      fontSize: 20)),
              const SizedBox(height: 20),
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
                      TextSpan(text: 'Here’s how your dating life will transform as you level up from Rookie to '),
                      TextSpan(
                        text: 'Hall of Game (H.O.G).',
                        style: TextStyle(color: AppColors.lime),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 45),
              Text(
                'Slide to Drive',
                style: TextStyle(color: Color(0xffD9D9D9), fontSize: 11, fontWeight: FontWeight.w900, fontFamily: 'ReservationWide', fontStyle: FontStyle.italic),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width*0.12),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape: CustomImageThumb(image: AssetImage('assets/images/car-slider-icon.png')),
                    trackHeight: 6,
                    activeTrackColor: AppColors.themeClr,
                    inactiveTrackColor: AppColors.white,
                  ),
                  child: Slider(
                    value: sliderValue,
                    min: 0,
                    max: 100,
                    onChanged: (value) {
                      setState(() {
                        sliderValue = value;
                      });
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IntrinsicWidth(
                  child: Container(
                    height: 24,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.only(right: 40),
                    decoration: BoxDecoration(
                      color: const Color(0xff3C4257),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Obx(() => Text(
                        rizzLevel.value,
                        style: TextStyle(color: AppColors.lime, fontSize: 10, fontWeight: FontWeight.w900, fontFamily: 'ReservationWide'),
                      )),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() => Image.asset(rizzLevel.value == "Rizzler" ? 'assets/images/rizzler-chart.png' : rizzLevel.value == "RizzKing" ? 'assets/images/rizz-king-chart.png' : rizzLevel.value == "RizzGod" ? 'assets/images/rizz-god-chart.png' : rizzLevel.value == "H.O.G" ? 'assets/images/hog-chart.png' : 'assets/images/rookie-chart.png', width: width)),
              ),
              const Spacer(flex: 2),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(title: 'Continue', btnWidth: 114, txtSize: 12, onTap: () => Get.to(ShowLove())),
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

// Custom thumb image for slider
class CustomImageThumb extends SliderComponentShape {
  final ImageProvider image;
  CustomImageThumb({required this.image});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size(40, 40);

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final canvas = context.canvas;
    final imageRect = Rect.fromCenter(center: center, width: 36, height: 36);
    final paint = Paint();

    final imageStream = image.resolve(ImageConfiguration());
    imageStream.addListener(ImageStreamListener((ImageInfo info, bool _) {
      canvas.drawImageRect(
        info.image,
        Rect.fromLTWH(0, 0, info.image.width.toDouble(), info.image.height.toDouble()),
        imageRect,
        paint,
      );
    }));
  }
}

