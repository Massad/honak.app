import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/requests/domain/entities/entities.dart';
import 'package:honak/features/requests/presentation/providers/provider.dart';
import 'package:honak/features/requests/presentation/widgets/request_list_card.dart';
import 'package:honak/features/requests/presentation/widgets/request_list_skeleton.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Customer "My Requests" page — "\u0637\u0644\u0628\u0627\u062a\u064a".
///
/// Three filter tabs (active / completed / all) with pull-to-refresh.
class RequestListPage extends ConsumerStatefulWidget {
  const RequestListPage({super.key});

  @override
  ConsumerState<RequestListPage> createState() => _RequestListPageState();
}

class _RequestListPageState extends ConsumerState<RequestListPage> {
  _Tab _selectedTab = _Tab.active;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            title: const Text('\u0637\u0644\u0628\u0627\u062a\u064a'),
            actions: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: _FilterTabs(
                selected: _selectedTab,
                onChanged: (tab) => setState(() => _selectedTab = tab),
              ),
            ),
          ),
        ],
        body: _RequestList(tab: _selectedTab),
      ),
    );
  }
}

// ---------------------------------------------------------------
// Filter Tabs
// ---------------------------------------------------------------

enum _Tab { active, completed, all }

class _FilterTabs extends StatelessWidget {
  final _Tab selected;
  final ValueChanged<_Tab> onChanged;

  const _FilterTabs({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.sm,
      ),
      child: Row(
        children: [
          _TabChip(
            label: '\u0646\u0634\u0637\u0629',
            isSelected: selected == _Tab.active,
            onTap: () => onChanged(_Tab.active),
          ),
          const SizedBox(width: AppSpacing.sm),
          _TabChip(
            label: '\u0645\u0643\u062a\u0645\u0644\u0629',
            isSelected: selected == _Tab.completed,
            onTap: () => onChanged(_Tab.completed),
          ),
          const SizedBox(width: AppSpacing.sm),
          _TabChip(
            label: '\u0627\u0644\u0643\u0644',
            isSelected: selected == _Tab.all,
            onTap: () => onChanged(_Tab.all),
          ),
        ],
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : context.colorScheme.surfaceContainerLow,
          borderRadius: AppRadius.pill,
        ),
        child: Text(
          label,
          style: context.textTheme.bodySmall?.copyWith(
            color: isSelected ? Colors.white : context.colorScheme.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------
// Request List
// ---------------------------------------------------------------

class _RequestList extends ConsumerWidget {
  final _Tab tab;

  const _RequestList({required this.tab});

  String? get _statusFilter => switch (tab) {
        _Tab.active => 'active',
        _Tab.completed => 'completed',
        _Tab.all => null,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsAsync = ref.watch(myRequestsProvider(_statusFilter));

    return requestsAsync.when(
      loading: () => const RequestListSkeleton(),
      error: (error, _) => _ErrorState(
        onRetry: () => ref.invalidate(myRequestsProvider(_statusFilter)),
      ),
      data: (requests) {
        final filtered = _filterByTab(requests);
        if (filtered.isEmpty) return const _EmptyState();

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(myRequestsProvider(_statusFilter));
          },
          child: ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: filtered.length,
            separatorBuilder: (_, __) =>
                const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final request = filtered[index];
              return RequestListCard(
                request: request,
                onTap: () {
                  context.showSnackBar(
                      '\u062a\u0641\u0627\u0635\u064a\u0644 \u0627\u0644\u0637\u0644\u0628: ${request.id}');
                },
              );
            },
          ),
        );
      },
    );
  }

  List<CustomerRequest> _filterByTab(List<CustomerRequest> requests) {
    return switch (tab) {
      _Tab.active => requests.where((r) => _isActive(r.status)).toList(),
      _Tab.completed =>
        requests.where((r) => _isCompleted(r.status)).toList(),
      _Tab.all => requests,
    };
  }

  static bool _isActive(String status) {
    const s = {
      'pending', 'pending_review', 'accepted', 'in_progress',
      'preparing', 'suggested', 'pending_reschedule', 'rescheduled',
      // Queue statuses
      'waiting', 'on_the_way', 'in_progress_queue', 'ready_for_pickup',
    };
    return s.contains(status);
  }

  static bool _isCompleted(String status) {
    const s = {
      'completed', 'delivered', 'declined',
      'cancelled_by_customer', 'cancelled_by_business',
      'no_show', // queue no-show
    };
    return s.contains(status);
  }
}

// ---------------------------------------------------------------
// Empty & Error States
// ---------------------------------------------------------------

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_bag_outlined,
                size: 48, color: context.colorScheme.outline),
            const SizedBox(height: AppSpacing.lg),
            Text(
              '\u0644\u0627 \u062a\u0648\u062c\u062f \u0637\u0644\u0628\u0627\u062a',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
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
        padding: const EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: context.colorScheme.outline),
            const SizedBox(height: AppSpacing.lg),
            Text(
              '\u062d\u062f\u062b \u062e\u0637\u0623 \u0623\u062b\u0646\u0627\u0621 \u062a\u062d\u0645\u064a\u0644 \u0627\u0644\u0637\u0644\u0628\u0627\u062a',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            btn.Button(
              onPressed: onRetry,
              label: '\u0625\u0639\u0627\u062f\u0629 \u0627\u0644\u0645\u062d\u0627\u0648\u0644\u0629',
              icon: const btn.ButtonIcon(Icons.refresh),
              variant: btn.Variant.text,
            ),
          ],
        ),
      ),
    );
  }
}
