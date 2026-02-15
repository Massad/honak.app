import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/requests/domain/entities/customer_request.dart';
import 'package:honak/features/requests/presentation/providers/provider.dart';
import 'package:honak/shared/widgets/app_image.dart';

/// Provider for completed orders suitable for reorder.
/// Filters for order-type requests with completed/delivered status, limited to 5.
final reorderableRequestsProvider =
    FutureProvider<List<CustomerRequest>>((ref) async {
  final all = await ref.watch(myRequestsProvider('completed').future);
  return all
      .where((r) =>
          (r.type == 'order') &&
          (r.status == 'completed' || r.status == 'delivered'))
      .take(5)
      .toList();
});

/// Horizontal scrollable strip showing recent completed orders with reorder.
class ReorderSection extends ConsumerWidget {
  const ReorderSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsAsync = ref.watch(reorderableRequestsProvider);

    return requestsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (requests) {
        if (requests.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Section header
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Text(
                context.l10n.reorderSectionTitle,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            // Scrollable cards
            SizedBox(
              height: 148,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg),
                itemCount: requests.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: AppSpacing.md),
                itemBuilder: (context, index) => _ReorderCard(
                  request: requests[index],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ReorderCard extends StatelessWidget {
  final CustomerRequest request;

  const _ReorderCard({required this.request});

  String _relativeDate(BuildContext context) {
    final now = DateTime.now();
    final date =
        DateTime.fromMillisecondsSinceEpoch(request.createdAt * 1000);
    final diff = now.difference(date);

    if (diff.inDays == 0) return context.l10n.today;
    if (diff.inDays == 1) return context.l10n.yesterday;
    if (diff.inDays < 7) return context.l10n.daysAgo(diff.inDays);
    if (diff.inDays < 30) {
      final weeks = (diff.inDays / 7).floor();
      return '$weeks أسبوع';
    }
    final months = (diff.inDays / 30).floor();
    return '$months شهر';
  }

  String _orderSummary() {
    if (request.items.isNotEmpty) {
      final first = request.items.first.name;
      final count = request.itemsCount > 0
          ? request.itemsCount
          : request.items.length;
      if (count > 1) {
        return '$first + ${count - 1} عنصر';
      }
      return first;
    }
    if (request.summary != null) return request.summary!;
    return '${request.itemsCount} أصناف';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.push(Routes.requestDetailPath(request.id)),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Avatar + business name
            Row(
              children: [
                const Spacer(),
                Flexible(
                  child: Text(
                    request.businessName,
                    style: context.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                ClipOval(
                  child: SizedBox(
                    width: 36,
                    height: 36,
                    child: request.businessAvatarUrl != null
                        ? AppImage(
                            url: request.businessAvatarUrl!,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: context
                                .colorScheme.surfaceContainerHighest,
                            child: Icon(
                              Icons.store,
                              size: 18,
                              color: context
                                  .colorScheme.onSurfaceVariant,
                            ),
                          ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            // Order summary
            Text(
              _orderSummary(),
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // Date + price
            Row(
              children: [
                if (request.total != null)
                  Text(
                    request.total!.toFormattedArabic(),
                    style: context.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                const Spacer(),
                Text(
                  _relativeDate(context),
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Reorder button
            SizedBox(
              width: double.infinity,
              height: 32,
              child: FilledButton.icon(
                onPressed: () {
                  if (request.businessSlug != null) {
                    context.push(
                        Routes.pagePath(request.businessSlug!));
                  }
                },
                icon: const Icon(Icons.replay, size: 14),
                label: Text(
                  context.l10n.reorderButton,
                  style: const TextStyle(fontSize: 12),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
