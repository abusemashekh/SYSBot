import 'package:flutter/material.dart';
import 'package:sysbot3/widgets/level_up_dialog1_widget.dart';

import '../../config/colors.dart';
import '../level_up_dialog2_widget.dart';

class LevelUpDialogCarousel extends StatefulWidget {
  const LevelUpDialogCarousel({super.key, required this.title, required this.percentage, required this.overallPercentage});
  final String title;
  final double percentage;
  final double overallPercentage;

  @override
  State<LevelUpDialogCarousel> createState() => _LevelUpDialogCarouselState();
}

class _LevelUpDialogCarouselState extends State<LevelUpDialogCarousel> {
  final PageController carouselController = PageController();
  int currentIndex = 0;

  final List<Widget> dialogPages = [];

  @override
  void initState() {
    super.initState();
    dialogPages.addAll([
      LevelUpDialog1Widget(title: widget.title),
      if(widget.title != 'Overall')
       LevelUpDialog2Widget(title: widget.title, percentage: widget.percentage),
      LevelUpDialog2Widget(title: 'Overall', percentage: widget.overallPercentage),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 390,
              child: PageView.builder(
                controller: carouselController,
                itemCount: dialogPages.length,
                onPageChanged: (index) => setState(() => currentIndex = index),
                itemBuilder: (context, index) => dialogPages[index],
              ),
            ),
            AnimatedBuilder(
              animation: carouselController,
              builder: (context, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(dialogPages.length, (index) {
                    bool isActive = index == currentIndex;
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: isActive ? 19 : 10,
                      height: isActive ? 10 : 10,
                      decoration: BoxDecoration(
                          color:
                          isActive ? AppColors.white : AppColors.black,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: isActive
                                  ? AppColors.white
                                  : AppColors.shadowClr,
                              width: 1.5),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.shadowClr,
                                offset: const Offset(1, 2),
                                blurRadius: 0,
                                spreadRadius: 0)
                          ]),
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
