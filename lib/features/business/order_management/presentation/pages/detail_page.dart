import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/order_management/presentation/providers/provider.dart';
import 'package:honak/features/business/order_management/presentation/widgets/alternative_sheet.dart';
import 'package:honak/features/business/order_management/presentation/widgets/decline_sheet.dart';
import 'package:honak/features/business/order_management/presentation/widgets/request_actions.dart';
import 'package:honak/features/business/order_management/presentation/widgets/request_detail_sections.dart';
import 'package:honak/features/business/shared/domain/entities/entities.dart';
import 'package:honak/features/chat/domain/entities/conversation.dart';
import 'package:honak/shared/providers/business_page_provider.dart';

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
        context.showSnackBar('تم قبول الطلب');
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar('حدث خطأ', isError: true);
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleDecline() async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => DeclineSheet(requestId: _request.id),
    );
    if (result == true && mounted) {
      setState(() {
        _request = _request.copyWith(status: 'declined');
      });
      context.showSnackBar('تم رفض الطلب');
    }
  }

  Future<void> _handleAlternative() async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => AlternativeSheet(requestId: _request.id),
    );
    if (result == true && mounted) {
      context.showSnackBar('تم إرسال الاقتراح');
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
        final label = requestStatusLabel(newStatus);
        context.showSnackBar('تم تحديث الحالة: $label');
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar('حدث خطأ', isError: true);
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('تفاصيل الطلب'),
        centerTitle: true,
        // Back button always on the left — in RTL, actions = left side
        actions: [
          IconButton(
            icon: const Directionality(
              textDirection: TextDirection.ltr,
              child: Icon(Icons.arrow_back_ios_new, size: 20),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          RequestCustomerHeader(
            customer: _request.customer,
            createdAt: _request.createdAt,
          ),
          const SizedBox(height: AppSpacing.sm),
          _MessageCustomerButton(request: _request),
          const SizedBox(height: AppSpacing.lg),
          RequestStatusBadge(status: _request.status),
          const SizedBox(height: AppSpacing.lg),
          RequestItemsList(
            items: _request.items,
            itemsCount: _request.itemsCount,
          ),
          const SizedBox(height: AppSpacing.lg),
          RequestTotalRow(total: _request.total),
          if (_request.note != null && _request.note!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            RequestNoteSection(note: _request.note!),
          ],
          if (_request.status == 'declined' &&
              _request.declineReason != null) ...[
            const SizedBox(height: AppSpacing.lg),
            RequestDeclineReasonSection(reason: _request.declineReason!),
          ],
          const SizedBox(height: AppSpacing.xxl),
          if (_request.status == 'pending') ...[
            SizedBox(
              height: 48,
              child: OutlinedButton.icon(
                onPressed: _handleAlternative,
                icon: const Icon(Icons.swap_horiz, size: 18),
                label: const Text('اقتراح بديل'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          RequestActions(
            status: _request.status,
            isLoading: _isLoading,
            onAccept: _handleAccept,
            onDecline: _handleDecline,
            onUpdateStatus: _handleUpdateStatus,
          ),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

class _MessageCustomerButton extends ConsumerWidget {
  final BizRequest request;

  const _MessageCustomerButton({required this.request});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: OutlinedButton.icon(
        onPressed: () => _openChat(context, ref),
        icon: const Icon(Icons.chat_outlined, size: 18),
        label: Text('مراسلة ${request.customer.name}'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  void _openChat(BuildContext context, WidgetRef ref) {
    final bizCtx = ref.read(businessContextProvider);

    // Build a Conversation object from the request data
    final conversation = Conversation(
      id: request.conversationId ?? 'conv_${request.customer.id}_${request.id}',
      pageId: bizCtx?.page.id ?? '',
      pageName: bizCtx?.page.name ?? '',
      pageAvatar: bizCtx?.page.avatarUrl,
      pageHandle: bizCtx?.page.slug,
      customerId: request.customer.id,
      customerName: request.customer.name,
      customerAvatar: request.customer.avatarUrl,
      requestId: request.id,
      requestStatus: request.status,
      lastMessage: null,
      lastMessageAt: request.createdAt,
      lastMessageFrom: null,
      unreadCount: 0,
      status: 'active',
      type: 'request',
    );

    context.push(
      Routes.chatDetailPath(conversation.id),
      extra: conversation,
    );
  }
}
