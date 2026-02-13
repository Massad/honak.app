import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/post_create/presentation/pages/form_page.dart';
import 'package:honak/features/business/stories/presentation/pages/story_creator_page.dart';
import 'package:honak/shared/providers/business_page_provider.dart';

class CreatePostPage extends ConsumerWidget {
  const CreatePostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bizContext = ref.watch(businessContextProvider);
    final archetype = bizContext?.archetype;

    // Archetype-aware post types — matches Figma BizCreatePost
    final postTypes = _getPostTypesForArchetype(archetype?.name);

    return ListView(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.xxl,
      ),
      children: [
        // Header
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            'إنشاء منشور',
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            'اختر نوع المنشور الذي تريد إنشاءه',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),

        // Story creation — gradient button (matches Figma)
        _StoryButton(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const StoryCreatorPage()),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Post type cards — matches Figma BizCreatePost list
        ...postTypes.map((type) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _PostTypeCard(type: type),
            )),

        const SizedBox(height: AppSpacing.lg),

        // Promoted post button
        _PromotedPostButton(
          onTap: () => context.showSnackBar('قريباً: منشور مروّج'),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Post types per archetype — matches Figma ARCHETYPE_POST_TYPES
// ═══════════════════════════════════════════════════════════════

List<_PostTypeDef> _getPostTypesForArchetype(String? archetype) {
  final allTypes = {
    'update': _PostTypeDef(
      key: 'update',
      icon: Icons.article_outlined,
      label: 'تحديث',
      desc: 'إعلان أو خبر',
      color: const Color(0xFF43A047),
      bgColor: const Color(0xFFE8F5E9),
    ),
    'daily_special': _PostTypeDef(
      key: 'daily_special',
      icon: Icons.auto_awesome_outlined,
      label: 'عرض اليوم',
      desc: 'عرض خاص — اختر صنف بسعر مميز',
      color: const Color(0xFFFF9800),
      bgColor: const Color(0xFFFFF3E0),
    ),
    'status': _PostTypeDef(
      key: 'status',
      icon: Icons.chat_bubble_outline,
      label: 'حالة',
      desc: 'حالة قصيرة (تختفي خلال ٢٤ س)',
      color: const Color(0xFF9C27B0),
      bgColor: const Color(0xFFF3E5F5),
    ),
    'photo': _PostTypeDef(
      key: 'photo',
      icon: Icons.camera_alt_outlined,
      label: 'أعمالنا',
      desc: 'صور أعمال مكتملة (قبل/بعد)',
      color: const Color(0xFFE91E63),
      bgColor: const Color(0xFFFCE4EC),
    ),
    'alert': _PostTypeDef(
      key: 'alert',
      icon: Icons.warning_amber_outlined,
      label: 'تنبيه',
      desc: 'تنبيه عاجل أو مهم للمتابعين',
      color: const Color(0xFFFF8F00),
      bgColor: const Color(0xFFFFF8E1),
    ),
  };

  final archetypeMap = <String, List<String>>{
    'catalogOrder': ['update', 'daily_special'],
    'menuOrder': ['update', 'daily_special'],
    'serviceBooking': ['update', 'daily_special', 'photo'],
    'quoteRequest': ['update', 'status', 'photo'],
    'portfolioInquiry': ['update', 'status'],
    'reservation': ['update', 'status'],
    'followOnly': ['alert', 'update', 'status'],
    'directory': ['update', 'status'],
  };

  final typeIds = archetypeMap[archetype] ?? ['update', 'status'];
  return typeIds
      .where((id) => allTypes.containsKey(id))
      .map((id) => allTypes[id]!)
      .toList();
}

// ═══════════════════════════════════════════════════════════════
// Story button — gradient like Figma
// ═══════════════════════════════════════════════════════════════

class _StoryButton extends StatelessWidget {
  final VoidCallback onTap;

  const _StoryButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentDirectional.centerEnd,
              end: AlignmentDirectional.centerStart,
              colors: [
                AppColors.primary,
                const Color(0xFF00BCD4),
              ],
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(
                Icons.chevron_left,
                size: 18,
                color: Colors.white.withValues(alpha: 0.7),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'ستوري جديدة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'شارك لحظات مع متابعيك',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.md),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add_a_photo_outlined,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Post type card — icon + label + desc (matches Figma)
// ═══════════════════════════════════════════════════════════════

class _PostTypeCard extends StatelessWidget {
  final _PostTypeDef type;

  const _PostTypeCard({required this.type});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => PostFormPage(
                  postTypeKey: type.key,
                  postTypeLabel: type.label,
                  postTypeIcon: type.icon,
                  postTypeColor: type.color,
                ),
              ),
            ),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Row(
            children: [
              Icon(
                Icons.chevron_left,
                size: 16,
                color: Colors.grey.shade300,
              ),
              const Spacer(),
              // Label + desc
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      type.label,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      type.desc,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade400,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              // Colored icon container
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: type.bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  type.icon,
                  size: 18,
                  color: type.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Promoted post button
// ═══════════════════════════════════════════════════════════════

class _PromotedPostButton extends StatelessWidget {
  final VoidCallback onTap;

  const _PromotedPostButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.secondary.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'منشور مروّج',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Icon(
                Icons.campaign_outlined,
                size: 18,
                color: AppColors.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostTypeDef {
  final String key;
  final IconData icon;
  final String label;
  final String desc;
  final Color color;
  final Color bgColor;

  const _PostTypeDef({
    required this.key,
    required this.icon,
    required this.label,
    required this.desc,
    required this.color,
    required this.bgColor,
  });
}
