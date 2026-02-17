import 'package:flutter/widgets.dart';
import 'package:honak/core/extensions/context_ext.dart';

enum QueueStatus {
  waiting,
  onTheWay,
  inProgress,
  ready,
  completed,
  noShow;

  /// Localized label via l10n. Requires [BuildContext].
  String label(BuildContext context) => switch (this) {
        waiting => context.l10n.queueLabelWaiting,
        onTheWay => context.l10n.queueLabelOnTheWay,
        inProgress => context.l10n.queueLabelInProgress,
        ready => context.l10n.queueLabelReady,
        completed => context.l10n.queueLabelCompleted,
        noShow => context.l10n.queueLabelNoShow,
      };
}
