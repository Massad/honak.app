import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/account/presentation/widgets/sub_screen_header.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

class PrivacySecurityPage extends StatefulWidget {
  const PrivacySecurityPage({super.key});

  @override
  State<PrivacySecurityPage> createState() => _PrivacySecurityPageState();
}

class _PrivacySecurityPageState extends State<PrivacySecurityPage> {
  bool _activityVisible = true;

  final List<_BlockedPage> _blockedPages = [
    _BlockedPage(id: 'spam-page', name: 'صفحة مزعجة', handle: '@spam_page'),
  ];

  void _showDeleteConfirmation() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _DeleteAccountSheet(
        onCancel: () => Navigator.of(ctx).pop(),
        onConfirm: () {
          Navigator.of(ctx).pop();
          context.showSnackBar('تم إرسال طلب حذف الحساب');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surfaceContainerLowest,
      appBar: const SubScreenHeader(title: 'الخصوصية والأمان'),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        children: [
          // ── Privacy section ──
          _sectionLabel('الخصوصية'),
          const SizedBox(height: AppSpacing.sm),
          _cardContainer(
            child: Row(
              children: [
                _iconBox(Icons.visibility_off_outlined, AppColors.textHint),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('إخفاء حالة النشاط',
                          style: context.textTheme.bodyMedium),
                      Text(
                        'لن تظهر آخر مرة كنت متصلاً فيها',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.textHint,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: !_activityVisible,
                  onChanged: (val) {
                    setState(() => _activityVisible = !val);
                    context.showSnackBar(
                      val
                          ? 'تم إخفاء حالة النشاط'
                          : 'تم إظهار حالة النشاط',
                    );
                  },
                  activeTrackColor: AppColors.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // ── Blocked pages ──
          _sectionLabel('الصفحات المحظورة'),
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
            child: _blockedPages.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      children: [
                        Icon(Icons.block, size: 24, color: AppColors.divider),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'لا توجد صفحات محظورة',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: AppColors.textHint,
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: List.generate(_blockedPages.length, (i) {
                      final page = _blockedPages[i];
                      return Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: i > 0
                            ? BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: context
                                        .colorScheme.surfaceContainerLowest,
                                  ),
                                ),
                              )
                            : null,
                        child: Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: AppColors.error.withValues(alpha: 0.1),
                                borderRadius:
                                    BorderRadius.circular(AppRadius.sm),
                              ),
                              child: const Icon(
                                Icons.block,
                                size: 14,
                                color: AppColors.error,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(page.name,
                                      style: context.textTheme.bodyMedium),
                                  Text(
                                    page.handle,
                                    style:
                                        context.textTheme.labelSmall?.copyWith(
                                      color: AppColors.textHint,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            btn.Button(
                              onPressed: () {
                                setState(() => _blockedPages.removeAt(i));
                                context.showSnackBar('تم إلغاء الحظر');
                              },
                              label: 'إلغاء الحظر',
                              variant: btn.Variant.text,
                              size: btn.ButtonSize.small,
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // ── Data & Account ──
          _sectionLabel('البيانات والحساب'),
          const SizedBox(height: AppSpacing.sm),

          // Download data
          _actionCard(
            icon: Icons.download_outlined,
            iconColor: AppColors.textHint,
            iconBg: context.colorScheme.surfaceContainerLowest,
            title: 'تحميل بياناتي',
            subtitle: 'طلب نسخة من جميع بياناتك',
            onTap: () => context.showSnackBar('تم إرسال طلب تحميل البيانات'),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Delete account
          _actionCard(
            icon: Icons.delete_outline,
            iconColor: AppColors.error,
            iconBg: AppColors.error.withValues(alpha: 0.1),
            title: 'حذف الحساب',
            titleColor: AppColors.error,
            subtitle: 'حذف جميع بياناتك نهائياً',
            borderColor: AppColors.error.withValues(alpha: 0.2),
            onTap: _showDeleteConfirmation,
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: AppSpacing.xs),
      child: Text(
        text,
        style: context.textTheme.labelSmall?.copyWith(
          color: AppColors.textHint,
        ),
      ),
    );
  }

  Widget _cardContainer({required Widget child}) {
    return Container(
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
      child: child,
    );
  }

  Widget _iconBox(IconData icon, Color color, [Color? bg]) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: bg ?? context.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Icon(icon, size: 16, color: color),
    );
  }

  Widget _actionCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    Color? titleColor,
    Color? borderColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: context.colorScheme.surface,
      borderRadius: AppRadius.card,
      child: InkWell(
        borderRadius: AppRadius.card,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: AppRadius.card,
            border: Border.all(color: borderColor ?? AppColors.border),
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
              _iconBox(icon, iconColor, iconBg),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: titleColor,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: AppColors.textHint,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_left,
                size: 16,
                color: AppColors.textHint,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BlockedPage {
  final String id;
  final String name;
  final String handle;

  _BlockedPage({
    required this.id,
    required this.name,
    required this.handle,
  });
}

// ── Delete Account Bottom Sheet ──

class _DeleteAccountSheet extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const _DeleteAccountSheet({
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.xxl),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.huge,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('حذف الحساب', style: theme.textTheme.titleSmall),
              IconButton(
                onPressed: onCancel,
                icon: Icon(
                  Icons.close,
                  size: 18,
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // Warning box
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.05),
              borderRadius: AppRadius.card,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  size: 20,
                  color: AppColors.error,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'هذا الإجراء لا يمكن التراجع عنه',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'سيتم حذف جميع بياناتك بما في ذلك: الطلبات، المحادثات، العناوين، والصفحات التجارية المرتبطة بحسابك.',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Buttons
          Row(
            textDirection: TextDirection.ltr,
            children: [
              Expanded(
                child: btn.Button(
                  onPressed: onCancel,
                  label: 'إلغاء',
                  variant: btn.Variant.tonal,
                  size: btn.ButtonSize.large,
                  expand: true,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: btn.Button(
                  onPressed: onConfirm,
                  label: 'حذف الحساب',
                  style: btn.Style.danger,
                  size: btn.ButtonSize.large,
                  expand: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
