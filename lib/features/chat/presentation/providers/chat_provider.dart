import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/features/chat/data/repository/chat_repository.dart';
import 'package:honak/features/chat/domain/entities/conversation.dart';
import 'package:honak/features/chat/domain/entities/message.dart';
import 'package:honak/shared/providers/api_provider.dart';
import 'package:honak/shared/providers/app_mode_provider.dart';
import 'package:honak/shared/providers/business_page_provider.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository(ref.read(apiClientProvider));
});

final conversationsProvider = FutureProvider<List<Conversation>>((ref) async {
  final repo = ref.read(chatRepositoryProvider);
  final modeAsync = ref.watch(appModeProvider);
  final pageAsync = ref.watch(currentBusinessPageProvider);

  // Wait for async dependencies to resolve before firing API call.
  // While loading, return empty — Riverpod re-evaluates when they resolve.
  final mode = modeAsync.valueOrNull;
  if (mode == null) return [];

  final page = pageAsync.valueOrNull;
  if (mode == AppMode.business && page == null) return [];

  try {
    return await repo.getConversations(
      mode: mode == AppMode.business ? 'business' : 'customer',
      pageHandle: mode == AppMode.business ? page?.slug : null,
    );
  } catch (e, st) {
    debugPrint('[conversationsProvider] Error loading conversations: $e');
    debugPrint('[conversationsProvider] Stack: $st');
    rethrow;
  }
});

final unreadChatCountProvider = Provider<int>((ref) {
  final convs = ref.watch(conversationsProvider);
  return convs.when(
    data: (list) => list.fold(0, (sum, c) => sum + c.unreadCount),
    loading: () => 0,
    error: (_, __) => 0,
  );
});

final conversationMessagesProvider =
    FutureProvider.family<List<Message>, String>((ref, conversationId) async {
  final repo = ref.read(chatRepositoryProvider);
  return repo.getMessages(conversationId);
});

final sendMessageProvider =
    FutureProvider.family<Message, ({String conversationId, String content})>(
        (ref, params) async {
  final repo = ref.read(chatRepositoryProvider);
  return repo.sendMessage(params.conversationId, params.content);
});

final markConversationReadProvider =
    FutureProvider.family<void, String>((ref, conversationId) async {
  final api = ref.read(apiClientProvider);
  await api.post('/v1/chat/$conversationId/read');
});

/// Items for the current business page — used by ProductPickerSheet.
final businessItemsProvider =
    FutureProvider.family<List<Item>, String>((ref, pageSlug) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get<List<Item>>(
    '/v1/pages/$pageSlug/items',
    fromJson: (json) => (json as List)
        .map((e) => Item.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
  if (response.isSuccess && response.data != null) return response.data!;
  throw Exception(response.error?.message ?? 'Failed to load items');
});
