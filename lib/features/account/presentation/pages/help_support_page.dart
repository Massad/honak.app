import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/account/presentation/widgets/sub_screen_header.dart';
import 'package:honak/shared/widgets/app_screen.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});

  @override
  State<HelpSupportPage> createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
  int? _expandedFaq;
  bool _showReport = false;
  final _reportController = TextEditingController();

  static const _faqItems = [
    _FaqItem(
      q: 'كيف أتابع صفحة تجارية؟',
      a: 'من صفحة المتجر، اضغط زر "متابعة". ستظهر منشوراتهم في الصفحة الرئيسية وستتلقى إشعارات بالعروض الجديدة.',
    ),
    _FaqItem(
      q: 'كيف أطلب من متجر؟',
      a: 'ادخل صفحة المتجر، اختر المنتجات أو الخدمات، ثم اضغط "أرسل الطلب". سيتواصل معك المتجر لتأكيد التفاصيل.',
    ),
    _FaqItem(
      q: 'كيف أُنشئ صفحة تجارية؟',
      a: 'من حسابي \u2190 "أنشئ صفحتك التجارية". اختر نوع النشاط، أضف المعلومات الأساسية، وابدأ باستقبال الطلبات. الخدمة مجانية بالكامل.',
    ),
    _FaqItem(
      q: 'هل هناك رسوم على استخدام المنصة؟',
      a: 'لا! إنشاء الصفحة، إدراج المنتجات، واستقبال الطلبات \u2014 كل شيء مجاني. الإيرادات تأتي فقط من المنشورات المُروَّجة.',
    ),
    _FaqItem(
      q: 'كيف أُلغي طلبي؟',
      a: 'من "طلباتي"، افتح تفاصيل الطلب \u2190 "إلغاء الطلب". مدة الإلغاء تعتمد على سياسة المتجر (عادةً خلال ساعات من تقديم الطلب).',
    ),
    _FaqItem(
      q: 'كيف يتم الدفع؟',
      a: 'الدفع يتم مباشرة بينك وبين المتجر. المتاجر تحدد طرق الدفع المقبولة (كاش، كليك، تحويل بنكي). المنصة لا تتدخل في عمليات الدفع.',
    ),
    _FaqItem(
      q: 'كيف أحذف حسابي؟',
      a: 'من حسابي \u2190 الخصوصية والأمان \u2190 حذف الحساب. سيتم حذف جميع بياناتك نهائياً.',
    ),
  ];

  @override
  void dispose() {
    _reportController.dispose();
    super.dispose();
  }

  void _handleSubmitReport() {
    if (_reportController.text.trim().isEmpty) return;
    context.showSnackBar('تم إرسال بلاغك \u2014 سنتواصل معك قريباً');
    _reportController.clear();
    setState(() => _showReport = false);
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      backgroundColor: context.colorScheme.surfaceContainerLowest,
      appBar: const SubScreenHeader(title: 'المساعدة والدعم'),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        children: [
          // ── Contact support ──
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.centerEnd,
                end: AlignmentDirectional.centerStart,
                colors: [
                  AppColors.primary.withValues(alpha: 0.05),
                  Colors.white,
                ],
              ),
              borderRadius: AppRadius.card,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.15),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('تواصل مع الدعم', style: context.textTheme.bodyMedium),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: btn.Button(
                        onPressed: () {},
                        label: 'واتساب',
                        icon: btn.ButtonIcon(Icons.chat, size: 16),
                        style: btn.Style.success,
                        size: btn.ButtonSize.large,
                        expand: true,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: btn.Button(
                        onPressed: () {},
                        label: 'اتصال',
                        icon: btn.ButtonIcon(Icons.phone, size: 16),
                        size: btn.ButtonSize.large,
                        expand: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Center(
                  child: Text(
                    'متاحون من الأحد إلى الخميس، 9 صباحاً \u2013 6 مساءً',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // ── FAQ ──
          Padding(
            padding: const EdgeInsetsDirectional.only(start: AppSpacing.xs),
            child: Text(
              'الأسئلة الشائعة',
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.textHint,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: AppRadius.card,
              border: Border.all(color: AppColors.border),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: List.generate(_faqItems.length, (i) {
                final item = _faqItems[i];
                final isExpanded = _expandedFaq == i;
                return Column(
                  children: [
                    if (i > 0)
                      Divider(
                        height: 1,
                        color: context.colorScheme.surfaceContainerLowest,
                      ),
                    InkWell(
                      onTap: () =>
                          setState(() => _expandedFaq = isExpanded ? null : i),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Row(
                          children: [
                            Icon(
                              Icons.help_outline,
                              size: 14,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Text(
                                item.q,
                                style: context.textTheme.bodyMedium,
                              ),
                            ),
                            Icon(
                              isExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 14,
                              color: AppColors.textHint,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isExpanded)
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                          AppSpacing.lg + 14 + AppSpacing.md,
                          0,
                          AppSpacing.lg,
                          AppSpacing.lg,
                        ),
                        child: Text(
                          item.a,
                          style: context.textTheme.labelSmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                  ],
                );
              }),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // ── Report problem ──
          Padding(
            padding: const EdgeInsetsDirectional.only(start: AppSpacing.xs),
            child: Text(
              'الإبلاغ عن مشكلة',
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.textHint,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (_showReport)
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: AppRadius.card,
                border: Border.all(color: AppColors.border),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 14,
                        color: AppColors.warning,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text('صف المشكلة', style: context.textTheme.bodyMedium),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextField(
                    controller: _reportController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'اكتب تفاصيل المشكلة هنا...',
                      hintStyle: TextStyle(color: AppColors.textHint),
                      filled: true,
                      fillColor: context.colorScheme.surfaceContainerLowest,
                      contentPadding: const EdgeInsets.all(AppSpacing.md),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                        borderSide: BorderSide(color: AppColors.divider),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                        borderSide: BorderSide(color: AppColors.divider),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                    ),
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    textDirection: TextDirection.ltr,
                    children: [
                      Expanded(
                        child: btn.Button(
                          onPressed: () => setState(() => _showReport = false),
                          label: 'إلغاء',
                          variant: btn.Variant.tonal,
                          size: btn.ButtonSize.large,
                          expand: true,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: btn.Button(
                          onPressed: _handleSubmitReport,
                          label: 'إرسال',
                          icon: btn.ButtonIcon(Icons.send, size: 14),
                          size: btn.ButtonSize.large,
                          expand: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          else
            Material(
              color: context.colorScheme.surface,
              borderRadius: AppRadius.card,
              child: InkWell(
                borderRadius: AppRadius.card,
                onTap: () => setState(() => _showReport = true),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    borderRadius: AppRadius.card,
                    border: Border.all(color: AppColors.border),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0D000000),
                        blurRadius: 4,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.warning.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                        child: const Icon(
                          Icons.error_outline,
                          size: 16,
                          color: AppColors.warning,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'الإبلاغ عن مشكلة',
                              style: context.textTheme.bodyMedium,
                            ),
                            Text(
                              'أخبرنا عن أي مشكلة تواجهك',
                              style: context.textTheme.labelSmall?.copyWith(
                                color: AppColors.textHint,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.xxl),

          // ── App info ──
          Center(
            child: Column(
              children: [
                Text(
                  'هناك.app',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
                Text(
                  'الإصدار 1.0.0',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

class _FaqItem {
  final String q;
  final String a;

  const _FaqItem({required this.q, required this.a});
}
