import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/order_management/domain/entities/deposit_ledger.dart';
import 'package:honak/features/business/order_management/domain/entities/property_inspection.dart';
import 'package:honak/features/business/order_management/presentation/widgets/deposit_tracker.dart';
import 'package:honak/features/business/order_management/presentation/widgets/order_snapshot_display.dart';
import 'package:honak/features/business/order_management/presentation/widgets/property_condition_recorder.dart';

/// Wrapper that combines deposit tracker + property condition + order snapshot.
class ReservationManagementSection extends StatelessWidget {
  final DepositLedger? ledger;
  final PropertyInspection? inspection;
  final OrderSnapshot? snapshot;
  final String currentStatus;
  final String viewMode; // 'customer' | 'business'
  final ValueChanged<DepositLedger>? onLedgerChange;
  final ValueChanged<PropertyInspection>? onInspectionChange;

  const ReservationManagementSection({
    super.key,
    this.ledger,
    this.inspection,
    this.snapshot,
    this.currentStatus = 'accepted',
    this.viewMode = 'business',
    this.onLedgerChange,
    this.onInspectionChange,
  });

  bool get _isBusiness => viewMode == 'business';
  bool get _isCustomer => viewMode == 'customer';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Deposit tracker (both views, if deposit required)
        if (ledger != null && ledger!.requiredAmount > 0) ...[
          DepositTracker(
            ledger: ledger!,
            onChange: onLedgerChange,
            readOnly: _isCustomer,
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // Property condition recorder (business only)
        if (_isBusiness && inspection != null) ...[
          PropertyConditionRecorder(
            inspection: inspection!,
            onChange: onInspectionChange,
            currentStatus: currentStatus,
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // Order snapshot (both views)
        if (snapshot != null)
          OrderSnapshotDisplay(snapshot: snapshot!),
      ],
    );
  }
}
