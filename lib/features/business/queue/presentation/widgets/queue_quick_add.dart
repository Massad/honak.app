import 'package:flutter/material.dart';

import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/queue/domain/entities/queue_add_on.dart';
import 'package:honak/features/business/queue/domain/entities/queue_discount.dart';
import 'package:honak/features/business/queue/domain/entities/queue_entry.dart';
import 'package:honak/features/business/queue/domain/entities/queue_source.dart';
import 'package:honak/features/business/queue/domain/entities/queue_status.dart';
import 'package:honak/features/business/queue/domain/entities/service_package.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

part 'queue_quick_add_details.dart';
part 'queue_quick_add_widgets.dart';

// ═════════════════════════════════════════════════════════════════
// Public API
// ═════════════════════════════════════════════════════════════════

/// Shows a 2-step bottom sheet for adding a walk-in customer to the queue.
/// Returns the new [QueueEntry] if submitted, `null` if dismissed.
Future<QueueEntry?> showQueueQuickAdd(
  BuildContext context, {
  required List<ServicePackage> packages,
}) {
  return showAppSheet<QueueEntry>(
    context,
    builder: (_) => _QueueQuickAddSheet(packages: packages),
  );
}

// ═════════════════════════════════════════════════════════════════
// Root Sheet
// ═════════════════════════════════════════════════════════════════

class _QueueQuickAddSheet extends StatefulWidget {
  final List<ServicePackage> packages;

  const _QueueQuickAddSheet({required this.packages});

  @override
  State<_QueueQuickAddSheet> createState() => _QueueQuickAddSheetState();
}

class _QueueQuickAddSheetState extends State<_QueueQuickAddSheet> {
  ServicePackage? _selectedPackage;

  void _onPackageSelected(ServicePackage pkg) {
    setState(() => _selectedPackage = pkg);
  }

  void _clearPackage() {
    setState(() => _selectedPackage = null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SheetHeader(
          title: _selectedPackage == null
              ? 'اختر الخدمة'
              : 'تفاصيل العميل',
          onClose: () => Navigator.pop(context),
        ),
        Flexible(
          child: _selectedPackage == null
              ? _PackageList(
                  packages: widget.packages,
                  onSelect: _onPackageSelected,
                )
              : _DetailsStep(
                  package: _selectedPackage!,
                  onChangePackage: _clearPackage,
                  onSubmit: (entry) => Navigator.pop(context, entry),
                ),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════
// Sheet Header
// ═════════════════════════════════════════════════════════════════

class _SheetHeader extends StatelessWidget {
  final String title;
  final VoidCallback onClose;

  const _SheetHeader({required this.title, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Title + close
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onClose,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════
// Step 1 — Package Selection
// ═════════════════════════════════════════════════════════════════

class _PackageList extends StatelessWidget {
  final List<ServicePackage> packages;
  final ValueChanged<ServicePackage> onSelect;

  const _PackageList({
    required this.packages,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
      itemCount: packages.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        final pkg = packages[index];
        return _PackageCard(package: pkg, onTap: () => onSelect(pkg));
      },
    );
  }
}

// _PackageCard is in queue_quick_add_details.dart (part file)
