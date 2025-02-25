import 'package:url_launcher/url_launcher.dart';

void openEmail() async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: 'support@aakar.ai',
    queryParameters: {
      'subject': 'Support Request',
    },
  );

  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    print("Could not launch email client");
  }
}
