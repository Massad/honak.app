import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

enum LoginPromptTrigger {
  follow,
  order,
  chat,
  save,
  general,
  cart,
  message,
  book,
  quote,
  reserve,
}

class _TriggerConfig {
  final IconData icon;
  final String title;
  final String desc;
  final Color color;
  final List<({IconData icon, String text})> benefits;

  const _TriggerConfig({
    required this.icon,
    required this.title,
    required this.desc,
    required this.color,
    required this.benefits,
  });
}

final _triggerConfigs = <LoginPromptTrigger, _TriggerConfig>{
  LoginPromptTrigger.follow: _TriggerConfig(
    icon: Icons.favorite,
    title: 'تابع الصفحات المفضلة',
    desc: 'أنشئ حسابك لمتابعة الصفحات وتلقي آخر التحديثات والعروض',
    color: Color(0xFFE53935),
    benefits: [
      (icon: Icons.notifications_active, text: 'تلقّي إشعارات عند كل عرض جديد'),
      (icon: Icons.dynamic_feed, text: 'شاهد منشورات الصفحات في خلاصتك'),
      (icon: Icons.bookmark, text: 'احفظ الصفحات للرجوع إليها بسرعة'),
    ],
  ),
  LoginPromptTrigger.order: _TriggerConfig(
    icon: Icons.shopping_bag,
    title: 'اطلب بسهولة',
    desc: 'أنشئ حسابك لإرسال طلبات مباشرة للأعمال المحلية',
    color: Color(0xFF1A73E8),
    benefits: [
      (icon: Icons.local_shipping, text: 'تتبّع طلباتك ومعرفة حالتها'),
      (icon: Icons.history, text: 'أعد الطلب بضغطة واحدة'),
      (icon: Icons.chat_bubble, text: 'تواصل مع البائع بخصوص طلبك'),
    ],
  ),
  LoginPromptTrigger.chat: _TriggerConfig(
    icon: Icons.chat_bubble,
    title: 'تواصل مع الأعمال',
    desc: 'أنشئ حسابك لإرسال رسائل والتواصل مع أصحاب الأعمال',
    color: Color(0xFF43A047),
    benefits: [
      (icon: Icons.mark_chat_read, text: 'رسائل محفوظة ومنظمة'),
      (icon: Icons.attach_file, text: 'أرسل صور ومرفقات'),
      (icon: Icons.notifications, text: 'تنبيهات عند الرد'),
    ],
  ),
  LoginPromptTrigger.save: _TriggerConfig(
    icon: Icons.bookmark,
    title: 'احفظ للمراجعة لاحقاً',
    desc: 'أنشئ حسابك لحفظ الصفحات والعروض ومراجعتها لاحقاً',
    color: Color(0xFFFF9800),
    benefits: [
      (icon: Icons.collections_bookmark, text: 'نظّم محفوظاتك في مجموعات'),
      (icon: Icons.offline_pin, text: 'اوصل لمحفوظاتك بسرعة'),
      (icon: Icons.share, text: 'شارك الصفحات مع أصدقائك'),
    ],
  ),
  LoginPromptTrigger.general: _TriggerConfig(
    icon: Icons.person_add,
    title: 'انضم لهناك',
    desc: 'أنشئ حسابك للاستفادة من كل الميزات',
    color: Color(0xFF1A73E8),
    benefits: [
      (icon: Icons.favorite, text: 'تابع الصفحات واحصل على آخر العروض'),
      (icon: Icons.shopping_bag, text: 'اطلب واحجز مباشرة من التطبيق'),
      (icon: Icons.shield, text: 'حسابك محمي — رقم هاتفك فقط'),
    ],
  ),
  LoginPromptTrigger.cart: _TriggerConfig(
    icon: Icons.shopping_cart,
    title: 'أضف للسلة واطلب',
    desc: 'أنشئ حسابك لإضافة المنتجات وإرسال طلبك مباشرة',
    color: Color(0xFF1A73E8),
    benefits: [
      (icon: Icons.local_shipping, text: 'تتبّع طلباتك ومعرفة حالتها'),
      (icon: Icons.replay, text: 'أعد الطلب بضغطة واحدة'),
      (icon: Icons.payment, text: 'ادفع بالطريقة المناسبة لك'),
    ],
  ),
  LoginPromptTrigger.message: _TriggerConfig(
    icon: Icons.chat_bubble_outline,
    title: 'تواصل مباشرة',
    desc: 'أنشئ حسابك لإرسال رسائل مباشرة لأصحاب الأعمال',
    color: Color(0xFF43A047),
    benefits: [
      (icon: Icons.mark_chat_read, text: 'رسائل محفوظة ومنظمة'),
      (icon: Icons.attach_file, text: 'أرسل صور وتفاصيل طلبك'),
      (icon: Icons.notifications, text: 'تنبيهات فورية عند الرد'),
    ],
  ),
  LoginPromptTrigger.book: _TriggerConfig(
    icon: Icons.calendar_today,
    title: 'احجز موعدك',
    desc: 'أنشئ حسابك لحجز المواعيد والخدمات بسهولة',
    color: Color(0xFF7C3AED),
    benefits: [
      (icon: Icons.event_available, text: 'احجز بالوقت المناسب لك'),
      (icon: Icons.notifications_active, text: 'تذكير تلقائي قبل الموعد'),
      (icon: Icons.history, text: 'سجل حجوزاتك السابقة'),
    ],
  ),
  LoginPromptTrigger.quote: _TriggerConfig(
    icon: Icons.request_quote,
    title: 'اطلب عرض سعر',
    desc: 'أنشئ حسابك لإرسال طلب عرض سعر والحصول على رد سريع',
    color: Color(0xFFF59E0B),
    benefits: [
      (icon: Icons.compare_arrows, text: 'قارن العروض واختر الأنسب'),
      (icon: Icons.chat_bubble, text: 'ناقش التفاصيل مع مقدم الخدمة'),
      (icon: Icons.verified_user, text: 'مقدمي خدمات موثوقين'),
    ],
  ),
  LoginPromptTrigger.reserve: _TriggerConfig(
    icon: Icons.event_seat,
    title: 'احجز مكانك',
    desc: 'أنشئ حسابك لحجز القاعات والمساحات المتاحة',
    color: Color(0xFFEC4899),
    benefits: [
      (icon: Icons.calendar_month, text: 'اختر التاريخ المناسب'),
      (icon: Icons.groups, text: 'حدد عدد الضيوف والتفاصيل'),
      (icon: Icons.check_circle, text: 'تأكيد فوري من صاحب المكان'),
    ],
  ),
};

/// Shows a bottom sheet prompting the guest user to log in.
/// Call this when a guest taps a protected action.
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
    final config =
        _triggerConfigs[trigger] ?? _triggerConfigs[LoginPromptTrigger.general]!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Drag handle
        Padding(
          padding: const EdgeInsets.only(top: AppSpacing.sm),
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: context.colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Gradient header
        Container(
          width: double.infinity,
          margin: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.lg,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xxl,
            vertical: AppSpacing.xxl,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
              colors: [
                config.color,
                config.color.withValues(alpha: 0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(config.icon, size: 28, color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                config.title,
                style: context.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                config.desc,
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.85),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),

        // Per-trigger benefit cards
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.xxl,
          ),
          child: Column(
            children: [
              for (final benefit in config.benefits) ...[
                _BenefitCard(icon: benefit.icon, text: benefit.text),
                const SizedBox(height: AppSpacing.sm),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // CTA button
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.xxl,
          ),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.go(Routes.login);
              },
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
              ),
              child: Text(
                'إنشاء حساب مجاناً',
                style: context.textTheme.titleSmall?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Footer text
        Text(
          'رقم هاتف أردني فقط · بدون بيانات شخصية · ثواني',
          style: TextStyle(
            fontSize: 10,
            color: context.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xxxl),
      ],
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
        color: context.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              text,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
