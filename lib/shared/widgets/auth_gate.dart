import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/auth/auth_provider.dart';
import 'package:honak/shared/auth/auth_state.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

/// Utility for gating actions behind authentication.
///
/// Usage:
/// ```dart
/// AuthGate.require(context, ref,
///   action: 'متابعة',
///   onAuthed: () => doSomething(),
/// );
/// ```
abstract final class AuthGate {
  /// Checks auth state and either calls [onAuthed] immediately (if
  /// authenticated) or prompts the user to log in.
  static void require(
    BuildContext context,
    WidgetRef ref, {
    required String action,
    required VoidCallback onAuthed,
  }) {
    final authState = ref.read(authProvider).valueOrNull;

    if (authState is Authenticated) {
      onAuthed();
      return;
    }

    if (authState is Unauthenticated) {
      Navigator.of(context).pushNamed(Routes.welcome);
      return;
    }

    // AuthGuest — show login prompt sheet
    _showLoginPrompt(context, action: action);
  }

  static void _showLoginPrompt(
    BuildContext context, {
    required String action,
  }) {
    showAppSheet<void>(
      context,
      builder: (ctx) => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: AppSpacing.xxl),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Lock icon
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: ctx.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.lock_outline_rounded,
                color: ctx.colorScheme.primary,
                size: 28,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Title: "سجل دخول لـ {action}"
            Text(
              '\u0633\u062c\u0644 \u062f\u062e\u0648\u0644 \u0644\u0640 $action',
              style: ctx.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),

            // Subtitle: "يجب تسجيل الدخول للمتابعة"
            Text(
              '\u064a\u062c\u0628 \u062a\u0633\u062c\u064a\u0644 \u0627\u0644\u062f\u062e\u0648\u0644 \u0644\u0644\u0645\u062a\u0627\u0628\u0639\u0629',
              style: ctx.textTheme.bodyMedium?.copyWith(
                color: ctx.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Login button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.of(ctx).pop(); // dismiss sheet
                  Navigator.of(ctx).pushNamed(Routes.welcome);
                },
                child: Text(
                  // "تسجيل الدخول"
                  '\u062a\u0633\u062c\u064a\u0644 \u0627\u0644\u062f\u062e\u0648\u0644',
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),

            // Cancel
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(
                // "إلغاء"
                '\u0625\u0644\u063a\u0627\u0621',
                style: TextStyle(
                  color: ctx.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
