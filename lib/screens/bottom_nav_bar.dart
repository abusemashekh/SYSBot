import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sysbot3/provider/bottom_nav_bar_provider.dart';
import 'package:sysbot3/screens/main_screens/coaching_hub.dart';
import 'package:sysbot3/screens/main_screens/levelup_screen.dart';
import 'package:sysbot3/screens/main_screens/road_map.dart';

import '../config/colors.dart';
import '../controller/bottom_bar_controller.dart';
import 'main_screens/rizz_report.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // List of screens to display for each tab
  final List<Widget> _screens = [
    RizzReport(),
    RoadMap(),
    LevelUpScreen(),
    CoachingHub()
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //AnimationPrecache.precacheAnimation('assets/animations/car.riv');
      precacheImage(AssetImage('assets/images/roadmap-road.jpg'), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavBarProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: AppColors.black,
          body: _screens[provider.currentIndex],
          extendBody: true,
          bottomNavigationBar: Container(
            color: AppColors.black,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: provider.currentIndex,
              onTap: (index) {
                provider.updateCurrentIndex(index);
              },
              backgroundColor: AppColors.black,
              elevation: 0,
              selectedItemColor: AppColors.lime,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Image.asset('assets/images/rizz-report-bottom.png',
                        width: 22, height: 22),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Image.asset('assets/images/rizz-report-active.png',
                        color: AppColors.lime, width: 22, height: 22),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.asset('assets/images/roadmap-bottom.png',
                        width: 18),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.asset('assets/images/roadmap-active.png',
                        width: 18),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Image.asset('assets/images/level-up-bottom.png',
                        width: 21),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Image.asset('assets/images/levelup-active.png',
                        width: 21, color: AppColors.lime),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 13),
                    child: Image.asset('assets/images/coaching-hub-bottom.png',
                        width: 18),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(top: 13),
                    child: Image.asset('assets/images/coaching-active.png',
                        width: 18, color: AppColors.lime),
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
