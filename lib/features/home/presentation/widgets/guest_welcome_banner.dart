import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_spacing.dart';

class GuestWelcomeBanner extends StatelessWidget {
  const GuestWelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final isRtl = context.isRtl;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A73E8), Color(0xFF4DA3FF)],
            begin: AlignmentDirectional.centerStart,
            end: AlignmentDirectional.centerEnd,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon circle
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.explore,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: AppSpacing.md),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isRtl
                            ? context.l10n.guestWelcomeTitle
                            : context.l10n.guestWelcomeTitle,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: AppSpacing.xxs),
                      Text(
                        isRtl
                            ? context.l10n.guestWelcomeSubtitle
                            : context.l10n.guestWelcomeSubtitle,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.md),
            // CTA Row
            Row(
              children: [
                // Explore button
                Expanded(
                  child: GestureDetector(
                    onTap: () => context.go(Routes.explore),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            context.l10n.guestExploreNearby,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: AppSpacing.xs),
                          Icon(
                            isRtl ? Icons.arrow_back : Icons.arrow_forward,
                            size: 12,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                // Sign up button
                Expanded(
                  child: GestureDetector(
                    onTap: () => context.go(Routes.login),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_add,
                            size: 12,
                            color: context.colorScheme.primary,
                          ),
                          SizedBox(width: AppSpacing.xs),
                          Text(
                            context.l10n.guestCreateAccount,
                            style: TextStyle(
                              fontSize: 12,
                              color: context.colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
