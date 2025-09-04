import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sysbot3/screens/bottom_nav_bar.dart';

import '../../../config/colors.dart';
import '../../../provider/onboard_provider.dart';
import '../../../widgets/custom_button.dart';

void openReferralCodeBottomSheet(
    {required BuildContext context,
    required RxBool isLoading,
    required RxBool showNoMoreInvitesTxt}) {
  showModalBottomSheet(
    isScrollControlled: true,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(40), topLeft: Radius.circular(40)),
    ),
    context: context,
    builder: (BuildContext context) {
      return ReferralCodeBottomSheet(
          isLoading: isLoading, showNoMoreInvitesTxt: showNoMoreInvitesTxt);
    },
  );
}

class ReferralCodeBottomSheet extends StatefulWidget {
  const ReferralCodeBottomSheet(
      {super.key, required this.isLoading, required this.showNoMoreInvitesTxt});

  final RxBool isLoading;
  final RxBool showNoMoreInvitesTxt;

  @override
  State<ReferralCodeBottomSheet> createState() =>
      _ReferralCodeBottomSheetState();
}

class _ReferralCodeBottomSheetState extends State<ReferralCodeBottomSheet> {
  String referralCode = 'U4Q58R';
  int invites = 3;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: width,
          decoration: const BoxDecoration(
            color: Color(0xff232323),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12), topLeft: Radius.circular(12)),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 27,
                  height: 4,
                  decoration: BoxDecoration(
                      color: const Color(0xff979797).withValues(alpha: 0.59),
                      borderRadius: BorderRadius.circular(7)),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/ticket-icon.png', width: 75),
                    CustomButton(
                        onTap: () async {
                          /// TODO: use commented code
                          Get.offAll(() => BottomNavBar());
                          /*final provider = Provider.of<OnboardProvider>(context, listen: false);
                          Get.back();
                          widget.isLoading.value = true;
                          var isRedeemed = await provider.redeemCode();
                          if (isRedeemed == false) {
                            final userData = provider.localStorage.getUserData.data;
                            if (userData?.settings?.promoCodes?.contains(userData.promoCode) ?? false) {
                              widget.isLoading.value = false;
                              Get.offAll(() => BottomNavBar());
                            } else {
                              widget.showNoMoreInvitesTxt.value = true;
                              await Future.delayed(const Duration(seconds: 3));
                              widget.isLoading.value = false;
                              widget.showNoMoreInvitesTxt.value = false;
                            }
                          } else {
                            widget.isLoading.value = false;
                            Get.offAll(() => BottomNavBar());
                          }*/
                        },
                        btnWidth: 102,
                        btnClr: const Color(0xff424242),
                        shadowClr: const Color(0xff424242),
                        title: 'Redeem',
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Share your invite code',
                        style: TextStyle(
                            fontFamily: 'ReservationWide',
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 20))),
                const SizedBox(height: 6),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        'Invite 3 friends to unlock results. After your friends sign up come back here and tap “Redeem” to get credit.',
                        style: TextStyle(
                            fontFamily: 'ReservationWide',
                            color: AppColors.mediumGrey,
                            fontWeight: FontWeight.w700,
                            fontSize: 13))),
                const SizedBox(height: 20),
                Container(
                  width: width,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Color(0xff434343).withValues(alpha: 0.68)),
                  child: Row(
                    children: [
                      const SizedBox(width: 36),
                      const Spacer(),
                      Text(referralCode,
                          style: TextStyle(
                              fontFamily: 'ReservationWide',
                              color: AppColors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 16)),
                      const Spacer(),
                      GestureDetector(
                          onTap: () async {
                            await Clipboard.setData(
                                ClipboardData(text: referralCode));
                            Get.snackbar('Invite code copied successfully', '',
                                colorText: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                messageText: SizedBox(),
                                margin: EdgeInsets.symmetric(horizontal: 20));
                          },
                          child: Image.asset('assets/images/copy-icon.png',
                              width: 17)),
                      const SizedBox(width: 20)
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                    onTap: () {
                      SharePlus.instance.share(
                        ShareParams(text: 'Download the app and use my referral code "$referralCode"')
                      );
                    },
                    title: 'Share')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
