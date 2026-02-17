import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/l10n/arb/app_localizations.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/order_management/presentation/providers/provider.dart';
import 'package:honak/features/business/order_management/presentation/widgets/alternative_sheet.dart';
import 'package:honak/features/business/order_management/presentation/widgets/decline_sheet.dart';
import 'package:honak/features/business/order_management/presentation/widgets/request_actions.dart';
import 'package:honak/features/business/order_management/presentation/widgets/request_detail_parts.dart';
import 'package:honak/features/business/order_management/presentation/widgets/request_detail_sections.dart';
import 'package:honak/features/business/shared/domain/entities/entities.dart';
import 'package:honak/features/chat/domain/entities/conversation.dart';
import 'package:honak/shared/providers/business_page_provider.dart';
import 'package:honak/shared/widgets/app_screen.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/button.dart';
import 'package:honak/shared/widgets/receipt_sheet.dart';

/// Localized labels for request types.
Map<String, String> _typeLabels(AppLocalizations l10n) => {
  'order': l10n.bizReqTypeOrder,
  'booking': l10n.bizReqTypeBooking,
  'inspection': l10n.bizReqTypeInspection,
  'inquiry': l10n.bizReqTypeInquiry,
  'reservation': l10n.bizReqTypeReservation,
};

class RequestDetailPage extends ConsumerStatefulWidget {
  final BizRequest request;

  const RequestDetailPage({super.key, required this.request});

  @override
  ConsumerState<RequestDetailPage> createState() => _RequestDetailPageState();
}

class _RequestDetailPageState extends ConsumerState<RequestDetailPage> {
  late BizRequest _request;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _request = widget.request;
  }

  Future<void> _handleAccept() async {
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(requestRepositoryProvider);
      await repo.acceptRequest(_request.id);
      if (mounted) {
        setState(() {
          _request = _request.copyWith(status: 'accepted');
          _isLoading = false;
        });
        context.showSnackBar(context.l10n.bizReqAccepted);
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar(context.l10n.bizReqError, isError: true);
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleDecline() async {
    final result = await showAppSheet<bool>(
      context,
      builder: (_) => DeclineSheet(requestId: _request.id),
    );
    if (result == true && mounted) {
      setState(() {
        _request = _request.copyWith(status: 'declined');
      });
      context.showSnackBar(context.l10n.bizReqDeclined);
    }
  }

  Future<void> _handleAlternative() async {
    final result = await showAppSheet<bool>(
      context,
      builder: (_) => AlternativeSheet(requestId: _request.id),
    );
    if (result == true && mounted) {
      context.showSnackBar(context.l10n.bizReqSuggestionSent);
    }
  }

  Future<void> _handleUpdateStatus(String newStatus) async {
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(requestRepositoryProvider);
      await repo.updateStatus(_request.id, newStatus);
      if (mounted) {
        setState(() {
          _request = _request.copyWith(status: newStatus);
          _isLoading = false;
        });
        final l10n = context.l10n;
        final label = requestStatusLabel(newStatus, l10n);
        context.showSnackBar(l10n.bizReqStatusUpdated(label));
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar(context.l10n.bizReqError, isError: true);
        setState(() => _isLoading = false);
      }
    }
  }

  void _showReceipt() {
    final bizCtx = ref.read(businessContextProvider);
    final dt = DateTime.fromMillisecondsSinceEpoch(_request.createdAt * 1000);
    final dateStr = DateFormat('yyyy/MM/dd', 'ar').format(dt);
    final timeStr = DateFormat('h:mm a', 'ar').format(dt);

    showReceiptSheet(
      context,
      businessName: bizCtx?.page.name ?? '',
      customerName: _request.customer.name,
      customerPhone: _request.customer.phone,
      referenceNumber: _request.id,
      items: _request.items
          .map(
            (i) => ReceiptLineItem(
              name: i.name,
              quantity: i.quantity,
              priceCents: i.price?.cents ?? 0,
            ),
          )
          .toList(),
      totalCents: _request.total?.cents ?? 0,
      statusLabel: requestStatusLabel(_request.status, context.l10n),
      date: dateStr,
      time: timeStr,
      notes: _request.note,
    );
  }

  void _openChat() {
    final bizCtx = ref.read(businessContextProvider);
    final conversation = Conversation(
      id:
          _request.conversationId ??
          'conv_${_request.customer.id}_${_request.id}',
      pageId: bizCtx?.page.id ?? '',
      pageName: bizCtx?.page.name ?? '',
      pageAvatar: bizCtx?.page.avatarUrl,
      pageHandle: bizCtx?.page.slug,
      customerId: _request.customer.id,
      customerName: _request.customer.name,
      customerAvatar: _request.customer.avatarUrl,
      requestId: _request.id,
      requestStatus: _request.status,
      lastMessage: null,
      lastMessageAt: _request.createdAt,
      lastMessageFrom: null,
      unreadCount: 0,
      status: 'active',
      type: 'request',
    );
    context.push(Routes.chatDetailPath(conversation.id), extra: conversation);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final labels = _typeLabels(l10n);
    final typeLabel = labels[_request.type] ?? labels['order']!;
    final dt = DateTime.fromMillisecondsSinceEpoch(_request.createdAt * 1000);
    final createdStr = DateFormat('yyyy/MM/dd — h:mm a', 'ar').format(dt);

    return DefaultTabController(
      length: 2,
      child: AppScreen(
        title: Text(l10n.bizReqDetailTitle),
        showBack: true,
        backgroundColor: const Color(0xFFF5F5F5),
        body: Column(
          children: [
            // Header: type + ID + timestamp
            Container(
              width: double.infinity,
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Text(
                    '$typeLabel #${_request.id}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    createdStr,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),

            // Tab bar
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
              ),
              child: TabBar(
                labelColor: Color(0xFF1A73E8),
                unselectedLabelColor: Color(0xFF9CA3AF),
                labelStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: TextStyle(fontSize: 12),
                indicatorColor: Color(0xFF1A73E8),
                indicatorWeight: 2,
                tabs: [
                  Tab(text: l10n.bizReqSummaryTab),
                  Tab(text: l10n.bizReqLogTab),
                ],
              ),
            ),

            // Tab content
            Expanded(
              child: TabBarView(
                children: [
                  _SummaryTab(
                    request: _request,
                    isLoading: _isLoading,
                    onAccept: _handleAccept,
                    onDecline: _handleDecline,
                    onAlternative: _handleAlternative,
                    onUpdateStatus: _handleUpdateStatus,
                    onReceipt:
                        (_request.status == 'completed' ||
                            _request.status == 'delivered')
                        ? _showReceipt
                        : null,
                    onChat:
                        (_request.status == 'completed' ||
                            _request.status == 'delivered')
                        ? _openChat
                        : null,
                    onOpenChat: _openChat,
                  ),
                  RequestActivityLogTab(request: _request),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Summary Tab
// ═══════════════════════════════════════════════════════════════

class _SummaryTab extends StatelessWidget {
  final BizRequest request;
  final bool isLoading;
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final VoidCallback onAlternative;
  final ValueChanged<String> onUpdateStatus;
  final VoidCallback? onReceipt;
  final VoidCallback? onChat;
  final VoidCallback onOpenChat;

  const _SummaryTab({
    required this.request,
    required this.isLoading,
    required this.onAccept,
    required this.onDecline,
    required this.onAlternative,
    required this.onUpdateStatus,
    this.onReceipt,
    this.onChat,
    required this.onOpenChat,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      children: [
        // Status context banner
        RequestStatusContextBanner(status: request.status),

        RequestCustomerHeader(
          customer: request.customer,
          createdAt: request.createdAt,
        ),
        const SizedBox(height: AppSpacing.sm),
        _MessageCustomerButton(request: request, onOpenChat: onOpenChat),
        const SizedBox(height: AppSpacing.lg),
        RequestStatusBadge(status: request.status),
        const SizedBox(height: AppSpacing.lg),
        RequestItemsList(items: request.items, itemsCount: request.itemsCount),
        const SizedBox(height: AppSpacing.lg),
        RequestTotalRow(total: request.total),
        if (request.note != null && request.note!.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          RequestNoteSection(note: request.note!),
        ],
        if (request.status == 'declined' && request.declineReason != null) ...[
          const SizedBox(height: AppSpacing.lg),
          RequestDeclineReasonSection(reason: request.declineReason!),
        ],
        const SizedBox(height: AppSpacing.xxl),
        if (request.status == 'pending') ...[
          Button(
            onPressed: onAlternative,
            label: context.l10n.bizReqSuggestAlternative,
            icon: const ButtonIcon(Icons.swap_horiz),
            variant: Variant.outlined,
            size: ButtonSize.large,
            expand: true,
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        RequestActions(
          status: request.status,
          isLoading: isLoading,
          onAccept: onAccept,
          onDecline: onDecline,
          onUpdateStatus: onUpdateStatus,
          onReceipt: onReceipt,
          onChat: onChat,
        ),
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Message Customer Button (preserved from original)
// ═══════════════════════════════════════════════════════════════

class _MessageCustomerButton extends ConsumerWidget {
  final BizRequest request;
  final VoidCallback onOpenChat;

  const _MessageCustomerButton({
    required this.request,
    required this.onOpenChat,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Button(
      onPressed: onOpenChat,
      label: context.l10n.bizReqMessageCustomer(request.customer.name),
      icon: const ButtonIcon(Icons.chat_outlined),
      variant: Variant.outlined,
      size: ButtonSize.large,
      expand: true,
    );
  }
}
