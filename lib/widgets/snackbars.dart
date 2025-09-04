// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSuccessSnackBar(String? text) {
  Get.snackbar(
    '$text',
    '',
    colorText: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    messageText: SizedBox(),
    margin: EdgeInsets.symmetric(horizontal: 20),
  );
}

void showErrorSnackBar({String? text}) {
  Get.snackbar(
    '',
    '',
    titleText: Text('$text',
        style: TextStyle(fontFamily: 'Mont', fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white)),
    messageText: SizedBox(),
    colorText: Colors.white,
    icon: Icon(Icons.close, size: 20, color: Colors.white),
    borderRadius: 12,
    backgroundColor: const Color(0x84FF3A30),
    shouldIconPulse: false,
    padding: EdgeInsets.only(left: 20, top: 12, bottom: 12),
  );
  // Get.showSnackbar(
  //   GetSnackBar(
  //     messageText: ShakeWidget(
  //       maxRepetitions: 10,
  //       child: Row(
  //         children: [
  //           const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 26),
  //           const SizedBox(width: 12),
  //           Flexible(
  //             child: Text(
  //               text ?? 'Error',
  //               style: const TextStyle(
  //                 fontFamily: 'Mont',
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.w500,
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //     backgroundColor: const Color(0xffFF3B30),
  //     isDismissible: true,
  //     duration: duration,
  //     overlayBlur: 0.0001,
  //     borderRadius: 20,
  //     margin: _snackBarMargin,
  //     padding: _snackBarPadding,
  //   ),
  // );
}

// const EdgeInsets _snackBarMargin = EdgeInsets.symmetric(vertical: 15, horizontal: 15);
// const EdgeInsets _snackBarPadding = EdgeInsets.symmetric(horizontal: 15, vertical: 12);

// class ShakeWidget extends StatefulWidget {
//   const ShakeWidget({
//     super.key,
//     required this.child,
//     required this.maxRepetitions,
//   });
//   final Widget child;
//   final int maxRepetitions;

//   @override
//   State<ShakeWidget> createState() => _ShakeWidgetState();
// }

// class _ShakeWidgetState extends State<ShakeWidget> with SingleTickerProviderStateMixin {
//   late AnimationController animationController;
//   late Animation<double> _animation;
//   int _repetitionCount = 0;

//   @override
//   void initState() {
//     super.initState();
//     shakeWidget();
//   }

//   @override
//   void dispose() {
//     animationController.removeStatusListener(_updateAnimationStatus);
//     animationController.dispose();
//     super.dispose();
//   }

//   void _updateAnimationStatus(AnimationStatus status) {
//     if (status == AnimationStatus.completed) {
//       _repetitionCount++;
//       if (_repetitionCount < widget.maxRepetitions) {
//         animationController.reverse();
//       }
//     } else if (status == AnimationStatus.dismissed) {
//       animationController.forward();
//     }
//   }

//   void shakeWidget() {
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 50),
//     );
//     _animation = Tween<double>(begin: -1.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: animationController,
//         curve: Curves.easeInOutSine,
//       ),
//     );
//     animationController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         _repetitionCount++;
//         if (_repetitionCount < widget.maxRepetitions) {
//           animationController.reverse();
//         }
//       } else if (status == AnimationStatus.dismissed) {
//         animationController.forward();
//       }
//     });
//     animationController.addStatusListener(_updateAnimationStatus);

//     animationController.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animationController,
//       child: widget.child,
//       builder: (context, child) {
//         return Transform.translate(
//           offset: Offset(_animation.value, 0),
//           child: child,
//         );
//       },
//     );
//   }
// }
