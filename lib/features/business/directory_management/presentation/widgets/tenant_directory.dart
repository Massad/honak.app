import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/directory_management/domain/entities/directory_manage_data.dart';
import 'package:honak/features/business/directory_management/domain/entities/tenant.dart';
import 'package:honak/features/business/directory_management/domain/entities/tenant_status.dart';
import 'package:honak/features/business/directory_management/presentation/providers/directory_manage_provider.dart';
import 'package:honak/features/business/directory_management/presentation/widgets/overlays/amenity_manager_overlay.dart';
import 'package:honak/features/business/directory_management/presentation/widgets/overlays/category_manager_overlay.dart';
import 'package:honak/features/business/directory_management/presentation/widgets/overlays/featured_picker_overlay.dart';
import 'package:honak/features/business/directory_management/presentation/widgets/overlays/floor_manager_overlay.dart';
import 'package:honak/features/business/directory_management/presentation/widgets/overlays/tenant_form_overlay.dart';
import 'package:honak/features/business/directory_management/presentation/widgets/overlays/venue_maps_overlay.dart';
import 'package:honak/features/business/directory_management/presentation/widgets/shared/tenant_coverage_bar.dart';
import 'package:honak/features/business/directory_management/presentation/widgets/shared/tenant_manage_card.dart';
import 'package:honak/features/business/directory_management/presentation/widgets/sheets/delete_slot_sheet.dart';
import 'package:honak/features/business/directory_management/presentation/widgets/sheets/send_invite_sheet.dart';
import 'package:honak/features/business/directory_management/presentation/widgets/sheets/unlink_tenant_sheet.dart';
import 'package:honak/features/business/directory_management/presentation/widgets/tenant_directory_config_chips.dart';
import 'package:honak/features/business/directory_management/presentation/widgets/tenant_directory_filters.dart';
import 'package:honak/features/business/directory_management/presentation/widgets/tenant_directory_stats.dart';
import 'package:honak/shared/providers/business_page_provider.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Core management widget for the directory — assembles stats, config chips,
/// filters, coverage bar, and tenant card list. Launched from [DirectoryManagePage].
class TenantDirectory extends ConsumerStatefulWidget {
  const TenantDirectory({super.key});

  @override
  ConsumerState<TenantDirectory> createState() => _TenantDirectoryState();
}

class _TenantDirectoryState extends ConsumerState<TenantDirectory> {
  String? _statusFilter;
  String _searchQuery = '';
  String? _overlayType;

  // ── Filtering ───────────────────────────────────────────────

  List<Tenant> _applyFilters(List<Tenant> tenants) {
    var result = tenants;

    if (_statusFilter != null) {
      result = result.where((t) {
        return switch (_statusFilter) {
          'claimed' => t.status == TenantStatus.claimed,
          'new' => t.status == TenantStatus.newTenant,
          'invited' => t.status == TenantStatus.invited,
          'unclaimed' => t.status == TenantStatus.unclaimed,
          _ => true,
        };
      }).toList();
    }

    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      result = result.where((t) {
        return t.name.toLowerCase().contains(q) ||
            t.unit.toLowerCase().contains(q) ||
            t.category.toLowerCase().contains(q);
      }).toList();
    }

    return result;
  }

  // ── Tenant actions ──────────────────────────────────────────

  void _showTenantMenu(Tenant tenant) {
    final status = tenant.status;
    showAppSheet(
      context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSheetHeader(
            title: tenant.name,
            onClose: () => Navigator.pop(context),
          ),
          if (status == TenantStatus.claimed ||
              status == TenantStatus.newTenant) ...[
            _MenuTile(
              icon: Icons.edit_outlined,
              label: 'تعديل',
              onTap: () {
                Navigator.pop(context);
                _openEditTenant(tenant);
              },
            ),
            _MenuTile(
              icon: Icons.link_off,
              label: 'إلغاء الربط',
              onTap: () {
                Navigator.pop(context);
                _showUnlinkSheet(tenant);
              },
            ),
          ],
          if (status == TenantStatus.invited) ...[
            _MenuTile(
              icon: Icons.send,
              label: 'إعادة إرسال الدعوة',
              onTap: () {
                Navigator.pop(context);
                _showInviteSheet(tenant);
              },
            ),
            _MenuTile(
              icon: Icons.edit_outlined,
              label: 'تعديل',
              onTap: () {
                Navigator.pop(context);
                _openEditTenant(tenant);
              },
            ),
            _MenuTile(
              icon: Icons.cancel_outlined,
              label: 'إلغاء الدعوة',
              color: AppColors.error,
              onTap: () {
                Navigator.pop(context);
                _showToast('تم إلغاء الدعوة');
              },
            ),
          ],
          if (status == TenantStatus.unclaimed) ...[
            _MenuTile(
              icon: Icons.mail_outline,
              label: 'إرسال دعوة',
              onTap: () {
                Navigator.pop(context);
                _showInviteSheet(tenant);
              },
            ),
            _MenuTile(
              icon: Icons.edit_outlined,
              label: 'تعديل',
              onTap: () {
                Navigator.pop(context);
                _openEditTenant(tenant);
              },
            ),
            _MenuTile(
              icon: Icons.delete_outline,
              label: 'حذف',
              color: AppColors.error,
              onTap: () {
                Navigator.pop(context);
                _showDeleteSheet(tenant);
              },
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }

  void _openAddTenant() {
    setState(() => _overlayType = 'add_tenant');
  }

  void _openEditTenant(Tenant tenant) {
    setState(() => _overlayType = 'edit_tenant:${tenant.id}');
  }

  void _showUnlinkSheet(Tenant tenant) {
    showAppSheet(
      context,
      builder: (_) => UnlinkTenantSheet(
        tenant: tenant,
        onConfirm: (reason) {
          Navigator.pop(context);
          _showToast('تم إلغاء ربط ${tenant.name}');
        },
      ),
    );
  }

  void _showDeleteSheet(Tenant tenant) {
    showAppSheet(
      context,
      builder: (_) => DeleteSlotSheet(
        tenant: tenant,
        onConfirm: () {
          Navigator.pop(context);
          _showToast('تم حذف ${tenant.name}');
        },
      ),
    );
  }

  void _showInviteSheet(Tenant tenant) {
    final bizContext = ref.read(businessContextProvider);
    showAppSheet(
      context,
      builder: (_) => SendInviteSheet(
        tenant: tenant,
        mallName: bizContext?.page.name ?? '',
      ),
    );
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  // ── Overlay navigation ──────────────────────────────────────

  void _closeOverlay() {
    setState(() => _overlayType = null);
  }

  // ── Build ───────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final bizContext = ref.watch(businessContextProvider);
    if (bizContext == null) return const SizedBox.shrink();

    final pageId = bizContext.page.id;
    final dataAsync = ref.watch(directoryManageDataProvider(pageId));

    return dataAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => _ErrorState(
        onRetry: () => ref.invalidate(directoryManageDataProvider(pageId)),
      ),
      data: (data) => _buildContent(data, pageId),
    );
  }

  Widget _buildContent(DirectoryManageData data, String pageId) {
    final stats = data.stats;
    final filtered = _applyFilters(data.tenants);

    // Check for active overlay
    if (_overlayType != null) {
      return _buildOverlay(data, pageId);
    }

    return Stack(
      children: [
        ListView(
          children: [
            const SizedBox(height: AppSpacing.md),

            // Section header
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpacing.lg,
              ),
              child: Text(
                'إدارة الدليل',
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Config chips bar
            TenantDirectoryConfigChips(
              floorCount: data.floors.length,
              categoryCount: data.categories.length,
              amenityCount: data.amenities.length,
              featuredCount: data.featuredTenantIds.length,
              onFloorsTap: () => setState(() => _overlayType = 'floors'),
              onCategoriesTap: () =>
                  setState(() => _overlayType = 'categories'),
              onAmenitisTap: () =>
                  setState(() => _overlayType = 'amenities'),
              onFeaturedTap: () =>
                  setState(() => _overlayType = 'featured'),
              onMapsTap: () => setState(() => _overlayType = 'maps'),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Stats grid
            if (stats != null) ...[
              TenantDirectoryStats(
                stats: stats,
                activeFilter: _statusFilter,
                onFilterChanged: (f) => setState(() => _statusFilter = f),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],

            // Coverage bar
            if (stats != null) ...[
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                child: TenantCoverageBar(stats: stats),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],

            // Status filter chips + search
            if (stats != null)
              TenantDirectoryFilters(
                stats: stats,
                activeStatusFilter: _statusFilter,
                onStatusFilterChanged: (f) =>
                    setState(() => _statusFilter = f),
                searchQuery: _searchQuery,
                onSearchChanged: (q) => setState(() => _searchQuery = q),
              ),
            const SizedBox(height: AppSpacing.md),

            // Tenant list header
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpacing.lg,
              ),
              child: Row(
                children: [
                  Text(
                    '${filtered.length} وحدة',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _openAddTenant,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, size: 16, color: AppColors.primary),
                        const SizedBox(width: 2),
                        Text(
                          'إضافة وحدة',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),

            // Tenant list
            if (filtered.isEmpty)
              _EmptyState(
                isFiltering:
                    _statusFilter != null || _searchQuery.isNotEmpty,
                onClearFilters: () => setState(() {
                  _statusFilter = null;
                  _searchQuery = '';
                }),
                onAdd: _openAddTenant,
              )
            else
              ...filtered.map(
                (tenant) => Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.lg,
                    0,
                    AppSpacing.lg,
                    AppSpacing.sm,
                  ),
                  child: TenantManageCard(
                    tenant: tenant,
                    onTap: () => _openEditTenant(tenant),
                    onMenuAction: () => _showTenantMenu(tenant),
                    onViewPage: tenant.pageId != null
                        ? () => _showToast('عرض صفحة ${tenant.name}')
                        : null,
                    onEdit: () => _openEditTenant(tenant),
                    onInvite: () => _showInviteSheet(tenant),
                  ),
                ),
              ),

            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ],
    );
  }

  Widget _buildOverlay(DirectoryManageData data, String pageId) {
    if (_overlayType == 'floors') {
      return FloorManagerOverlay(
        floors: data.floors,
        onClose: _closeOverlay,
        onSave: (floors) {
          _closeOverlay();
          _showToast('تم تحديث الطوابق');
        },
      );
    }
    if (_overlayType == 'categories') {
      return CategoryManagerOverlay(
        categories: data.categories,
        tenants: data.tenants,
        onClose: _closeOverlay,
        onSave: (categories) {
          _closeOverlay();
          _showToast('تم تحديث التصنيفات');
        },
      );
    }
    if (_overlayType == 'amenities') {
      return AmenityManagerOverlay(
        selected: data.amenities,
        onClose: _closeOverlay,
        onSave: (amenities) {
          _closeOverlay();
          _showToast('تم تحديث المرافق');
        },
      );
    }
    if (_overlayType == 'featured') {
      return FeaturedPickerOverlay(
        tenants: data.tenants,
        selectedIds: data.featuredTenantIds,
        onClose: _closeOverlay,
        onSave: (ids) {
          _closeOverlay();
          _showToast('تم تحديث المميزون');
        },
      );
    }
    if (_overlayType == 'maps') {
      return VenueMapsOverlay(
        floors: data.floors,
        onClose: _closeOverlay,
      );
    }
    if (_overlayType == 'add_tenant') {
      return TenantFormOverlay(
        floors: data.floors,
        categories: data.categories,
        existingTenants: data.tenants,
        onClose: _closeOverlay,
        onSave: (tenantData) {
          _closeOverlay();
          _showToast('تم إضافة المستأجر');
        },
      );
    }
    if (_overlayType?.startsWith('edit_tenant:') ?? false) {
      final tenantId = _overlayType!.substring('edit_tenant:'.length);
      final tenant = data.tenants.where((t) => t.id == tenantId).firstOrNull;
      if (tenant != null) {
        return TenantFormOverlay(
          tenant: tenant,
          floors: data.floors,
          categories: data.categories,
          existingTenants: data.tenants,
          onClose: _closeOverlay,
          onSave: (tenantData) {
            _closeOverlay();
            _showToast('تم تحديث ${tenant.name}');
          },
        );
      }
    }

    _closeOverlay();
    return const SizedBox.shrink();
  }
}

// ═══════════════════════════════════════════════════════════════
// Menu tile for tenant action sheet
// ═══════════════════════════════════════════════════════════════

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _MenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? context.colorScheme.onSurface;
    return ListTile(
      leading: Icon(icon, size: 20, color: c),
      title: Text(
        label,
        style: TextStyle(fontSize: 14, color: c),
      ),
      onTap: onTap,
      dense: true,
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Empty & error states
// ═══════════════════════════════════════════════════════════════

class _EmptyState extends StatelessWidget {
  final bool isFiltering;
  final VoidCallback onClearFilters;
  final VoidCallback onAdd;

  const _EmptyState({
    required this.isFiltering,
    required this.onClearFilters,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    if (isFiltering) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 32, color: Theme.of(context).colorScheme.outlineVariant),
            const SizedBox(height: AppSpacing.md),
            Text(
              'لا توجد نتائج',
              style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.md),
            GestureDetector(
              onTap: onClearFilters,
              child: const Text(
                'مسح التصفية',
                style: TextStyle(fontSize: 12, color: AppColors.primary),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl,
        vertical: AppSpacing.xxxl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.06),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.store_mall_directory_outlined,
              size: 30,
              color: AppColors.primary.withValues(alpha: 0.4),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'لا يوجد مستأجرين بعد',
            style: context.textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'أضف مستأجرين لبناء دليل مولك',
            style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.xl),
          GestureDetector(
            onTap: onAdd,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'إضافة مستأجر',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorState({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.error.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'خطأ في تحميل بيانات الدليل',
              style: context.textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            btn.Button(
              onPressed: onRetry,
              label: 'إعادة المحاولة',
              icon: const btn.ButtonIcon(Icons.refresh),
              variant: btn.Variant.text,
            ),
          ],
        ),
      ),
    );
  }
}
