import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:image_picker/image_picker.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui' as ui;


import '../backend/api_requests.dart';
import '../backend/local_storage/local_storage.dart';
import '../model/leaderboard_model.dart';
import '../model/user_model.dart';
import '../screens/main_screens/leaderboard.dart';
import '../utils/functions/common_fun.dart';
import '../widgets/loading.dart';
import '../widgets/snackbars.dart';

class BottomNavBarProvider with ChangeNotifier {
  final _localStorage = LocalStorage();
  final _apiRequest = ApiRequests();
  UserModel get userData => _localStorage.getUserData;
  bool get isUpgradedUser => _localStorage.getIsUserUpgrade;
  final GlobalKey globalKeyRizzReportMainCard = GlobalKey();
  LeaderBoardModel leaderBoardData = LeaderBoardModel();
  List<LeaderBoardItems> listOfLeaderBoardItems = [];
  int currentUserRank = 0;
  bool isMoreDataLoading = false;
  int maxPage = 5;
  bool isImageCapturing = false;
  int currentIndex = 0;

  void updateCurrentIndex(int index) {
    logPrint(message: 'Current index: $index', isError: true);
    if (index == 1 || index == 2) {
      currentUserRankData();
    }
    currentIndex = index;
    notifyListeners();
  }

  /// Captures the widget associated with [globalKeyRizzReportMainCard] as an image file.
  ///
  /// Returns a [Future<File?>] representing the captured image file. The image is
  /// saved temporarily in the device's temporary directory with the filename 'rizz_report.png'.
  /// If an error occurs during the capture or conversion process, the method logs the error
  /// and returns `null`.
  // Future<File?> _captureWidgetAsFile() async {
  //   try {
  //     RenderRepaintBoundary boundary =
  //         globalKeyRizzReportMainCard.currentContext!.findRenderObject() as RenderRepaintBoundary;

  //     ui.Image image = await boundary.toImage(pixelRatio: 3.0);
  //     ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //     if (byteData == null) return null;

  //     final directory = await getTemporaryDirectory();
  //     final filePath = '${directory.path}/rizz_report.png';

  //     File file = File(filePath);
  //     await file.writeAsBytes(byteData.buffer.asUint8List());
  //     return file;
  //   } catch (e) {
  //     logPrint(message: 'Error capturing widget: $e', isError: true);
  //     return null;
  //   }
  // }

  /// Captures the RizzReportWidget as an image file using offscreen rendering.
  Future<File?> _captureWidgetAsFile(BuildContext context) async {
    try {
      final userData = _localStorage.getUserData.data;
      final overAllScore = userData?.overallScore?.toDouble() ?? 0;
      final juiceLevelScore = userData?.juiceLevelScore?.toDouble() ?? 0;
      final flexFactorScore = userData?.flexFactorScore?.toDouble() ?? 0;
      final pickupGameScore = userData?.pickupGameScore?.toDouble() ?? 0;
      final dripCheckScore = userData?.dripCheckScore?.toDouble() ?? 0;
      final goalDiggerScore = userData?.goalDiggerScore?.toDouble() ?? 0;

      final GlobalKey offscreenKey = GlobalKey();
      isImageCapturing = true;

      /*final widgetToCapture = RizzReportWidget(
        overallScore: overAllScore,
        juiceLevelScore: juiceLevelScore,
        dripCheckScore: dripCheckScore,
        flexFactorScore: flexFactorScore,
        goalDiggerScore: goalDiggerScore,
        pickupGameScore: pickupGameScore,
        globalKey: offscreenKey,
      );
      final OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) => Stack(
          children: [
            Positioned(
              left: -500,
              right: 500,
              top: 300,
              bottom: 0,
              child: Material(
                child: widgetToCapture,
              ),
            ),
          ],
        ),
      );

      Overlay.of(context).insert(overlayEntry);
      await Future.delayed(Duration(milliseconds: 200)); // Increased delay for rendering

      final RenderRepaintBoundary boundary = offscreenKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      overlayEntry.remove();
      isImageCapturing = false;

      if (byteData == null) return null;

      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/rizz_report.png';
      final File file = File(filePath);
      await file.writeAsBytes(byteData.buffer.asUint8List());
      return file;*/
      return null;
    } catch (e) {
      logPrint(message: 'Error capturing widget offscreen: $e', isError: true);
      return null;
    }
  }

  /// Captures the widget associated with [globalKeyRizzReportMainCard] as an image,
  /// saves it to the device's photo gallery, and shows a success snackbar if the
  /// save operation is successful. If an error occurs during the capture or
  /// conversion process, the method logs the error and shows an error snackbar.
  Future<void> captureAndSaveWidgetImage(BuildContext context) async {
    try {
      File? file = await _captureWidgetAsFile(context);
      if (file == null) return;

      final fileName = 'rizz_report.png';
      final skipIfExists = false;
      final bytes = await file.readAsBytes();
      final result = await SaverGallery.saveImage(bytes, fileName: fileName, skipIfExists: skipIfExists);
      if (result.isSuccess) {
        showSuccessSnackBar('Rizz report saved to gallery successfully');
      } else {
        logPrint(message: 'Fail image to gallery', isError: true);
      }
    } catch (e) {
      logPrint(message: 'Error capturing widget: $e', isError: true);
    }
  }

  /// Captures the widget associated with [globalKeyRizzReportMainCard] as an image,
  /// and shares it using the platform's share feature.
  Future<void> shareRizzReport(BuildContext context) async {
    try {
      File? file = await _captureWidgetAsFile(context);
      if (file == null) return;

      await Share.shareXFiles([XFile(file.path)], text: 'Check out my Rizz Report!');
    } catch (e) {
      logPrint(message: 'Error sharing widget: $e', isError: true);
    }
  }

  Future<void> updateProfile(String? imagePath, String? name) async {
    if (name != null) {
      // Dismiss the edit name dialog
      dismissLoadingDialog();
    }
    loadingDialog();
    Map<String, dynamic> data = {
      'device_id': _localStorage.getUserData.data?.deviceId,
      'profile_image': imagePath != null ? await MultipartFile.fromFile(imagePath) : null,
      'name': name,
    };
    FormData formData = FormData.fromMap(data);
    _apiRequest.updateProfileApi(formData).then((value) {
      _localStorage.setUserData(UserModel.fromJson(value));
      notifyListeners();
      dismissLoadingDialog();
    }).onError(
          (error, stackTrace) {
        commonErrorDioHandler(error, closeLoadingDialog: true, showSnackBar: true);
      },
    );
  }

  Future<void> pickImageFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        await updateProfile(image.path, null);
      } else {
        // User canceled the picker
      }
    } catch (e) {
      commonErrorDioHandler(e);
    }
  }

  void getLeaderBoardData(int page) {
    Map<String, dynamic> data = {
      'page': page,
    };
    if (page == 1) {
      loadingDialog();
    } else {
      isMoreDataLoading = true;
      notifyListeners();
    }

    _apiRequest.currentRankListApi(data).then((value) {
      leaderBoardData = LeaderBoardModel.fromJson(value);
      maxPage = leaderBoardData.data?.lastPage ?? 0;
      listOfLeaderBoardItems.addAll(leaderBoardData.data!.items!);
      if (page == 1) {
        dismissLoadingDialog();
        getx.Get.to(() => Leaderboard());
      } else {
        isMoreDataLoading = false;
        notifyListeners();
      }
    }).onError(
          (error, stackTrace) {
        if (page == 1) {
          commonErrorDioHandler(error, closeLoadingDialog: true, showSnackBar: true);
        } else {
          isMoreDataLoading = false;
          notifyListeners();
          commonErrorDioHandler(error);
        }
      },
    );
  }

  void currentUserRankData() {
    Map<String, dynamic> data = {
      'device_id': userData.data?.deviceId,
    };
    _apiRequest.currentUserRankApi(data).then((value) {
      currentUserRank = value['data'];
      notifyListeners();
    }).onError(
          (error, stackTrace) {
        commonErrorDioHandler(error);
      },
    );
  }

  void resetData() {
    listOfLeaderBoardItems.clear();
    maxPage = 5;
    notifyListeners();
  }
}
