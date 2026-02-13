import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/chat/domain/entities/message.dart';

/// Tracks locally edited message content: msgId → new text.
final editedMessagesProvider = StateProvider<Map<String, String>>((ref) => {});

/// Messages hidden locally (delete for me).
final deletedForMeProvider = StateProvider<Set<String>>((ref) => {});

/// Messages shown as "deleted" to everyone.
final deletedForEveryoneProvider = StateProvider<Set<String>>((ref) => {});

/// Multi-select mode: set of selected message IDs.
final selectedMessagesProvider = StateProvider<Set<String>>((ref) => {});

/// The message currently being edited (shows edit banner in input).
final editingMessageProvider = StateProvider<Message?>((ref) => null);
