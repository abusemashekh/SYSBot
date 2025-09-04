import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../config/colors.dart';

class GradientCircularProgress extends StatelessWidget {
  const GradientCircularProgress({
    super.key,
    required this.percentage,
    this.size,
    this.innerSize,
    this.textSize,
    this.colors
  });

  final double percentage; // Current value to display
  final double? size;
  final double? innerSize;
  final double? textSize;
  final List<Color>? colors;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // Calculate stops dynamically based on the number of gradient colors

    final List<Color> gradientColors = colors ?? [
      AppColors.lime,
      if(percentage <=20)
         AppColors.lime,
      if(percentage > 20)
        AppColors.themeClr,
      if(percentage >= 70)
        AppColors.lime
    ];

    final List<double> stops = List.generate(
      gradientColors.length,
          (index) => index / (gradientColors.length - 1),
    );

    return SizedBox(
      height: size ?? height*0.17,
      width: size ?? height*0.17,
      child: SfRadialGauge(
        enableLoadingAnimation: true,
        axes: [
          RadialAxis(
            minimum: 0,
            maximum: 100,
            startAngle: 270,
            endAngle: 270,
            showLabels: false,
            showTicks: false,
            axisLineStyle: AxisLineStyle(
              thickness: 11,
              color: const Color(0xff434343), // Background track color
            ),
            pointers: [
              RangePointer(
                value: percentage,
                width: 11,
                gradient: SweepGradient(
                  colors: gradientColors,
                  stops: stops, // Explicitly define stops for multiple colors
                ),
                cornerStyle: CornerStyle.bothFlat, // Smooth rounded ends
              ),
            ],
            annotations: [
              GaugeAnnotation(
                widget: Container(
                  width: innerSize ?? height*0.132,
                  height: innerSize ?? height*0.132,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/dotted-bg.png'), fit: BoxFit.cover)
                  ),
                  child: Center(
                    child: Text(
                      "${percentage.toInt()}%",
                      style: TextStyle(
                        fontFamily: 'ReservationWide',
                        fontSize: textSize ?? height*0.032,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xffEFEFEF),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
