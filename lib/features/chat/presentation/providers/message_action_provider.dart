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

/// Purpose of selection mode: 'report', 'delete', or null (generic).
final selectionPurposeProvider = StateProvider<String?>((ref) => null);

/// The message currently being edited (shows edit banner in input).
final editingMessageProvider = StateProvider<Message?>((ref) => null);

/// Locally-sent messages that haven't round-tripped to the backend yet.
/// Keyed by conversation ID → list of messages (newest first).
final localMessagesProvider =
    StateProvider<Map<String, List<Message>>>((ref) => {});

/// The most recently sent action-card message that can still be undone.
/// Cleared when the user sends a text, the timer expires, or undo is tapped.
final undoableMessageProvider = StateProvider<Message?>((ref) => null);
