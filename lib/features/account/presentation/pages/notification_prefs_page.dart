import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/account/presentation/widgets/sub_screen_header.dart';
import 'package:honak/shared/widgets/app_screen.dart';

class NotificationPrefsPage extends StatefulWidget {
  const NotificationPrefsPage({super.key});

  @override
  State<NotificationPrefsPage> createState() => _NotificationPrefsPageState();
}

class _NotificationPrefsPageState extends State<NotificationPrefsPage> {
  final List<_NotifGroup> _groups = [
    _NotifGroup(
      id: 'orders',
      icon: Icons.shopping_bag_outlined,
      label: 'طلباتي',
      desc: 'حالة الطلب، تحديثات التوصيل، تأكيد الحجز',
      enabled: true,
    ),
    _NotifGroup(
      id: 'followed',
      icon: Icons.store_outlined,
      label: 'صفحات متابَعة',
      desc: 'منشورات جديدة من الصفحات التي تتابعها',
      enabled: true,
    ),
    _NotifGroup(
      id: 'offers',
      icon: Icons.local_offer_outlined,
      label: 'العروض والتخفيضات',
      desc: 'عروض وتخفيضات من صفحاتك المفضلة',
      enabled: false,
    ),
    _NotifGroup(
      id: 'chat',
      icon: Icons.chat_bubble_outline,
      label: 'المحادثات',
      desc: 'رسائل جديدة من الصفحات التجارية',
      enabled: true,
    ),
  ];

  bool get _allEnabled => _groups.every((g) => g.enabled);
  bool get _allDisabled => _groups.every((g) => !g.enabled);

  void _toggleGroup(int index) {
    setState(() => _groups[index].enabled = !_groups[index].enabled);
    context.showSnackBar('تم حفظ الإعدادات');
  }

  void _toggleAll() {
    final newState = !_allEnabled;
    setState(() {
      for (final g in _groups) {
        g.enabled = newState;
      }
    });
    context.showSnackBar(
      newState ? 'تم تفعيل جميع الإشعارات' : 'تم إيقاف جميع الإشعارات',
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      backgroundColor: context.colorScheme.surfaceContainerLowest,
      appBar: const SubScreenHeader(title: 'إشعاراتي'),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        children: [
          // Master toggle
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
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: const Icon(
                    Icons.notifications_outlined,
                    size: 20,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('الإشعارات', style: context.textTheme.bodyMedium),
                      Text(
                        _allDisabled
                            ? 'جميع الإشعارات مغلقة'
                            : _allEnabled
                            ? 'جميع الإشعارات مفعّلة'
                            : 'بعض الإشعارات مفعّلة',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.textHint,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: !_allDisabled,
                  onChanged: (_) => _toggleAll(),
                  activeTrackColor: AppColors.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Section label
          Padding(
            padding: const EdgeInsetsDirectional.only(start: AppSpacing.xs),
            child: Text(
              'تخصيص الإشعارات',
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.textHint,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Individual toggles
          ...List.generate(_groups.length, (i) {
            final group = _groups[i];
            return Padding(
              padding: EdgeInsets.only(
                bottom: i < _groups.length - 1 ? AppSpacing.sm : 0,
              ),
              child: Container(
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
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Icon(
                        group.icon,
                        size: 16,
                        color: AppColors.textHint,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            group.label,
                            style: context.textTheme.bodyMedium,
                          ),
                          Text(
                            group.desc,
                            style: context.textTheme.labelSmall?.copyWith(
                              color: AppColors.textHint,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: group.enabled,
                      onChanged: (_) => _toggleGroup(i),
                      activeTrackColor: AppColors.primary,
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: AppSpacing.lg),

          // Info note
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              borderRadius: AppRadius.card,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.15),
              ),
            ),
            child: Text(
              'يمكنك أيضاً تخصيص إشعارات كل صفحة تتابعها بشكل فردي من صفحة المتجر.',
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotifGroup {
  final String id;
  final IconData icon;
  final String label;
  final String desc;
  bool enabled;

  _NotifGroup({
    required this.id,
    required this.icon,
    required this.label,
    required this.desc,
    required this.enabled,
  });
}
