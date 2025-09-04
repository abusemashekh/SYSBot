import 'package:url_launcher/url_launcher.dart';

Future<void> launchEmail(
    {required String subject,
    required String body,
    required String supportEmail}) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: supportEmail,
    query: 'subject=$subject&body=$body',
  );

  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    // Handle error if the URL can't be launched
    print('Could not launch $emailUri');
  }
}
