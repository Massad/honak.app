import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:honak/core/constants/storage_keys.dart';
import 'package:honak/shared/entities/user.dart';
import 'package:honak/shared/providers/business_page_provider.dart';

enum AppMode { customer, business }

const _storage = FlutterSecureStorage();

final appModeProvider = AsyncNotifierProvider<AppModeNotifier, AppMode>(() {
  return AppModeNotifier();
});

class AppModeNotifier extends AsyncNotifier<AppMode> {
  @override
  FutureOr<AppMode> build() async {
    final saved = await _storage.read(key: StorageKeys.appMode);
    if (saved == 'business') return AppMode.business;
    return AppMode.customer;
  }

  Future<void> switchToBusinessMode(UserPage page) async {
    await _storage.write(key: StorageKeys.appMode, value: 'business');
    await ref.read(currentBusinessPageProvider.notifier).selectPage(page);
    state = const AsyncValue.data(AppMode.business);
  }

  Future<void> switchToCustomerMode() async {
    await _storage.write(key: StorageKeys.appMode, value: 'customer');
    state = const AsyncValue.data(AppMode.customer);
  }

  Future<void> reset() async {
    await _storage.delete(key: StorageKeys.appMode);
    await ref.read(currentBusinessPageProvider.notifier).clearSelection();
    state = const AsyncValue.data(AppMode.customer);
  }
}
