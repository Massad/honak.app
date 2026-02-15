import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/availability_data.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/blocked_dates_tab.dart';
import 'package:honak/features/business/catalog_management/presentation/widgets/weekly_schedule_tab.dart';

// ═══════════════════════════════════════════════════════════════════
// Availability Overlay — full-screen overlay for managing
// weekly schedule + blocked dates.
// Matches Figma AvailabilityManager pixel-for-pixel.
// ═══════════════════════════════════════════════════════════════════

enum _AvailTab { schedule, blocks }

class AvailabilityOverlay extends StatefulWidget {
  final VoidCallback onClose;

  const AvailabilityOverlay({super.key, required this.onClose});

  @override
  State<AvailabilityOverlay> createState() => _AvailabilityOverlayState();
}

class _AvailabilityOverlayState extends State<AvailabilityOverlay> {
  _AvailTab _tab = _AvailTab.schedule;
  bool _saved = false;
  String? _expandedDay;

  // Weekly schedule
  late Map<String, DaySchedule> _weekly;

  // Blocked dates
  late List<BlockedDate> _blocks;

  @override
  void initState() {
    super.initState();
    _weekly = {
      for (final d in weekdays)
        d.id: DaySchedule(enabled: d.id != 'fri'),
    };
    _blocks = List.of(demoBlocks);
  }

  void _handleSave() {
    setState(() => _saved = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _saved = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ─── Sticky header ───
        _buildHeader(context),

        // ─── Content ───
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 100,
            ),
            children: [
              if (_tab == _AvailTab.schedule)
                WeeklyScheduleTab(
                  weekly: _weekly,
                  expandedDay: _expandedDay,
                  onExpandDay: (d) => setState(
                      () => _expandedDay = _expandedDay == d ? null : d),
                  onChanged: () => setState(() {}),
                ),
              if (_tab == _AvailTab.blocks)
                BlockedDatesTab(
                  blocks: _blocks,
                  onChange: (b) => setState(() => _blocks = b),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    final blockCount = _blocks.length;
    return Container(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.md),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
            bottom: BorderSide(color: context.colorScheme.outlineVariant)),
      ),
      child: Column(
        children: [
          // Title row
          Row(
            children: [
              // Back button
              GestureDetector(
                onTap: widget.onClose,
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: const Icon(Icons.arrow_forward_ios,
                      size: 14, color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              // Title + subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('إدارة المواعيد',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: context.colorScheme.onSurface)),
                    const Text('الجدول الأسبوعي وحظر التواريخ',
                        style: TextStyle(
                            fontSize: 10, color: AppColors.textHint)),
                  ],
                ),
              ),
              // Save button
              GestureDetector(
                onTap: _handleSave,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg, vertical: 6),
                  decoration: BoxDecoration(
                    color: _saved ? AppColors.success : AppColors.primary,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: _saved
                      ? const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('تم الحفظ',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)),
                            SizedBox(width: 4),
                            Icon(Icons.check,
                                size: 12, color: Colors.white),
                          ],
                        )
                      : const Text('حفظ',
                          style: TextStyle(
                              fontSize: 12, color: Colors.white)),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Tab pills
          Row(
            children: [
              _tabPill('الجدول الأسبوعي', _AvailTab.schedule),
              const SizedBox(width: AppSpacing.sm),
              _tabPill('حظر مواعيد', _AvailTab.blocks, badge: blockCount),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tabPill(String label, _AvailTab tab, {int badge = 0}) {
    final isActive = _tab == tab;
    return GestureDetector(
      onTap: () => setState(() => _tab = tab),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.surfaceVariant,
          borderRadius: AppRadius.pill,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: 12,
                    color:
                        isActive ? Colors.white : AppColors.textSecondary)),
            if (badge > 0 && isActive) ...[
              const SizedBox(width: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: AppRadius.pill,
                ),
                child: Text('$badge',
                    style: const TextStyle(
                        fontSize: 9, color: Colors.white)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
