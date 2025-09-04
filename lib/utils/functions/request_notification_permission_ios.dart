import 'package:permission_handler/permission_handler.dart';

Future<void> askNotificationPermission() async {
  final status = await Permission.notification.request();

  if (status.isGranted) {
    print('Notification permission granted.');
  } else if (status.isDenied) {
    print('Notification permission denied.');
  } else if (status.isPermanentlyDenied) {
    print(
        'Notification permission permanently denied. Opening app settings...');
    await openAppSettings();
  }
}
