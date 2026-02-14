import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_wizard/presentation/providers/wizard_provider.dart';

export 'type_picker_category.dart';

import 'type_picker_category.dart';

class TypePickerStep extends ConsumerStatefulWidget {
  const TypePickerStep({super.key});

  @override
  ConsumerState<TypePickerStep> createState() => _TypePickerStepState();
}

class _TypePickerStepState extends ConsumerState<TypePickerStep> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<BizTypeOption> _allTypes() {
    final seen = <String>{};
    final result = <BizTypeOption>[];
    for (final cat in bizTypeCategories) {
      for (final t in cat.types) {
        if (seen.add(t.id)) result.add(t);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(wizardProvider);
    final notifier = ref.read(wizardProvider.notifier);
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      children: [
        // Search bar
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'ابحث عن نوع النشاط...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: AppRadius.button,
              borderSide: BorderSide(color: context.colorScheme.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.button,
              borderSide: BorderSide(color: context.colorScheme.outlineVariant),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
          ),
          onChanged: (v) => setState(() => _searchQuery = v.trim()),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Search results or default view
        if (_searchQuery.isNotEmpty)
          _buildSearchResults(state.selectedTypeId, notifier, theme)
        else ...[
          // Popular section
          Text(
            'الأكثر شيوعاً',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: popularTypes.map((t) {
              final selected = state.selectedTypeId == t.id;
              return TypeChip(
                type: t,
                selected: selected,
                onTap: () => notifier.selectType(t.id, t.name, t.archetype),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.xxl),

          // Category sections
          ...bizTypeCategories.map((cat) => CategorySection(
                category: cat,
                selectedTypeId: state.selectedTypeId,
                onSelect: (t) => notifier.selectType(t.id, t.name, t.archetype),
              )),
        ],

        // Selected type info box
        if (state.selectedTypeId != null && state.selectedArchetype != null) ...[
          const SizedBox(height: AppSpacing.lg),
          ArchetypeInfoBox(archetype: state.selectedArchetype!),
        ],
      ],
    );
  }

  Widget _buildSearchResults(
    String? selectedId,
    WizardNotifier notifier,
    ThemeData theme,
  ) {
    final query = _searchQuery.toLowerCase();
    final results = _allTypes().where((t) => t.name.contains(query)).toList();
    if (results.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxxl),
          child: Text(
            'لا توجد نتائج',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }
    return Column(
      children: results.map((t) {
        return TypeListTile(
          type: t,
          selected: selectedId == t.id,
          onTap: () => notifier.selectType(t.id, t.name, t.archetype),
        );
      }).toList(),
    );
  }
}
