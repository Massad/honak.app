import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/message.dart';
import 'package:honak/features/chat/domain/entities/power_chat_types.dart';
import 'package:honak/features/chat/presentation/widgets/chat_action_card_shell.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/widgets/button.dart';

class ServiceSuggestionCardMessage extends StatefulWidget {
  final Message message;
  final bool isBusinessMode;

  const ServiceSuggestionCardMessage({
    super.key,
    required this.message,
    required this.isBusinessMode,
  });

  @override
  State<ServiceSuggestionCardMessage> createState() =>
      _ServiceSuggestionCardMessageState();
}

class _ServiceSuggestionCardMessageState
    extends State<ServiceSuggestionCardMessage> {
  late String _status;

  @override
  void initState() {
    super.initState();
    _status = ServiceSuggestionData.fromMetadata(
      widget.message.metadata,
    ).status;
  }

  @override
  void didUpdateWidget(covariant ServiceSuggestionCardMessage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.message.id != widget.message.id) {
      _status = ServiceSuggestionData.fromMetadata(
        widget.message.metadata,
      ).status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ServiceSuggestionData.fromMetadata(widget.message.metadata);
    final isPending = _status == 'pending';
    final accent = switch (_status) {
      'accepted' => AppColors.success,
      'declined' => context.colorScheme.outline,
      _ => context.colorScheme.primary,
    };

    return ChatActionCardShell(
      message: widget.message,
      icon: Icons.content_cut_rounded,
      color: accent,
      title: 'خدمة مقترحة',
      body: Padding(
        padding: const EdgeInsetsDirectional.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.serviceName,
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (data.category != null &&
                          data.category!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: context.colorScheme.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            data.category!,
                            style: context.textTheme.labelSmall?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Text(
                  Money(data.priceCents).toFormattedArabic(),
                  style: context.textTheme.titleSmall?.copyWith(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            if (data.teamMemberName != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Container(
                width: double.infinity,
                padding: const EdgeInsetsDirectional.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.teamMemberName!,
                      style: context.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (data.teamMemberRole != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        data.teamMemberRole!,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: _MetaPill(
                    icon: Icons.calendar_today_outlined,
                    label: data.dateLabel,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                _MetaPill(icon: Icons.schedule, label: data.timeLabel),
              ],
            ),
          ],
        ),
      ),
      footer: isPending
          ? Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.md,
                0,
                AppSpacing.md,
                AppSpacing.sm,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Button(
                      onPressed: widget.isBusinessMode
                          ? null
                          : () => setState(() => _status = 'accepted'),
                      label: 'قبول',
                      size: ButtonSize.small,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Button(
                      onPressed: widget.isBusinessMode
                          ? null
                          : () => setState(() => _status = 'declined'),
                      label: 'رفض',
                      size: ButtonSize.small,
                      variant: Variant.outlined,
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}

class _MetaPill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: context.colorScheme.primary),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
