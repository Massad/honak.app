import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/order_management/presentation/pages/detail_page.dart';
import 'package:honak/features/business/order_management/presentation/providers/provider.dart';
import 'package:honak/features/business/order_management/presentation/widgets/action_chip.dart';
import 'package:honak/features/business/order_management/presentation/widgets/alternative_sheet.dart';
import 'package:honak/features/business/order_management/presentation/widgets/decline_sheet.dart';
import 'package:honak/features/business/order_management/presentation/widgets/request_card_sections.dart';
import 'package:honak/features/business/shared/domain/entities/entities.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

class RequestCard extends ConsumerWidget {
  final BizRequest request;
  final VoidCallback onInvalidate;

  const RequestCard({
    super.key,
    required this.request,
    required this.onInvalidate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPending = request.status == 'pending';
    final isAccepted = request.status == 'accepted';

    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => RequestDetailPage(request: request),
          ),
        );
        onInvalidate();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isPending
                ? const Color(0xFFFF9800).withValues(alpha: 0.3)
                : Theme.of(context).colorScheme.surfaceContainerLow,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            RequestCardHeader(request: request),
            if (request.note != null && request.note!.isNotEmpty)
              RequestCardNotePreview(note: request.note!),
            _buildFooter(context, ref, isPending, isAccepted),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(
    BuildContext context,
    WidgetRef ref,
    bool isPending,
    bool isAccepted,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(14),
        ),
      ),
      child: Row(
        children: [
          if (isPending) ...[
            RequestActionChip(
              label: 'قبول',
              color: const Color(0xFF43A047),
              icon: Icons.check,
              onTap: () => _handleAccept(context, ref),
            ),
            const SizedBox(width: AppSpacing.sm),
            RequestActionChip(
              label: 'بديل',
              color: AppColors.primary,
              icon: Icons.swap_horiz,
              onTap: () => _handleAlternative(context),
            ),
            const SizedBox(width: AppSpacing.sm),
            RequestActionChip(
              label: 'رفض',
              color: const Color(0xFFE53935),
              icon: Icons.close,
              onTap: () => _handleDecline(context),
            ),
          ] else if (isAccepted) ...[
            RequestActionChip(
              label: 'قيد التنفيذ',
              color: AppColors.primary,
              icon: Icons.local_shipping_outlined,
              onTap: null,
            ),
          ],
          const Spacer(),
          Text(
            request.total?.toFormattedArabic() ?? '',
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleAccept(BuildContext context, WidgetRef ref) async {
    try {
      final repo = ref.read(requestRepositoryProvider);
      await repo.acceptRequest(request.id);
      if (context.mounted) {
        context.showSnackBar('تم قبول الطلب');
      }
      onInvalidate();
    } catch (e) {
      if (context.mounted) {
        context.showSnackBar('حدث خطأ', isError: true);
      }
    }
  }

  Future<void> _handleDecline(BuildContext context) async {
    final result = await showAppSheet<bool>(
      context,
      builder: (_) => DeclineSheet(requestId: request.id),
    );
    if (result == true) {
      onInvalidate();
    }
  }

  Future<void> _handleAlternative(BuildContext context) async {
    final result = await showAppSheet<bool>(
      context,
      builder: (_) => AlternativeSheet(requestId: request.id),
    );
    if (result == true) {
      onInvalidate();
    }
  }
}
