import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:honak/core/constants/storage_keys.dart';

const _storage = FlutterSecureStorage();

final themeModeProvider =
    AsyncNotifierProvider<ThemeModeNotifier, ThemeMode>(() {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends AsyncNotifier<ThemeMode> {
  @override
  FutureOr<ThemeMode> build() async {
    final saved = await _storage.read(key: StorageKeys.themeMode);
    return switch (saved) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await _storage.write(key: StorageKeys.themeMode, value: value);
    state = AsyncValue.data(mode);
  }
}
