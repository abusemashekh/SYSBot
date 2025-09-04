import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;
import 'package:sysbot3/widgets/dialogs/locked_time_up_dialog.dart';

import '../../config/colors.dart';
import '../../controller/bottom_bar_controller.dart';

class RoadMap extends StatefulWidget {
  const RoadMap({super.key});

  @override
  State<RoadMap> createState() => _RoadMapState();
}

class _RoadMapState extends State<RoadMap> with SingleTickerProviderStateMixin {
  rive.Artboard? _artboard;

  final String currentLevel = 'Hall of Game';
  final int targetCheckpoint = 4;

  final Map<String, Map<String, dynamic>> levels = {
    "Rizzler": {
      "isLocked": false,
      "questsCompleted": 2,
      "totalQuests": 8,
    },
    "Rizz King": {
      "isLocked": true,
      "questsCompleted": 0,
      "totalQuests": 8,
    },
    "Rizz God": {
      "isLocked": true,
      "questsCompleted": 0,
      "totalQuests": 8,
    },
    "Hall of Game": {
      "isLocked": true,
      "questsCompleted": 0,
      "totalQuests": 7,
    },
  };

  // Animation
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

         // Animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4), // Entire path time
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    //load Rive
    rootBundle.load('assets/animations/car.riv').then(
      (data) async {
        await rive.RiveFile.initialize();
        final file = rive.RiveFile.import(data);
        final artboard = file.mainArtboard;

        final controller = rive.StateMachineController.fromArtboard(
            artboard, 'State Machine 1');
        if (controller != null) {
          artboard.addController(controller);
        }

        setState(() {
          _artboard = artboard;
        });

        // Start animation after car appears at Rookie
      Future.delayed(const Duration(milliseconds: 500), () {
        _controller.forward();
      });
      },
    );
  }


  final List<Map<String, dynamic>> carPositions = [
    //Rookie
    {
      "bottom": 10.0,
      "left": null,
      "right": 0.1111,
      "width": 160.0,
      "height": 210.0,
    },
    //Rizzler
    {
      "bottom": 0.16,
      // "left":  0.275,
      // "right": null,
      "left":  null,
      "right": 0.36,
      "width": 130.0,
      "height": 170.0,
    },
    //Rizz King
    {
      "bottom": 0.305,
      "left": null,
      "right": 0.33,
      "width": 85.0,
      "height": 111.0,
    },
    //Rizz God
    {
      "bottom": 0.4,
      // "left": 0.23611,
      // "right": null,
      "left": null,
      "right": 0.55,
      "width": 68.0,
      "height": 88.0,
    },
    //Hall of Game
    {
      "bottom": 0.438,
      "left": null,
      "right": 0.48,
      "width": 50.0,
      "height": 66.0,
    }
  ];

    @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Map<String, dynamic> interpolatePosition(double t, double width, double height) {
    int start = 0; //Starting from 0 Index
    int end = targetCheckpoint;

    double fraction = t.clamp(0, 1);

    double startBottom = 10;
    double endBottom = carPositions[end]['bottom'] is double && carPositions[end]['bottom'] > 1
        ? carPositions[end]['bottom']
        : height * (carPositions[end]['bottom'] as double);


    double? startRight = width* 0.1111;
    double? endRight = carPositions[end]['right'] != null ? width * carPositions[end]['right'] : null;

    double startWidth = carPositions[start]['width'];
    double endWidth = carPositions[end]['width'];

    double startHeight = carPositions[start]['height'];
    double endHeight = carPositions[end]['height'];

    return {
      "bottom": lerpDouble(startBottom, endBottom, fraction),
      "left": null,
      "right": lerpDouble(startRight, endRight, fraction),
      "width": lerpDouble(startWidth, endWidth, fraction),
      "height": lerpDouble(startHeight, endHeight, fraction),
    };
  }

  double? lerpDouble(double? a, double? b, double t) {
    if (a == null || b == null) return null;
    return a + (b - a) * t;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
                child: Stack(
              children: [

                Positioned.fill(
                  child: Image.asset('assets/images/roadmap-road.jpg',
                      width: width, height: double.infinity, fit: BoxFit.cover),
                ),

                //Text
                Positioned(
                  left: 24,
                  child: Text('Roadmap',
                      style: TextStyle(
                          fontFamily: 'ReservationWide',
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                          fontStyle: FontStyle.italic,
                          color: AppColors.white)),
                ),

                //Rizzler
                Positioned(
                    bottom: height * 0.25,
                    left: width * 0.22,
                    child: Image.asset('assets/images/map-pin.png',
                        width: width * 0.09722)),
                Positioned(
                  bottom: height * 0.273,
                  left: width * 0.09,
                  child: GestureDetector(
                    onTap: () {
                      Get.find<BottomNavController>().changeIndex(2);
                    },
                    child: Container(
                      width: width * 0.2361,
                      height: width * 0.1138,
                      decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.shadowClr),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.shadowClr,
                                offset: const Offset(3, 3))
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 5),
                              Image.asset('assets/images/shield-icon.png',
                                  width: width * 0.03888),
                              const SizedBox(width: 5),
                              Text('Rizzler',
                                  style: TextStyle(
                                      fontFamily: 'ReservationWide',
                                      fontSize: width * 0.02777,
                                      fontWeight: FontWeight.w100,
                                      color: AppColors.white))
                            ],
                          ),
                          Text(
                              '${levels['Rizzler']?['questsCompleted']}/${levels['Rizzler']?['totalQuests']} quests',
                              style: TextStyle(
                                  fontFamily: 'ReservationWide',
                                  fontSize: width * 0.02777,
                                  fontWeight: FontWeight.w100,
                                  color: AppColors.lime))
                        ],
                      ),
                    ),
                  ),
                ),

                //Riz King
                Positioned(
                    bottom: height * 0.35,
                    right: width * 0.15,
                    child: Image.asset('assets/images/map-pin.png',
                        width: width * 0.09722)),
                Positioned(
                  bottom: height * 0.38,
                  right: width * 0.15,
                  child: GestureDetector(
                    onTap: () {
                      if (levels['Rizz King']?['isLocked']) {
                        lockedTimeUpDialog(context);
                      } else {
                        Get.find<BottomNavController>().changeIndex(2);
                      }
                    },
                    child: Container(
                      width: width * 0.23611,
                      height: width * 0.11388,
                      decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: AppColors.shadowClr, width: 1),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.shadowClr,
                                offset: const Offset(3, 3))
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 5),
                              Image.asset('assets/images/shields-2.png',
                                  width: width * 0.05),
                              const SizedBox(width: 5),
                              Text('Rizz King',
                                  style: TextStyle(
                                      fontFamily: 'ReservationWide',
                                      fontSize: width * 0.025,
                                      fontWeight: FontWeight.w100,
                                      color: AppColors.white))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  '${levels['Rizz King']?['questsCompleted']}/${levels['Rizz King']?['totalQuests']} quests',
                                  style: TextStyle(
                                      fontFamily: 'ReservationWide',
                                      fontSize: width * 0.025,
                                      fontWeight: FontWeight.w100,
                                      color: AppColors.lime)),
                              Visibility(
                                  visible: levels['Rizz King']?['isLocked'],
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Image.asset(
                                        'assets/images/lock-icon.png',
                                        width: width * 0.0222),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                //Rizz God
                Positioned(
                    bottom: height * 0.435,
                    left: width * 0.18055,
                    child: Image.asset('assets/images/map-pin.png',
                        width: width * 0.09722)),
                Positioned(
                  bottom: height * 0.46,
                  left: width * 0.06,
                  child: GestureDetector(
                    onTap: () {
                      if (levels['Rizz God']?['isLocked']) {
                        lockedTimeUpDialog(context);
                      } else {
                        Get.find<BottomNavController>().changeIndex(2);
                      }
                    },
                    child: Container(
                      width: width * 0.21666,
                      height: width * 0.1166,
                      decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: AppColors.shadowClr, width: 1),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.shadowClr,
                                offset: const Offset(3, 3))
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Image.asset('assets/images/shields-3.png',
                                  width: width * 0.06111),
                              const Spacer(),
                              Text('Rizz\nGod',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'ReservationWide',
                                      fontSize: width * 0.0222,
                                      fontWeight: FontWeight.w100,
                                      color: AppColors.white)),
                              const SizedBox(width: 10),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  '${levels['Rizz God']?['questsCompleted']}/${levels['Rizz God']?['totalQuests']} quests',
                                  style: TextStyle(
                                      fontFamily: 'ReservationWide',
                                      fontSize: width * 0.0222,
                                      fontWeight: FontWeight.w100,
                                      color: AppColors.lime)),
                              Visibility(
                                  visible: levels['Rizz God']?['isLocked'],
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Image.asset(
                                        'assets/images/lock-icon.png',
                                        width: width * 0.0222),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                //Hall Of Game
                Positioned(
                    bottom: height * 0.47,
                    right: width * 0.32,
                    child: Image.asset('assets/images/map-pin.png',
                        width: width * 0.06944)),
                Positioned(
                  bottom: height * 0.488,
                  right: width * 0.3,
                  child: GestureDetector(
                    onTap: () {
                      if (levels['Hall of Game']?['isLocked']) {
                        lockedTimeUpDialog(context);
                      } else {
                        Get.find<BottomNavController>().changeIndex(2);
                      }
                    },
                    child: Container(
                      width: width * 0.2083,
                      height: width * 0.1166,
                      decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: AppColors.shadowClr, width: 1),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.shadowClr,
                                offset: const Offset(3, 3))
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Image.asset('assets/images/shields-4.png',
                                  width: width * 0.05),
                              const Spacer(),
                              Text('Hall Of\nGame',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'ReservationWide',
                                      fontSize: width * 0.01944,
                                      fontWeight: FontWeight.w100,
                                      color: AppColors.white)),
                              const SizedBox(width: 10),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  '${levels['Hall of Game']?['questsCompleted']}/${levels['Hall of Game']?['totalQuests']} quests',
                                  style: TextStyle(
                                      fontFamily: 'ReservationWide',
                                      fontSize: width * 0.01944,
                                      fontWeight: FontWeight.w100,
                                      color: AppColors.lime)),
                              Visibility(
                                  visible: levels['Hall of Game']?['isLocked'],
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Image.asset(
                                        'assets/images/lock-icon.png',
                                        width: width * 0.0222),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                // Car
                            if (_artboard != null)
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final pos = interpolatePosition(_animation.value, width, height);

                  return Positioned(
                    bottom: pos['bottom'],
                    left: pos['left'],
                    right: pos['right'],
                    child: SizedBox(
                      width: pos['width'],
                      height: pos['height'],
                      child: rive.Rive(
                        artboard: _artboard!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}


class AnimationPrecache {
  static final Map<String, rive.Artboard> _precachedAnimations = {};

  static Future<void> precacheAnimation(String assetPath) async {
    if (_precachedAnimations.containsKey(assetPath)) return;

    final bytes = await rootBundle.load(assetPath);
    await rive.RiveFile.initialize();
    final file = rive.RiveFile.import(bytes);
    _precachedAnimations[assetPath] = file.mainArtboard
      ..advance(0);
  }

  static rive.Artboard? getPrecachedAnimation(String assetPath) {
    return _precachedAnimations[assetPath];
  }
}