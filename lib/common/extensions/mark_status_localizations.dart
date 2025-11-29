import 'package:asmrapp/data/models/mark_status.dart';
import 'package:asmrapp/l10n/app_localizations.dart';

extension MarkStatusLocalizations on MarkStatus {
  String localizedLabel(AppLocalizations l10n) {
    switch (this) {
      case MarkStatus.wantToListen:
        return l10n.markStatusWantToListen;
      case MarkStatus.listening:
        return l10n.markStatusListening;
      case MarkStatus.listened:
        return l10n.markStatusListened;
      case MarkStatus.relistening:
        return l10n.markStatusRelistening;
      case MarkStatus.onHold:
        return l10n.markStatusOnHold;
    }
  }
}
