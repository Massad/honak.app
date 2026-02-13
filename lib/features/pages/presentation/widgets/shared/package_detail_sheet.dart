import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';
import 'package:honak/features/pages/presentation/widgets/shared/packages_section.dart'
    show iconEmojiForPackage;
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

void showPackageDetailSheet(
  BuildContext context, {
  required Package pkg,
  required String archetype,
  String? pageName,
  int? existingCredits,
  String? existingCreditLabel,
}) {
  showAppSheet<void>(
    context,
    builder: (_) => PackageDetailSheet(
      pkg: pkg,
      archetype: archetype,
      pageName: pageName,
      existingCredits: existingCredits,
      existingCreditLabel: existingCreditLabel,
    ),
  );
}

class PackageDetailSheet extends StatelessWidget {
  final Package pkg;
  final String archetype;
  final String? pageName;
  final int? existingCredits;
  final String? existingCreditLabel;

  const PackageDetailSheet({
    super.key,
    required this.pkg,
    required this.archetype,
    this.pageName,
    this.existingCredits,
    this.existingCreditLabel,
  });

  @override
  Widget build(BuildContext context) {
    final price = Money(pkg.priceCents);
    final savings = _savingsPercent;
    final regularTotal = (pkg.compareSinglePrice != null && pkg.credits > 0)
        ? pkg.compareSinglePrice! * pkg.credits
        : null;
    final howItWorks = _howItWorksSteps;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        Container(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg, AppSpacing.xl, AppSpacing.lg, AppSpacing.md,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: context.colorScheme.outlineVariant,
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  pkg.name,
                  style: context.textTheme.titleMedium,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Content
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: Column(
              children: [
                // Icon + description
                _buildIconSection(context),
                const SizedBox(height: AppSpacing.lg),

                // Bundle items
                if (pkg.model == 'bundle' && pkg.items.isNotEmpty) ...[
                  _buildBundleItems(context),
                  const SizedBox(height: AppSpacing.lg),
                ],

                // Savings breakdown
                if (regularTotal != null && savings != null && savings > 0) ...[
                  _buildSavingsBreakdown(context, regularTotal, price),
                  const SizedBox(height: AppSpacing.lg),
                ] else if (pkg.compareSinglePrice != null &&
                    pkg.model == 'date_only') ...[
                  _buildDateOnlySavings(context),
                  const SizedBox(height: AppSpacing.lg),
                ],

                // Per-unit price
                if (pkg.credits > 0 && pkg.creditLabel != null) ...[
                  Center(
                    child: Text(
                      '(${Money((pkg.priceCents / pkg.credits).round()).toJodString()} د.أ لكل ${pkg.creditLabel})',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],

                // How it works
                if (howItWorks.isNotEmpty) ...[
                  _buildHowItWorks(context, howItWorks),
                  const SizedBox(height: AppSpacing.lg),
                ],

                // Info notice
                if (pkg.model != 'bundle') ...[
                  _buildInfoNotice(context),
                  const SizedBox(height: AppSpacing.lg),
                ],

                // Credit extension notice (existing subscription)
                if (existingCredits != null && pkg.credits > 0) ...[
                  _buildCreditExtensionNotice(context),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ],
            ),
          ),
        ),

        // CTA button
        _buildCta(context, price),
      ],
    );
  }

  Widget _buildIconSection(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF), // blue-50
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Center(
            child: Text(
              iconEmojiForPackage(pkg.icon),
              style: const TextStyle(fontSize: 28),
            ),
          ),
        ),
        if (pkg.description != null && pkg.description!.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            pkg.description!,
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
        if (_validityText != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            _validityText!,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }

  Widget _buildBundleItems(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'تشمل الباقة:',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ...pkg.items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Row(
                children: [
                  const Icon(
                    Icons.check,
                    size: 14,
                    color: AppColors.success,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      item,
                      style: context.textTheme.bodyMedium,
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

  Widget _buildSavingsBreakdown(
    BuildContext context,
    int regularTotal,
    Money packagePrice,
  ) {
    final savings = _savingsPercent!;
    final regularMoney = Money(regularTotal);
    final savedMoney = Money(regularTotal - pkg.priceCents);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: const Color(0xFFC8E6C9)),
      ),
      child: Column(
        children: [
          // Regular price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${regularMoney.toJodString()} د.أ',
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                'السعر العادي: ${pkg.credits} × ${Money(pkg.compareSinglePrice!).toJodString()} =',
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),

          // Package price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${packagePrice.toJodString()} د.أ',
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'سعر الباقة:',
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Divider(color: Color(0xFFA5D6A7)),
          ),

          // Savings
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${savedMoney.toJodString()} د.أ ($savings%)',
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'توفيرك:',
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateOnlySavings(BuildContext context) {
    final singlePrice = Money(pkg.compareSinglePrice!);
    final breakEven = (pkg.priceCents / pkg.compareSinglePrice!).ceil();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: const Color(0xFFC8E6C9)),
      ),
      child: Column(
        children: [
          Text(
            'الجلسة الواحدة: ${singlePrice.toFormattedArabic()}',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'توفّر بعد $breakEven زيارات',
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.success,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHowItWorks(BuildContext context, List<String> steps) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'كيف يعمل:',
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        ...steps.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEFF6FF),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${entry.key + 1}',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          entry.value,
                          style: context.textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ],
    );
  }

  Widget _buildInfoNotice(BuildContext context) {
    final text = pkg.model == 'date_only'
        ? 'الاشتراك لهذا النشاط التجاري فقط. غير قابل للاسترداد.'
        : 'الرصيد لهذا النشاط التجاري فقط.${pkg.validityMonths != null ? ' صالح لمدة ${pkg.validityMonths} أشهر.' : ''} غير قابل للاسترداد.';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF), // blue-50
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.info_outline,
              size: 14,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.primary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreditExtensionNotice(BuildContext context) {
    final label = existingCreditLabel ?? pkg.creditLabel ?? 'رصيد';
    final newTotal = existingCredits! + pkg.credits;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4), // green-50
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: const Color(0xFFBBF7D0)), // green-200
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.add_circle_outline,
              size: 14,
              color: AppColors.success,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'لديك اشتراك حالي',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  'عند الشراء سيُضاف ${pkg.credits} $label إلى رصيدك الحالي ($existingCredits $label متبقي)',
                  style: TextStyle(
                    fontSize: 11,
                    color: context.colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  'الرصيد بعد الشراء: $newTotal $label',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.success,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCta(BuildContext context, Money price) {
    final label = _ctaLabelWithPrice(price);

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: context.colorScheme.outlineVariant,
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('قريباً — شراء الباقات'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Text(label),
          ),
        ),
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────

  int? get _savingsPercent {
    if (pkg.compareSinglePrice == null || pkg.compareSinglePrice == 0) {
      return null;
    }
    if (pkg.credits <= 0) return null;
    final regularTotal = pkg.compareSinglePrice! * pkg.credits;
    if (regularTotal <= pkg.priceCents) return null;
    return (((regularTotal - pkg.priceCents) / regularTotal) * 100).round();
  }

  String? get _validityText {
    if (pkg.validityMonths != null && pkg.validityMonths! > 0) {
      return pkg.validityMonths == 1
          ? 'صالحة لمدة شهر من تاريخ الشراء'
          : 'صالحة لمدة ${pkg.validityMonths} أشهر من تاريخ الشراء';
    }
    if (pkg.model == 'visits_only') {
      return 'بدون تاريخ انتهاء — استخدم بوقتك';
    }
    return null;
  }

  String _ctaLabelWithPrice(Money price) {
    final priceStr = price.toFormattedArabic();
    if (pkg.model == 'bundle') {
      return archetype == 'service_booking'
          ? 'احجز الآن — $priceStr'
          : 'اطلب الآن — $priceStr';
    }
    if (pkg.model == 'date_only') return 'اشترك — $priceStr';
    return 'شراء الباقة — $priceStr';
  }

  List<String> get _howItWorksSteps {
    return switch (pkg.model) {
      'visits_and_date' => [
          'اشترِ هذه الباقة',
          'تحصل على ${pkg.credits} رصيد ${pkg.creditLabel ?? ''}',
          'كل طلب أو حجز يُخصم من رصيدك تلقائياً',
          'تابع رصيدك في أي وقت',
        ],
      'visits_only' => [
          'اشترِ هذه الباقة',
          'تحصل على ${pkg.credits} رصيد ${pkg.creditLabel ?? ''} — بدون تاريخ انتهاء',
          'كل طلب يُخصم من رصيدك تلقائياً',
          'استخدم بالسرعة التي تناسبك',
        ],
      'date_only' => [
          'اشترك في هذه الباقة',
          'احجز عدد غير محدود من الجلسات خلال فترة الاشتراك',
          'كل حجز مغطّى — بدون رسوم إضافية',
          'جدّد أو اترك الاشتراك ينتهي',
        ],
      'bundle' => [
          'اطلب الباقة وسيتواصل معك النشاط التجاري',
          'يتم تنسيق موعد التنفيذ مباشرة',
          'جميع العناصر المذكورة مشمولة بالسعر',
        ],
      _ => [],
    };
  }
}
