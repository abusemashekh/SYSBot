import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sysbot3/model/user_model.dart';
import 'package:sysbot3/provider/bottom_nav_bar_provider.dart';
import 'package:sysbot3/screens/main_screens/menu_bottom_sheet.dart';

import '../../config/colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/gradient_circular_progress_bar.dart';
import '../../widgets/progress_bar.dart';

class RizzReport extends StatelessWidget {
  RizzReport({super.key});

  final carouselController = PageController();
  final RxInt currentIndex = 0.obs;

  final RxBool isLoading = false.obs;
  final RxBool showNoMoreInvitesTxt = false.obs;

  final Rx<File?> selectedImage = Rx<File?>(null);

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  String level = '';
  String profileImage = '';
  String name = '';
  int badge = 0;

  double overAllScore = 0;
  double juiceLevelScore = 0;
  double flexFactorScore = 0;
  double pickupGameScore = 0;
  double dripCheckScore = 0;
  double goalDiggerScore = 0;

  final nameController = TextEditingController();
  final RxBool isNameValid = false.obs;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (carouselController.hasClients) {
        carouselController.jumpToPage(0);
        currentIndex.value = 0;
      }
    });
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff0A0A0A),
      body: Consumer<BottomNavBarProvider>(
          builder: (context, bottomNavProvider, child) {
        final userData = bottomNavProvider.userData.data;
        final isUserUsedPromocode =
            userData?.settings?.promoCodes?.contains(userData.promoCode) ??
                false;

        overAllScore = userData?.overallScore.toDouble() ?? 0;
        juiceLevelScore = userData?.juiceLevelScore.toDouble() ?? 0;
        flexFactorScore = userData?.flexFactorScore.toDouble() ?? 0;
        pickupGameScore = userData?.pickupGameScore.toDouble() ?? 0;
        dripCheckScore = userData?.dripCheckScore.toDouble() ?? 0;
        goalDiggerScore = userData?.goalDiggerScore.toDouble() ?? 0;
        name = userData?.name ?? '';
        profileImage = userData?.profileImage ?? '';
        badge = userData?.badgeCount ?? 0;
        level = _getLevel(userData?.badgeCount ?? 0);
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/left-gradient-bg.png'),
                  fit: BoxFit.cover)),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text('Rizz Report',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'ReservationWide',
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.italic,
                                  color: AppColors.white,
                                  fontSize: 28)),
                        ),
                        GestureDetector(
                            onTap: () {
                              openMenuBottomSheet(context);
                            },
                            child: Image.asset('assets/images/menu-icon.png',
                                width: 28, height: 28))
                      ],
                    ),
                  ),
                  Obx(() => AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        height: currentIndex.value == 0 ? 522 : height - 350,
                        child: PageView(
                          dragStartBehavior: DragStartBehavior.down,
                          controller: carouselController,
                          onPageChanged: (index) {
                            currentIndex.value = index;
                          },
                          children: [
                            allReportWidget(context),
                            singleCarouseItem(
                                title: 'Flex Factor',
                                percentage: flexFactorScore,
                                iconWidth: 45,
                                iconPath: 'assets/images/flex-factor-icon.png',
                                subtitle:
                                    'Measures your ability to stay poised and self assured in social settings, projecting confidence without arrogance.'),
                            singleCarouseItem(
                                title: 'Drip Check',
                                percentage: dripCheckScore,
                                iconWidth: 60,
                                iconPath: 'assets/images/drip-check-icon.png',
                                subtitle:
                                    'Evaluates your style, grooming, and physical presence to ensure you’re making a strong first impression.'),
                            singleCarouseItem(
                                title: 'Juice Level',
                                percentage: juiceLevelScore,
                                iconWidth: 60,
                                iconPath: 'assets/images/juice-level-icon.png',
                                subtitle:
                                    'Reflects your charisma and ability to connect, captivate, and stand out in group dynamics.'),
                            singleCarouseItem(
                                title: 'Pickup Game',
                                percentage: pickupGameScore,
                                iconWidth: 56,
                                iconPath: 'assets/images/pickup-game-icon.png',
                                subtitle:
                                    'Scores your creativity, humor, and ability to spark chemistry  in flirty, engaging interactions.'),
                            singleCarouseItem(
                                title: 'Goal Digger',
                                percentage: goalDiggerScore,
                                iconWidth: 46,
                                iconPath: 'assets/images/goal-digger-icon.png',
                                subtitle:
                                    'Assesses your ambition and drive, showcasing how you pursue personal or professional growth.'),
                            singleCarouseItem(
                                title: 'Overall',
                                percentage: overAllScore,
                                iconWidth: 50,
                                iconPath: 'assets/images/100-icon.png',
                                subtitle:
                                    'Measures your ability to stay poised and self assured in social settings, projecting confidence without arrogance.'),
                          ],
                        ),
                      )),
                  const SizedBox(height: 8),
                  AnimatedBuilder(
                    animation: carouselController,
                    builder: (context, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(7, (index) {
                          bool isActive = index == currentIndex.value;
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            width: isActive ? 19 : 10,
                            height: isActive ? 10 : 10,
                            decoration: BoxDecoration(
                                color:
                                    isActive ? AppColors.lime : AppColors.black,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: isActive
                                        ? AppColors.black
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
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButton(
                        title: 'Save',
                        iconPath: 'assets/images/download-icon.png',
                        iconWidth: 24),
                  ),
                  Padding(
                    key: ValueKey('share_button'),
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 24),
                    child: CustomButton(
                      title: 'Share',
                      iconPath: 'assets/images/share-icon.png',
                      iconWidth: 24,
                      btnClr: AppColors.lime,
                      txtClr: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 24)
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  String _getLevel(int badgeCount) {
    Map<int, String> levelMap = {
      0: 'Rookie',
      1: 'Rizzler',
      2: 'Rizz King',
      3: 'Rizz God',
      4: 'Hall Of Game',
    };
    return levelMap[badgeCount] ?? 'Rookie';
  }


  Widget allReportWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.shadowClr, width: 3),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowClr,
                  offset: const Offset(3, 4),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Obx(() => Stack(
                      children: [
                        Container(
                          width: 78,
                          height: 78,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xff9FACE6).withAlpha(128),
                              width: 2.9,
                            ),
                            image: DecorationImage(
                              image: selectedImage.value != null
                                  ? FileImage(selectedImage.value!)
                                      as ImageProvider
                                  : (profileImage != '')
                                      ? NetworkImage(profileImage)
                                      : const AssetImage(
                                          'assets/images/user-profile-picture-dummy.jpeg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: pickImage,
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                color: AppColors.themeClr,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(Icons.edit,
                                    color: AppColors.white, size: 14),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
                const SizedBox(width: 16),
                Expanded(
                  flex: 12,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("[$level]",
                            style: TextStyle(
                                fontFamily: 'ReservationWide',
                                fontWeight: FontWeight.w700,
                                color: AppColors.lime,
                                fontSize: 10)),
                        const SizedBox(height: 4),
                        GestureDetector(
                            onTap: () {
                              editNameDialog(context);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(name,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          height: 1,
                                          fontFamily: 'ReservationWide',
                                          fontWeight: FontWeight.w900,
                                          color: AppColors.white,
                                          fontSize: 17)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 3, left: 4),
                                  child: Image.asset('assets/images/3-dots.png',
                                      width: 12),
                                )
                              ],
                            )),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(4, (index) {
                            String imagePath = index < badge
                                ? 'assets/images/shield-icon.png'
                                : 'assets/images/shield-grey.png';

                            return Image.asset(
                              imagePath,
                              width: 24,
                            );
                          }),
                        )
                      ]),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              reportItem(
                  percentage: overAllScore,
                  title: 'Overall',
                  iconPath: 'assets/images/100-icon.png',
                  isLimeColor: true),
              const SizedBox(width: 12),
              reportItem(
                  percentage: juiceLevelScore,
                  title: 'Juice Level',
                  iconPath: 'assets/images/juice-level-icon.png'),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              reportItem(
                  percentage: flexFactorScore,
                  title: 'Flex Factor',
                  iconPath: 'assets/images/flex-factor-icon.png'),
              const SizedBox(width: 12),
              reportItem(
                  percentage: pickupGameScore,
                  title: 'Pickup Game',
                  iconPath: 'assets/images/pickup-game-icon.png'),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              reportItem(
                  percentage: dripCheckScore,
                  title: 'Drip Check',
                  iconPath: 'assets/images/drip-check-icon.png'),
              const SizedBox(width: 12),
              reportItem(
                  percentage: goalDiggerScore,
                  title: 'Goal Digger',
                  iconPath: 'assets/images/goal-digger-icon.png'),
            ],
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  Widget reportItem(
      {required String title,
      required String iconPath,
      required double percentage,
      bool? isLimeColor}) {
    return Expanded(
      child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isLimeColor == true ? AppColors.lime : AppColors.black,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color:
                    isLimeColor == true ? AppColors.black : AppColors.shadowClr,
                width: 3),
            boxShadow: [
              BoxShadow(
                color:
                    isLimeColor == true ? AppColors.white : AppColors.shadowClr,
                offset: const Offset(3, 4),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(iconPath, width: 17),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Text(title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'ReservationWide',
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: isLimeColor == true
                                  ? AppColors.black
                                  : AppColors.white)))
                ],
              ),
              const SizedBox(height: 8),
              Text("${percentage.toInt()}%",
                  style: TextStyle(
                      fontFamily: 'ReservationWide',
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: isLimeColor == true
                          ? AppColors.black
                          : AppColors.white)),
              const SizedBox(height: 5),
              progressBar(
                  percentage: percentage,
                  bgClr: AppColors.themeClr.withValues(alpha: 0.42),
                  fillClr: AppColors.themeClr)
            ],
          )),
    );
  }

  Widget singleCarouseItem(
      {required String title,
      required String subtitle,
      required String iconPath,
      required double iconWidth,
      required double percentage}) {
    double height = Get.height;
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.shadowClr, width: 3),
        boxShadow: [
          BoxShadow(
              color: AppColors.shadowClr,
              offset: const Offset(3, 4),
              spreadRadius: 0)
        ],
      ),
      child: Column(
        children: [
          const Spacer(),
          Image.asset(iconPath, width: iconWidth),
          const SizedBox(height: 8),
          Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'ReservationWide',
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  color: AppColors.lime,
                  fontSize: height * 0.03457)),
          const SizedBox(height: 5),
          GradientCircularProgress(percentage: percentage),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'ReservationWide',
                  fontSize: height * 0.01595,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white),
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }

  Future<dynamic> editNameDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: IntrinsicHeight(
            child: Container(
              padding: EdgeInsets.all(24),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.white.withValues(alpha: 0.18),
                        offset: const Offset(3, 4))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Edit Name",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          fontFamily: 'ReservationWide',
                          color: AppColors.white)),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: nameController,
                    cursorColor: AppColors.white,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        isNameValid.value = false;
                      } else {
                        isNameValid.value = true;
                      }
                    },
                    style: TextStyle(
                        fontFamily: 'ReservationWide',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            AppColors.darkCharcoal.withValues(alpha: 0.68),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        hintText: 'Enter your username',
                        hintStyle: TextStyle(
                            fontFamily: 'ReservationWide',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.dimGrey)),
                  ),
                  SizedBox(height: 30),
                  Center(
                      child: Obx(() => CustomButton(
                          onTap: () {
                            if (isNameValid.value) {
                              name = nameController.text;
                              nameController.text = '';
                              isNameValid.value = false;
                              Get.back();
                            }
                          },
                          title: 'Save',
                          btnWidth: 135,
                          btnClr: isNameValid.value == false
                              ? const Color(0xff3c2e71)
                              : null,
                          txtClr: isNameValid.value == false
                              ? AppColors.mediumGrey
                              : null))),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
