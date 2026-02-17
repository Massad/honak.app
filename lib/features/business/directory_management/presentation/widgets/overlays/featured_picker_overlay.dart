import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/directory_management/domain/entities/tenant.dart';
import 'package:honak/features/business/directory_management/domain/entities/tenant_status.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Overlay for picking featured tenants — checkbox list, max 8 selections.
class FeaturedPickerOverlay extends StatefulWidget {
  final List<Tenant> tenants;
  final List<String> selectedIds;
  final VoidCallback onClose;
  final ValueChanged<List<String>> onSave;

  const FeaturedPickerOverlay({
    super.key,
    required this.tenants,
    required this.selectedIds,
    required this.onClose,
    required this.onSave,
  });

  @override
  State<FeaturedPickerOverlay> createState() => _FeaturedPickerOverlayState();
}

class _FeaturedPickerOverlayState extends State<FeaturedPickerOverlay> {
  late Set<String> _selected;
  static const _maxFeatured = 8;

  @override
  void initState() {
    super.initState();
    _selected = Set.from(widget.selectedIds);
  }

  // Only claimed + new tenants can be featured
  List<Tenant> get _eligibleTenants => widget.tenants
      .where((t) =>
          t.status == TenantStatus.claimed ||
          t.status == TenantStatus.newTenant)
      .toList();

  void _toggle(String id) {
    setState(() {
      if (_selected.contains(id)) {
        _selected.remove(id);
      } else if (_selected.length < _maxFeatured) {
        _selected.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final eligible = _eligibleTenants;

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: widget.onClose,
        ),
        title: Text(
          context.l10n.dirFeaturedTitle,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          btn.Button(
            onPressed: () => widget.onSave(_selected.toList()),
            label: context.l10n.save,
            variant: btn.Variant.text,
            size: btn.ButtonSize.small,
          ),
        ],
      ),
      body: Column(
        children: [
          // Counter
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                const Icon(Icons.auto_awesome,
                    size: 18, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  context.l10n
                      .dirFeaturedCount(_selected.length, _maxFeatured),
                  style: context.textTheme.titleSmall?.copyWith(
                    color: _selected.length >= _maxFeatured
                        ? AppColors.error
                        : AppColors.primary,
                  ),
                ),
                const Spacer(),
                if (_selected.isNotEmpty)
                  GestureDetector(
                    onTap: () => setState(() => _selected.clear()),
                    child: Text(
                      context.l10n.clearAll,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // List
          Expanded(
            child: eligible.isEmpty
                ? Center(
                    child: Text(
                      context.l10n.dirFeaturedNoLinked,
                      style: TextStyle(
                          fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    itemCount: eligible.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (_, i) {
                      final tenant = eligible[i];
                      final isSelected = _selected.contains(tenant.id);
                      final isDisabled = !isSelected &&
                          _selected.length >= _maxFeatured;

                      return GestureDetector(
                        onTap: isDisabled ? null : () => _toggle(tenant.id),
                        child: Container(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            borderRadius: AppRadius.card,
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                      .withValues(alpha: 0.4)
                                  : context.colorScheme.outlineVariant,
                            ),
                            color: isSelected
                                ? AppColors.primary
                                    .withValues(alpha: 0.04)
                                : null,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isSelected
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                size: 20,
                                color: isSelected
                                    ? AppColors.primary
                                    : isDisabled
                                        ? Theme.of(context).colorScheme.outline
                                        : Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: context
                                      .colorScheme.surfaceContainerHighest,
                                ),
                                child: Icon(
                                  Icons.storefront,
                                  size: 16,
                                  color:
                                      context.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tenant.name,
                                      style: context.textTheme.titleSmall,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '${tenant.unit} · ${tenant.category}',
                                      style: context.textTheme.bodySmall
                                          ?.copyWith(
                                        color: context
                                            .colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
