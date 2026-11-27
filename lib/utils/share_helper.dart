import 'package:share_plus/share_plus.dart';

Future<void> shareProfile(String name) {
  return SharePlus.instance.share(
    ShareParams(text: 'Lihat profil $name di SocialApp!'),
  );
}
