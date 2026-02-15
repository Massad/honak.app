import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:honak/core/l10n/arb/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/router/app_router.dart';
import 'package:honak/core/theme/app_theme.dart';
import 'package:honak/shared/providers/locale_provider.dart';
import 'package:honak/shared/providers/theme_mode_provider.dart';

class HonakApp extends ConsumerWidget {
  const HonakApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localeProvider).valueOrNull ?? const Locale('ar');
    final themeMode =
        ref.watch(themeModeProvider).valueOrNull ?? ThemeMode.system;

    return MaterialApp.router(
      title: 'هناك.app',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
