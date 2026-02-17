import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/order_management/domain/entities/deposit_ledger.dart';
import 'package:honak/shared/entities/money.dart';

/// Expand/collapse card for deposit payment management.
class DepositTracker extends StatefulWidget {
  final DepositLedger ledger;
  final ValueChanged<DepositLedger>? onChange;
  final bool readOnly;

  const DepositTracker({
    super.key,
    required this.ledger,
    this.onChange,
    this.readOnly = false,
  });

  @override
  State<DepositTracker> createState() => _DepositTrackerState();
}

class _DepositTrackerState extends State<DepositTracker> {
  bool _expanded = false;
  bool _showDepositForm = false;
  bool _showRefundForm = false;

  DepositLedger get _ledger => widget.ledger;

  Color get _statusColor {
    switch (_ledger.status) {
      case 'received':
        return AppColors.success;
      case 'partial':
        return AppColors.warning;
      case 'refunded':
      case 'partially_refunded':
        return AppColors.error;
      default:
        return AppColors.textHint;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Collapsed header ──
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: const Icon(
                      Icons.receipt_long_outlined,
                      size: 18,
                      color: AppColors.success,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              context.l10n.bizReqDepTitle,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: cs.onSurface,
                              ),
                            ),
                            const SizedBox(width: 6),
                            _StatusPill(
                              label: _ledger.statusLabel,
                              color: _statusColor,
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          context.l10n.bizReqDepSummary(
                            _ledger.netDepositedMoney.toFormattedArabic(),
                            _ledger.requiredMoney.toFormattedArabic(),
                            _ledger.totalMoney.toFormattedArabic(),
                          ),
                          style: TextStyle(
                            fontSize: 10,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 20,
                    color: AppColors.textHint,
                  ),
                ],
              ),
            ),
          ),

          // ── Expanded content ──
          if (_expanded)
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.md, 0, AppSpacing.md, AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress bar
                  _ProgressBar(progress: _ledger.progressPercent),
                  const SizedBox(height: AppSpacing.md),

                  // Summary cards
                  _SummaryRow(ledger: _ledger),
                  const SizedBox(height: AppSpacing.md),

                  // Deposit records
                  if (_ledger.deposits.isNotEmpty) ...[
                    _SectionLabel(label: context.l10n.bizReqDepPayments),
                    const SizedBox(height: AppSpacing.xs),
                    ..._ledger.deposits.map(_buildDepositRecord),
                    const SizedBox(height: AppSpacing.sm),
                  ],

                  // Refund records
                  if (_ledger.refunds.isNotEmpty) ...[
                    _SectionLabel(label: context.l10n.bizReqDepRefunds),
                    const SizedBox(height: AppSpacing.xs),
                    ..._ledger.refunds.map(_buildRefundRecord),
                    const SizedBox(height: AppSpacing.sm),
                  ],

                  // Forms
                  if (_showDepositForm)
                    _AddDepositForm(
                      onSave: (record) {
                        setState(() => _showDepositForm = false);
                        // In a real app: update ledger via onChange
                      },
                      onCancel: () =>
                          setState(() => _showDepositForm = false),
                    ),

                  if (_showRefundForm)
                    _AddRefundForm(
                      maxAmount: _ledger.netDeposited,
                      onSave: (record) {
                        setState(() => _showRefundForm = false);
                      },
                      onCancel: () =>
                          setState(() => _showRefundForm = false),
                    ),

                  // Action buttons
                  if (!widget.readOnly &&
                      !_showDepositForm &&
                      !_showRefundForm) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      textDirection: Directionality.of(context),
                      children: [
                        const Spacer(),
                        if (_ledger.deposits.isNotEmpty)
                          _TrackerActionButton(
                            label: context.l10n.bizReqDepRefund,
                            icon: Icons.undo,
                            color: AppColors.textSecondary,
                            onTap: () =>
                                setState(() => _showRefundForm = true),
                          ),
                        if (_ledger.deposits.isNotEmpty)
                          const SizedBox(width: AppSpacing.sm),
                        _TrackerActionButton(
                          label: context.l10n.bizReqDepRecordPayment,
                          icon: Icons.add,
                          color: AppColors.success,
                          onTap: () =>
                              setState(() => _showDepositForm = true),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDepositRecord(DepositRecord record) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: cs.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(
              _methodIcon(record.method),
              size: 16,
              color: AppColors.success,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record.money.toFormattedArabic(),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface,
                    ),
                  ),
                  Text(
                    '${record.method.label}'
                    '${record.methodDetail != null ? ' · ${record.methodDetail}' : ''}'
                    ' · ${record.date}'
                    ' · ${record.recordedBy}',
                    style: TextStyle(
                      fontSize: 10,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (record.receiptPhoto != null)
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(Icons.image, size: 14, color: AppColors.textHint),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRefundRecord(RefundRecord record) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: AppColors.error.withValues(alpha: 0.15)),
        ),
        child: Row(
          children: [
            const Icon(Icons.undo, size: 16, color: AppColors.error),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '-${record.money.toFormattedArabic()}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.error,
                    ),
                  ),
                  Text(
                    '${record.date} · ${record.reason}',
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _methodIcon(DepositMethod method) {
    switch (method) {
      case DepositMethod.cash:
        return Icons.payments_outlined;
      case DepositMethod.cliq:
        return Icons.phone_iphone;
      case DepositMethod.bankTransfer:
        return Icons.account_balance_outlined;
      case DepositMethod.other:
        return Icons.more_horiz;
    }
  }
}

// ─── Sub-widgets ────────────────────────────────────────────

class _StatusPill extends StatelessWidget {
  final String label;
  final Color color;
  const _StatusPill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppRadius.pill,
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double progress;
  const _ProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    final color = progress >= 1.0
        ? AppColors.success
        : progress > 0
            ? AppColors.warning
            : AppColors.textHint;

    return Container(
      height: 6,
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: AppRadius.pill,
      ),
      child: FractionallySizedBox(
        alignment: AlignmentDirectional.centerStart,
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: AppRadius.pill,
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final DepositLedger ledger;
  const _SummaryRow({required this.ledger});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        _SummaryCard(
          label: context.l10n.bizReqDepRequired,
          value: ledger.requiredMoney.toFormattedArabic(),
          color: cs.onSurface,
        ),
        const SizedBox(width: AppSpacing.sm),
        _SummaryCard(
          label: context.l10n.bizReqDepReceived,
          value: ledger.netDepositedMoney.toFormattedArabic(),
          color: AppColors.success,
        ),
        const SizedBox(width: AppSpacing.sm),
        _SummaryCard(
          label: context.l10n.bizReqDepRemaining,
          value: Money(ledger.requiredAmount - ledger.netDeposited)
              .toFormattedArabic(),
          color: AppColors.warning,
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _SummaryCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: cs.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 9, color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      ),
    );
  }
}

class _TrackerActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _TrackerActionButton({
    required this.label,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Add Deposit Form ──────────────────────────────────────

class _AddDepositForm extends StatefulWidget {
  final ValueChanged<DepositRecord> onSave;
  final VoidCallback onCancel;
  const _AddDepositForm({required this.onSave, required this.onCancel});

  @override
  State<_AddDepositForm> createState() => _AddDepositFormState();
}

class _AddDepositFormState extends State<_AddDepositForm> {
  final _amountController = TextEditingController();
  final _detailController = TextEditingController();
  final _notesController = TextEditingController();
  DepositMethod _method = DepositMethod.cash;

  bool get _needsDetail =>
      _method == DepositMethod.cliq || _method == DepositMethod.bankTransfer;

  bool get _canSave {
    final amount = int.tryParse(_amountController.text);
    return amount != null && amount > 0;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _detailController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.bizReqDepFormTitle,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Amount input
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            textDirection: Directionality.of(context),
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: context.l10n.bizReqDepAmountHint,
              hintStyle: const TextStyle(fontSize: 13),
              filled: true,
              fillColor: cs.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                borderSide: BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                borderSide: BorderSide(color: AppColors.border),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Method selector
          Row(
            children: DepositMethod.values.map((m) {
              final isActive = _method == m;
              return Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: m != DepositMethod.values.last ? 6 : 0,
                  ),
                  child: GestureDetector(
                    onTap: () => setState(() => _method = m),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppColors.success.withValues(alpha: 0.1)
                            : cs.surface,
                        borderRadius:
                            BorderRadius.circular(AppRadius.sm),
                        border: Border.all(
                          color: isActive
                              ? AppColors.success
                              : AppColors.border,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        m.label,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight:
                              isActive ? FontWeight.w600 : FontWeight.w500,
                          color: isActive
                              ? AppColors.success
                              : cs.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Method detail
          if (_needsDetail) ...[
            TextField(
              controller: _detailController,
              decoration: InputDecoration(
                hintText: _method == DepositMethod.cliq
                    ? context.l10n.bizReqDepCliqAccount
                    : context.l10n.bizReqDepBankName,
                hintStyle: const TextStyle(fontSize: 13),
                filled: true,
                fillColor: cs.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  borderSide: BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  borderSide: BorderSide(color: AppColors.border),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],

          // Receipt photo placeholder
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: Border.all(
                color: AppColors.textHint,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                Icon(Icons.camera_alt_outlined,
                    size: 20, color: AppColors.textHint),
                const SizedBox(height: 4),
                Text(
                  context.l10n.bizReqDepAttachReceipt,
                  style: TextStyle(fontSize: 10, color: AppColors.textHint),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Notes
          TextField(
            controller: _notesController,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: context.l10n.bizReqDepNotesHint,
              hintStyle: const TextStyle(fontSize: 13),
              filled: true,
              fillColor: cs.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                borderSide: BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                borderSide: BorderSide(color: AppColors.border),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Buttons
          Row(
            textDirection: Directionality.of(context),
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: widget.onCancel,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      context.l10n.bizReqDepCancel,
                      style: TextStyle(
                        fontSize: 13,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: _canSave
                      ? () {
                          final amount =
                              int.parse(_amountController.text) * 100;
                          widget.onSave(DepositRecord(
                            id: 'dep_${DateTime.now().millisecondsSinceEpoch}',
                            amount: amount,
                            method: _method,
                            methodDetail: _needsDetail
                                ? _detailController.text
                                : null,
                            date: DateTime.now().toIso8601String(),
                            notes: _notesController.text.isEmpty
                                ? null
                                : _notesController.text,
                            recordedBy: context.l10n.bizReqDepRecordedBy,
                          ));
                        }
                      : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: _canSave
                          ? AppColors.success
                          : AppColors.success.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check, size: 14, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          context.l10n.bizReqDepSave,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Add Refund Form ───────────────────────────────────────

class _AddRefundForm extends StatefulWidget {
  final int maxAmount; // piasters
  final ValueChanged<RefundRecord> onSave;
  final VoidCallback onCancel;
  const _AddRefundForm({
    required this.maxAmount,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<_AddRefundForm> createState() => _AddRefundFormState();
}

class _AddRefundFormState extends State<_AddRefundForm> {
  final _amountController = TextEditingController();
  final _reasonController = TextEditingController();

  bool get _canSave {
    final amount = int.tryParse(_amountController.text);
    return amount != null &&
        amount > 0 &&
        amount * 100 <= widget.maxAmount &&
        _reasonController.text.trim().isNotEmpty;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.bizReqDepRefundTitle,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            context.l10n.bizReqDepRefundMax(Money(widget.maxAmount).toFormattedArabic()),
            style: const TextStyle(fontSize: 10, color: AppColors.warning),
          ),
          const SizedBox(height: AppSpacing.md),

          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            textDirection: Directionality.of(context),
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: context.l10n.bizReqDepAmountHint,
              hintStyle: const TextStyle(fontSize: 13),
              filled: true,
              fillColor: cs.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                borderSide: BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                borderSide: BorderSide(color: AppColors.border),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          TextField(
            controller: _reasonController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: context.l10n.bizReqDepRefundReasonHint,
              hintStyle: const TextStyle(fontSize: 13),
              filled: true,
              fillColor: cs.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                borderSide: BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                borderSide: BorderSide(color: AppColors.border),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          Row(
            textDirection: Directionality.of(context),
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: widget.onCancel,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      context.l10n.bizReqDepCancel,
                      style: TextStyle(
                        fontSize: 13,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: _canSave
                      ? () {
                          final amount =
                              int.parse(_amountController.text) * 100;
                          widget.onSave(RefundRecord(
                            id: 'ref_${DateTime.now().millisecondsSinceEpoch}',
                            amount: amount,
                            method: DepositMethod.cash,
                            date: DateTime.now().toIso8601String(),
                            reason: _reasonController.text.trim(),
                          ));
                        }
                      : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: _canSave
                          ? AppColors.error
                          : AppColors.error.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check, size: 14, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          context.l10n.bizReqDepConfirmRefund,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
