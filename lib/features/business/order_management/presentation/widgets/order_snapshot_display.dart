import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/entities/money.dart';

/// Locked-in booking terms at the time of reservation.
class OrderSnapshot {
  final PriceSnapshot priceSnapshot;
  final CancellationPolicySnapshot? cancellationPolicy;
  final List<String> houseRules;
  final List<DisclaimerSnapshot> disclaimers;
  final List<QuestionAnswer> questions;
  final List<String> paymentMethods;
  final String capturedAt; // ISO 8601

  const OrderSnapshot({
    required this.priceSnapshot,
    this.cancellationPolicy,
    this.houseRules = const [],
    this.disclaimers = const [],
    this.questions = const [],
    this.paymentMethods = const [],
    required this.capturedAt,
  });
}

class PriceSnapshot {
  final int? basePricePerNight; // piasters
  final int? totalNights;
  final int? cleaningFee; // piasters
  final int? discountAmount; // piasters
  final String? discountLabel;
  final int total; // piasters
  final int depositRequired; // piasters

  const PriceSnapshot({
    this.basePricePerNight,
    this.totalNights,
    this.cleaningFee,
    this.discountAmount,
    this.discountLabel,
    required this.total,
    this.depositRequired = 0,
  });
}

class CancellationPolicySnapshot {
  final String? lateCancelMessage;
  final String? lateCancelFeeType; // none, keep_deposit, percentage, fixed
  final int? lateCancelPercentage;
  final int? lateCancelAmount; // piasters

  const CancellationPolicySnapshot({
    this.lateCancelMessage,
    this.lateCancelFeeType,
    this.lateCancelPercentage,
    this.lateCancelAmount,
  });
}

enum DisclaimerType { safety, responsibility, policy, custom }

class DisclaimerSnapshot {
  final String id;
  final DisclaimerType type;
  final String title;
  final String content;
  final bool acknowledged;

  const DisclaimerSnapshot({
    required this.id,
    required this.type,
    required this.title,
    required this.content,
    this.acknowledged = false,
  });
}

class QuestionAnswer {
  final String questionId;
  final String question;
  final String? answer;

  const QuestionAnswer({
    required this.questionId,
    required this.question,
    this.answer,
  });
}

/// Expand/collapse card showing locked-in booking terms.
class OrderSnapshotDisplay extends StatefulWidget {
  final OrderSnapshot snapshot;

  const OrderSnapshotDisplay({
    super.key,
    required this.snapshot,
  });

  @override
  State<OrderSnapshotDisplay> createState() => _OrderSnapshotDisplayState();
}

class _OrderSnapshotDisplayState extends State<OrderSnapshotDisplay> {
  bool _expanded = false;
  static const _purple = Color(0xFF7C3AED);

  OrderSnapshot get _snap => widget.snapshot;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Collapsed header ──
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: _purple.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Icon(Icons.lock_outline, size: 18, color: _purple),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'شروط الحجز المثبّتة',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: cs.onSurface,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: _purple.withValues(alpha: 0.05),
                                borderRadius: AppRadius.pill,
                              ),
                              child: Text(
                                'مرجع',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: _purple,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'تم التثبيت ${_snap.capturedAt}',
                          style: TextStyle(
                            fontSize: 10,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 20,
                    color: AppColors.textHint,
                  ),
                ],
              ),
            ),
          ),

          // ── Expanded content ──
          if (_expanded) ...[
            Divider(height: 1, color: AppColors.border),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info banner
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _purple.withValues(alpha: 0.03),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.lock_outline,
                            size: 12, color: _purple.withValues(alpha: 0.6)),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'هذه نسخة مثبّتة من شروط الحجز كما كانت لحظة إرسال الطلب. '
                            'لا يمكن تعديلها وتُستخدم كمرجع في حال وجود خلاف.',
                            style: TextStyle(
                              fontSize: 10,
                              color: _purple.withValues(alpha: 0.8),
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Price snapshot
                  _buildPriceSection(context),
                  const SizedBox(height: AppSpacing.md),

                  // Cancellation policy
                  if (_snap.cancellationPolicy != null)
                    _buildCancellationSection(context),

                  // House rules
                  if (_snap.houseRules.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.md),
                    _buildHouseRulesSection(context),
                  ],

                  // Disclaimers
                  if (_snap.disclaimers.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.md),
                    _buildDisclaimersSection(context),
                  ],

                  // Questions
                  if (_snap.questions.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.md),
                    _buildQuestionsSection(context),
                  ],

                  // Payment methods
                  if (_snap.paymentMethods.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.md),
                    _buildPaymentMethodsSection(context),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPriceSection(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final price = _snap.priceSnapshot;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.receipt_long_outlined, size: 10, color: cs.onSurfaceVariant),
            const SizedBox(width: 4),
            Text(
              'التسعير عند الحجز',
              style: TextStyle(fontSize: 10, color: cs.onSurfaceVariant),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: cs.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Column(
            children: [
              if (price.basePricePerNight != null)
                _PriceRow(
                  label: 'السعر لكل ليلة',
                  value: Money(price.basePricePerNight!).toFormattedArabic(),
                ),
              if (price.totalNights != null)
                _PriceRow(
                  label: 'عدد الليالي',
                  value: '${price.totalNights}',
                ),
              if (price.cleaningFee != null)
                _PriceRow(
                  label: 'رسوم التنظيف',
                  value: Money(price.cleaningFee!).toFormattedArabic(),
                ),
              if (price.discountAmount != null)
                _PriceRow(
                  label: price.discountLabel ?? 'خصم',
                  value: '-${Money(price.discountAmount!).toFormattedArabic()}',
                  valueColor: AppColors.success,
                ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.only(top: 4),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColors.divider),
                  ),
                ),
                child: _PriceRow(
                  label: 'المجموع',
                  value: Money(price.total).toFormattedArabic(),
                  valueColor: AppColors.primary,
                  isBold: true,
                ),
              ),
              if (price.depositRequired > 0)
                _PriceRow(
                  label: 'العربون المطلوب',
                  value: Money(price.depositRequired).toFormattedArabic(),
                  valueColor: AppColors.warning,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCancellationSection(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final policy = _snap.cancellationPolicy!;

    String? feeText;
    if (policy.lateCancelFeeType == 'keep_deposit') {
      feeText = 'الإلغاء المتأخر: يحتفظ بالعربون';
    } else if (policy.lateCancelFeeType == 'percentage' &&
        policy.lateCancelPercentage != null) {
      feeText = 'الإلغاء المتأخر: ${policy.lateCancelPercentage}% من المبلغ';
    } else if (policy.lateCancelFeeType == 'fixed' &&
        policy.lateCancelAmount != null) {
      feeText =
          'الإلغاء المتأخر: ${Money(policy.lateCancelAmount!).toFormattedArabic()}';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'سياسة الإلغاء عند الحجز',
          style: TextStyle(fontSize: 10, color: cs.onSurfaceVariant),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: cs.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                policy.lateCancelMessage ?? 'لا توجد سياسة إلغاء',
                style: TextStyle(fontSize: 11, color: cs.onSurface, height: 1.4),
              ),
              if (feeText != null) ...[
                const SizedBox(height: 4),
                Text(
                  feeText,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.warning,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHouseRulesSection(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'قوانين المنزل عند الحجز',
          style: TextStyle(fontSize: 10, color: cs.onSurfaceVariant),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: cs.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _snap.houseRules
                .map((rule) => Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        '• $rule',
                        style: TextStyle(
                          fontSize: 11,
                          color: cs.onSurface,
                          height: 1.4,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDisclaimersSection(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ackCount =
        _snap.disclaimers.where((d) => d.acknowledged).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.shield_outlined, size: 10, color: cs.onSurfaceVariant),
            const SizedBox(width: 4),
            Text(
              'بنود السلامة والمسؤولية ($ackCount/${_snap.disclaimers.length} تم الموافقة)',
              style: TextStyle(fontSize: 10, color: cs.onSurfaceVariant),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ..._snap.disclaimers.map((disc) {
          final dColor = _disclaimerColor(disc.type);
          final dIcon = _disclaimerIcon(disc.type);

          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: cs.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(dIcon, size: 12, color: dColor),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                disc.title,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: cs.onSurface,
                                ),
                              ),
                            ),
                            if (disc.acknowledged) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.success
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'وافق ✓',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: AppColors.success,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          disc.content,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            color: cs.onSurfaceVariant,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildQuestionsSection(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.fact_check_outlined, size: 10, color: cs.onSurfaceVariant),
            const SizedBox(width: 4),
            Text(
              'إجابات العميل (${_snap.questions.length})',
              style: TextStyle(fontSize: 10, color: cs.onSurfaceVariant),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: cs.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _snap.questions.map((qa) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      qa.question,
                      style: TextStyle(
                        fontSize: 10,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      qa.answer ?? '—',
                      style: TextStyle(
                        fontSize: 11,
                        color: cs.onSurface,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodsSection(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'طرق الدفع المتاحة عند الحجز',
          style: TextStyle(fontSize: 10, color: cs.onSurfaceVariant),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: _snap.paymentMethods.map((m) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: cs.surfaceContainerLowest,
                borderRadius: AppRadius.pill,
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                m,
                style: TextStyle(fontSize: 9, color: cs.onSurfaceVariant),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Color _disclaimerColor(DisclaimerType type) {
    switch (type) {
      case DisclaimerType.safety:
        return AppColors.error;
      case DisclaimerType.responsibility:
        return AppColors.warning;
      case DisclaimerType.policy:
        return AppColors.primary;
      case DisclaimerType.custom:
        return AppColors.textSecondary;
    }
  }

  IconData _disclaimerIcon(DisclaimerType type) {
    switch (type) {
      case DisclaimerType.safety:
        return Icons.shield_outlined;
      case DisclaimerType.responsibility:
        return Icons.front_hand_outlined;
      case DisclaimerType.policy:
        return Icons.article_outlined;
      case DisclaimerType.custom:
        return Icons.label_outline;
    }
  }
}

// ─── Price Row helper ──────────────────────────────────────

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isBold;

  const _PriceRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isBold ? cs.onSurface : cs.onSurfaceVariant,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 11,
              color: valueColor ?? cs.onSurface,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
