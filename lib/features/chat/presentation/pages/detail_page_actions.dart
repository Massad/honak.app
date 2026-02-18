part of 'detail_page.dart';

/// Mixin containing power-menu openers, message send handlers, undo logic,
/// selection/report actions, and local-message injection for [ChatDetailPage].
mixin _DetailPageActions on ConsumerState<ChatDetailPage> {
  // Provided by _ChatDetailPageState
  Conversation get _conv;

  void _handleSend(String text) {
    _clearUndoable();

    final editingMsg = ref.read(editingMessageProvider);
    if (editingMsg != null) {
      // Apply edit locally
      final edited = ref.read(editedMessagesProvider.notifier);
      edited.state = {...edited.state, editingMsg.id: text};
      ref.read(editingMessageProvider.notifier).state = null;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تم تعديل الرسالة')));
      return;
    }
    // Mock send — also inject a local text message so it appears immediately.
    _addLocalMessage(
      Message(
        id: 'msg_local_${DateTime.now().millisecondsSinceEpoch}',
        conversationId: _conv.id,
        type: 'text',
        content: text,
        isFromBusiness:
            ref.read(appModeProvider).valueOrNull == AppMode.business,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      ),
    );
  }

  void _cancelEdit() {
    ref.read(editingMessageProvider.notifier).state = null;
  }

  // ── Power menu & picker openers ────────────────────────────

  void _showPowerMenu(BuildContext context) {
    final bizCtx = ref.read(businessContextProvider);
    if (bizCtx == null) return;
    final branches = ref.read(branchProvider).valueOrNull;
    final hasLocation = branches == null
        ? true
        : branches.any((branch) => branch.active);

    showAppSheet(
      context,
      builder: (_) => PowerChatMenu(
        archetype: bizCtx.archetype,
        hasLocation: hasLocation,
        onSendProduct: () => _openProductPicker(context, bizCtx),
        onSendAvailability: () => _openAvailabilityPicker(context),
        onSendQuote: () => _openQuoteBuilder(context),
        onAskInfo: () => _openAskInfo(context, bizCtx),
        onSendUpdate: () => _openUpdateBuilder(context, bizCtx),
        onSendPortfolio: () => _openPortfolioPicker(context, bizCtx),
        onSendLocation: () => _openLocationPicker(context),
        onSendReceipt: () => _openReceiptBuilder(context),
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

  void _openProductPicker(BuildContext context, BusinessContext bizCtx) async {
    final title = _pickerTitles[bizCtx.archetype] ?? 'اختر منتج';

    List<Map<String, dynamic>> teamMembers = const [];
    if (bizCtx.archetype == Archetype.serviceBooking) {
      try {
        teamMembers = await ref.read(
          pageTeamMembersProvider(bizCtx.page.id).future,
        );
      } catch (_) {
        // Proceed without team filter if fetch fails
      }
    }

    if (!context.mounted) return;
    if (bizCtx.archetype == Archetype.serviceBooking) {
      showAppSheet(
        context,
        builder: (_) => ItemPickerSheet(
          pageSlug: bizCtx.page.slug,
          title: title,
          wizardMode: PickerWizardMode.book,
          teamMembers: teamMembers,
          pageName: bizCtx.page.name,
          onBookingConfirmed: _handleSendServiceSuggestion,
        ),
      );
      return;
    }

    showAppSheet(
      context,
      builder: (_) => ItemPickerSheet(
        pageSlug: bizCtx.page.slug,
        title: title,
        teamMembers: teamMembers,
        onItemSelected: _handleSendSelectedItem,
      ),
    );
  }

  void _openAvailabilityPicker(BuildContext context) {
    showAppSheet(
      context,
      builder: (_) =>
          AvailabilityPickerSheet(onSend: _handleSendAvailabilityCard),
    );
  }

  void _openQuoteBuilder(BuildContext context) {
    showAppSheet(
      context,
      builder: (_) => QuoteBuilderSheet(onSend: _handleSendQuoteCard),
    );
  }

  void _openAskInfo(BuildContext context, BusinessContext bizCtx) {
    showAppSheet(
      context,
      builder: (_) => AskInfoSheet(
        pageId: bizCtx.page.id,
        businessTypeId: bizCtx.config?.id,
        onSend: _handleSendInfoRequest,
      ),
    );
  }

  void _openUpdateBuilder(BuildContext context, BusinessContext bizCtx) {
    showAppSheet(
      context,
      builder: (_) => UpdateBuilderSheet(
        archetype: bizCtx.archetype,
        onSend: _handleSendUpdateCard,
      ),
    );
  }

  void _openPortfolioPicker(BuildContext context, BusinessContext bizCtx) {
    showAppSheet(
      context,
      builder: (_) => PortfolioPickerSheet(
        pageHandle: bizCtx.page.slug,
        onSend: _handleSendPortfolioCard,
      ),
    );
  }

  void _openLocationPicker(BuildContext context) {
    showAppSheet(
      context,
      builder: (_) => LocationPickerSheet(onSend: _handleSendLocationCard),
    );
  }

  void _openReceiptBuilder(BuildContext context) {
    showAppSheet(
      context,
      builder: (_) => ReceiptBuilderSheet(onSend: _handleSendReceiptCard),
    );
  }

  // ── Send handlers ──────────────────────────────────────────

  void _handleSendSelectedItem(SelectedItem item) {
    final data = ProductCardData.fromSelectedItem(item);
    _addLocalMessage(
      Message(
        id: 'msg_local_${DateTime.now().millisecondsSinceEpoch}',
        conversationId: _conv.id,
        type: 'product_card',
        content: '',
        isFromBusiness: true,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        metadata: {
          'product': {
            'id': data.id,
            'name': data.name,
            if (data.image != null) 'image': data.image,
            'price_cents': data.priceCents,
            if (data.description != null) 'description': data.description,
            if (data.category != null) 'category': data.category,
            if (data.duration != null) 'duration': data.duration,
            if (data.optionsSummary != null)
              'options_summary': data.optionsSummary,
            if (data.quantity != null) 'quantity': data.quantity,
            if (data.unitPriceCents != null)
              'unit_price_cents': data.unitPriceCents,
            if (data.totalPriceCents != null)
              'total_price_cents': data.totalPriceCents,
          },
          'status': 'sent',
        },
      ),
    );
  }

  void _handleSendAvailabilityCard(
    List<AvailabilitySlot> slots,
    String? serviceName,
  ) {
    _addLocalMessage(
      Message(
        id: 'msg_local_${DateTime.now().millisecondsSinceEpoch}',
        conversationId: _conv.id,
        type: 'availability_card',
        content: '',
        isFromBusiness: true,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        metadata: {
          'slots': slots
              .map(
                (s) => {
                  'id': s.id,
                  'date': s.date,
                  'time': s.time,
                  if (s.teamMember != null) 'team_member': s.teamMember,
                },
              )
              .toList(),
          if (serviceName != null) 'service_name': serviceName,
          'status': 'pending',
        },
      ),
    );
  }

  void _handleSendServiceSuggestion(BookingResult booking) {
    final date = booking.date;
    final dateLabel = date == null ? '' : _formatBookingDate(date);
    _addLocalMessage(
      Message(
        id: 'msg_local_${DateTime.now().millisecondsSinceEpoch}',
        conversationId: _conv.id,
        type: 'service_suggestion',
        content: '',
        isFromBusiness: true,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        metadata: {
          'suggestion': {
            'id': 'svc_suggestion_${DateTime.now().millisecondsSinceEpoch}',
            'service': {
              'id': booking.serviceId,
              'name': booking.serviceName,
              'price_cents': booking.priceCents,
              'duration_minutes': booking.durationMinutes,
            },
            if (booking.memberName != null)
              'team_member': {
                if (booking.memberId != null) 'id': booking.memberId,
                'name': booking.memberName,
              },
            'date': dateLabel,
            'time': booking.time ?? '',
          },
          'status': 'pending',
        },
      ),
    );
  }

  void _handleSendQuoteCard(QuoteData quote) {
    _addLocalMessage(
      Message(
        id: 'msg_local_${DateTime.now().millisecondsSinceEpoch}',
        conversationId: _conv.id,
        type: 'quote_card',
        content: '',
        isFromBusiness: true,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        metadata: {
          'quote': {
            'id': quote.id,
            'items': quote.items
                .map(
                  (i) => {
                    'description': i.description,
                    'quantity': i.quantity,
                    'unit_price': i.unitPriceCents,
                  },
                )
                .toList(),
            'subtotal': quote.subtotalCents,
            if (quote.discountCents != null) 'discount': quote.discountCents,
            'total': quote.totalCents,
            if (quote.validDays != null) 'valid_days': quote.validDays,
            if (quote.notes != null) 'notes': quote.notes,
          },
          'status': 'pending',
        },
      ),
    );
  }

  void _handleSendInfoRequest(AskInfoResult result) {
    final data = InfoRequestData.fromAskInfoResult(result);
    _addLocalMessage(
      Message(
        id: 'msg_local_${DateTime.now().millisecondsSinceEpoch}',
        conversationId: _conv.id,
        type: 'info_request',
        content: data.question,
        isFromBusiness: true,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        metadata: {
          'question': data.question,
          if (result.note != null) 'note': result.note,
          'info_items': data.items
              .map(
                (item) => {
                  'label': item.label,
                  if (item.description != null) 'description': item.description,
                  'type': item.type,
                  if (item.options != null) 'options': item.options,
                },
              )
              .toList(),
        },
      ),
    );
  }

  void _handleSendUpdateCard(UpdateCardData data) {
    _addLocalMessage(
      Message(
        id: 'msg_local_${DateTime.now().millisecondsSinceEpoch}',
        conversationId: _conv.id,
        type: 'update_card',
        content: '',
        isFromBusiness: true,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        metadata: {
          'title': data.title,
          'body': data.body,
          'status': data.status,
        },
      ),
    );
  }

  void _handleSendPortfolioCard(PortfolioCardData data) {
    _addLocalMessage(
      Message(
        id: 'msg_local_${DateTime.now().millisecondsSinceEpoch}',
        conversationId: _conv.id,
        type: 'portfolio_card',
        content: '',
        isFromBusiness: true,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        metadata: {
          'portfolio': {
            if (data.id != null) 'id': data.id,
            'title': data.title,
            if (data.subtitle != null) 'subtitle': data.subtitle,
            if (data.imageUrl != null) 'image_url': data.imageUrl,
            if (data.images.isNotEmpty) 'images': data.images,
            if (data.caption != null) 'caption': data.caption,
            if (data.category != null) 'category': data.category,
            if (data.ctaLabel != null) 'cta_label': data.ctaLabel,
          },
        },
      ),
    );
  }

  void _handleSendLocationCard(LocationCardData data) {
    _addLocalMessage(
      Message(
        id: 'msg_local_${DateTime.now().millisecondsSinceEpoch}',
        conversationId: _conv.id,
        type: 'location_card',
        content: '',
        isFromBusiness: true,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        metadata: {
          'location': {
            'title': data.title,
            'address': data.address,
            if (data.phone != null) 'phone': data.phone,
            if (data.hours != null) 'hours': data.hours,
            if (data.mapUrl != null) 'map_url': data.mapUrl,
            if (data.mode != null) 'mode': data.mode,
            if (data.branchId != null) 'branch_id': data.branchId,
            if (data.latitude != null) 'latitude': data.latitude,
            if (data.longitude != null) 'longitude': data.longitude,
          },
        },
      ),
    );
  }

  void _handleSendReceiptCard(ReceiptCardData data) {
    _addLocalMessage(
      Message(
        id: 'msg_local_${DateTime.now().millisecondsSinceEpoch}',
        conversationId: _conv.id,
        type: 'receipt_card',
        content: '',
        isFromBusiness: true,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        metadata: {
          'receipt': {
            'title': data.title,
            'items': data.items
                .map(
                  (item) => {
                    'label': item.label,
                    'quantity': item.quantity,
                    'unit_price_cents': item.unitPriceCents,
                  },
                )
                .toList(),
            'subtotal_cents': data.subtotalCents,
            'discount_cents': data.discountCents,
            'delivery_fee_cents': data.deliveryFeeCents,
            'total_cents': data.totalCents,
            'payment_method': data.paymentMethod,
            'status': data.status,
          },
        },
      ),
    );
  }

  // ── Local message injection & undo ─────────────────────────

  /// Whether [type] is an action card that supports undo.
  static const _undoableTypes = {
    'product_card',
    'availability_card',
    'quote_card',
    'service_suggestion',
    'info_request',
    'update_card',
    'portfolio_card',
    'location_card',
    'receipt_card',
  };

  void _addLocalMessage(Message message) {
    final notifier = ref.read(localMessagesProvider.notifier);
    final current = notifier.state;
    final convMessages = current[_conv.id] ?? [];
    notifier.state = {
      ...current,
      _conv.id: [message, ...convMessages],
    };

    // Start undo window for action cards.
    if (_undoableTypes.contains(message.type)) {
      ref.read(undoableMessageProvider.notifier).state = message;
    }
  }

  void _clearUndoable() {
    ref.read(undoableMessageProvider.notifier).state = null;
  }

  void _undoLastAction() {
    final msg = ref.read(undoableMessageProvider);
    if (msg == null) return;

    // Remove from local messages.
    final notifier = ref.read(localMessagesProvider.notifier);
    final current = notifier.state;
    final convMessages = current[_conv.id] ?? [];
    notifier.state = {
      ...current,
      _conv.id: convMessages.where((m) => m.id != msg.id).toList(),
    };
    _clearUndoable();
  }

  String _formatBookingDate(DateTime date) {
    const dayNames = [
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
      'الأحد',
    ];
    const months = [
      'كانون الثاني',
      'شباط',
      'آذار',
      'نيسان',
      'أيار',
      'حزيران',
      'تموز',
      'آب',
      'أيلول',
      'تشرين الأول',
      'تشرين الثاني',
      'كانون الأول',
    ];
    return '${dayNames[date.weekday - 1]} ${date.day} ${months[date.month - 1]}';
  }

  // ── Selection & delete ─────────────────────────────────────

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

  // ── Report flow ────────────────────────────────────────────

  void _enterReportSelectionMode([String? initialMessageId]) {
    ref.read(selectionPurposeProvider.notifier).state = 'report';
    ref.read(selectedMessagesProvider.notifier).state = initialMessageId != null
        ? {initialMessageId}
        : {};
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
}
