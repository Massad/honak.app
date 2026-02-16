import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Full-screen page listing all branches with search and city filters.
/// Pushed as [MaterialPageRoute] (no GoRouter route needed).
class BranchesPage extends StatefulWidget {
  final List<Branch> branches;
  final String pageName;

  const BranchesPage({
    super.key,
    required this.branches,
    required this.pageName,
  });

  @override
  State<BranchesPage> createState() => _BranchesPageState();
}

class _BranchesPageState extends State<BranchesPage> {
  String _query = '';
  String? _selectedCity;

  List<String> get _cities => widget.branches
      .map((b) => b.city)
      .where((c) => c != null)
      .cast<String>()
      .toSet()
      .toList();

  List<Branch> get _filtered {
    var list = widget.branches;
    if (_selectedCity != null) {
      list = list.where((b) => b.city == _selectedCity).toList();
    }
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      list = list
          .where((b) =>
              b.name.toLowerCase().contains(q) ||
              (b.address?.toLowerCase().contains(q) ?? false) ||
              (b.city?.toLowerCase().contains(q) ?? false) ||
              (b.neighborhood?.toLowerCase().contains(q) ?? false))
          .toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final showCityFilter = _cities.length > 1;
    final filtered = _filtered;

    return Scaffold(
      appBar: AppBar(
        // "الفروع (N)"
        title: Text(
          '\u0627\u0644\u0641\u0631\u0648\u0639 (${widget.branches.length})',
        ),
      ),
      body: Column(
        children: [
          // Search field
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                // "ابحث عن فرع..."
                hintText: '\u0627\u0628\u062d\u062b \u0639\u0646 \u0641\u0631\u0639...',
                prefixIcon: const Icon(Icons.search, size: 20),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  borderSide: BorderSide(
                    color: context.colorScheme.outlineVariant,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  borderSide: BorderSide(
                    color: context.colorScheme.outlineVariant,
                  ),
                ),
              ),
            ),
          ),

          // City filter chips
          if (showCityFilter)
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsetsDirectional.only(start: AppSpacing.lg),
                children: [
                  _CityChip(
                    // "الكل"
                    label: '\u0627\u0644\u0643\u0644',
                    isSelected: _selectedCity == null,
                    onTap: () => setState(() => _selectedCity = null),
                  ),
                  ..._cities.map(
                    (city) => _CityChip(
                      label: city,
                      isSelected: _selectedCity == city,
                      onTap: () => setState(() => _selectedCity = city),
                    ),
                  ),
                ],
              ),
            ),

          SizedBox(height: AppSpacing.sm),

          // Branch list
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Text(
                      // "لا توجد نتائج"
                      '\u0644\u0627 \u062a\u0648\u062c\u062f \u0646\u062a\u0627\u0626\u062c',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) =>
                        _BranchListCard(branch: filtered[index]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _CityChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CityChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: AppSpacing.xs),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? context.colorScheme.primary
                : context.colorScheme.surfaceContainerHighest,
            borderRadius: AppRadius.pill,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? context.colorScheme.onPrimary
                  : context.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

class _BranchListCard extends StatelessWidget {
  final Branch branch;

  const _BranchListCard({required this.branch});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: AppSpacing.sm),
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    branch.name,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (branch.venueId != null) _VenueBadge(branch: branch),
              ],
            ),
            if (branch.address != null) ...[
              SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      branch.address!,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            if (branch.hours != null) ...[
              SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    size: 14,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  SizedBox(width: AppSpacing.xs),
                  Text(
                    branch.hours!,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
            if (branch.phone != null) ...[
              SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Icon(
                    Icons.phone_outlined,
                    size: 14,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  SizedBox(width: AppSpacing.xs),
                  Text(
                    branch.phone!,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
            SizedBox(height: AppSpacing.sm),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: btn.Button(
                onPressed: () {},
                label: '\u0641\u062a\u062d \u0641\u064a \u0627\u0644\u062e\u0631\u0627\u0626\u0637',
                icon: const btn.ButtonIcon(Icons.map_outlined),
                variant: btn.Variant.text,
                size: btn.ButtonSize.small,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Small blue pill badge showing venue info on a branch card.
class _VenueBadge extends StatelessWidget {
  final Branch branch;

  const _VenueBadge({required this.branch});

  @override
  Widget build(BuildContext context) {
    final parts = <String>[];
    if (branch.venueName != null) {
      parts.add('\u0641\u064a ${branch.venueName}');
    }
    if (branch.venueUnit != null) parts.add(branch.venueUnit!);
    if (parts.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: AppRadius.pill,
      ),
      child: Text(
        parts.join(' \u00b7 '),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: context.colorScheme.primary,
        ),
      ),
    );
  }
}
