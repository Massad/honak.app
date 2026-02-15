/// A pending stock quantity change for a catalog item.
class StockChange {
  const StockChange({
    required this.itemId,
    required this.itemName,
    required this.originalStock,
    required this.newStock,
    this.category,
  });

  final String itemId;
  final String itemName;
  final int originalStock;
  final int newStock;
  final String? category;

  int get delta => newStock - originalStock;
}

/// A pending low-stock threshold change for a catalog item.
class ThresholdChange {
  const ThresholdChange({
    required this.itemId,
    required this.originalThreshold,
    required this.newThreshold,
  });

  final String itemId;
  final int originalThreshold;
  final int newThreshold;
}
