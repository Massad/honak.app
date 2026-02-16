import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/config/archetype.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/conversation.dart';
import 'package:honak/features/pages/presentation/providers/page_detail_providers.dart';
import 'package:honak/features/chat/domain/entities/message.dart';
import 'package:honak/features/chat/domain/entities/power_chat_types.dart';
import 'package:honak/features/chat/presentation/providers/chat_provider.dart';
import 'package:honak/features/chat/presentation/providers/message_action_provider.dart';
import 'package:honak/features/chat/presentation/widgets/alternative_card.dart';
import 'package:honak/features/chat/presentation/widgets/ask_info_sheet.dart';
import 'package:honak/features/chat/presentation/widgets/availability_card_message.dart';
import 'package:honak/features/chat/presentation/widgets/availability_picker_sheet.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/features/chat/presentation/widgets/chat_detail_skeleton.dart';
import 'package:honak/features/chat/presentation/widgets/image_message.dart';
import 'package:honak/features/chat/presentation/widgets/info_request_card.dart';
import 'package:honak/features/chat/presentation/widgets/message_actions_menu.dart';
import 'package:honak/features/chat/presentation/widgets/report_conversation_sheet.dart';
import 'package:honak/features/chat/presentation/widgets/message_bubble.dart';
import 'package:honak/features/chat/presentation/widgets/message_input.dart';
import 'package:honak/features/chat/presentation/widgets/modification_card.dart';
import 'package:honak/features/chat/presentation/widgets/power_chat_menu.dart';
import 'package:honak/features/chat/presentation/widgets/product_card_message.dart';
import 'package:honak/features/chat/presentation/widgets/quote_builder_sheet.dart';
import 'package:honak/shared/entities/selected_item.dart';
import 'package:honak/shared/widgets/item_selection/item_picker_sheet.dart';
import 'package:honak/features/chat/presentation/widgets/quote_card_message.dart';
import 'package:honak/features/chat/presentation/widgets/system_message.dart';
import 'package:honak/shared/providers/app_mode_provider.dart';
import 'package:honak/shared/providers/business_page_provider.dart';
import 'package:honak/features/stories/presentation/utils/story_launcher.dart';
import 'package:honak/shared/widgets/button.dart';
import 'package:honak/shared/widgets/story_ring_avatar.dart';

part 'detail_page_actions.dart';
part 'detail_page_message_list.dart';

class ChatDetailPage extends ConsumerStatefulWidget {
  final Conversation conversation;

  const ChatDetailPage({super.key, required this.conversation});

  @override
  ConsumerState<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends ConsumerState<ChatDetailPage>
    with _DetailPageActions {
  final _scrollController = ScrollController();

  @override
  Conversation get _conv => widget.conversation;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync =
        ref.watch(conversationMessagesProvider(_conv.id));
    final localMsgs =
        ref.watch(localMessagesProvider)[_conv.id] ?? const [];

    final mode = ref.watch(appModeProvider).valueOrNull;
    final isBusinessMode = mode == AppMode.business;
    final bizCtx = ref.watch(businessContextProvider);
    final showZap = isBusinessMode &&
        bizCtx != null &&
        hasPowerChatActions(bizCtx.archetype);

    final selectedIds = ref.watch(selectedMessagesProvider);
    final selectionPurpose = ref.watch(selectionPurposeProvider);
    final isSelectionMode =
        selectionPurpose != null || selectedIds.isNotEmpty;
    final isReportSelection = selectionPurpose == 'report';
    final editingMsg = ref.watch(editingMessageProvider);
    final undoableMsg = ref.watch(undoableMessageProvider);

    return Scaffold(
      appBar: isSelectionMode
          ? _buildSelectionAppBar(
              context, selectedIds.length, isReportSelection)
          : _buildAppBar(context),
      body: Column(
        children: [
          if (_conv.requestId != null && _isActiveRequest(_conv))
            _RequestBanner(
              conversation: _conv,
              isBusinessMode: isBusinessMode,
            ),
          Expanded(
            child: messagesAsync.when(
              loading: () => const ChatDetailSkeleton(),
              error: (error, _) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'حدث خطأ في تحميل الرسائل',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Button(
                      onPressed: () => ref.invalidate(
                        conversationMessagesProvider(_conv.id),
                      ),
                      label: 'إعادة المحاولة',
                      variant: Variant.text,
                    ),
                  ],
                ),
              ),
              data: (messages) => _MessageList(
                messages: [...localMsgs, ...messages],
                scrollController: _scrollController,
                isBusinessMode: isBusinessMode,
                ref: ref,
                selectedIds: selectedIds,
                isSelectionMode: isSelectionMode,
                onLongPress: (message, isMine) {
                  showMessageActionsMenu(
                    context,
                    message,
                    isMine,
                    ref,
                    onReport: () =>
                        _enterReportSelectionMode(message.id),
                  );
                },
                onTapInSelectionMode: (messageId) {
                  final notifier =
                      ref.read(selectedMessagesProvider.notifier);
                  final current = notifier.state;
                  if (current.contains(messageId)) {
                    notifier.state = current.difference({messageId});
                  } else {
                    notifier.state = {...current, messageId};
                  }
                },
              ),
            ),
          ),
          if (undoableMsg != null)
            _UndoBanner(
              messageType: undoableMsg.type,
              onUndo: _undoLastAction,
            ),
          if (isReportSelection)
            _ReportSelectionFooter(
              selectedCount: selectedIds.length,
              onContinue: _handleReportContinue,
            )
          else
            MessageInput(
              onSend: _handleSend,
              isBusinessMode: isBusinessMode,
              onZapTap: showZap ? () => _showPowerMenu(context) : null,
              editingMessage: editingMsg,
              onCancelEdit: _cancelEdit,
            ),
        ],
      ),
    );
  }

  static const _activeStatuses = {
    'pending',
    'confirmed',
    'in_progress',
    'quoted',
  };

  bool _isActiveRequest(Conversation conv) {
    final status = conv.requestStatus ?? '';
    return _activeStatuses.contains(status);
  }

  PreferredSizeWidget _buildSelectionAppBar(
    BuildContext context,
    int count,
    bool isReport,
  ) {
    if (isReport) {
      return AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.flag_rounded,
                  size: 13, color: Colors.red.shade500),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'اختر الرسائل',
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: _clearSelection,
            child: Container(
              width: 32,
              height: 32,
              margin:
                  const EdgeInsetsDirectional.only(end: AppSpacing.md),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: 14,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.lg,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  count > 0
                      ? '$count رسالة محددة'
                      : 'اختر رسالة أو أكثر',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Select all selectable messages
                    final messages = ref
                        .read(conversationMessagesProvider(_conv.id))
                        .valueOrNull;
                    if (messages == null) return;
                    final selectable = messages
                        .where((m) =>
                            m.type == 'text' || m.type == 'image')
                        .map((m) => m.id)
                        .toSet();
                    final notifier =
                        ref.read(selectedMessagesProvider.notifier);
                    if (notifier.state.length == selectable.length) {
                      notifier.state = {};
                    } else {
                      notifier.state = selectable;
                    }
                  },
                  child: Text(
                    'تحديد الكل',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Default delete selection bar
    return AppBar(
      leading: Button(
        onPressed: _clearSelection,
        icon: ButtonIcon(Icons.close),
        variant: Variant.text,
        size: ButtonSize.small,
      ),
      title: Text('$count محدد'),
      centerTitle: true,
      actions: [
        Button(
          onPressed: _deleteSelectedForMe,
          icon: ButtonIcon(Icons.delete_outline, color: AppColors.error),
          variant: Variant.text,
          size: ButtonSize.small,
        ),
      ],
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final mode = ref.watch(appModeProvider).valueOrNull;
    final isBiz = mode == AppMode.business;
    final title = _conv.displayName(isBusinessMode: isBiz);
    final avatarUrl = _conv.displayAvatar(isBusinessMode: isBiz);

    return AppBar(
      automaticallyImplyLeading: false,
      title: GestureDetector(
        onTap: !isBiz && _conv.pageHandle != null
            ? () => context.push(Routes.pagePath(_conv.pageHandle!))
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStoryAvatar(context, avatarUrl: avatarUrl, isBiz: isBiz),
            const SizedBox(width: AppSpacing.sm),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (_conv.requestId != null)
                    Text(
                      'طلب #${_conv.requestId}',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.primary,
                        fontSize: 11,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      centerTitle: true,
      actions: [
        PopupMenuButton<String>(
          icon: Icon(
            Icons.more_vert,
            size: 18,
            color: context.colorScheme.onSurfaceVariant,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          offset: const Offset(0, 40),
          onSelected: (value) {
            if (value == 'report') _handleReportFromMenu();
          },
          itemBuilder: (_) => [
            PopupMenuItem(
              value: 'report',
              child: Row(
                children: [
                  Icon(Icons.flag_outlined,
                      size: 14, color: Colors.red.shade400),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'الإبلاغ عن المحادثة',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red.shade500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Button(
          onPressed: () => Navigator.pop(context),
          icon: ButtonIcon(Icons.arrow_forward_ios, size: 20),
          variant: Variant.text,
          size: ButtonSize.small,
        ),
      ],
    );
  }

  Widget _buildStoryAvatar(
    BuildContext context, {
    String? avatarUrl,
    bool isBiz = false,
  }) {
    final title = _conv.displayName(isBusinessMode: isBiz);
    // Stories belong to business pages, not customers
    final showStories = !isBiz && _conv.hasActiveStory;

    return StoryRingAvatar(
      imageUrl: avatarUrl ?? _conv.pageAvatar,
      name: title,
      radius: 16,
      hasStories: showStories,
      onTap: showStories
          ? () => openStoryViewer(context, ref, pageId: _conv.pageId)
          : null,
    );
  }
}
