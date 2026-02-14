import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/conversation.dart';
import 'package:honak/features/chat/presentation/providers/chat_provider.dart';
import 'package:honak/features/chat/presentation/widgets/chat_list_skeleton.dart';
import 'package:honak/features/chat/presentation/widgets/conversation_card.dart';
import 'package:honak/features/stories/presentation/providers/stories_provider.dart'
    show storyContentProvider;
import 'package:honak/features/stories/presentation/utils/story_launcher.dart';
import 'package:honak/shared/providers/app_mode_provider.dart';
import 'package:honak/shared/widgets/empty_state.dart';

enum _ChatFilter { all, requests, messages }

class ChatListPage extends ConsumerStatefulWidget {
  const ChatListPage({super.key});

  @override
  ConsumerState<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends ConsumerState<ChatListPage> {
  _ChatFilter _activeFilter = _ChatFilter.all;

  List<Conversation> _applyFilter(List<Conversation> conversations) {
    return switch (_activeFilter) {
      _ChatFilter.all => conversations,
      _ChatFilter.requests =>
        conversations.where((c) => c.type == 'request').toList(),
      _ChatFilter.messages =>
        conversations.where((c) => c.type == 'message').toList(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final conversationsAsync = ref.watch(conversationsProvider);
    // Pre-load story content for avatar taps
    ref.watch(storyContentProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _buildTitle(context),
        centerTitle: false,
      ),
      body: Column(
        children: [
          _buildFilterTabs(context),
          Expanded(
            child: conversationsAsync.when(
              data: (conversations) {
                final filtered = _applyFilter(conversations);
                if (conversations.isEmpty) {
                  return const EmptyState(
                    icon: Icons.chat_bubble_outline,
                    title: 'لا توجد محادثات بعد',
                    subtitle: 'ستظهر محادثاتك هنا عندما تبدأ التواصل مع الصفحات',
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
                    separatorBuilder: (_, __) => const Divider(
                      height: 1,
                      indent: 76,
                    ),
                    itemBuilder: (context, index) {
                      final conv = filtered[index];
                      return ConversationCard(
                        conversation: conv,
                        isBusinessMode: _isBusinessMode,
                        onTap: () {
                          context.push(
                            Routes.chatDetailPath(conv.id),
                            extra: conv,
                          );
                        },
                        onAvatarTap: conv.hasActiveStory
                            ? () => openStoryViewer(
                                  context,
                                  ref,
                                  pageId: conv.pageId,
                                )
                            : null,
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
                    SizedBox(height: AppSpacing.md),
                    Text(
                      'حدث خطأ أثناء تحميل المحادثات',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                    ),
                    SizedBox(height: AppSpacing.lg),
                    TextButton(
                      onPressed: () => ref.invalidate(conversationsProvider),
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final unreadCount = ref.watch(unreadChatCountProvider);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'المحادثات',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        if (unreadCount > 0) ...[
          SizedBox(width: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.error,
              borderRadius: AppRadius.pill,
            ),
            child: Text(
              unreadCount > 99 ? '+99' : '$unreadCount',
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFilterTabs(BuildContext context) {
    final conversations =
        ref.watch(conversationsProvider).valueOrNull ?? [];
    final allCount = conversations.length;
    final requestCount =
        conversations.where((c) => c.type == 'request').length;
    final messageCount =
        conversations.where((c) => c.type == 'message').length;

    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: AppSpacing.lg,
        end: AppSpacing.lg,
        top: AppSpacing.sm,
        bottom: AppSpacing.md,
      ),
      child: Row(
        children: [
          _buildFilterChip(context, _ChatFilter.all, 'الكل', allCount),
          SizedBox(width: AppSpacing.sm),
          _buildFilterChip(
              context, _ChatFilter.requests, 'الطلبات', requestCount),
          SizedBox(width: AppSpacing.sm),
          _buildFilterChip(
              context, _ChatFilter.messages, 'الرسائل', messageCount),
        ],
      ),
    );
  }

  bool get _isBusinessMode =>
      ref.watch(appModeProvider).valueOrNull == AppMode.business;

  Widget _buildFilterChip(
    BuildContext context,
    _ChatFilter filter,
    String label,
    int count,
  ) {
    final isActive = _activeFilter == filter;

    return GestureDetector(
      onTap: () => setState(() => _activeFilter = filter),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : context.colorScheme.surfaceContainerLow,
          borderRadius: AppRadius.pill,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color:
                        isActive ? AppColors.white : context.colorScheme.onSurfaceVariant,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
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
