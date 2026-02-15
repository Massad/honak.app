import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/customers/domain/entities/customer_invite.dart';
import 'package:honak/features/business/customers/presentation/providers/customers_provider.dart';
import 'package:honak/features/business/customers/presentation/widgets/invite_card.dart';
import 'package:honak/features/business/customers/presentation/widgets/invites_list_overlay.dart';

/// InviteSection — invite new customers with phone, name, optional package.
/// Matches Figma InviteSection.tsx.
class InviteSection extends StatefulWidget {
  final BizCustomersData data;
  final String pageSlug;
  final List<InvitePackage> packages;

  const InviteSection({
    super.key,
    required this.data,
    required this.pageSlug,
    this.packages = const [],
  });

  @override
  State<InviteSection> createState() => _InviteSectionState();
}

class _InviteSectionState extends State<InviteSection> {
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  String? _selectedPackageId;
  bool _directActivate = false;
  bool _packagePickerExpanded = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  List<CustomerInvite> get _invites => widget.data.invites;
  List<InvitePackage> get _packages => widget.packages;

  List<CustomerInvite> get _pendingInvites =>
      _invites.where((i) => i.status == InviteStatus.pending).toList();

  List<CustomerInvite> get _registeredInvites =>
      _invites.where((i) => i.status == InviteStatus.registered).toList();

  List<CustomerInvite> get _subscribedInvites =>
      _invites.where((i) => i.status == InviteStatus.subscribed).toList();

  int get _conversionPercent {
    if (_invites.isEmpty) return 0;
    return (_subscribedInvites.length / _invites.length * 100).round();
  }

  void _handleAddManual() {
    if (_phoneController.text.trim().isEmpty) return;
    context.showSnackBar(context.l10n.comingSoon);
    _phoneController.clear();
    _nameController.clear();
  }

  void _handleWhatsApp() {
    if (_phoneController.text.trim().isEmpty) return;
    context.showSnackBar(context.l10n.comingSoon);
  }

  String get _inviteUrl {
    final base = 'honak.app/${widget.pageSlug}/invite';
    if (_selectedPackageId != null) return '$base?pkg=$_selectedPackageId';
    return base;
  }

  void _handleCopyLink() {
    Clipboard.setData(ClipboardData(text: _inviteUrl));
    context.showSnackBar(context.l10n.bizInviteLinkCopied);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Invite card ──
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg), // p-4
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Header: "دعوة عميل" + icon
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    l10n.bizInviteTitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  const Icon(
                    Icons.person_add_outlined,
                    size: 14,
                    color: AppColors.primary,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Phone input
              _InviteInput(
                controller: _phoneController,
                hint: l10n.bizInvitePhoneHint,
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10), // space-y-2.5

              // Name input
              _InviteInput(
                controller: _nameController,
                hint: l10n.bizInviteNameHint,
              ),

              // Package picker (if page has packages)
              if (_packages.isNotEmpty) ...[
                const SizedBox(height: 10),
                _PackagePicker(
                  packages: _packages,
                  selectedId: _selectedPackageId,
                  expanded: _packagePickerExpanded,
                  onToggle: () => setState(
                    () => _packagePickerExpanded = !_packagePickerExpanded,
                  ),
                  onSelect: (id) => setState(() {
                    _selectedPackageId = id;
                    _packagePickerExpanded = false;
                    if (id == null) _directActivate = false;
                  }),
                ),
              ],

              // Direct activate toggle (if package selected)
              if (_selectedPackageId != null) ...[
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () =>
                      setState(() => _directActivate = !_directActivate),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0FDF4), // green-50
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFFBBF7D0), // green-100
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            l10n.bizInviteDirectActivateLabel,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: _directActivate
                                ? AppColors.success
                                : Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: _directActivate
                                  ? AppColors.success
                                  : AppColors.divider,
                              width: 2,
                            ),
                          ),
                          child: _directActivate
                              ? const Icon(
                                  Icons.check,
                                  size: 10,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              const SizedBox(height: AppSpacing.md),

              // Action buttons
              Row(
                textDirection: TextDirection.ltr,
                children: [
                  // Copy button
                  GestureDetector(
                    onTap: _handleCopyLink,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.divider),
                      ),
                      child: const Icon(
                        Icons.copy,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),

                  // WhatsApp button
                  Expanded(
                    child: GestureDetector(
                      onTap: _handleWhatsApp,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF25D366), // WhatsApp green
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.share, size: 12, color: Colors.white),
                            const SizedBox(width: 6),
                            Text(
                              l10n.bizInviteWhatsApp,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),

                  // Add/Send button
                  Expanded(
                    child: GestureDetector(
                      onTap: _handleAddManual,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _directActivate
                              ? AppColors.success
                              : AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.send, size: 12, color: Colors.white),
                            const SizedBox(width: 6),
                            Text(
                              l10n.bizInviteAdd,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Invite link preview
              const SizedBox(height: AppSpacing.sm),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    _inviteUrl,
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.textHint,
                      fontFamily: 'monospace',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
        ),

        // ── Invite summary stats ──
        if (_invites.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          _InviteSummaryStats(
            pendingCount: _pendingInvites.length,
            registeredCount: _registeredInvites.length,
            subscribedCount: _subscribedInvites.length,
            conversionPercent: _conversionPercent,
          ),
        ],

        // ── Recent invites preview ──
        if (_invites.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          _RecentInvitesPreview(
            invites: _invites,
            pendingCount: _pendingInvites.length,
            onShowAll: () => _showAllInvites(context),
          ),
        ],
      ],
    );
  }

  void _showAllInvites(BuildContext context) {
    showInvitesListOverlay(context, invites: _invites);
  }
}

// ═══════════════════════════════════════════════════════════════
// Invite Input
// ═══════════════════════════════════════════════════════════════

class _InviteInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData? icon;
  final TextInputType? keyboardType;

  const _InviteInput({
    required this.controller,
    required this.hint,
    this.icon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textDirection: TextDirection.rtl,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: AppColors.textHint,
        ),
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        contentPadding: EdgeInsetsDirectional.fromSTEB(
          AppSpacing.md,
          10,
          icon != null ? 36.0 : AppSpacing.md,
          10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        prefixIcon: icon != null
            ? Padding(
                padding: const EdgeInsetsDirectional.only(start: 12),
                child: Icon(icon, size: 12, color: AppColors.textHint),
              )
            : null,
        prefixIconConstraints: icon != null
            ? const BoxConstraints(minWidth: 32, minHeight: 0)
            : null,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Package Picker
// ═══════════════════════════════════════════════════════════════

class _PackagePicker extends StatelessWidget {
  final List<InvitePackage> packages;
  final String? selectedId;
  final bool expanded;
  final VoidCallback onToggle;
  final ValueChanged<String?> onSelect;

  const _PackagePicker({
    required this.packages,
    required this.selectedId,
    required this.expanded,
    required this.onToggle,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final selected = selectedId != null
        ? packages.where((p) => p.id == selectedId).firstOrNull
        : null;

    return Column(
      children: [
        // Dropdown button
        GestureDetector(
          onTap: onToggle,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: selected != null
                  ? const Color(0xFFEFF6FF) // blue-50
                  : const Color(0xFFF9FAFB), // gray-50
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected != null
                    ? AppColors.primary
                    : AppColors.divider,
              ),
            ),
            child: Row(
              children: [
                AnimatedRotation(
                  turns: expanded ? 0.25 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.chevron_left,
                    size: 14,
                    color: selected != null
                        ? AppColors.primary
                        : AppColors.textHint,
                  ),
                ),
                const Spacer(),
                Text(
                  selected?.name ?? l10n.bizInviteSelectPackage,
                  style: TextStyle(
                    fontSize: 12,
                    color: selected != null
                        ? AppColors.primary
                        : AppColors.textHint,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Icon(
                  Icons.card_giftcard_outlined,
                  size: 12,
                  color: selected != null
                      ? AppColors.primary
                      : AppColors.textHint,
                ),
              ],
            ),
          ),
        ),

        // Expanded package list
        if (expanded) ...[
          const SizedBox(height: AppSpacing.xs),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                // "No package" option
                _PackageRadio(
                  label: l10n.bizInviteSelectPackage,
                  subtitle: null,
                  isSelected: selectedId == null,
                  onTap: () => onSelect(null),
                ),
                ...packages.map((pkg) => _PackageRadio(
                  label: pkg.name,
                  subtitle: '${(pkg.price / 100).toStringAsFixed(0)} د.أ',
                  isSelected: pkg.id == selectedId,
                  onTap: () => onSelect(pkg.id),
                )),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _PackageRadio extends StatelessWidget {
  final String label;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _PackageRadio({
    required this.label,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 10,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.border, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            // Radio circle
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.divider,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : null,
            ),
            const Spacer(),
            // Label + price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textPrimary,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textHint,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Invite Summary Stats
// ═══════════════════════════════════════════════════════════════

class _InviteSummaryStats extends StatelessWidget {
  final int pendingCount;
  final int registeredCount;
  final int subscribedCount;
  final int conversionPercent;

  const _InviteSummaryStats({
    required this.pendingCount,
    required this.registeredCount,
    required this.subscribedCount,
    required this.conversionPercent,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      children: [
        _InviteStat(
          value: '$pendingCount',
          label: l10n.bizInviteSummaryPending,
          color: const Color(0xFFD97706), // amber-600
          bgColor: const Color(0xFFFFFBEB), // amber-50
        ),
        const SizedBox(width: AppSpacing.sm),
        _InviteStat(
          value: '$registeredCount',
          label: l10n.bizInviteSummaryRegistered,
          color: AppColors.primary,
          bgColor: const Color(0xFFEFF6FF), // blue-50
        ),
        const SizedBox(width: AppSpacing.sm),
        _InviteStat(
          value: '$subscribedCount',
          label: l10n.bizInviteSummarySubscribed,
          color: AppColors.success,
          bgColor: const Color(0xFFF0FDF4), // green-50
        ),
        const SizedBox(width: AppSpacing.sm),
        _InviteStat(
          value: '$conversionPercent%',
          label: l10n.bizInviteConversionRate,
          color: const Color(0xFF9333EA), // purple-600
          bgColor: const Color(0xFFFAF5FF), // purple-50
        ),
      ],
    );
  }
}

class _InviteStat extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final Color bgColor;

  const _InviteStat({
    required this.value,
    required this.label,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 9,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Recent Invites Preview
// ═══════════════════════════════════════════════════════════════

class _RecentInvitesPreview extends StatelessWidget {
  final List<CustomerInvite> invites;
  final int pendingCount;
  final VoidCallback onShowAll;

  const _RecentInvitesPreview({
    required this.invites,
    required this.pendingCount,
    required this.onShowAll,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final preview = invites.take(3).toList();

    return Column(
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Show all link
            if (invites.length > 3)
              GestureDetector(
                onTap: onShowAll,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${l10n.viewAll} (${invites.length})',
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.chevron_left,
                      size: 10,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              )
            else
              const SizedBox.shrink(),

            // Title + pending badge
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.bizInviteSentInvites,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                if (pendingCount > 0) ...[
                  const SizedBox(width: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFBEB), // amber-50
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      '$pendingCount ${l10n.bizInvitePending}',
                      style: const TextStyle(
                        fontSize: 9,
                        color: Color(0xFFD97706), // amber-600
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),

        // Preview cards
        ...preview.map(
          (inv) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: InviteCard(invite: inv),
          ),
        ),
      ],
    );
  }
}
