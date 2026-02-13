import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

enum LoginPromptTrigger { follow, order, chat, save, general }

class _TriggerConfig {
  final IconData icon;
  final String title;
  final String desc;
  final Color color;

  const _TriggerConfig({
    required this.icon,
    required this.title,
    required this.desc,
    required this.color,
  });
}

const _triggerConfigs = <LoginPromptTrigger, _TriggerConfig>{
  LoginPromptTrigger.follow: _TriggerConfig(
    icon: Icons.favorite,
    title: 'تابع الصفحات المفضلة',
    desc: 'أنشئ حسابك لمتابعة الصفحات وتلقي آخر التحديثات والعروض في الخلاصة',
    color: Color(0xFFE53935),
  ),
  LoginPromptTrigger.order: _TriggerConfig(
    icon: Icons.shopping_bag,
    title: 'اطلب بسهولة',
    desc: 'أنشئ حسابك لإرسال طلبات وحجوزات مباشرة للأعمال المحلية',
    color: Color(0xFF1A73E8),
  ),
  LoginPromptTrigger.chat: _TriggerConfig(
    icon: Icons.chat_bubble,
    title: 'تواصل مع الأعمال',
    desc: 'أنشئ حسابك لإرسال رسائل والتواصل المباشر مع أصحاب الأعمال',
    color: Color(0xFF43A047),
  ),
  LoginPromptTrigger.save: _TriggerConfig(
    icon: Icons.bookmark,
    title: 'احفظ للمراجعة لاحقاً',
    desc: 'أنشئ حسابك لحفظ الصفحات والعروض ومراجعتها لاحقاً',
    color: Color(0xFFFF9800),
  ),
  LoginPromptTrigger.general: _TriggerConfig(
    icon: Icons.person_add,
    title: 'انضم لهناك',
    desc: 'أنشئ حسابك للاستفادة من كل الميزات — متابعة، طلبات، محادثات',
    color: Color(0xFF1A73E8),
  ),
};

/// Shows a bottom sheet prompting the guest user to log in.
/// Call this when a guest taps a protected action (follow, cart, chat, save).
Future<void> showLoginPrompt(
  BuildContext context, {
  LoginPromptTrigger trigger = LoginPromptTrigger.general,
}) {
  return showAppSheet(
    context,
    builder: (context) => _LoginPromptContent(trigger: trigger),
  );
}

class _LoginPromptContent extends StatelessWidget {
  final LoginPromptTrigger trigger;

  const _LoginPromptContent({required this.trigger});

  @override
  Widget build(BuildContext context) {
    final config = _triggerConfigs[trigger] ?? _triggerConfigs[LoginPromptTrigger.general]!;

    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppSpacing.xxl,
        end: AppSpacing.xxl,
        top: AppSpacing.sm,
        bottom: AppSpacing.xxxl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E7EB),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            alignment: Alignment.center,
            child: Icon(
              config.icon,
              size: 28,
              color: config.color,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Title
          Text(
            config.title,
            style: context.textTheme.titleLarge?.copyWith(
              color: const Color(0xFF111827),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),

          // Description
          Text(
            config.desc,
            style: context.textTheme.titleSmall?.copyWith(
              color: const Color(0xFF6B7280),
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxl),

          // Benefit cards
          _BenefitCard(
            icon: Icons.favorite,
            text: 'تابع الصفحات واحصل على آخر العروض',
          ),
          const SizedBox(height: AppSpacing.sm),
          _BenefitCard(
            icon: Icons.shopping_bag,
            text: 'اطلب واحجز مباشرة من التطبيق',
          ),
          const SizedBox(height: AppSpacing.sm),
          _BenefitCard(
            icon: Icons.shield,
            text: 'حسابك محمي — رقم هاتفك فقط',
          ),
          const SizedBox(height: AppSpacing.xxl),

          // CTA button
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              context.go(Routes.welcome);
            },
            child: Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person_add,
                    size: 16,
                    color: AppColors.white,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'إنشاء حساب — مجاناً',
                    style: context.textTheme.titleSmall?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Footer text
          Text(
            'التسجيل يتطلب رقم هاتف أردني فقط',
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF9CA3AF),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _BenefitCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const _BenefitCard({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 14,
            color: AppColors.primary,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              text,
              style: context.textTheme.bodySmall?.copyWith(
                color: const Color(0xFF4B5563),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
