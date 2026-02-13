import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/config/archetype.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/domain/entities/page_detail.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';
import 'package:honak/features/pages/presentation/widgets/shared/follow_button.dart';
import 'package:honak/features/pages/presentation/widgets/shared/page_overflow_menu.dart';
import 'package:honak/shared/widgets/auth_gate.dart';
import 'package:url_launcher/url_launcher.dart';

/// Action bar matching Figma: `flex gap-2` inside the white info section.
///
/// Button layout per Figma:
/// - Most archetypes: [Follow (flex-1)] [Message (flex-1)] [Call (px-4 icon)] [WhatsApp (px-4 icon)] [Overflow]
/// - follow_only/directory: [Follow (flex-1)] [Call (flex-1 + label)] [WhatsApp (flex-1 + label)] [Share (flex-1 + label)]
/// - permanently_closed: [Share (flex-1)]
/// - showcase/visibility engagement: Message hidden
class ActionBar extends ConsumerWidget {
  final PageDetail page;
  final Archetype archetype;
  final bool isFollowing;
  final ValueChanged<FollowLevel?> onFollowChanged;
  final VoidCallback? onMessage;
  final VoidCallback? onCall;
  final VoidCallback? onWhatsApp;
  final VoidCallback? onShare;
  final VoidCallback? onClaimPage;

  const ActionBar({
    super.key,
    required this.page,
    required this.archetype,
    required this.isFollowing,
    required this.onFollowChanged,
    this.onMessage,
    this.onCall,
    this.onWhatsApp,
    this.onShare,
    this.onClaimPage,
  });

  bool get _isPermanentlyClosed => page.permanentlyClosed;
  bool get _isFollowOnly =>
      archetype == Archetype.followOnly || archetype == Archetype.directory;
  bool get _isUnclaimed => page.claimStatus == 'unclaimed';

  /// Message hidden for follow_only, permanently_closed, unclaimed,
  /// or showcase/visibility engagement levels.
  bool get _showMessage {
    if (_isFollowOnly || _isPermanentlyClosed || _isUnclaimed) return false;
    final level = page.engagementLevel;
    if (level == 'showcase' || level == 'visibility') return false;
    return true;
  }

  bool get _showCall =>
      page.phone != null && page.phone!.isNotEmpty && !_isPermanentlyClosed;
  bool get _showWhatsApp =>
      page.whatsapp != null &&
      page.whatsapp!.isNotEmpty &&
      !_isPermanentlyClosed;

  bool get _hasExternalLinks =>
      page.engagementLevel == 'showcase' && page.externalLinks.isNotEmpty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // Main action row
        Row(
          children: [
            // Follow / Share (permanently closed)
            if (_isPermanentlyClosed)
              Expanded(
                child: _ActionButton(
                  icon: Icons.share_outlined,
                  label: '\u0645\u0634\u0627\u0631\u0643\u0629',
                  onTap: onShare,
                ),
              )
            else
              Expanded(
                child: FollowButton(
                  isFollowing: isFollowing,
                  onFollowChanged: onFollowChanged,
                  variant: FollowButtonVariant.primary,
                  pageName: page.name,
                ),
              ),

            SizedBox(width: AppSpacing.sm),

            // Message button
            if (_showMessage) ...[
              Expanded(
                child: _ActionButton(
                  icon: Icons.chat_bubble_outline,
                  label: '\u0645\u0631\u0627\u0633\u0644\u0629',
                  onTap: () => AuthGate.require(
                    context,
                    ref,
                    action: '\u0645\u0631\u0627\u0633\u0644\u0629',
                    onAuthed: () => onMessage?.call(),
                  ),
                ),
              ),
              SizedBox(width: AppSpacing.sm),
            ],

            // Call button
            if (_showCall) ...[
              if (_isFollowOnly)
                Expanded(
                  child: _ActionButton(
                    icon: Icons.phone_outlined,
                    label: '\u0627\u062a\u0635\u0627\u0644',
                    onTap: () => AuthGate.require(
                      context,
                      ref,
                      action: '\u0627\u062a\u0635\u0627\u0644',
                      onAuthed: () => onCall?.call(),
                    ),
                  ),
                )
              else
                _ActionButton(
                  icon: Icons.phone_outlined,
                  label: null,
                  onTap: () => AuthGate.require(
                    context,
                    ref,
                    action: '\u0627\u062a\u0635\u0627\u0644',
                    onAuthed: () => onCall?.call(),
                  ),
                  compact: true,
                ),
              SizedBox(width: AppSpacing.sm),
            ],

            // WhatsApp button
            if (_showWhatsApp) ...[
              if (_isFollowOnly)
                Expanded(
                  child: _ActionButton(
                    icon: Icons.chat,
                    label: '\u0648\u0627\u062a\u0633\u0627\u0628',
                    onTap: () => AuthGate.require(
                      context,
                      ref,
                      action: '\u0648\u0627\u062a\u0633\u0627\u0628',
                      onAuthed: () => onWhatsApp?.call(),
                    ),
                  ),
                )
              else
                _ActionButton(
                  icon: Icons.chat,
                  label: null,
                  onTap: () => AuthGate.require(
                    context,
                    ref,
                    action: '\u0648\u0627\u062a\u0633\u0627\u0628',
                    onAuthed: () => onWhatsApp?.call(),
                  ),
                  compact: true,
                ),
              SizedBox(width: AppSpacing.sm),
            ],

            // Share button (follow_only/directory only)
            if (_isFollowOnly && !_isPermanentlyClosed) ...[
              Expanded(
                child: _ActionButton(
                  icon: Icons.share_outlined,
                  label: '\u0645\u0634\u0627\u0631\u0643\u0629',
                  onTap: onShare,
                ),
              ),
              SizedBox(width: AppSpacing.sm),
            ],

            // Overflow menu
            _ActionButton(
              icon: Icons.more_vert,
              label: null,
              onTap: () => PageOverflowMenu.show(
                context: context,
                handle: page.handle ?? page.slug,
                claimStatus: page.claimStatus,
                pageName: page.name,
                onClaimPage: onClaimPage,
              ),
              compact: true,
            ),
          ],
        ),

        // External links row (showcase engagement only)
        if (_hasExternalLinks) ...[
          SizedBox(height: AppSpacing.sm),
          _ExternalLinksRow(links: page.externalLinks),
        ],
      ],
    );
  }
}

/// Row of external link buttons for showcase engagement level.
/// Style: bg-gray-900, text-white, rounded-xl, py-2.5, text-sm.
class _ExternalLinksRow extends StatelessWidget {
  final List<ExternalLink> links;

  const _ExternalLinksRow({required this.links});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: links.map((link) => _ExternalLinkButton(link: link)).toList(),
    );
  }
}

class _ExternalLinkButton extends StatelessWidget {
  final ExternalLink link;

  const _ExternalLinkButton({required this.link});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => launchUrl(
          Uri.parse(link.url),
          mode: LaunchMode.externalApplication,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: AppSpacing.md,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.open_in_new,
                size: 14,
                color: Colors.white,
              ),
              const SizedBox(width: 6),
              Text(
                link.label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Standard gray action button: `bg-gray-100 text-gray-700 py-2.5 rounded-xl text-sm`.
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String? label;
  final VoidCallback? onTap;
  final bool compact;

  const _ActionButton({
    required this.icon,
    this.label,
    this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: compact ? AppSpacing.lg : AppSpacing.sm,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: compact ? MainAxisSize.min : MainAxisSize.max,
            children: [
              Icon(
                icon,
                size: 16,
                color: context.colorScheme.onSurfaceVariant,
              ),
              if (label != null) ...[
                const SizedBox(width: 6),
                Text(
                  label!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
