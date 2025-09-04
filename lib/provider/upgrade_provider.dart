import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../backend/local_storage/local_storage.dart';
import '../backend/payment/payment_constant.dart';
import '../screens/bottom_nav_bar.dart';
import '../utils/functions/common_fun.dart';
import '../widgets/loading.dart';
import '../widgets/snackbars.dart';

class UpgradeProvider extends ChangeNotifier {
  final localStorage = LocalStorage();

  /// Purchases a subscription for the user.
  ///
  /// If the user is already upgraded, shows a success snackbar and does nothing.
  /// Otherwise, attempts to purchase the first package available in the
  /// [PaymentConstant.offeringMvp] offering. If the offering is not found or
  /// there are no packages available, logs an error message. If a
  /// [PlatformException] is thrown while purchasing the package, logs an error
  /// message with the exception message. Otherwise, logs a success message with
  /// the user's entitlements and navigates to the [BottomNavBar].
  Future<void> purchaseSubscription() async {
    if (localStorage.getIsUserUpgrade == true) {
      showSuccessSnackBar('You are already upgraded');
      return;
    }
    String offeringIdentifier = PaymentConstant.offeringMvp;
    loadingDialog();
    try {
      Offerings offerings = await Purchases.getOfferings();

      if (offerings.all.containsKey(offeringIdentifier)) {
        Offering offering = offerings.all[offeringIdentifier]!;
        if (offering.availablePackages.isNotEmpty) {
          // Assuming the first package is the one you want to purchase
          Package packageToPurchase = offering.availablePackages.first;

          CustomerInfo customerInfo = await Purchases.purchasePackage(packageToPurchase);
          await checkIsUserUpgraded();
          dismissLoadingDialog();
          Get.offAll(() => BottomNavBar());

          logPrint(message: 'Purchase successful: ====>  ${customerInfo.entitlements.all}');
        } else {
          dismissLoadingDialog();
          logPrint(message: 'No packages available in the offering: $offeringIdentifier', isError: true);
        }
      } else {
        dismissLoadingDialog();
        logPrint(message: 'Offering not found: $offeringIdentifier', isError: true);
      }
    } on PlatformException catch (e) {
      dismissLoadingDialog();
      logPrint(message: 'Error purchasing subscription: ${e.message}', isError: true);
    }
  }

  /// Restores previous purchases for the user.
  ///
  /// This method is used to restore previous purchases for the user.
  /// It will check if the user has any previous purchases and update the
  /// user's upgrade status accordingly.
  ///
  /// If there is an error, it will log the error message.
  ///
  Future<void> restorePurchases() async {
    if (localStorage.getIsUserUpgrade == true) {
      showSuccessSnackBar('You are already upgraded');
      return;
    }
    try {
      loadingDialog();
      CustomerInfo restoredInfo = await Purchases.restorePurchases();
      bool isUserUpgrade = await checkIsUserUpgraded();
      if (isUserUpgrade) {
        dismissLoadingDialog();
        logPrint(message: 'Restoration successful: ====>  ${restoredInfo.entitlements.all}');
        showSuccessSnackBar('Purchases restored successfully');
        Get.offAll(() => BottomNavBar());
      } else {
        dismissLoadingDialog();
        showSuccessSnackBar('No Purchase To Restore');
      }
    } on PlatformException catch (e) {
      // showSuccessSnackBar('Error restoring purchases');
      dismissLoadingDialog();
      logPrint(message: 'Error restoring purchases: ${e.message}', isError: true);
    }
  }

/// Fetches the local price and currency symbol of the subscription.
///
/// This method retrieves the first available package in the specified offering
/// and returns its price and currency symbol. If no packages are available or
/// an error occurs, it logs the error and returns null.
// Future<Map<String, String>?> fetchSubscriptionPriceAndCurrency() async {
//   String offeringIdentifier = PaymentConstant.offeringMvp;
//   try {
//     Offerings offerings = await Purchases.getOfferings();

//     if (offerings.all.containsKey(offeringIdentifier)) {
//       Offering offering = offerings.all[offeringIdentifier]!;
//       if (offering.availablePackages.isNotEmpty) {
//         Package package = offering.availablePackages.first;
//         String price = package.storeProduct.priceString;
//         String currencySymbol = package.storeProduct.currencyCode;
//         return {'price': price, 'currencySymbol': currencySymbol};
//       } else {
//         logPrint(message: 'No packages available in the offering: $offeringIdentifier', isError: true);
//       }
//     } else {
//       logPrint(message: 'Offering not found: $offeringIdentifier', isError: true);
//     }
//   } on PlatformException catch (e) {
//     logPrint(message: 'Error fetching subscription price: ${e.message}', isError: true);
//   }
//   return null;
// }
}
