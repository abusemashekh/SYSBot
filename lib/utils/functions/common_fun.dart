import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sysbot3/backend/api_end_points.dart';
import 'package:sysbot3/widgets/loading.dart';
import 'package:sysbot3/widgets/snackbars.dart';

void logPrint(
    {String message = 'No ERR', bool isError = false, StackTrace? stackTrace}) {
  if (kDebugMode) {
    if (isError) {
      if (stackTrace != null) {
        log('\x1B[31m${"🔥 Exception Data: $message"}\x1B[0m',
            error: stackTrace);
      } else {
        log('\x1B[31m${"🔥 Exception Data: $message"}\x1B[0m');
      }
    } else {
      log('\x1B[34m${"😃 Log Data: $message"}\x1B[0m');
    }
  }
}

void commonErrorDioHandler(Object? error,
    {bool closeLoadingDialog = false,
    bool showSnackBar = false,
    StackTrace? stackTrace}) {
  if (error is DioException) {
    if (closeLoadingDialog) dismissLoadingDialog();
    if (showSnackBar) showErrorSnackBar(text: error.error.toString());
    if (stackTrace != null) {
      logPrint(
          message: error.toString(), isError: true, stackTrace: stackTrace);
    } else {
      logPrint(message: error.toString(), isError: true);
    }
  }
}

/// Converts [seconds] to minutes.
///
/// If [seconds] is null or 0, returns 0.
///
/// Otherwise, it subtracts [seconds] from 30 minutes in seconds and divides by
/// 60 to get the remaining minutes in double with one decimal place.
double secondsToMinutes(int? seconds) {
  if (seconds == null || seconds == 0) {
    return 0;
  }
  var initialSeconds = 30 * 60;
  final remainindSeconds = initialSeconds - (initialSeconds - seconds);
  return double.parse((remainindSeconds / 60).toStringAsFixed(1));
}

String fullImageUrl(String url) {
  return ApiEndpoints.imageUrl + url;
}

/// Returns a valid [ImageProvider] for a given [url].
///
/// If the [url] is null, returns an [AssetImage] pointing to the default bot head image.
/// Otherwise, returns a [NetworkImage] pointing to the absolute URL of the image.
ImageProvider<Object> manipulateImage(String? url) {
  return url != null
      ? NetworkImage(fullImageUrl(url))
      : const AssetImage('assets/images/bot_image.png');
}

/// Format a double to a string.
///
/// If the double is an integer (i.e. it has no decimal places), it is
/// formatted as an integer. Otherwise, it is formatted as a double.
///
String formatDouble(double value) {
  if (value == value.toInt()) {
    return value.toInt().toString();
  } else {
    return value.toString();
  }
}

/// Returns 1 if [status] is true, 0 if [status] is false.
///
/// This is used to convert a boolean value to an integer for the upgrade status
/// in the database.
int manageUpgradeStatus(bool status) {
  return status ? 1 : 0;
}

/// Calculates a responsive size based on the screen width.
///
/// Takes a [size] value and scales it relative to a base screen width of 390 pixels.
/// This function is useful for making UI elements proportionate across different devices.
///
/// Returns a double representing the scaled size.
double getResponsiveSize(double size) {
  final screenWidth = MediaQuery.of(Get.context!).size.width;
  return size * screenWidth / 390;
}

/// Returns the ordinal representation of a number.
///
/// For example, 1 becomes 1st, 2 becomes 2nd, 3 becomes 3rd, and so on.
/// Handles numbers of any size.
String getOrdinalSuffix(int number) {
  if (number % 100 >= 11 && number % 100 <= 13) {
    return '${number}th';
  }

  switch (number % 10) {
    case 1:
      return '${number}st';
    case 2:
      return '${number}nd';
    case 3:
      return '${number}rd';
    default:
      return '${number}th';
  }
}

String setUserId(int? id) {
  return 'User $id';
}
