import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/colors.dart';
import '../../widgets/gradient_text.dart';
import '../../widgets/dialogs/how_it_works_dialog_leaderboard.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  late ConfettiController confettiController;

  final List<bool> isCurrentUser = [
    false,
    false,
    true,
    false,
    false,
    false,
    false
  ];

  final List<String> badge = [
    "Rizzler",
    "",
    "Hall of Game",
    "",
    "",
    "Rizz God",
    "Rizz King"
  ];

  @override
  void initState() {
    super.initState();
    confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
    confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff151516),
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/leaderboard-bg.png'), fit: BoxFit.cover
            )
        ),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () => Get.back(),
                              child: Icon(Icons.arrow_back, color: Colors.white, size: 20)),
                          GestureDetector(
                            onTap: (){
                              howItWorksDialogLeaderboard(context);
                            },
                            child: Image.asset('assets/images/baloon-icon.png',
                                width: 16),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text("RIZZ GAMES",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontFamily: 'ReservationWide',
                            fontSize: 28,
                            fontStyle: FontStyle.italic,
                            color: AppColors.white)),
                    Text("LEADERBOARD",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontFamily: 'ReservationWide',
                            fontSize: 15,
                            color: AppColors.lime)),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: width * 0.9,
                      height: 200,
                      child: Stack(
                        children: [
                          //Background
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: width * 0.9,
                              height: 105,
                              decoration: BoxDecoration(
                                  color: Color(0xff161515),
                                  border: Border.all(color: AppColors.darkCharcoal.withValues(alpha: 0.53), width: 1),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                            ),
                          ),
                
                          //First Position
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                height: 200,
                                width: width * 0.3,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                        width: width * 0.3,
                                        height: 130,
                                        decoration: BoxDecoration(
                                            color: Color(0xff230060).withValues(alpha: 0.88),
                                            border: Border.all(color: AppColors.black, width: 1),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(50),
                                                topLeft: Radius.circular(50))),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 8,
                                                  right: 0,
                                                  top: 28,
                                                  child: Center(
                                                    child: Container(
                                                      width: 70,
                                                      height: 70,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/images/dummy-user-img.png'),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                                  ),
                                                ),
                                                Image.asset(
                                                    'assets/images/first-position.png',
                                                    width: 85,
                                                    height: 109),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text('Rachel',
                                              style: TextStyle(
                                                  fontFamily: 'ReservationWide',
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.white,
                                                  fontSize: 14.5)),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  'assets/images/star.png',
                                                  width: 11,
                                                  height: 11),
                                              const SizedBox(width: 6),
                                              GradientText(
                                                  textWidget: Text('99',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'ReservationWide',
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontStyle: FontStyle.italic,
                                                          color: Colors.white,
                                                          fontSize: 22))),
                                              const SizedBox(width: 8),
                                            ],
                                          ),
                                          GradientText(
                                              textWidget: Text('Rizz pts',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'ReservationWide',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white,
                                                      fontSize: 12))),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                
                          //Second Position
                          Positioned(
                            left: width * 0.0555,
                            bottom: 10,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 22,
                                      child: Center(
                                        child: Container(
                                          width: 58,
                                          height: 58,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/dummy-img2.jpeg'),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                    ),
                                    Image.asset(
                                        'assets/images/second-position.png',
                                        width: 62,
                                        height: 92),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text('John',
                                    style: TextStyle(
                                        fontFamily: 'ReservationWide',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        fontSize: 14.5)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/star.png',
                                        width: 11, height: 11),
                                    const SizedBox(width: 6),
                                    Text('75',
                                        style: TextStyle(
                                            fontFamily: 'ReservationWide',
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 16)),
                                    const SizedBox(width: 8),
                                  ],
                                ),
                                Text('Rizz pts',
                                    style: TextStyle(
                                        fontFamily: 'ReservationWide',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontSize: 11.5)),
                              ],
                            ),
                          ),
                
                          //3rd Position
                          Positioned(
                            right: width * 0.0555,
                            bottom: 10,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 22,
                                      child: Center(
                                        child: Container(
                                          width: 58,
                                          height: 58,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/dummy-img2.jpeg'),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                    ),
                                    Image.asset(
                                        'assets/images/third-position.png',
                                        width: 62,
                                        height: 92),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text('Tim',
                                    style: TextStyle(
                                        fontFamily: 'ReservationWide',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        fontSize: 15)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/star.png',
                                        width: 11, height: 11),
                                    const SizedBox(width: 6),
                                    Text('66',
                                        style: TextStyle(
                                            fontFamily: 'ReservationWide',
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 16)),
                                    const SizedBox(width: 8),
                                  ],
                                ),
                                Text('Rizz pts',
                                    style: TextStyle(
                                        fontFamily: 'ReservationWide',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontSize: 11.5)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width,
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 30, bottom: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(6))),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 15),
                            width: width,
                            height: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: AppColors.black, width: 2.75),
                                gradient: isCurrentUser[index] == true
                                    ? LinearGradient(colors: [
                                        Color(0xffAC32E4),
                                        Color(0xff7918F2),
                                        Color(0xff4801FF)
                                      ])
                                    : null,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.white.withValues(alpha: 0.17),
                                  spreadRadius: 1,
                                  offset: const Offset(4, 4)
                                )
                              ]
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 18),
                                Text("${index + 4}",
                                    style: TextStyle(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.white,
                                        fontFamily: 'ReservationWide')),
                                const SizedBox(width: 14),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/dummy-img2.jpeg'),
                                          fit: BoxFit.cover)),
                                ),
                                const SizedBox(width: 15),
                                Text(
                                    isCurrentUser[index] == true
                                        ? "You"
                                        : "Marsha",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.white,
                                        fontFamily: 'ReservationWide')),
                                const SizedBox(width: 8),
                                ...List.generate(
                                    badge[index] == "Rizzler"
                                        ? 1
                                        : badge[index] == "Rizz King"
                                            ? 2
                                            : badge[index] == "Rizz God"
                                                ? 3
                                                : badge[index] == "Hall of Game"
                                                    ? 4
                                                    : 0, (index) {
                                  return Image.asset('assets/images/shield-icon.png',
                                      width: 17);
                                }),
                                const Spacer(),
                                if (isCurrentUser[index] == true)
                                  GradientText(
                                      textWidget: Text("36 Rizz pts",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w900,
                                              color: AppColors.white,
                                              fontStyle: FontStyle.italic,
                                              fontFamily: 'ReservationWide')))
                                else
                                  Text("36 Rizz pts",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.white,
                                          fontFamily: 'ReservationWide')),
                                const SizedBox(width: 16),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: confettiController,
                  blastDirection: 3.14 / 2,
                  // downwards
                  emissionFrequency: 1,
                  numberOfParticles: 20,
                  gravity: 0.5,
                  shouldLoop: false,
                  blastDirectionality: BlastDirectionality.explosive,
                  maxBlastForce: 10,
                  minBlastForce: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
