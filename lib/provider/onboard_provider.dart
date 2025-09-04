import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sysbot3/screens/onboarding/rizz_quiz/give_quiz.dart';
import 'package:sysbot3/screens/onboarding/rizz_quiz/rizz_quiz.dart';
import 'package:sysbot3/screens/onboarding/rizz_quiz/see_result.dart';

import '../backend/api_requests.dart';
import '../backend/local_storage/local_storage.dart';
import '../model/rizz_quizz_model.dart';
import '../model/user_model.dart';
import '../screens/bottom_nav_bar.dart';
import '../screens/onboarding/core_dating_skills.dart';
import '../screens/onboarding/referral_code_screen.dart';
import '../utils/functions/common_fun.dart';
import '../widgets/loading.dart';

class OnboardProvider with ChangeNotifier {
  final String goalDiggerKey = 'goal_digger_score';
  final _apiRequests = ApiRequests();
  final localStorage = LocalStorage();

  RizzQuizzModel? get rizzQuizzData => localStorage.getRizzQuizzData;

  List<Options> selectedFlexFactors = [];
  List<Options> selectedDripCheck = [];
  List<Options> selectedJuiceLevel = [];
  List<Options> selectedPickupGame = [];
  List<Options> selectedGoalDigger = [];

  final carouselController = PageController();
  int currentIndex = 0;

  void updateIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Future<String?> initDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(Get.context!).platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Theme.of(Get.context!).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? '';
    }
    return null;
  }

  Future<void> initializeUser() async {
    loadingDialog();
    Map<String, dynamic> data = {
      'device_id': await initDeviceId(),
    };
    _apiRequests.initializeUserApi(data).then((value) async {
      UserModel userModel = UserModel.fromJson(value);
      await localStorage.setUserData(userModel);
      await localStorage.setUserBadgesCount(userModel.data?.badgeCount ?? 0);
      dismissLoadingDialog();
      _manageScreens();
    }).onError(
      (error, stackTrace) {
        commonErrorDioHandler(error,
            closeLoadingDialog: true,
            showSnackBar: true,
            stackTrace: stackTrace);
      },
    );
  }

  /// Navigates the user to the appropriate screen based on their user data and scores.
  ///
  /// This function retrieves the user's data from local storage and evaluates their scores
  /// across various categories. If the user's overall score is greater than zero and all
  /// individual scores are non-zero, it checks the number of referrals completed.
  /// - If referrals are three or more, navigates to the `BottomNavBar`.
  /// - If less than three, navigates to `SeeMyResult`.
  /// If any score is zero, navigates to the `QuestionsScreen`.
  /// If the overall score is zero or less, navigates to the `ReferralCodeScreen`.
  void _manageScreens() {
    final userData = localStorage.getUserData.data;
    final scores = [
      userData?.flexFactorScore,
      userData?.dripCheckScore,
      userData?.juiceLevelScore,
      userData?.pickupGameScore,
      userData?.goalDiggerScore,
    ];
    if ((userData?.overallScore ?? 0) > 0) {
      if (scores.every((score) => score != 0)) {
        if (((userData?.referredDone ?? 0) >= 3) ||
            localStorage.getIsUserUpgrade == true) {
          Get.offAll(() => BottomNavBar());
        } else {
          Get.offAll(() => SeeResult());
        }
      } else {
        Get.offAll(() => CoreDatingSkills());
      }
    } else {
      Get.offAll(() => ReferralCodeScreen());
    }
  }

  void setRizzDataToLocalStorage() {
    loadingDialog();
    try {
      _apiRequests.getRizzQuizzApi().then((value) async {
        RizzQuizzModel rizzQuizzModel = RizzQuizzModel.fromJson(value);
        await localStorage.setRizzQuizzData(rizzQuizzModel);
        dismissLoadingDialog();
        Get.offAll(() => GiveQuiz());
      }).onError(
        (error, stackTrace) {
          commonErrorDioHandler(error,
              closeLoadingDialog: true,
              showSnackBar: true,
              stackTrace: stackTrace);
        },
      );
    } catch (e, stackTrace) {
      commonErrorDioHandler(e,
          closeLoadingDialog: true, showSnackBar: true, stackTrace: stackTrace);
    }
  }

  void updateRizzQuizApi(String score, String categoryKey) {
    loadingDialog();
    Map<String, dynamic> data = {
      'device_id': localStorage.getUserData.data?.deviceId,
      'score': score,
      'category_key': categoryKey,
    };
    _apiRequests.updateRizzQuizzAnsApi(data).then((value) async {
      UserModel userModel = UserModel.fromJson(value);
      await localStorage.setUserData(userModel);
      dismissLoadingDialog();
      if (categoryKey == goalDiggerKey) {
        Get.offAll(() => SeeResult());
      } else {
        carouselController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    }).onError(
      (error, stackTrace) {
        commonErrorDioHandler(error,
            closeLoadingDialog: true,
            showSnackBar: true,
            stackTrace: stackTrace);
      },
    );
  }

  Future<bool> redeemCode() {
    Map<String, dynamic> data = {
      'device_id': localStorage.getUserData.data?.deviceId,
    };
    return _apiRequests.checkReferStatusApi(data).then((value) async {
      if (value['status'] == true) {
        UserModel userModel = UserModel.fromJson(value);
        await localStorage.setUserData(userModel);
        return true;
      } else {
        return false;
      }
    }).onError((error, stackTrace) {
      commonErrorDioHandler(error);
      return false;
    });
  }

  void addReferralCode(String referralCode) {
    loadingDialog();
    Map<String, dynamic> data = {
      'device_id': localStorage.getUserData.data?.deviceId,
      'referral_code': referralCode,
    };
    _apiRequests.initializeFriendApi(data).then((value) async {
      UserModel userModel = UserModel.fromJson(value);
      await localStorage.setUserData(userModel);
      dismissLoadingDialog();
      Get.offAll(() => OnboardProvider());
    }).onError((error, stackTrace) {
      commonErrorDioHandler(error,
          closeLoadingDialog: true, showSnackBar: true, stackTrace: stackTrace);
    });
  }

  /// Calculate the total score of the given options.
  ///
  /// The score is the sum of the weights of the given options. If an option does not have a weight,
  /// it is ignored.
  ///
  /// Returns the calculated score as a string.
  String calculateScore(List<Options> options) {
    return options
        .fold<int>(0, (sum, option) => sum + (option.weight ?? 0))
        .toString();
  }

  /// Update the Rizz Quiz API based on the selected options of the current page
  /// in the carousel.
  ///
  /// This method calculates the score of the selected options and calls
  /// [updateRizzQuizApi] with the calculated score and the score key of the
  /// current page.
  ///
  void updateRizzQuizApiFromCarouselPage() {
    final page = carouselController.page?.toInt() ?? 0;
    final categories = rizzQuizzData?.data?.categories;

    final Map<int, List<Options>> optionsMap = {
      0: selectedFlexFactors,
      1: selectedDripCheck,
      2: selectedJuiceLevel,
      3: selectedPickupGame,
      4: selectedGoalDigger,
    };

    final Map<int, String?> scoreKeyMap = {
      0: categories?.flexFactorScore?.scoreKey,
      1: categories?.dripCheckScore?.scoreKey,
      2: categories?.juiceLevelScore?.scoreKey,
      3: categories?.pickupGameScore?.scoreKey,
      4: categories?.goalDiggerScore?.scoreKey,
    };

    updateRizzQuizApi(
      calculateScore(optionsMap[page] ?? []),
      scoreKeyMap[page] ?? '',
    );
  }

  void onScreenOpen() {
    final userData = localStorage.getUserData.data;
    final scores = [
      userData?.flexFactorScore,
      userData?.dripCheckScore,
      userData?.juiceLevelScore,
      userData?.pickupGameScore,
      userData?.goalDiggerScore,
    ];

    for (int i = 0; i < scores.length; i++) {
      if (scores[i] == 0) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (carouselController.hasClients) {
            carouselController.jumpToPage(i);
          }
        });
        break;
      }
    }
  }
}
