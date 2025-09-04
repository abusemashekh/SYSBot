import 'dart:io';

import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sysbot3/backend/api_requests.dart';
import 'package:sysbot3/backend/local_storage/local_storage.dart';
import 'package:sysbot3/model/user_model.dart';
import 'package:sysbot3/utils/functions/common_fun.dart';

class PaymentConstant {
  // static const offeringMvp = 'subscription';
  static const offeringMvp = 'new_subscriptions';
  static const entitlementMVP = 'unlmited_shot';

  static const googleApiKey = 'goog_XgFmFCaeczKeRrQFAvMRXizygCQ';
  static const appleApiKey = 'appl_dCfmAicSsdEivsZqPCFdTISmJMd';
}

Future<void> initPlatformState() async {
  PurchasesConfiguration configuration;
  final apiKey = Platform.isAndroid
      ? PaymentConstant.googleApiKey
      : PaymentConstant.appleApiKey;
  configuration = PurchasesConfiguration(apiKey);

  await Purchases.configure(configuration);
}

/// Checks if the user has an active subscription upgrade.
///
/// This function retrieves the customer's purchase information to determine
/// if the user has the active entitlement specified in [PaymentConstant.entitlementMVP].
/// It updates the user's upgrade status in local storage and the backend database.
///
Future<bool> checkIsUserUpgraded() async {
  final apiRequests = ApiRequests();
  final localStorage = LocalStorage();
  try {
    CustomerInfo purchaserInfo = await Purchases.getCustomerInfo();
    bool hasEntitlement =
        // localStorage.getUserData.data?.referredBy == FREE_USER_ID ||
        (purchaserInfo
                .entitlements.all[PaymentConstant.entitlementMVP]?.isActive ??
            false);
    // Update the user's upgrade status in local storage
    localStorage.setIsUserUpgrade(hasEntitlement);
    Map<String, dynamic> data = {
      'device_id': localStorage.getUserData.data?.deviceId,
      'pro_plan': manageUpgradeStatus(
          hasEntitlement), // it will return 1 (true) or 0 (false)
    };
    // Update the user's upgrade status in the backend database
    if (localStorage.getUserData.data?.deviceId != null) {
      var apiValue = await apiRequests.updatePlanStatusApi(data);
      // Update local storage
      await localStorage.setUserData(UserModel.fromJson(apiValue));
    }
    logPrint(message: 'UPGRADE status: $hasEntitlement');
    return hasEntitlement;
  } catch (e) {
    logPrint(message: 'Error checking User Upgrade status: $e', isError: true);
    return false;
  }
}
