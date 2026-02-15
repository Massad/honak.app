import 'package:flutter/material.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/shared/extensions/sort_extensions.dart';

/// Shared filtering, search, category, and pagination logic for section widgets.
///
/// Provides common state fields (`selectedCategory`, `searchQuery`,
/// `visibleCount`) and methods (`extractCategories`, `baseFilterItems`,
/// `selectCategory`, `updateSearch`, `showMore`) used identically across
/// catalog, menu, and service booking sections.
mixin SectionFilterMixin<T extends StatefulWidget> on State<T> {
  static const sectionPageSize = 12;

  String? selectedCategory;
  String searchQuery = '';
  int visibleCount = sectionPageSize;

  /// Extract unique category names preserving sort order.
  List<String> extractCategories(List<Item> items) {
    final sorted = items.sortedByOrder((i) => i.sortOrder);
    final categories = <String>[];
    final seen = <String>{};
    for (final item in sorted) {
      if (item.categoryName != null &&
          item.categoryName!.isNotEmpty &&
          seen.add(item.categoryName!)) {
        categories.add(item.categoryName!);
      }
    }
    return categories;
  }

  /// Base filter: category pill + text search + default sort.
  ///
  /// Catalog overrides this to add price/stock/sort filters on top.
  List<Item> baseFilterItems(List<Item> items) {
    var filtered = items;

    if (selectedCategory != null) {
      filtered = filtered
          .where((item) => item.categoryName == selectedCategory)
          .toList();
    }

    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filtered = filtered.where((item) {
        final nameMatch = item.nameAr.toLowerCase().contains(query);
        final descMatch =
            item.descriptionAr?.toLowerCase().contains(query) ?? false;
        return nameMatch || descMatch;
      }).toList();
    }

    return filtered.sortedByOrder((i) => i.sortOrder);
  }

  void selectCategory(String? cat) {
    setState(() {
      selectedCategory = cat;
      visibleCount = sectionPageSize;
    });
  }

  void updateSearch(String query) {
    setState(() {
      searchQuery = query;
      visibleCount = sectionPageSize;
    });
  }

  void showMore() {
    setState(() {
      visibleCount += sectionPageSize;
    });
  }
}
