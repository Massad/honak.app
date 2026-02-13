import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// A single entry in the credit usage history.
class CreditHistoryEntry {
  final DateTime date;
  final String description;
  final int credits;

  const CreditHistoryEntry({
    required this.date,
    required this.description,
    required this.credits,
  });
}

/// Bottom sheet showing credit usage history for a subscription.
///
/// Show via [CreditHistorySheet.show].
class CreditHistorySheet extends StatelessWidget {
  final String creditLabel;
  final List<CreditHistoryEntry> entries;

  const CreditHistorySheet({
    super.key,
    required this.creditLabel,
    required this.entries,
  });

  /// Shows this sheet as a modal bottom sheet.
  static Future<void> show(
    BuildContext context, {
    required String creditLabel,
    required List<CreditHistoryEntry> entries,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CreditHistorySheet(
        creditLabel: creditLabel,
        entries: entries,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: context.screenHeight * 0.7,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.xxl),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(top: AppSpacing.sm),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      // "سجل {creditLabel}"
                      '\u0633\u062c\u0644 $creditLabel',
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Divider(height: 1, color: context.colorScheme.outlineVariant),

            // Entry list
            if (entries.isEmpty)
              Padding(
                padding: const EdgeInsets.all(AppSpacing.xxxl),
                child: Text(
                  // "لا يوجد سجل استخدام"
                  '\u0644\u0627 \u064a\u0648\u062c\u062f \u0633\u062c\u0644 \u0627\u0633\u062a\u062e\u062f\u0627\u0645',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              )
            else
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.lg,
                    AppSpacing.lg,
                  ),
                  itemCount: entries.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.xs),
                  itemBuilder: (context, index) =>
                      _EntryRow(entry: entries[index]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _EntryRow extends StatelessWidget {
  final CreditHistoryEntry entry;

  const _EntryRow({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          // Date
          SizedBox(
            width: 72,
            child: Text(
              _formatDate(entry.date),
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),

          const SizedBox(width: AppSpacing.sm),

          // Description
          Expanded(
            child: Text(
              entry.description,
              style: context.textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(width: AppSpacing.sm),

          // Credits
          Text(
            '-${entry.credits}',
            style: context.textTheme.labelSmall?.copyWith(
              color: const Color(0xFFDC2626), // red-600
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    return '$d/$m/${date.year}';
  }
}
