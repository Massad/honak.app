import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/conversation.dart';
import 'package:honak/features/chat/presentation/providers/chat_provider.dart';
import 'package:honak/features/chat/presentation/widgets/chat_list_skeleton.dart';
import 'package:honak/features/chat/presentation/widgets/conversation_card.dart';
import 'package:honak/shared/widgets/button.dart';
import 'package:honak/shared/widgets/empty_state.dart';

// Business-specific chat list matching Figma design:
// - Header: "محادثات العملاء" + unread badge + search toggle
// - Filters: الكل / بحاجة رد / بانتظار العميل
// - No Scaffold — embedded in BusinessShell

enum _BizChatFilter { all, needsAction, waiting }

class BusinessChatListPage extends ConsumerStatefulWidget {
  const BusinessChatListPage({super.key});

  @override
  ConsumerState<BusinessChatListPage> createState() =>
      _BusinessChatListPageState();
}

class _BusinessChatListPageState extends ConsumerState<BusinessChatListPage> {
  _BizChatFilter _activeFilter = _BizChatFilter.all;
  bool _showSearch = false;
  String _searchQuery = '';

  List<Conversation> _applyFilter(List<Conversation> conversations) {
    var filtered = switch (_activeFilter) {
      _BizChatFilter.all => conversations,
      _BizChatFilter.needsAction => conversations
          .where((c) => c.unreadCount > 0 || c.needsInfo)
          .toList(),
      _BizChatFilter.waiting => conversations
          .where(
              (c) => c.lastMessageFrom == 'business' && c.unreadCount == 0)
          .toList(),
    };

    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      filtered = filtered.where((c) {
        final nameMatch =
            c.customerName?.toLowerCase().contains(q) ?? false;
        final idMatch = c.requestId?.toLowerCase().contains(q) ?? false;
        return nameMatch || idMatch;
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final conversationsAsync = ref.watch(conversationsProvider);

    return Column(
      children: [
        _buildHeader(context),
        if (_showSearch) _buildSearchBar(),
        _buildFilterTabs(context),
        Expanded(
          child: conversationsAsync.when(
            data: (conversations) {
              final filtered = _applyFilter(conversations);
              if (conversations.isEmpty) {
                return const EmptyState(
                  icon: Icons.chat_bubble_outline,
                  title: 'لا توجد محادثات بعد',
                  subtitle:
                      'عندما يتواصل معك عملاء ستظهر محادثاتهم هنا',
                );
              }
              if (filtered.isEmpty) {
                return const EmptyState(
                  icon: Icons.chat_bubble_outline,
                  title: 'لا توجد محادثات في هذا القسم',
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(conversationsProvider);
                  await ref.read(conversationsProvider.future);
                },
                child: ListView.separated(
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) =>
                      const Divider(height: 1, indent: 76),
                  itemBuilder: (context, index) {
                    final conv = filtered[index];
                    return ConversationCard(
                      conversation: conv,
                      isBusinessMode: true,
                      onTap: () {
                        context.push(
                          Routes.chatDetailPath(conv.id),
                          extra: conv,
                        );
                      },
                    );
                  },
                ),
              );
            },
            loading: () => const ChatListSkeleton(),
            error: (error, _) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'حدث خطأ أثناء تحميل المحادثات',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: context.colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Button(
                    onPressed: () =>
                        ref.invalidate(conversationsProvider),
                    label: 'إعادة المحاولة',
                    variant: Variant.text,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    final unreadCount = ref.watch(unreadChatCountProvider);

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.sm,
        0,
      ),
      child: Row(
        children: [
          Text(
            'محادثات العملاء',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          if (unreadCount > 0) ...[
            const SizedBox(width: AppSpacing.sm),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$unreadCount بانتظار الرد',
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          const Spacer(),
          Button(
            onPressed: () => setState(() {
              _showSearch = !_showSearch;
              if (!_showSearch) _searchQuery = '';
            }),
            icon: ButtonIcon(
              _showSearch ? Icons.close : Icons.search,
              size: 20,
              color: context.colorScheme.onSurfaceVariant,
            ),
            variant: Variant.text,
            size: ButtonSize.small,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      child: TextField(
        onChanged: (v) => setState(() => _searchQuery = v),
        decoration: InputDecoration(
          hintText: 'ابحث بالاسم أو رقم الطلب...',
          hintStyle:
              TextStyle(color: context.colorScheme.onSurfaceVariant, fontSize: 14),
          prefixIcon: Icon(
            Icons.search,
            size: 20,
            color: context.colorScheme.onSurfaceVariant,
          ),
          filled: true,
          fillColor: context.colorScheme.surfaceContainerLowest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          isDense: true,
        ),
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildFilterTabs(BuildContext context) {
    final conversations =
        ref.watch(conversationsProvider).valueOrNull ?? [];
    final allCount = conversations.length;
    final needsActionCount = conversations
        .where((c) => c.unreadCount > 0 || c.needsInfo)
        .length;
    final waitingCount = conversations
        .where(
            (c) => c.lastMessageFrom == 'business' && c.unreadCount == 0)
        .length;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          _FilterChip(
            label: 'الكل',
            count: allCount,
            isActive: _activeFilter == _BizChatFilter.all,
            onTap: () =>
                setState(() => _activeFilter = _BizChatFilter.all),
          ),
          const SizedBox(width: AppSpacing.sm),
          _FilterChip(
            label: 'بحاجة رد',
            count: needsActionCount,
            isActive: _activeFilter == _BizChatFilter.needsAction,
            onTap: () => setState(
                () => _activeFilter = _BizChatFilter.needsAction),
          ),
          const SizedBox(width: AppSpacing.sm),
          _FilterChip(
            label: 'بانتظار العميل',
            count: waitingCount,
            isActive: _activeFilter == _BizChatFilter.waiting,
            onTap: () => setState(
                () => _activeFilter = _BizChatFilter.waiting),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final int count;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.count,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.md,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : context.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight:
                    isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive
                    ? AppColors.white
                    : context.colorScheme.onSurfaceVariant,
              ),
            ),
            if (count > 0) ...[
              const SizedBox(width: 4),
              Text(
                '$count',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isActive
                      ? AppColors.white.withValues(alpha: 0.7)
                      : context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
