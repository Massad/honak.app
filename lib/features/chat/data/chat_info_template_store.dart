import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:honak/features/chat/data/chat_info_templates.dart';
import 'package:honak/features/chat/domain/entities/chat_info_template_item.dart';

const _storage = FlutterSecureStorage();
const _keyPrefix = 'chat_info_tpl_';

/// Provides the info-request template items for a specific business page.
///
/// Family key = `pageId:businessTypeId` (colon-separated).
/// On first load, copies the const defaults for the business type.
/// After any edit, the custom list is persisted per page.
final pageInfoTemplatesProvider = AsyncNotifierProvider.family<
    PageInfoTemplatesNotifier, List<ChatInfoTemplateItem>, String>(
  PageInfoTemplatesNotifier.new,
);

class PageInfoTemplatesNotifier
    extends FamilyAsyncNotifier<List<ChatInfoTemplateItem>, String> {
  String get _pageId => arg.split(':').first;
  String? get _businessTypeId {
    final parts = arg.split(':');
    return parts.length > 1 ? parts[1] : null;
  }

  String get _storageKey => '$_keyPrefix$_pageId';

  @override
  Future<List<ChatInfoTemplateItem>> build(String arg) async {
    final raw = await _storage.read(key: _storageKey);
    if (raw != null) {
      final list = (jsonDecode(raw) as List)
          .map((e) => ChatInfoTemplateItem.fromJson(e as Map<String, dynamic>))
          .toList();
      if (list.isNotEmpty) return list;
    }
    // First time — copy const defaults.
    return getChatInfoTemplateItems(_businessTypeId);
  }

  Future<void> _persist(List<ChatInfoTemplateItem> items) async {
    final json = jsonEncode(items.map((e) => e.toJson()).toList());
    await _storage.write(key: _storageKey, value: json);
    state = AsyncValue.data(items);
  }

  Future<void> addItem(ChatInfoTemplateItem item) async {
    final current = state.valueOrNull ?? [];
    await _persist([...current, item]);
  }

  Future<void> updateItem(ChatInfoTemplateItem updated) async {
    final current = state.valueOrNull ?? [];
    final list =
        current.map((e) => e.id == updated.id ? updated : e).toList();
    await _persist(list);
  }

  Future<void> removeItem(String itemId) async {
    final current = state.valueOrNull ?? [];
    await _persist(current.where((e) => e.id != itemId).toList());
  }

  Future<void> reorder(List<ChatInfoTemplateItem> reordered) async {
    await _persist(reordered);
  }

  Future<void> resetToDefaults() async {
    await _storage.delete(key: _storageKey);
    state = AsyncValue.data(getChatInfoTemplateItems(_businessTypeId));
  }
}
