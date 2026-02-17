import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/directory_management/domain/entities/tenant.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

/// Invite sharing sheet — pre-formatted message + share buttons
/// (WhatsApp, SMS, Copy).
class SendInviteSheet extends StatelessWidget {
  final Tenant tenant;
  final String mallName;

  const SendInviteSheet({
    super.key,
    required this.tenant,
    required this.mallName,
  });

  String _inviteMessage(BuildContext context) =>
      context.l10n.dirInviteMessage(mallName, tenant.unit, tenant.category);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSheetHeader(
          title: context.l10n.dirInviteSheetTitle,
          onClose: () => Navigator.pop(context),
        ),

        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Message preview
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLowest,
                  borderRadius: AppRadius.cardInner,
                  border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                ),
                child: Text(
                  _inviteMessage(context),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Share buttons
              Row(
                children: [
                  // WhatsApp
                  Expanded(
                    child: _ShareButton(
                      icon: Icons.chat,
                      label: context.l10n.dirInviteWhatsApp,
                      color: const Color(0xFF25D366),
                      onTap: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(context.l10n.dirInviteWhatsAppSoon)),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),

                  // SMS
                  Expanded(
                    child: _ShareButton(
                      icon: Icons.sms_outlined,
                      label: context.l10n.dirInviteSMS,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      onTap: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(context.l10n.dirInviteSMSSoon)),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),

                  // Copy
                  Expanded(
                    child: _ShareButton(
                      icon: Icons.copy,
                      label: context.l10n.dirInviteCopy,
                      color: null,
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(text: _inviteMessage(context)),
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(context.l10n.dirInviteCopied)),
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShareButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback onTap;

  const _ShareButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isFilled = color != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: isFilled ? color : null,
          borderRadius: AppRadius.button,
          border: isFilled ? null : Border.all(color: Theme.of(context).colorScheme.outline),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isFilled ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: isFilled ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
