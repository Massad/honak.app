import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/features/business/catalog_management/domain/entities/price_change.dart';
import 'package:honak/shared/providers/business_page_provider.dart';

class PriceChangeState {
  final PriceChange? active;
  final List<PriceChange> history;

  const PriceChangeState({this.active, this.history = const []});

  PriceChangeState copyWith({
    PriceChange? active,
    List<PriceChange>? history,
    bool clearActive = false,
  }) {
    return PriceChangeState(
      active: clearActive ? null : (active ?? this.active),
      history: history ?? this.history,
    );
  }
}

final priceChangeProvider =
    AsyncNotifierProvider<PriceChangeNotifier, PriceChangeState>(() {
  return PriceChangeNotifier();
});

class PriceChangeNotifier extends AsyncNotifier<PriceChangeState> {
  @override
  Future<PriceChangeState> build() async {
    final bizContext = ref.watch(businessContextProvider);
    if (bizContext == null) return const PriceChangeState();

    final pageId = bizContext.page.id;
    return _loadFromFixture(pageId);
  }

  Future<PriceChangeState> _loadFromFixture(String pageId) async {
    try {
      final jsonStr = await rootBundle
          .loadString('assets/api/business/price_changes.json');
      final data = json.decode(jsonStr) as Map<String, dynamic>;
      final pageData = data[pageId] as Map<String, dynamic>?;
      if (pageData == null) return const PriceChangeState();

      final activeJson = pageData['active'];
      final historyJson = pageData['history'] as List? ?? [];

      return PriceChangeState(
        active: activeJson != null
            ? PriceChange.fromJson(activeJson as Map<String, dynamic>)
            : null,
        history: historyJson
            .map((e) => PriceChange.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } catch (_) {
      return const PriceChangeState();
    }
  }

  void applyChange(PriceChange change) {
    final current = state.valueOrNull;
    if (current == null) return;

    // Move current active to history if exists
    final updatedHistory = [
      if (current.active != null)
        current.active!.copyWith(status: 'cancelled'),
      ...current.history,
    ];

    state = AsyncValue.data(PriceChangeState(
      active: change,
      history: updatedHistory,
    ));
  }

  void stopActive() {
    final current = state.valueOrNull;
    if (current == null || current.active == null) return;

    state = AsyncValue.data(PriceChangeState(
      active: null,
      history: [
        current.active!.copyWith(status: 'cancelled'),
        ...current.history,
      ],
    ));
  }
}
