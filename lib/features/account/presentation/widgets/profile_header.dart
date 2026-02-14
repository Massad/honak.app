import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/auth/auth_provider.dart';
import 'package:honak/shared/auth/auth_state.dart';
import 'package:honak/shared/widgets/app_image.dart';

class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider).valueOrNull;
    final user = authState is Authenticated ? authState.user : null;

    return Container(
      color: context.colorScheme.surface,
      padding: EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        MediaQuery.of(context).padding.top + AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      child: Row(
        children: [
          // Settings icon
          IconButton(
            onPressed: () => context.push(Routes.settings),
            icon: Icon(
              Icons.settings_outlined,
              color: context.colorScheme.onSurfaceVariant,
              size: 24,
            ),
          ),
          const Spacer(),
          // Name + phone
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                user?.name ?? '',
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (user?.phone.isNotEmpty == true) ...[
                const SizedBox(height: 2),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    user!.phone,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          // Avatar
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colorScheme.surfaceContainerLow,
              border: Border.all(color: context.colorScheme.surface, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: AppImage.avatar(
              url: user?.avatarUrl,
              name: user?.name,
              radius: 32,
            ),
          ),
        ],
      ),
    );
  }
}
