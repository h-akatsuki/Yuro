import 'package:asmrapp/l10n/app_localizations.dart';

String localizedPlaylistName(String? name, AppLocalizations l10n) {
  switch (name) {
    case '__SYS_PLAYLIST_MARKED':
      return l10n.playlistSystemMarked;
    case '__SYS_PLAYLIST_LIKED':
      return l10n.playlistSystemLiked;
    default:
      return name ?? '';
  }
}
