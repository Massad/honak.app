part of 'detail_page.dart';

// ═══════════════════════════════════════════════════════════════
// Report Selection Footer
// ═══════════════════════════════════════════════════════════════

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
          child: Button(
            onPressed: enabled ? onContinue : null,
            label: 'متابعة ($selectedCount)',
            size: ButtonSize.large,
            expand: true,
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Undo Banner
// ═══════════════════════════════════════════════════════════════

class _UndoBanner extends StatelessWidget {
  final String messageType;
  final VoidCallback onUndo;

  const _UndoBanner({required this.messageType, required this.onUndo});

  String get _label => switch (messageType) {
        'product_card' => 'تم إرسال المنتج',
        'availability_card' => 'تم إرسال الأوقات',
        'quote_card' => 'تم إرسال عرض السعر',
        'info_request' => 'تم إرسال طلب المعلومات',
        _ => 'تم الإرسال',
      };

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        border: Border(
          top: BorderSide(color: cs.outlineVariant, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 16,
            color: AppColors.success,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              _label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: cs.onSurface,
              ),
            ),
          ),
          GestureDetector(
            onTap: onUndo,
            child: Container(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'تراجع',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.error,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Request Banner
// ═══════════════════════════════════════════════════════════════

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
            bottom: BorderSide(
                color: context.colorScheme.outlineVariant, width: 0.5),
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

// ═══════════════════════════════════════════════════════════════
// Message List
// ═══════════════════════════════════════════════════════════════

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
              color:
                  context.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
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
      'alternative_suggestion' => AlternativeCard(
          message: message,
          isBusinessMode: isBusinessMode,
        ),
      'modification_request' => ModificationCard(
          message: message,
          isBusinessMode: isBusinessMode,
        ),
      'info_request' => InfoRequestCard(
          message: message,
          isBusinessMode: isBusinessMode,
        ),
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

// ═══════════════════════════════════════════════════════════════
// Date Header
// ═══════════════════════════════════════════════════════════════

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
