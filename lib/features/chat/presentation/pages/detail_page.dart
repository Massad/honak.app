import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/config/archetype.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/conversation.dart';
import 'package:honak/features/chat/domain/entities/message.dart';
import 'package:honak/features/chat/domain/entities/power_chat_types.dart';
import 'package:honak/features/chat/presentation/providers/chat_provider.dart';
import 'package:honak/features/chat/presentation/providers/message_action_provider.dart';
import 'package:honak/features/chat/presentation/widgets/alternative_card.dart';
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
import 'package:honak/shared/widgets/story_ring_avatar.dart';

class ChatDetailPage extends ConsumerStatefulWidget {
  final Conversation conversation;

  const ChatDetailPage({super.key, required this.conversation});

  @override
  ConsumerState<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends ConsumerState<ChatDetailPage> {
  final _scrollController = ScrollController();

  Conversation get _conv => widget.conversation;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSend(String text) {
    final editingMsg = ref.read(editingMessageProvider);
    if (editingMsg != null) {
      // Apply edit locally
      final edited = ref.read(editedMessagesProvider.notifier);
      edited.state = {...edited.state, editingMsg.id: text};
      ref.read(editingMessageProvider.notifier).state = null;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تعديل الرسالة')),
      );
      return;
    }
    // Mock send — in a real app this calls the repository and
    // updates the messages list via provider invalidation.
    ref.invalidate(conversationMessagesProvider(_conv.id));
  }

  void _cancelEdit() {
    ref.read(editingMessageProvider.notifier).state = null;
  }

  void _showPowerMenu(BuildContext context) {
    final bizCtx = ref.read(businessContextProvider);
    if (bizCtx == null) return;

    showAppSheet(
      context,
      builder: (_) => PowerChatMenu(
        archetype: bizCtx.archetype,
        onSendProduct: () => _openProductPicker(context, bizCtx),
        onSendAvailability: () => _openAvailabilityPicker(context),
        onSendQuote: () => _openQuoteBuilder(context),
        onClose: () => Navigator.pop(context),
      ),
    );
  }

  static const _pickerTitles = {
    Archetype.catalogOrder: 'اختر منتج',
    Archetype.menuOrder: 'اختر صنف',
    Archetype.serviceBooking: 'اختر خدمة',
    Archetype.quoteRequest: 'اختر خدمة',
    Archetype.portfolioInquiry: 'اختر عمل',
    Archetype.reservation: 'اختر خيار',
  };

  void _openProductPicker(BuildContext context, BusinessContext bizCtx) {
    final title =
        _pickerTitles[bizCtx.archetype] ?? 'اختر منتج';
    showAppSheet(
      context,
      builder: (_) => ItemPickerSheet(
        pageSlug: bizCtx.page.slug,
        title: title,
        onItemSelected: _handleSendSelectedItem,
      ),
    );
  }

  void _openAvailabilityPicker(BuildContext context) {
    showAppSheet(
      context,
      builder: (_) => AvailabilityPickerSheet(
        onSend: _handleSendAvailabilityCard,
      ),
    );
  }

  void _openQuoteBuilder(BuildContext context) {
    showAppSheet(
      context,
      builder: (_) => QuoteBuilderSheet(
        onSend: _handleSendQuoteCard,
      ),
    );
  }

  void _handleSendSelectedItem(SelectedItem item) {
    // Convert to ProductCardData for chat message serialization.
    // In a real app this would POST to the backend.
    final _ = ProductCardData.fromSelectedItem(item);
    ref.invalidate(conversationMessagesProvider(_conv.id));
  }

  void _handleSendAvailabilityCard(
    List<AvailabilitySlot> slots,
    String? serviceName,
  ) {
    ref.invalidate(conversationMessagesProvider(_conv.id));
  }

  void _handleSendQuoteCard(QuoteData quote) {
    ref.invalidate(conversationMessagesProvider(_conv.id));
  }

  void _clearSelection() {
    ref.read(selectedMessagesProvider.notifier).state = {};
    ref.read(selectionPurposeProvider.notifier).state = null;
  }

  void _deleteSelectedForMe() {
    final selected = ref.read(selectedMessagesProvider);
    final deleted = ref.read(deletedForMeProvider.notifier);
    deleted.state = {...deleted.state, ...selected};
    _clearSelection();
  }

  // ── Report flow ──────────────────────────────────────────────

  void _enterReportSelectionMode([String? initialMessageId]) {
    ref.read(selectionPurposeProvider.notifier).state = 'report';
    ref.read(selectedMessagesProvider.notifier).state =
        initialMessageId != null ? {initialMessageId} : {};
  }

  void _openReportSheet({Set<String> preSelectedIds = const {}}) {
    final mode = ref.read(appModeProvider).valueOrNull;
    final isBiz = mode == AppMode.business;
    final name = _conv.displayName(isBusinessMode: isBiz);

    ReportConversationSheet.show(
      context: context,
      conversationName: name,
      preSelectedIds: preSelectedIds,
      onSubmit: _handleReportSubmit,
      onSelectInChat: () => _enterReportSelectionMode(),
    );
  }

  void _handleReportContinue() {
    final selected = ref.read(selectedMessagesProvider);
    _clearSelection();
    _openReportSheet(preSelectedIds: selected);
  }

  void _handleReportSubmit(ChatReportData report) {
    // In a real app: POST to backend.
    // The sheet auto-dismisses after 2.5s with a success screen.
  }

  void _handleReportFromMenu() {
    _openReportSheet();
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync =
        ref.watch(conversationMessagesProvider(_conv.id));

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
                    TextButton(
                      onPressed: () => ref.invalidate(
                        conversationMessagesProvider(_conv.id),
                      ),
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              ),
              data: (messages) => _MessageList(
                messages: messages,
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
              child: Icon(Icons.flag_rounded, size: 13, color: Colors.red.shade500),
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
              margin: const EdgeInsetsDirectional.only(end: AppSpacing.md),
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
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: _clearSelection,
      ),
      title: Text('$count محدد'),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.delete_outline, color: AppColors.error),
          onPressed: _deleteSelectedForMe,
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
                  Icon(Icons.flag_outlined, size: 14, color: Colors.red.shade400),
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
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios, size: 20),
          onPressed: () => Navigator.pop(context),
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

class _ReportSelectionFooter extends StatelessWidget {
  final int selectedCount;
  final VoidCallback onContinue;

  const _ReportSelectionFooter({
    required this.selectedCount,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = selectedCount > 0;
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          top: BorderSide(color: context.colorScheme.outlineVariant, width: 0.5),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: FilledButton(
            onPressed: enabled ? onContinue : null,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              disabledBackgroundColor:
                  context.colorScheme.surfaceContainerHighest,
              disabledForegroundColor: context.colorScheme.outlineVariant,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('متابعة ($selectedCount)'),
          ),
        ),
      ),
    );
  }
}

class _RequestBanner extends StatelessWidget {
  final Conversation conversation;
  final bool isBusinessMode;

  const _RequestBanner({
    required this.conversation,
    required this.isBusinessMode,
  });

  @override
  Widget build(BuildContext context) {
    final status = conversation.requestStatus ?? '';
    final statusLabel = _statusLabel(status);
    final statusColor = _statusColor(status, context);

    return GestureDetector(
      onTap: () {
        final reqId = conversation.requestId;
        if (reqId == null) return;
        final path = isBusinessMode
            ? Routes.bizOrderDetailPath(reqId)
            : Routes.orderDetailPath(reqId);
        context.push(path);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.md,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F8FF),
          border: Border(
            bottom: BorderSide(color: context.colorScheme.outlineVariant, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.receipt_long_outlined,
              size: 14,
              color: AppColors.primary,
            ),
            const SizedBox(width: 6),
            Text(
              '#${conversation.requestId}',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            if (statusLabel.isNotEmpty) ...[
              const SizedBox(width: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
            const Spacer(),
            Icon(
              Directionality.of(context) == TextDirection.rtl
                  ? Icons.chevron_left
                  : Icons.chevron_right,
              size: 14,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  String _statusLabel(String status) {
    return switch (status) {
      'pending' => 'قيد الانتظار',
      'confirmed' => 'مؤكد',
      'in_progress' => 'قيد التنفيذ',
      'quoted' => 'تم التسعير',
      _ => '',
    };
  }

  Color _statusColor(String status, BuildContext context) {
    return switch (status) {
      'pending' => AppColors.warning,
      'confirmed' => AppColors.primary,
      'in_progress' => AppColors.info,
      'quoted' => AppColors.info,
      _ => context.colorScheme.onSurfaceVariant,
    };
  }
}

class _MessageList extends ConsumerWidget {
  final List<Message> messages;
  final ScrollController scrollController;
  final bool isBusinessMode;
  final WidgetRef ref;
  final Set<String> selectedIds;
  final bool isSelectionMode;
  final void Function(Message message, bool isMine) onLongPress;
  final void Function(String messageId) onTapInSelectionMode;

  const _MessageList({
    required this.messages,
    required this.scrollController,
    this.isBusinessMode = false,
    required this.ref,
    required this.selectedIds,
    this.isSelectionMode = false,
    required this.onLongPress,
    required this.onTapInSelectionMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deletedForMe = ref.watch(deletedForMeProvider);
    final deletedForEveryone = ref.watch(deletedForEveryoneProvider);
    final editedMessages = ref.watch(editedMessagesProvider);

    // Filter out locally-deleted messages
    final visibleMessages =
        messages.where((m) => !deletedForMe.contains(m.id)).toList();

    if (visibleMessages.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.chat_bubble_outline_rounded,
              size: 48,
              color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'لا توجد رسائل بعد',
              style: TextStyle(
                fontSize: 14,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'ابدأ المحادثة الآن',
              style: TextStyle(
                fontSize: 12,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      reverse: true,
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      itemCount: visibleMessages.length,
      itemBuilder: (context, index) {
        final message = visibleMessages[index];
        final isMine = isBusinessMode
            ? message.isFromBusiness
            : !message.isFromBusiness;

        // Check if deleted for everyone
        if (deletedForEveryone.contains(message.id)) {
          return DeletedBubble(isMine: isMine);
        }

        // Check for edited content
        final editedContent = editedMessages[message.id];
        final isEdited = editedContent != null;

        final messageWidget = _buildMessage(
          message,
          isMine,
          displayContent: editedContent,
          isEdited: isEdited,
          isSelected: selectedIds.contains(message.id),
        );

        // Wrap with gesture handling
        final wrapped = GestureDetector(
          onLongPress: () => onLongPress(message, isMine),
          onTap: isSelectionMode
              ? () => onTapInSelectionMode(message.id)
              : null,
          child: isSelectionMode
              ? Row(
                  children: [
                    Checkbox(
                      value: selectedIds.contains(message.id),
                      onChanged: (_) => onTapInSelectionMode(message.id),
                      activeColor: AppColors.primary,
                      visualDensity: VisualDensity.compact,
                    ),
                    Expanded(child: messageWidget),
                  ],
                )
              : messageWidget,
        );

        // Show date header when the next message (older) has a different date
        final showDateHeader = index == visibleMessages.length - 1 ||
            !_isSameDay(
              message.createdAt,
              visibleMessages[index + 1].createdAt,
            );

        if (showDateHeader) {
          return Column(
            children: [
              _DateHeader(timestamp: message.createdAt),
              wrapped,
            ],
          );
        }

        return wrapped;
      },
    );
  }

  Widget _buildMessage(
    Message message,
    bool isMine, {
    String? displayContent,
    bool isEdited = false,
    bool isSelected = false,
  }) {
    return switch (message.type) {
      'text' => MessageBubble(
          message: message,
          isMine: isMine,
          displayContent: displayContent,
          isEdited: isEdited,
          isSelected: isSelected,
        ),
      'image' => ImageMessage(message: message, isMine: isMine),
      'system' => SystemMessage(message: message),
      'alternative_suggestion' => AlternativeCard(message: message),
      'modification_request' => ModificationCard(message: message),
      'info_request' => InfoRequestCard(message: message),
      'product_card' => ProductCardMessage(
          message: message,
          isBusinessMode: isBusinessMode,
        ),
      'availability_card' => AvailabilityCardMessage(
          message: message,
          isBusinessMode: isBusinessMode,
        ),
      'quote_card' => QuoteCardMessage(
          message: message,
          isBusinessMode: isBusinessMode,
        ),
      _ => MessageBubble(
          message: message,
          isMine: isMine,
          displayContent: displayContent,
          isEdited: isEdited,
          isSelected: isSelected,
        ),
    };
  }

  bool _isSameDay(int ts1, int ts2) {
    final d1 = DateTime.fromMillisecondsSinceEpoch(ts1 * 1000);
    final d2 = DateTime.fromMillisecondsSinceEpoch(ts2 * 1000);
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}

class _DateHeader extends StatelessWidget {
  final int timestamp;

  const _DateHeader({required this.timestamp});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    String label;
    if (date.isAfter(today)) {
      label = 'اليوم';
    } else if (date.isAfter(yesterday)) {
      label = 'أمس';
    } else {
      const dayNames = [
        'الاثنين',
        'الثلاثاء',
        'الأربعاء',
        'الخميس',
        'الجمعة',
        'السبت',
        'الأحد',
      ];
      label = dayNames[date.weekday - 1];
    }

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: AppSpacing.md),
      child: Center(
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: context.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
