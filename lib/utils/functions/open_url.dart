import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(
    {required String androidUrl, required String iosUrl}) async {
  final Uri iosURL = Uri.parse(iosUrl);
  final Uri androidURL = Uri.parse(androidUrl);

  final Uri url = Platform.isIOS ? iosURL : androidURL;

  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}
