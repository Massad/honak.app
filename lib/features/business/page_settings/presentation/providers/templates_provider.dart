import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/page_settings/data/settings_repository.dart';

final _repo = SettingsRepository();

final templatesProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  return _repo.getTemplates();
});
