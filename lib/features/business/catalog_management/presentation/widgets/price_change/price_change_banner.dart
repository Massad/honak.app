import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/catalog_management/domain/entities/price_change.dart';
import 'package:intl/intl.dart' hide TextDirection;

// ── Helpers ──────────────────────────────────────────────────────────────────

bool isChangeActive(PriceChange change) {
  if (change.status != 'active') return false;
  final now = DateTime.now();
  final start = DateTime.parse(change.startsAt);
  if (now.isBefore(start)) return false;
  if (change.endsAt != null) {
    final end = DateTime.parse(change.endsAt!);
    if (now.isAfter(end)) return false;
  }
  return true;
}

bool _isScheduled(PriceChange change) {
  if (change.status == 'cancelled' || change.status == 'expired') return false;
  final now = DateTime.now();
  final start = DateTime.parse(change.startsAt);
  return now.isBefore(start);
}

int getDaysRemaining(String? endsAt) {
  if (endsAt == null) return -1;
  final end = DateTime.parse(endsAt);
  final diff = end.difference(DateTime.now()).inDays;
  return diff < 0 ? 0 : diff;
}

int _getDaysUntilStart(String startsAt) {
  final start = DateTime.parse(startsAt);
  final diff = start.difference(DateTime.now()).inDays;
  return diff < 0 ? 0 : diff;
}

double getProgressPercent(String startsAt, String? endsAt) {
  if (endsAt == null) return 0;
  final start = DateTime.parse(startsAt);
  final end = DateTime.parse(endsAt);
  final total = end.difference(start).inMinutes;
  if (total <= 0) return 100;
  final elapsed = DateTime.now().difference(start).inMinutes;
  return (elapsed / total * 100).clamp(0, 100);
}

String formatDateAr(String iso) {
  final date = DateTime.parse(iso);
  final months = [
    '',
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ];
  return '${date.day} ${months[date.month]}';
}

String _valueText(PriceChange change) {
  final sign = change.direction == 'decrease' ? '-' : '+';
  if (change.method == 'percentage') {
    return '$sign${change.value.toStringAsFixed(0)}%';
  }
  final formatted = NumberFormat('#,##0.##').format(change.value / 100);
  return '$sign$formatted د.أ';
}

String _scopeText(PriceChange change) {
  switch (change.scope) {
    case 'category':
      return change.categoryNames.join('، ');
    case 'specific':
      return '${change.affectedCount} عنصر';
    default:
      return 'جميع الأصناف';
  }
}

Color _directionColor(String direction) =>
    direction == 'decrease' ? AppColors.success : AppColors.warning;

IconData _directionIcon(String direction) =>
    direction == 'decrease'
        ? Icons.arrow_circle_down_outlined
        : Icons.arrow_circle_up_outlined;

// ── Banner Widget ────────────────────────────────────────────────────────────

class PriceChangeBanner extends StatelessWidget {
  final PriceChange? activePriceChange;
  final int historyCount;
  final VoidCallback onCreateNew;
  final VoidCallback onEdit;
  final VoidCallback onStop;
  final VoidCallback onViewHistory;

  const PriceChangeBanner({
    super.key,
    this.activePriceChange,
    required this.historyCount,
    required this.onCreateNew,
    required this.onEdit,
    required this.onStop,
    required this.onViewHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Column(
        children: [
          if (activePriceChange != null && _isScheduled(activePriceChange!))
            _ScheduledCard(
              change: activePriceChange!,
              onEdit: onEdit,
              onCancel: onStop,
            )
          else if (activePriceChange != null &&
              isChangeActive(activePriceChange!))
            _ActiveCard(
              change: activePriceChange!,
              onEdit: onEdit,
              onStop: onStop,
            )
          else
            _EmptyCard(onCreateNew: onCreateNew),
          const SizedBox(height: AppSpacing.sm),
          _HistoryLink(count: historyCount, onTap: onViewHistory),
        ],
      ),
    );
  }
}

// ── Empty State ──────────────────────────────────────────────────────────────

class _EmptyCard extends StatelessWidget {
  final VoidCallback onCreateNew;

  const _EmptyCard({required this.onCreateNew});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.local_offer_outlined,
            size: 14,
            color: Colors.grey.shade400,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'تغييرات الأسعار',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            ),
          ),
          GestureDetector(
            onTap: onCreateNew,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, size: 12, color: Colors.white),
                  SizedBox(width: 4),
                  Text(
                    'تغيير جديد',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Active Change Card ───────────────────────────────────────────────────────

class _ActiveCard extends StatelessWidget {
  final PriceChange change;
  final VoidCallback onEdit;
  final VoidCallback onStop;

  const _ActiveCard({
    required this.change,
    required this.onEdit,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    final color = _directionColor(change.direction);
    final hasEnd = change.endsAt != null;
    final daysLeft = getDaysRemaining(change.endsAt);
    final progress = getProgressPercent(change.startsAt, change.endsAt);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row: icon + value + scope
          Row(
            children: [
              Icon(_directionIcon(change.direction), size: 22, color: color),
              const SizedBox(width: AppSpacing.sm),
              Text(
                _valueText(change),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  _scopeText(change),
                  style: TextStyle(
                    fontSize: 13,
                    color: color.withValues(alpha: 0.8),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          // Reason + date range
          if (change.reason.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              change.reason,
              style: TextStyle(
                fontSize: 12,
                color: color.withValues(alpha: 0.7),
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          // Affected count + visibility
          Row(
            children: [
              Text(
                '${change.affectedCount} عنصر متأثر',
                style: TextStyle(
                  fontSize: 11,
                  color: color.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Icon(
                change.isPublic ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                size: 12,
                color: color.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 2),
              Text(
                change.isPublic ? 'عام' : 'خاص',
                style: TextStyle(
                  fontSize: 11,
                  color: color.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          // Progress bar
          if (hasEnd) ...[
            const SizedBox(height: AppSpacing.md),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress / 100,
                minHeight: 5,
                backgroundColor: Colors.white.withValues(alpha: 0.6),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDateAr(change.startsAt),
                  style: TextStyle(
                    fontSize: 10,
                    color: color.withValues(alpha: 0.6),
                  ),
                ),
                Text(
                  '$daysLeft يوم متبقي',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                Text(
                  formatDateAr(change.endsAt!),
                  style: TextStyle(
                    fontSize: 10,
                    color: color.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          // Action buttons
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  label: 'تعديل',
                  color: Colors.grey.shade600,
                  bgColor: Colors.white.withValues(alpha: 0.7),
                  onTap: onEdit,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _ActionButton(
                  label: 'إيقاف الآن',
                  color: AppColors.error,
                  bgColor: AppColors.error.withValues(alpha: 0.1),
                  onTap: onStop,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Scheduled Change Card ────────────────────────────────────────────────────

class _ScheduledCard extends StatelessWidget {
  final PriceChange change;
  final VoidCallback onEdit;
  final VoidCallback onCancel;

  const _ScheduledCard({
    required this.change,
    required this.onEdit,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final daysUntil = _getDaysUntilStart(change.startsAt);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                size: 22,
                color: AppColors.primary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                _valueText(change),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  _scopeText(change),
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.primary.withValues(alpha: 0.8),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          // Countdown badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'يبدأ بعد $daysUntil يوم',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          // Action buttons
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  label: 'تعديل',
                  color: Colors.grey.shade600,
                  bgColor: Colors.white.withValues(alpha: 0.7),
                  onTap: onEdit,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _ActionButton(
                  label: 'إلغاء',
                  color: AppColors.error,
                  bgColor: AppColors.error.withValues(alpha: 0.1),
                  onTap: onCancel,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── History Link ─────────────────────────────────────────────────────────────

class _HistoryLink extends StatelessWidget {
  final int count;
  final VoidCallback onTap;

  const _HistoryLink({required this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.access_time, size: 10, color: Colors.grey.shade400),
            const SizedBox(width: 4),
            Text(
              'سجل تغييرات الأسعار ($count)',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
            ),
            const SizedBox(width: 2),
            Icon(Icons.chevron_left, size: 10, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}

// ── Action Button ────────────────────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color bgColor;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.color,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ),
    );
  }
}
