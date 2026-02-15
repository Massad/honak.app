// Reads all assets/api/business/items_*.json files and generates
// corresponding categories_*.json files by extracting unique categories
// from the items data.
//
// Run:  dart run tool/generate_biz_categories.dart
import 'dart:convert';
import 'dart:io';

void main() {
  final bizDir = Directory('assets/api/business');
  if (!bizDir.existsSync()) {
    stderr.writeln('Error: assets/api/business/ not found. Run from project root.');
    exit(1);
  }

  final itemsFiles = bizDir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.contains('items_') && f.path.endsWith('.json'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  var generated = 0;
  var skipped = 0;

  for (final file in itemsFiles) {
    final filename = file.uri.pathSegments.last;
    final type = filename.replaceAll('items_', '').replaceAll('.json', '');

    final Map<String, dynamic> json;
    try {
      json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    } catch (e) {
      stderr.writeln('  SKIP $type — invalid JSON: $e');
      skipped++;
      continue;
    }

    final items = (json['data'] as List?) ?? [];
    if (items.isEmpty) {
      stderr.writeln('  SKIP $type — no items');
      skipped++;
      continue;
    }

    // Extract unique categories preserving first-seen order
    final seen = <String>{};
    final categories = <Map<String, dynamic>>[];
    var sortOrder = 1;

    for (final item in items) {
      final catId = item['category_id'] as String?;
      final catName = item['category_name'] as String?;
      if (catId == null || catName == null) continue;
      if (seen.contains(catId)) continue;
      seen.add(catId);

      // Count items in this category
      final count = items
          .where((i) => i['category_id'] == catId)
          .length;

      categories.add({
        'id': catId,
        'name': catName,
        'item_count': count,
        'sort_order': sortOrder++,
      });
    }

    if (categories.isEmpty) {
      stderr.writeln('  SKIP $type — no categories found in items');
      skipped++;
      continue;
    }

    final output = {
      'success': true,
      'data': categories,
      'meta': {'total': categories.length},
    };

    final outPath = 'assets/api/business/categories_$type.json';
    File(outPath).writeAsStringSync(
      '${const JsonEncoder.withIndent('  ').convert(output)}\n',
    );
    stdout.writeln('  OK  $type — ${categories.length} categories → $outPath');
    generated++;
  }

  stdout.writeln('');
  stdout.writeln('Done: $generated generated, $skipped skipped.');
}
