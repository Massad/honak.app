import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:intl/intl.dart' hide TextDirection;

/// A single entry in the credit usage history.
///
/// [amount] is signed: positive = credits added, negative = credits used.
class CreditHistoryEntry {
  final DateTime date;
  final String description;
  final int amount;

  const CreditHistoryEntry({
    required this.date,
    required this.description,
    required this.amount,
  });
}

/// Unified usage-history bottom sheet used from:
/// - Page detail (CreditChip → "السجل")
/// - Subscriptions → subscription detail → "سجل الاستخدام"
///
/// Shows package info, balance, and entries grouped by month.
class CreditHistorySheet extends StatelessWidget {
  final String packageName;
  final String pageName;
  final String creditLabel;
  final List<CreditHistoryEntry> entries;
  final DateTime? startsAt;
  final DateTime? expiresAt;
  final int? remainingCredits;
  final int? totalCredits;

  const CreditHistorySheet({
    super.key,
    required this.packageName,
    required this.pageName,
    required this.creditLabel,
    required this.entries,
    this.startsAt,
    this.expiresAt,
    this.remainingCredits,
    this.totalCredits,
  });

  static Future<void> show(
    BuildContext context, {
    required String packageName,
    required String pageName,
    required String creditLabel,
    required List<CreditHistoryEntry> entries,
    DateTime? startsAt,
    DateTime? expiresAt,
    int? remainingCredits,
    int? totalCredits,
  }) {
    return showAppSheet(
      context,
      builder: (_) => CreditHistorySheet(
        packageName: packageName,
        pageName: pageName,
        creditLabel: creditLabel,
        entries: entries,
        startsAt: startsAt,
        expiresAt: expiresAt,
        remainingCredits: remainingCredits,
        totalCredits: totalCredits,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupByMonth(entries);

    return Column(
      children: [
        // Drag handle
        const SizedBox(height: AppSpacing.sm),
        Container(
          width: 36,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(2),
          ),
        ),

        // Header
        _Header(
          packageName: packageName,
          pageName: pageName,
          startsAt: startsAt,
          expiresAt: expiresAt,
          onClose: () => Navigator.of(context).pop(),
        ),

        Divider(height: 1, color: Colors.grey.shade100),

        // Content
        Flexible(
          child: entries.isEmpty
              ? _buildEmptyState(context)
              : ListView(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.lg,
                    0,
                    AppSpacing.lg,
                    AppSpacing.lg,
                  ),
                  children: [
                    // Balance card
                    if (totalCredits != null && totalCredits! > 0)
                      _BalanceCard(
                        remaining: remainingCredits ?? 0,
                        total: totalCredits!,
                        creditLabel: creditLabel,
                      ),

                    // Grouped entries
                    for (final group in grouped) ...[
                      _MonthHeader(label: group.label),
                      for (final entry in group.entries)
                        _EntryRow(entry: entry),
                    ],

                    const SizedBox(height: AppSpacing.md),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 40,
            color: Colors.grey.shade200,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            // "لا يوجد سجل بعد"
            '\u0644\u0627 \u064a\u0648\u062c\u062f \u0633\u062c\u0644 \u0628\u0639\u062f',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }

  /// Groups entries by year-month, sorted newest month first.
  /// Within each month, entries are sorted newest first.
  static List<_MonthGroup> _groupByMonth(List<CreditHistoryEntry> entries) {
    final map = <String, List<CreditHistoryEntry>>{};
    for (final e in entries) {
      final key =
          '${e.date.year}-${e.date.month.toString().padLeft(2, '0')}';
      (map[key] ??= []).add(e);
    }

    final months = map.keys.toList()..sort((a, b) => b.compareTo(a));

    return months.map((key) {
      final monthEntries = map[key]!
        ..sort((a, b) => b.date.compareTo(a.date));

      final parts = key.split('-');
      final dt =
          DateTime(int.parse(parts[0]), int.parse(parts[1]));
      final label = DateFormat.yMMMM('ar').format(dt);

      return _MonthGroup(label: label, entries: monthEntries);
    }).toList();
  }
}

class _MonthGroup {
  final String label;
  final List<CreditHistoryEntry> entries;
  const _MonthGroup({required this.label, required this.entries});
}

// ─── Header ──────────────────────────────────────────────────

class _Header extends StatelessWidget {
  final String packageName;
  final String pageName;
  final DateTime? startsAt;
  final DateTime? expiresAt;
  final VoidCallback onClose;

  const _Header({
    required this.packageName,
    required this.pageName,
    this.startsAt,
    this.expiresAt,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Column(
        children: [
          // Title row
          Row(
            children: [
              Expanded(
                child: Text(
                  // "سجل الاستخدام"
                  '\u0633\u062c\u0644 \u0627\u0644\u0627\u0633\u062a\u062e\u062f\u0627\u0645',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onClose,
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

          const SizedBox(height: AppSpacing.sm),

          // Package + page name
          Text(
            '$packageName \u2014 $pageName',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),

          // Date range
          if (startsAt != null) ...[
            const SizedBox(height: 2),
            Text(
              _formatDateRange(),
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  String _formatDateRange() {
    final fmt = DateFormat('d MMM yyyy', 'ar');
    final start =
        // "بدأت:"
        '\u0628\u062f\u0623\u062a: ${fmt.format(startsAt!)}';
    if (expiresAt != null) {
      return '$start \u00b7 '
          // "تنتهي:"
          '\u062a\u0646\u062a\u0647\u064a: ${fmt.format(expiresAt!)}';
    }
    return start;
  }
}

// ─── Balance Card ────────────────────────────────────────────

class _BalanceCard extends StatelessWidget {
  final int remaining;
  final int total;
  final String creditLabel;

  const _BalanceCard({
    required this.remaining,
    required this.total,
    required this.creditLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF), // blue-50
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            '$remaining / $total',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A73E8),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            // "{creditLabel} متبقي"
            '$creditLabel \u0645\u062a\u0628\u0642\u064a',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF1E40AF), // blue-800
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Month Header ────────────────────────────────────────────

class _MonthHeader extends StatelessWidget {
  final String label;
  const _MonthHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.lg,
        bottom: AppSpacing.sm,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: Colors.grey.shade400,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ─── Entry Row ───────────────────────────────────────────────

class _EntryRow extends StatelessWidget {
  final CreditHistoryEntry entry;

  const _EntryRow({required this.entry});

  @override
  Widget build(BuildContext context) {
    final isPositive = entry.amount > 0;
    final color = isPositive ? AppColors.success : AppColors.info;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade50),
        ),
      ),
      child: Row(
        children: [
          // Description + date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.description,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  DateFormat('d MMMM', 'ar').format(entry.date),
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: AppSpacing.sm),

          // Amount badge
          if (entry.amount != 0)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  isPositive ? '+${entry.amount}' : '${entry.amount}',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
