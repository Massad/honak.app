import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/requests/domain/entities/entities.dart';

/// Cart state management — in-memory, keyed by business page ID.
///
/// Each business page gets its own independent [Cart] so customers can
/// browse multiple pages without losing items.
final cartProvider =
    NotifierProvider<CartNotifier, Map<String, Cart>>(CartNotifier.new);

class CartNotifier extends Notifier<Map<String, Cart>> {
  static const maxQuantity = 99;

  @override
  Map<String, Cart> build() => {};

  /// Generates a composite key for a cart item based on itemId + selected options.
  /// Same item with different options produces a different key.
  String _lineKey(String itemId, Map<String, List<String>> selectedOptions) {
    if (selectedOptions.isEmpty) return itemId;
    final sorted = SplayTreeMap<String, List<String>>.from(selectedOptions);
    final hash = sorted.entries
        .map((e) => '${e.key}=${(List<String>.from(e.value)..sort()).join(",")}')
        .join('|');
    return '${itemId}_$hash';
  }

  void addItem(
    String pageId,
    String pageName,
    String? pageAvatarUrl,
    CartItem item,
  ) {
    final existing = state[pageId];
    final key = _lineKey(item.itemId, item.selectedOptions);

    if (existing != null) {
      // Merge only if BOTH itemId AND selectedOptions match.
      final idx = existing.items.indexWhere(
        (i) => _lineKey(i.itemId, i.selectedOptions) == key,
      );
      if (idx >= 0) {
        final updated = existing.items[idx];
        final newQty =
            (updated.quantity + item.quantity).clamp(1, maxQuantity);
        final newItems = [...existing.items];
        newItems[idx] = updated.copyWith(quantity: newQty);
        state = {...state, pageId: existing.copyWith(items: newItems)};
      } else {
        final clampedItem =
            item.copyWith(quantity: item.quantity.clamp(1, maxQuantity));
        state = {
          ...state,
          pageId: existing.copyWith(items: [...existing.items, clampedItem]),
        };
      }
    } else {
      final clampedItem =
          item.copyWith(quantity: item.quantity.clamp(1, maxQuantity));
      state = {
        ...state,
        pageId: Cart(
          pageId: pageId,
          pageName: pageName,
          pageAvatarUrl: pageAvatarUrl,
          items: [clampedItem],
        ),
      };
    }
  }

  void removeItem(String pageId, String itemId) {
    final cart = state[pageId];
    if (cart == null) return;
    final newItems = cart.items.where((i) => i.itemId != itemId).toList();
    if (newItems.isEmpty) {
      state = Map.of(state)..remove(pageId);
    } else {
      state = {...state, pageId: cart.copyWith(items: newItems)};
    }
  }

  void updateQuantity(String pageId, String itemId, int quantity) {
    final cart = state[pageId];
    if (cart == null) return;
    if (quantity <= 0) {
      removeItem(pageId, itemId);
      return;
    }
    final clamped = quantity.clamp(1, maxQuantity);
    final newItems = cart.items.map((i) {
      if (i.itemId == itemId) return i.copyWith(quantity: clamped);
      return i;
    }).toList();
    state = {...state, pageId: cart.copyWith(items: newItems)};
  }

  void clearCart(String pageId) {
    state = Map.of(state)..remove(pageId);
  }

  Cart? getCart(String pageId) => state[pageId];
}

/// Convenience: get the [Cart] for a specific page (or null).
final currentCartProvider = Provider.family<Cart?, String>((ref, pageId) {
  final carts = ref.watch(cartProvider);
  return carts[pageId];
});

/// Convenience: badge count of items in a page's cart.
final cartItemCountProvider = Provider.family<int, String>((ref, pageId) {
  final cart = ref.watch(currentCartProvider(pageId));
  return cart?.itemCount ?? 0;
});
