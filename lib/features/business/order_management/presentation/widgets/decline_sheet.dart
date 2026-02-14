import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/order_management/presentation/providers/provider.dart';

class DeclineSheet extends ConsumerStatefulWidget {
  final String requestId;

  const DeclineSheet({super.key, required this.requestId});

  @override
  ConsumerState<DeclineSheet> createState() => _DeclineSheetState();
}

class _DeclineSheetState extends ConsumerState<DeclineSheet> {
  String? _selectedReason;
  final _customController = TextEditingController();
  bool _isLoading = false;

  static const _presetReasons = [
    'غير متوفر',
    'خارج نطاق التوصيل',
    'مشغولون حالياً',
    'السعر تغيّر',
  ];

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  String get _effectiveReason {
    if (_selectedReason == 'custom') {
      return _customController.text.trim();
    }
    return _selectedReason ?? '';
  }

  bool get _canSubmit {
    if (_isLoading) return false;
    if (_selectedReason == null) return false;
    if (_selectedReason == 'custom') {
      return _customController.text.trim().isNotEmpty;
    }
    return true;
  }

  Future<void> _handleDecline() async {
    if (!_canSubmit) return;
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(requestRepositoryProvider);
      await repo.declineRequest(widget.requestId, _effectiveReason);
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar('حدث خطأ أثناء الرفض', isError: true);
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Title
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                'سبب الرفض',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Preset reason chips
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                textDirection: TextDirection.rtl,
                children: _presetReasons.map((reason) {
                  final isSelected = _selectedReason == reason;
                  return GestureDetector(
                    onTap: () => setState(() {
                      _selectedReason = isSelected ? null : reason;
                    }),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.error.withValues(alpha: 0.1)
                            : Theme.of(context).colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.error
                              : Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ),
                      child: Text(
                        reason,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected
                              ? AppColors.error
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Custom reason
            GestureDetector(
              onTap: () => setState(() {
                _selectedReason =
                    _selectedReason == 'custom' ? null : 'custom';
              }),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'سبب آخر',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: _selectedReason == 'custom'
                          ? FontWeight.w600
                          : FontWeight.normal,
                      color: _selectedReason == 'custom'
                          ? AppColors.error
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Icon(
                    _selectedReason == 'custom'
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    size: 18,
                    color: _selectedReason == 'custom'
                        ? AppColors.error
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
            if (_selectedReason == 'custom') ...[
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: _customController,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                maxLines: 2,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'اكتب السبب...',
                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainerLowest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.error),
                  ),
                  contentPadding: const EdgeInsets.all(AppSpacing.md),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.xl),

            // Confirm button
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: _canSubmit ? _handleDecline : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: Theme.of(context).colorScheme.surface,
                  disabledBackgroundColor: Theme.of(context).colorScheme.outlineVariant,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      )
                    : const Text(
                        'رفض الطلب',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        ),
      ),
    );
  }
}
