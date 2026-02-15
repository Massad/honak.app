import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/features/business/catalog_management/domain/entities/stock_change.dart';

// ═══════════════════════════════════════════════════════════════
// Stock Manager Providers
// ═══════════════════════════════════════════════════════════════

/// Filter mode for the stock manager sheet.
enum StockFilterMode { all, low, out }

/// Current search query in the stock manager.
final stockSearchQueryProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);

/// Current filter mode in the stock manager.
final stockFilterModeProvider = StateProvider.autoDispose<StockFilterMode>(
  (ref) => StockFilterMode.all,
);

/// Pending stock quantity changes (itemId → StockChange).
final stockChangesProvider =
    StateNotifierProvider.autoDispose<StockChangesNotifier, Map<String, StockChange>>(
  (ref) => StockChangesNotifier(),
);

/// Pending threshold changes (itemId → ThresholdChange).
final thresholdChangesProvider =
    StateNotifierProvider.autoDispose<ThresholdChangesNotifier, Map<String, ThresholdChange>>(
  (ref) => ThresholdChangesNotifier(),
);

/// Total number of pending changes (stock + threshold).
final totalPendingChangesProvider = Provider.autoDispose<int>((ref) {
  return ref.watch(stockChangesProvider).length +
      ref.watch(thresholdChangesProvider).length;
});

// ─────────────────────────────────────────────────────────────
// Notifiers
// ─────────────────────────────────────────────────────────────

class StockChangesNotifier extends StateNotifier<Map<String, StockChange>> {
  StockChangesNotifier() : super({});

  void updateStock({
    required String itemId,
    required String itemName,
    required int originalStock,
    required int delta,
    String? category,
  }) {
    final current = state[itemId];
    final currentStock = current?.newStock ?? originalStock;
    final newStock = (currentStock + delta).clamp(0, 99999);

    if (newStock == originalStock) {
      // Remove change if it matches original
      state = Map.from(state)..remove(itemId);
    } else {
      state = {
        ...state,
        itemId: StockChange(
          itemId: itemId,
          itemName: itemName,
          originalStock: originalStock,
          newStock: newStock,
          category: category,
        ),
      };
    }
  }

  void setStockDirect({
    required String itemId,
    required String itemName,
    required int originalStock,
    required int value,
    String? category,
  }) {
    final newStock = value.clamp(0, 99999);
    if (newStock == originalStock) {
      state = Map.from(state)..remove(itemId);
    } else {
      state = {
        ...state,
        itemId: StockChange(
          itemId: itemId,
          itemName: itemName,
          originalStock: originalStock,
          newStock: newStock,
          category: category,
        ),
      };
    }
  }

  void resetItem(String itemId) {
    state = Map.from(state)..remove(itemId);
  }

  void resetAll() {
    state = {};
  }
}

class ThresholdChangesNotifier
    extends StateNotifier<Map<String, ThresholdChange>> {
  ThresholdChangesNotifier() : super({});

  void setThreshold({
    required String itemId,
    required int originalThreshold,
    required int newThreshold,
  }) {
    if (newThreshold == originalThreshold) {
      state = Map.from(state)..remove(itemId);
    } else {
      state = {
        ...state,
        itemId: ThresholdChange(
          itemId: itemId,
          originalThreshold: originalThreshold,
          newThreshold: newThreshold,
        ),
      };
    }
  }

  void resetItem(String itemId) {
    state = Map.from(state)..remove(itemId);
  }

  void resetAll() {
    state = {};
  }
}
