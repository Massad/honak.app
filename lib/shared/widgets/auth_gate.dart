import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/features/auth/presentation/widgets/login_prompt_sheet.dart';
import 'package:honak/shared/auth/auth_provider.dart';
import 'package:honak/shared/auth/auth_state.dart';

export 'package:honak/features/auth/presentation/widgets/login_prompt_sheet.dart'
    show LoginPromptTrigger;

/// Utility for gating actions behind authentication.
///
/// Usage:
/// ```dart
/// AuthGate.require(context, ref,
///   trigger: LoginPromptTrigger.follow,
///   onAuthed: () => doSomething(),
/// );
/// ```
abstract final class AuthGate {
  /// Checks auth state and either calls [onAuthed] immediately (if
  /// authenticated) or prompts the user to log in.
  static void require(
    BuildContext context,
    WidgetRef ref, {
    LoginPromptTrigger trigger = LoginPromptTrigger.general,
    required VoidCallback onAuthed,
  }) {
    final authState = ref.read(authProvider).valueOrNull;

    if (authState is Authenticated) {
      onAuthed();
      return;
    }

    if (authState is Unauthenticated) {
      context.go(Routes.welcome);
      return;
    }

    // AuthGuest — show login prompt sheet
    showLoginPrompt(context, trigger: trigger);
  }
}
