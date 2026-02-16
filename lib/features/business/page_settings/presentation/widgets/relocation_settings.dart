import 'package:flutter/material.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';
import 'package:honak/shared/widgets/button.dart';
import 'package:honak/shared/widgets/confirm_dialog.dart';

class RelocationSettings extends StatefulWidget {
  final VoidCallback onClose;

  const RelocationSettings({super.key, required this.onClose});

  @override
  State<RelocationSettings> createState() => _RelocationSettingsState();
}

class _RelocationSettingsState extends State<RelocationSettings> {
  bool _isActive = false;
  bool _showConfirmation = false;
  bool _notifyFollowers = true;
  DateTime? _activatedAt;
  final _addressController = TextEditingController();

  int get _daysRemaining {
    if (_activatedAt == null) return 30;
    final elapsed = DateTime.now().difference(_activatedAt!).inDays;
    return (30 - elapsed).clamp(0, 30);
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  void _onToggleChanged(bool value) {
    if (value) {
      // Turning ON — show address input + confirmation flow
      setState(() {
        _showConfirmation = true;
        _notifyFollowers = true;
      });
    } else {
      // Turning OFF — show stop confirmation dialog
      _showStopConfirmation();
    }
  }

  Future<void> _showStopConfirmation() async {
    final confirmed = await ConfirmDialog.show(
      context,
      title: 'إيقاف إعلان الانتقال',
      message:
          'إيقاف الإعلان سيزيله فوراً من صفحتك.\n'
          'لن يتم إبلاغ المتابعين بالإلغاء.',
      confirmLabel: 'إيقاف',
      cancelLabel: 'تراجع',
      isDestructive: true,
    );
    if (confirmed && mounted) {
      setState(() {
        _isActive = false;
        _showConfirmation = false;
        _activatedAt = null;
        _addressController.clear();
      });
      context.showSnackBar('تم إيقاف إعلان الانتقال');
    }
  }

  void _onConfirmActivation() {
    if (_addressController.text.trim().isEmpty) return;
    setState(() {
      _isActive = true;
      _showConfirmation = false;
      _activatedAt = DateTime.now();
    });
    context.showSnackBar('تم تفعيل إعلان الانتقال وإبلاغ المتابعين');
  }

  void _onCancelConfirmation() {
    setState(() {
      _showConfirmation = false;
      _addressController.clear();
    });
  }

  // ── Toggle row ──────────────────────────────────────────────────────────

  Widget _buildToggleRow() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          Switch(
            value: _isActive || _showConfirmation,
            onChanged: _onToggleChanged,
            activeTrackColor: AppColors.primary.withValues(alpha: 0.4),
            activeThumbColor: AppColors.primary,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isActive ? 'الانتقال مفعّل' : 'تغيير الموقع',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _isActive
                      ? 'يظهر بانر على صفحتك يبلّغ الزوار بالعنوان الجديد'
                      : 'عند التفعيل، سيظهر إعلان "انتقلنا!" على صفحتك لمدة 30 يوم',
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Confirmation flow (toggle just turned on) ───────────────────────────

  Widget _buildConfirmationFlow() {
    final hasAddress = _addressController.text.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppSpacing.lg),

        // Address input
        Text(
          'العنوان الجديد:',
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: _addressController,
          onChanged: (_) => setState(() {}),
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            hintText: 'مثال: شارع المدينة المنورة، عمّان',
            hintStyle: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.outline),
            prefixIcon: Icon(
              Icons.location_on_outlined,
              size: 18,
              color: Theme.of(context).colorScheme.outline,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Info note
        _buildInfoNote(
          color: AppColors.primary,
          bgColor: const Color(0xFFE3F2FD),
          icon: Icons.info_outline,
          text: 'البانر سيظهر لمدة ٣٠ يوم من تاريخ التفعيل. يمكنك إيقافه في أي وقت.',
        ),

        // Live preview (only when address is entered)
        if (hasAddress) ...[
          const SizedBox(height: AppSpacing.md),
          _buildBannerPreview(_addressController.text.trim()),
        ],

        const SizedBox(height: AppSpacing.lg),

        // Notify followers toggle
        _buildNotifyToggle(),

        const SizedBox(height: AppSpacing.lg),

        // Action buttons — Cancel left, Confirm right (LTR row)
        Row(
          textDirection: TextDirection.ltr,
          children: [
            Expanded(
              child: Button(
                onPressed: _onCancelConfirmation,
                label: 'إلغاء',
                variant: Variant.outlined,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Button(
                onPressed: hasAddress ? _onConfirmActivation : null,
                label: 'تأكيد وإشعار المتابعين',
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Active state (relocation confirmed) ─────────────────────────────────

  Widget _buildActiveState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppSpacing.lg),

        // Live banner preview
        _buildBannerPreview(_addressController.text.trim()),

        const SizedBox(height: AppSpacing.md),

        // Days remaining
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            children: [
              Icon(Icons.timer_outlined, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'متبقي $_daysRemaining يوم',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                'سيختفي البانر تلقائياً',
                style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // Stop button
        Button(
          onPressed: _showStopConfirmation,
          label: 'إيقاف',
          icon: ButtonIcon(Icons.stop_circle_outlined),
          variant: Variant.outlined,
          style: Style.danger,
          expand: true,
        ),
      ],
    );
  }

  // ── Banner preview widget ───────────────────────────────────────────────

  Widget _buildBannerPreview(String address) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'معاينة البانر:',
            style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.sm),
          // The actual banner
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.primary),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'انتقلنا!',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'العنوان الجديد: $address',
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Info note widget ────────────────────────────────────────────────────

  Widget _buildInfoNote({
    required Color color,
    required Color bgColor,
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 10,
                color: color,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Notify followers toggle ─────────────────────────────────────────────

  Widget _buildNotifyToggle() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Switch(
            value: _notifyFollowers,
            onChanged: (v) => setState(() => _notifyFollowers = v),
            activeTrackColor: AppColors.primary.withValues(alpha: 0.4),
            activeThumbColor: AppColors.primary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'إعلام المتابعين',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'سيتم إشعار جميع المتابعين بالعنوان الجديد',
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Main build ──────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubScreenAppBar(title: 'نقل الموقع', onClose: widget.onClose),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              // Main toggle
              _buildToggleRow(),

              // Confirmation flow — just toggled on, need to enter address
              if (_showConfirmation && !_isActive) _buildConfirmationFlow(),

              // Active state — relocation confirmed and running
              if (_isActive) _buildActiveState(),

              // Inactive explanation — when off and not in confirmation
              if (!_isActive && !_showConfirmation) ...[
                const SizedBox(height: AppSpacing.md),
                _buildInfoNote(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  bgColor: Theme.of(context).colorScheme.surfaceContainerLowest,
                  icon: Icons.info_outline,
                  text:
                      'عند التفعيل، سيظهر إعلان "انتقلنا!" على صفحتك لمدة 30 يوم لإبلاغ الزوار والمتابعين بعنوانك الجديد.',
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
