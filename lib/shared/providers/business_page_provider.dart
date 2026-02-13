import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:honak/config/archetype.dart';
import 'package:honak/config/business_type_config.dart';
import 'package:honak/config/business_type_registry.dart';
import 'package:honak/core/constants/storage_keys.dart';
import 'package:honak/shared/auth/auth_provider.dart';
import 'package:honak/shared/auth/auth_state.dart';
import 'package:honak/shared/entities/user.dart';

// ═══════════════════════════════════════════════════════════════
// BusinessContext — derived context from active page + config
// ═══════════════════════════════════════════════════════════════

class BusinessContext {
  final UserPage page;
  final Archetype archetype;
  final BusinessTypeConfig? config;

  const BusinessContext({
    required this.page,
    required this.archetype,
    this.config,
  });

  bool get showRequestsTab => archetype.supportsRequests;
  bool get showManageTab => archetype.hasCatalog;

  String get manageTabLabel {
    final tabs = config?.manageTabs;
    if (tabs != null && tabs.isNotEmpty) return tabs.first.labelAr;
    return switch (archetype) {
      Archetype.catalogOrder => 'المنتجات',
      Archetype.menuOrder => 'القائمة',
      Archetype.serviceBooking => 'الخدمات',
      Archetype.quoteRequest => 'الخدمات',
      Archetype.portfolioInquiry => 'الأعمال',
      Archetype.reservation => 'المساحات',
      _ => 'إدارة',
    };
  }

  String get requestsTabLabel {
    final labels = config?.orderLabels;
    if (labels != null) return labels.incoming;
    return 'الطلبات';
  }

  List<DashboardSection> get dashboardSections =>
      config?.dashboard.sections ?? [];
}

// ═══════════════════════════════════════════════════════════════
// Current business page notifier — persists selection
// ═══════════════════════════════════════════════════════════════

const _storage = FlutterSecureStorage();

final currentBusinessPageProvider =
    AsyncNotifierProvider<CurrentBusinessPageNotifier, UserPage?>(() {
  return CurrentBusinessPageNotifier();
});

class CurrentBusinessPageNotifier extends AsyncNotifier<UserPage?> {
  @override
  Future<UserPage?> build() async {
    // Watch auth so this rebuilds when user data arrives
    final authState = ref.watch(authProvider).valueOrNull;

    final savedId =
        await _storage.read(key: StorageKeys.currentBusinessPageId);
    if (savedId == null) return null;

    List<UserPage> pages = [];
    if (authState is Authenticated) {
      pages = authState.user.pages;
    }
    if (pages.isEmpty) return null;

    final match = pages.where((p) => p.id == savedId).firstOrNull;
    return match;
  }

  Future<void> selectPage(UserPage page) async {
    await _storage.write(
      key: StorageKeys.currentBusinessPageId,
      value: page.id,
    );
    state = AsyncValue.data(page);
  }

  Future<void> clearSelection() async {
    await _storage.delete(key: StorageKeys.currentBusinessPageId);
    state = const AsyncValue.data(null);
  }
}

// ═══════════════════════════════════════════════════════════════
// Derived business context provider
// ═══════════════════════════════════════════════════════════════

final businessContextProvider = Provider<BusinessContext?>((ref) {
  final page = ref.watch(currentBusinessPageProvider).valueOrNull;
  if (page == null || page.businessTypeId == null) return null;

  final config = BusinessTypeRegistry.tryGetConfig(page.businessTypeId!);
  final archetype = config?.archetype ?? Archetype.followOnly;

  return BusinessContext(
    page: page,
    archetype: archetype,
    config: config,
  );
});
