import 'package:honak/core/l10n/arb/app_localizations.dart';

String timeAgo(int timestamp) {
  final now = DateTime.now();
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  final diff = now.difference(date);
  if (diff.inMinutes < 60) return '${diff.inMinutes}د';
  if (diff.inHours < 24) return '${diff.inHours}س';
  return '${diff.inDays}ي';
}

String offerExpiryText(AppLocalizations l10n, int expiresAt) {
  final expiry = DateTime.fromMillisecondsSinceEpoch(expiresAt * 1000);
  final now = DateTime.now();
  final diff = expiry.difference(now);

  if (diff.isNegative) return l10n.offerExpired;
  if (diff.inHours < 1) return l10n.offerEndsToday;
  if (diff.inHours < 24) return l10n.offerExpiresIn('${diff.inHours}h');
  if (diff.inDays == 1) return l10n.offerEndsTomorrow;
  return l10n.offerExpiresIn('${diff.inDays}d');
}
