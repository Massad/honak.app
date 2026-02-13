import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/shared/auth/auth_provider.dart';
import 'package:honak/shared/auth/auth_state.dart';

String? authGuard(BuildContext context, WidgetRef ref) {
  final authState = ref.read(authProvider).valueOrNull;
  if (authState is Unauthenticated) {
    return Routes.welcome;
  }
  return null;
}

String? unauthGuard(BuildContext context, WidgetRef ref) {
  final authState = ref.read(authProvider).valueOrNull;
  if (authState is Authenticated) {
    return Routes.home;
  }
  return null;
}
