import 'package:honak/features/chat/domain/entities/conversation.dart';
import 'package:honak/features/chat/domain/entities/message.dart';
import 'package:honak/shared/api/api_client.dart';

class ChatRepository {
  final ApiClient _api;
  ChatRepository(this._api);

  Future<List<Conversation>> getConversations({
    String? mode,
    String? pageHandle,
  }) async {
    final response = await _api.get<List<Conversation>>(
      '/v1/chat/conversations',
      queryParams: {
        if (mode != null) 'mode': mode,
        if (pageHandle != null) 'page_handle': pageHandle,
      },
      fromJson: (json) => (json as List)
          .map((e) => Conversation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    if (response.isSuccess && response.data != null) return response.data!;
    throw Exception(response.error?.message ?? 'Failed to load conversations');
  }

  Future<List<Message>> getMessages(String conversationId) async {
    final response = await _api.get<List<Message>>(
      '/v1/chat/$conversationId/messages',
      fromJson: (json) => (json as List)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    if (response.isSuccess && response.data != null) return response.data!;
    throw Exception(response.error?.message ?? 'Failed to load messages');
  }

  Future<Message> sendMessage(String conversationId, String content) async {
    final response = await _api.post<Message>(
      '/v1/chat/$conversationId/send',
      body: {'content': content},
      fromJson: (json) => Message.fromJson(json as Map<String, dynamic>),
    );
    if (response.isSuccess && response.data != null) return response.data!;
    throw Exception(response.error?.message ?? 'Failed to send message');
  }
}
