import 'package:url_launcher/url_launcher.dart';

void openLink(String? link) async {
  if (link == null) return;
  final Uri url = Uri.parse(link);

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

void sendEmail() async {
  final String recipient = 'sengthaite@gmail.com';
  final String subject = Uri.encodeComponent('Hello Friend');
  final String body = Uri.encodeComponent('Nice to meet you!');

  final Uri emailUri = Uri.parse(
    'mailto:$recipient?subject=$subject&body=$body',
  );

  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  }
}
