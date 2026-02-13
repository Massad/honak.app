import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/domain/entities/branch.dart';
import 'package:honak/features/business/page_settings/presentation/providers/branch_provider.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/branch_card.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';

final _citiesProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final jsonStr =
      await rootBundle.loadString('assets/api/locations/cities.json');
  final data = json.decode(jsonStr) as Map<String, dynamic>;
  final cities = data['cities'] as List;
  return cities.cast<Map<String, dynamic>>();
});

class BranchManager extends ConsumerWidget {
  final VoidCallback onClose;

  const BranchManager({
    super.key,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final branchesAsync = ref.watch(branchProvider);
    final citiesAsync = ref.watch(_citiesProvider);

    return Column(
      children: [
        SubScreenAppBar(title: 'الفروع', onClose: onClose),
        Expanded(
          child: branchesAsync.when(
            data: (branches) => _BranchList(
              branches: branches,
              cities: citiesAsync.valueOrNull ?? [],
            ),
            loading: () => const _BranchSkeleton(),
            error: (_, __) => Center(
              child: Text(
                'تعذر تحميل الفروع',
                style: TextStyle(color: Colors.grey.shade400),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BranchList extends ConsumerStatefulWidget {
  final List<Branch> branches;
  final List<Map<String, dynamic>> cities;

  const _BranchList({required this.branches, required this.cities});

  @override
  ConsumerState<_BranchList> createState() => _BranchListState();
}

class _BranchListState extends ConsumerState<_BranchList> {
  int _hoursMode = 0; // 0 = unified, 1 = per-branch
  final _hoursController = TextEditingController(text: '9:00 ص - 9:00 م');

  @override
  void dispose() {
    _hoursController.dispose();
    super.dispose();
  }

  void _addBranch() {
    final branch = Branch(
      id: 'br_${DateTime.now().millisecondsSinceEpoch}',
      name: 'فرع جديد',
    );
    ref.read(branchProvider.notifier).addBranch(branch);
    context.showSnackBar('تم إضافة فرع جديد — عدّل البيانات');
  }

  void _save() {
    context.showSnackBar('تم حفظ التغييرات');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              // Hours section
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          'ساعات العمل',
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Icon(Icons.access_time,
                            size: 16, color: Colors.grey.shade500),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    // Toggle bar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _ToggleOption(
                              label: 'لكل فرع',
                              selected: _hoursMode == 1,
                              onTap: () =>
                                  setState(() => _hoursMode = 1),
                            ),
                          ),
                          Expanded(
                            child: _ToggleOption(
                              label: 'موحّدة',
                              selected: _hoursMode == 0,
                              onTap: () =>
                                  setState(() => _hoursMode = 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_hoursMode == 0) ...[
                      const SizedBox(height: AppSpacing.sm),
                      TextField(
                        controller: _hoursController,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                          hintText: 'مثال: 9:00 ص - 9:00 م',
                          hintStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade400,
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Colors.grey.shade200),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Colors.grey.shade200),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Branches header
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  'الفروع (${widget.branches.length})',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),

              // Branch cards
              for (final branch in widget.branches) ...[
                BranchCard(
                  branch: branch,
                  cities: widget.cities,
                ),
                const SizedBox(height: AppSpacing.sm),
              ],

              // Add branch button (dashed border)
              GestureDetector(
                onTap: _addBranch,
                child: CustomPaint(
                  painter: _DashedBorderPainter(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    borderRadius: 14,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.lg),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'إضافة فرع',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Icon(Icons.add_circle_outline,
                            size: 18, color: AppColors.primary),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),

        // Fixed save button
        Container(
          padding: EdgeInsets.only(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            bottom:
                MediaQuery.of(context).padding.bottom + AppSpacing.md,
            top: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey.shade100),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: AppSpacing.md),
              ),
              child: const Text(
                'حفظ',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ToggleOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ToggleOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              color: selected ? AppColors.primary : Colors.grey.shade500,
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double borderRadius;

  _DashedBorderPainter({required this.color, required this.borderRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    const dashWidth = 6.0;
    const dashSpace = 4.0;

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        final end = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(
              distance, end > metric.length ? metric.length : end),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter old) =>
      color != old.color || borderRadius != old.borderRadius;
}

class _BranchSkeleton extends StatelessWidget {
  const _BranchSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: List.generate(2, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.shimmerBase,
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        );
      }),
    );
  }
}
