import 'dart:async';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:honak/core/constants/storage_keys.dart';

const _storage = FlutterSecureStorage();

final localeProvider = AsyncNotifierProvider<LocaleNotifier, Locale>(() {
  return LocaleNotifier();
});

class LocaleNotifier extends AsyncNotifier<Locale> {
  @override
  FutureOr<Locale> build() async {
    final saved = await _storage.read(key: StorageKeys.locale);
    if (saved != null) return Locale(saved);
    return const Locale('ar');
  }

  Future<void> setLocale(Locale locale) async {
    await _storage.write(key: StorageKeys.locale, value: locale.languageCode);
    state = AsyncValue.data(locale);
  }
}
