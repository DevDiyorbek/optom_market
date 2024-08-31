import 'package:url_launcher/url_launcher.dart';

void navigateToTelegramBot() async {
  const telegramUrl = 'https://t.me/MusicLyricsSSbot';

  if (await canLaunch(telegramUrl)) {
    await launch(telegramUrl);
  } else {
    throw 'Could not launch $telegramUrl';
  }
}