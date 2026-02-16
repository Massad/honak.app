import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/requests/domain/entities/customer_request.dart';
import 'package:honak/features/requests/presentation/widgets/cancel_confirmation.dart';
import 'package:honak/features/requests/presentation/widgets/detail_action_bar.dart';
import 'package:honak/features/requests/presentation/widgets/edit_order_sheet.dart';
import 'package:honak/features/requests/presentation/widgets/request_type_details.dart';
import 'package:honak/features/requests/presentation/widgets/reschedule_sheet.dart';
import 'package:honak/features/requests/presentation/widgets/status_timeline.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Full request detail page (customer view).
class CustomerRequestDetailPage extends StatefulWidget {
  final CustomerRequest request;

  const CustomerRequestDetailPage({super.key, required this.request});

  @override
  State<CustomerRequestDetailPage> createState() =>
      _CustomerRequestDetailPageState();
}

class _CustomerRequestDetailPageState
    extends State<CustomerRequestDetailPage> {
  late CustomerRequest _request;

  @override
  void initState() {
    super.initState();
    _request = widget.request;
  }

  static const _statusConfig = <String, (String, Color)>{
    'pending': ('بانتظار الرد', Color(0xFFFF8F00)),
    'pending_review': ('بانتظار الموافقة', Color(0xFFFF8F00)),
    'modification_requested': ('تعديل مرسل', Color(0xFFFF8F00)),
    'accepted': ('تم القبول', AppColors.success),
    'in_progress': ('قيد التنفيذ', AppColors.primary),
    'preparing': ('قيد التحضير', AppColors.primary),
    'completed': ('مكتمل', Color(0xFF6B7280)),
    'declined': ('مرفوض', AppColors.error),
    'cancelled_by_customer': ('ملغي', AppColors.error),
    'cancelled_by_business': ('ملغي من المتجر', AppColors.error),
    'pending_reschedule': ('بانتظار تأكيد الموعد', Color(0xFFFF8F00)),
  };

  static const _typeLabels = <String, String>{
    'order': 'طلب شراء',
    'booking': 'حجز خدمة',
    'quote': 'طلب معاينة',
    'inquiry': 'استفسار',
    'reservation': 'حجز',
  };

  static const _reorderLabels = <String, String>{
    'order': 'إعادة الطلب',
    'booking': 'حجز مرة أخرى',
    'quote': 'طلب معاينة جديد',
    'reservation': 'حجز مرة أخرى',
  };

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final (statusLabel, statusColor) =
        _statusConfig[_request.status] ??
        ('بانتظار الرد', const Color(0xFFFF8F00));
    final typeLabel = _typeLabels[_request.type] ?? 'طلب';

    return Scaffold(
      backgroundColor: context.colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Column(
          children: [
            Text('تفاصيل الطلب', style: textTheme.titleSmall),
            Text(
              '$typeLabel #${_request.id}',
              style: textTheme.labelSmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
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
        padding: const EdgeInsetsDirectional.only(
          start: AppSpacing.lg,
          end: AppSpacing.lg,
          top: AppSpacing.md,
          bottom: 120,
        ),
        children: [
          // Status badge
          _StatusBadge(label: statusLabel, color: statusColor),
          const SizedBox(height: AppSpacing.md),

          // Business info card
          DetailBusinessCard(
            businessName: _request.businessName,
            businessAvatarUrl: _request.businessAvatarUrl,
          ),
          const SizedBox(height: AppSpacing.md),

          // Decline / cancellation reason
          if (_request.status == 'declined' &&
              _request.declineReason != null)
            DetailDeclineCard(reason: _request.declineReason!),
          if (_request.status == 'cancelled_by_business' &&
              _request.declineReason != null)
            DetailDeclineCard(
              reason: _request.declineReason!,
              isCancellation: true,
              businessName: _request.businessName,
            ),

          // Status timeline
          DetailSectionCard(
            child: StatusTimeline(
              events: _request.timeline,
              currentStatus: _request.status,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Request details
          DetailSectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تفاصيل الطلب',
                  style: textTheme.titleSmall?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _buildDetailsSection(),
                if (_request.note != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  _NoteCard(note: _request.note!),
                ],
              ],
            ),
          ),
        ],
      ),
      bottomSheet: _buildActionButtons(context),
    );
  }

  Widget _buildDetailsSection() => buildDetailSectionFor(_request);

  Widget? _buildActionButtons(BuildContext context) {
    final status = _request.status;
    final isSchedulable = _request.isSchedulable;

    if (status == 'pending' || status == 'pending_review') {
      return DetailActionBar(children: [
        if (_request.isOrderType)
          DetailOutlinedAction(
            icon: Icons.edit_outlined,
            label: 'تعديل الطلب',
            onPressed: _showEditOrder,
          ),
        DetailTextAction(
          icon: Icons.cancel_outlined,
          label: 'إلغاء الطلب',
          color: AppColors.error,
          onPressed: _showCancel,
        ),
      ]);
    }

    if (status == 'accepted') {
      return DetailActionBar(children: [
        if (isSchedulable && _request.canReschedule)
          DetailOutlinedAction(
            icon: Icons.calendar_today,
            label: 'إعادة جدولة',
            onPressed: _showReschedule,
          ),
        if (_request.isOrderType && _request.canEdit)
          DetailOutlinedAction(
            icon: Icons.edit_outlined,
            label: 'تعديل الطلب',
            onPressed: _showEditOrder,
          ),
        if (_request.canCancel)
          DetailTextAction(
            icon: Icons.cancel_outlined,
            label: 'إلغاء',
            color: AppColors.error,
            onPressed: _showCancel,
          ),
      ]);
    }

    if (status == 'in_progress' || status == 'preparing') {
      return DetailActionBar(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Text(
            'لا يمكن الإلغاء بعد بدء التنفيذ',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
          ),
        ),
      ]);
    }

    if (status == 'completed') {
      return DetailActionBar(children: [
        btn.Button(
          onPressed: () {},
          label: _reorderLabels[_request.type] ?? 'إعادة الطلب',
          icon: const btn.ButtonIcon(Icons.replay),
          style: btn.Style.success,
          size: btn.ButtonSize.large,
          expand: true,
        ),
      ]);
    }

    if (status == 'cancelled_by_customer') {
      return DetailActionBar(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Text(
            'تم إلغاء هذا الطلب',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
          ),
        ),
      ]);
    }

    if (status == 'pending_reschedule') {
      return DetailActionBar(children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsetsDirectional.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E1),
            border: Border.all(color: const Color(0xFFFFE082)),
            borderRadius: AppRadius.cardInner,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.access_time,
                size: 16,
                color: Color(0xFFFF8F00),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'بانتظار موافقة المتجر على الموعد الجديد',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFFFF8F00),
                    ),
              ),
            ],
          ),
        ),
      ]);
    }

    return null;
  }

  void _showCancel() {
    showAppSheet<void>(
      context,
      builder: (_) => CancelConfirmationSheet(
        requestId: _request.id,
        onConfirm: () {
          setState(() {
            _request = _request.copyWith(
              status: 'cancelled_by_customer',
              timeline: [
                ..._request.timeline,
                TimelineEvent(
                  status: 'cancelled_by_customer',
                  label: 'ملغي من العميل',
                  timestamp:
                      DateTime.now().millisecondsSinceEpoch ~/ 1000,
                  actor: 'customer',
                ),
              ],
            );
          });
          Navigator.pop(context);
        },
        onReschedule: _request.isSchedulable
            ? () {
                Navigator.pop(context);
                _showReschedule();
              }
            : null,
      ),
    );
  }

  void _showReschedule() {
    showAppSheet<void>(
      context,
      builder: (_) => RescheduleSheet(
        request: _request,
        onSubmit: (newTime, reason) {
          setState(() {
            _request = _request.copyWith(
              status: 'pending_reschedule',
              timeline: [
                ..._request.timeline,
                TimelineEvent(
                  status: 'pending_reschedule',
                  label: 'طلب إعادة جدولة — $newTime',
                  timestamp:
                      DateTime.now().millisecondsSinceEpoch ~/ 1000,
                  actor: 'customer',
                  detail:
                      reason.isNotEmpty ? 'السبب: $reason' : null,
                ),
              ],
            );
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showEditOrder() {
    showAppSheet<void>(
      context,
      builder: (_) => EditOrderSheet(
        request: _request,
        onSave: (updatedItems, updatedNote) {
          setState(() {
            _request = _request.copyWith(
              items: updatedItems,
              note: updatedNote,
              status: 'modification_requested',
              timeline: [
                ..._request.timeline,
                TimelineEvent(
                  status: 'modification_requested',
                  label: 'طلب تعديل مرسل',
                  timestamp:
                      DateTime.now().millisecondsSinceEpoch ~/ 1000,
                  actor: 'customer',
                ),
              ],
            );
          });
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 10,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  final String note;

  const _NoteCard({required this.note});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: AppRadius.cardInner,
      ),
      child: RichText(
        text: TextSpan(
          style: textTheme.bodySmall,
          children: [
            TextSpan(
              text: 'ملاحظة: ',
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: note,
              style: textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
