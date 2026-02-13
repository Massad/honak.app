import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/presentation/widgets/shared/follow_notification_sheet.dart';
import 'package:honak/shared/widgets/auth_gate.dart';

/// Notification level for followed pages.
enum FollowLevel { all, importantOnly, none }

/// Visual variant matching Figma `getButtonClasses`.
enum FollowButtonVariant {
  /// BusinessPageView action bar: flex-1, h=44, rounded-xl, blue bg / gray bg.
  primary,

  /// CategoryBrowse: bordered, small, rounded-lg.
  outline,

  /// SearchResults: gray filled, small, rounded-lg.
  solid,

  /// GuestFeed / SectionEmptyState: rounded-full, bordered.
  pill,

  /// SectionEmptyState filled: rounded-full, blue-50 bg.
  pillFill,
}

/// Unified follow button reusable across BusinessPageView, CategoryBrowse,
/// SearchResults, SuggestedNearby, GuestFeed, etc.
///
/// Behaviour:
///   Not following → tap → follow immediately (calls onFollowChanged with FollowLevel.all)
///   Following     → tap → opens FollowNotificationSheet (notification levels + unfollow)
class FollowButton extends ConsumerStatefulWidget {
  final bool isFollowing;
  final ValueChanged<FollowLevel?> onFollowChanged;
  final FollowButtonVariant variant;
  final String? pageName;

  const FollowButton({
    super.key,
    required this.isFollowing,
    required this.onFollowChanged,
    this.variant = FollowButtonVariant.outline,
    this.pageName,
  });

  @override
  ConsumerState<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends ConsumerState<FollowButton> {
  FollowLevel _currentLevel = FollowLevel.all;

  void _showNotificationSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => FollowNotificationSheet(
        pageName: widget.pageName ?? '',
        currentLevel: _currentLevel,
        onChanged: (level) {
          if (level != null) {
            setState(() => _currentLevel = level);
          }
          widget.onFollowChanged(level);
        },
      ),
    );
  }

  void _handleTap() {
    if (widget.isFollowing) {
      _showNotificationSheet();
    } else {
      // Gate follow action behind authentication
      AuthGate.require(
        context,
        ref,
        // "\u0645\u062a\u0627\u0628\u0639\u0629" = متابعة
        action: '\u0645\u062a\u0627\u0628\u0639\u0629',
        onAuthed: () => widget.onFollowChanged(FollowLevel.all),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.variant) {
      FollowButtonVariant.primary =>
        _buildPrimary(context),
      FollowButtonVariant.outline =>
        _buildOutline(context),
      FollowButtonVariant.solid =>
        _buildSolid(context),
      FollowButtonVariant.pill =>
        _buildPill(context),
      FollowButtonVariant.pillFill =>
        _buildPillFill(context),
    };
  }

  // ─── primary: flex-1, h=44, rounded-xl ──────────────────────

  Widget _buildPrimary(BuildContext context) {
    final primary = context.colorScheme.primary;
    final isFollowing = widget.isFollowing;

    return Material(
      color: isFollowing
          ? context.colorScheme.surfaceContainerHighest
          : primary,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: _handleTap,
        child: SizedBox(
          height: 44,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isFollowing ? Icons.check : Icons.person_add_outlined,
                size: isFollowing ? 14 : 16,
                color: isFollowing
                    ? context.colorScheme.onSurfaceVariant
                    : Colors.white,
              ),
              SizedBox(width: AppSpacing.xs),
              Text(
                isFollowing
                    ? '\u0645\u062a\u0627\u0628\u064e\u0639'
                    : '\u0645\u062a\u0627\u0628\u0639\u0629',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isFollowing
                      ? context.colorScheme.onSurfaceVariant
                      : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── outline: border, small, rounded-lg ─────────────────────

  Widget _buildOutline(BuildContext context) {
    final primary = context.colorScheme.primary;
    final isFollowing = widget.isFollowing;

    return Material(
      color: isFollowing
          ? context.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: _handleTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isFollowing
                  ? context.colorScheme.outlineVariant
                  : primary,
            ),
          ),
          child: Text(
            isFollowing
                ? '\u0645\u062a\u0627\u0628\u064e\u0639'
                : '\u0645\u062a\u0627\u0628\u0639\u0629',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isFollowing
                  ? context.colorScheme.onSurfaceVariant
                  : primary,
            ),
          ),
        ),
      ),
    );
  }

  // ─── solid: gray bg, small, rounded-lg ──────────────────────

  Widget _buildSolid(BuildContext context) {
    final isFollowing = widget.isFollowing;

    return Material(
      color: context.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: _handleTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Text(
            isFollowing
                ? '\u0645\u062a\u0627\u0628\u064e\u0639'
                : '\u0645\u062a\u0627\u0628\u0639\u0629',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isFollowing
                  ? context.colorScheme.onSurfaceVariant
                  : context.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }

  // ─── pill: rounded-full, bordered ───────────────────────────

  Widget _buildPill(BuildContext context) {
    final primary = context.colorScheme.primary;
    final isFollowing = widget.isFollowing;

    return Material(
      color: isFollowing
          ? context.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: _handleTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: isFollowing
                  ? context.colorScheme.outlineVariant
                  : primary,
            ),
          ),
          child: Text(
            isFollowing
                ? '\u0645\u062a\u0627\u0628\u064e\u0639'
                : '\u0645\u062a\u0627\u0628\u0639\u0629',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isFollowing
                  ? context.colorScheme.onSurfaceVariant
                  : primary,
            ),
          ),
        ),
      ),
    );
  }

  // ─── pillFill: rounded-full, blue-50 bg ─────────────────────

  Widget _buildPillFill(BuildContext context) {
    final primary = context.colorScheme.primary;
    final isFollowing = widget.isFollowing;

    return Material(
      color: isFollowing
          ? context.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6)
          : primary.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: _handleTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isFollowing) ...[
                Icon(Icons.person_add_outlined, size: 12, color: primary),
                const SizedBox(width: 4),
              ],
              Text(
                isFollowing
                    ? '\u0645\u062a\u0627\u0628\u064e\u0639'
                    : '\u0645\u062a\u0627\u0628\u0639\u0629',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isFollowing
                      ? context.colorScheme.onSurfaceVariant
                      : primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
