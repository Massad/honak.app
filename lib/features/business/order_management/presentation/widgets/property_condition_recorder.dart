import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/order_management/domain/entities/property_inspection.dart';


/// 4 collapsible sections for property condition documentation.
class PropertyConditionRecorder extends StatefulWidget {
  final PropertyInspection inspection;
  final ValueChanged<PropertyInspection>? onChange;
  final String currentStatus;
  final bool readOnly;

  const PropertyConditionRecorder({
    super.key,
    required this.inspection,
    this.onChange,
    this.currentStatus = 'accepted',
    this.readOnly = false,
  });

  @override
  State<PropertyConditionRecorder> createState() =>
      _PropertyConditionRecorderState();
}

class _PropertyConditionRecorderState extends State<PropertyConditionRecorder> {
  int? _expandedSection;

  @override
  Widget build(BuildContext context) {
    final canCheckIn = [
      'accepted',
      'deposit_received',
      'checked_in',
    ].contains(widget.currentStatus);

    final canCheckOut = widget.currentStatus == 'checked_in';

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
          // ── Section 1: Check-in ──
          _ConditionSection(
            index: 0,
            expandedIndex: _expandedSection,
            onToggle: (i) => setState(() {
              _expandedSection = _expandedSection == i ? null : i;
            }),
            icon: Icons.login,
            iconColor: AppColors.primary,
            iconBgColor: AppColors.primary.withValues(alpha: 0.1),
            title: context.l10n.bizReqPropCheckIn,
            subtitle: widget.inspection.checkIn != null
                ? context.l10n.bizReqPropDocumented(widget.inspection.checkIn!.photos.length)
                : context.l10n.bizReqPropNotDocumented,
            badge: widget.inspection.checkIn != null ? context.l10n.bizReqPropDone : null,
            child: _CheckRecordContent(
              record: widget.inspection.checkIn,
              canRecord: canCheckIn && !widget.readOnly,
              onStartRecording: () {
                // Placeholder: in real app, open camera/gallery
              },
            ),
          ),

          const Divider(height: 1, indent: 16, endIndent: 16),

          // ── Section 2: Check-out ──
          _ConditionSection(
            index: 1,
            expandedIndex: _expandedSection,
            onToggle: (i) => setState(() {
              _expandedSection = _expandedSection == i ? null : i;
            }),
            icon: Icons.logout,
            iconColor: AppColors.warning,
            iconBgColor: AppColors.warning.withValues(alpha: 0.1),
            title: context.l10n.bizReqPropCheckOut,
            subtitle: widget.inspection.checkOut != null
                ? context.l10n.bizReqPropDocumented(widget.inspection.checkOut!.photos.length)
                : context.l10n.bizReqPropNotDocumented,
            badge: widget.inspection.checkOut != null ? context.l10n.bizReqPropDone : null,
            child: _CheckRecordContent(
              record: widget.inspection.checkOut,
              canRecord: canCheckOut && !widget.readOnly,
              onStartRecording: () {},
            ),
          ),

          const Divider(height: 1, indent: 16, endIndent: 16),

          // ── Section 3: Damages ──
          _ConditionSection(
            index: 2,
            expandedIndex: _expandedSection,
            onToggle: (i) => setState(() {
              _expandedSection = _expandedSection == i ? null : i;
            }),
            icon: Icons.warning_amber_rounded,
            iconColor: AppColors.error,
            iconBgColor: AppColors.error.withValues(alpha: 0.05),
            title: context.l10n.bizReqPropDamages,
            subtitle: widget.inspection.damages.isEmpty
                ? context.l10n.bizReqPropNoDamages
                : context.l10n.bizReqPropDamageCount(widget.inspection.damages.length),
            badgeCount: widget.inspection.damages.length,
            child: _DamageSection(
              damages: widget.inspection.damages,
              readOnly: widget.readOnly,
              onChange: (damages) {
                // Placeholder for onChange
              },
            ),
          ),

          const Divider(height: 1, indent: 16, endIndent: 16),

          // ── Section 4: Inventory ──
          _ConditionSection(
            index: 3,
            expandedIndex: _expandedSection,
            onToggle: (i) => setState(() {
              _expandedSection = _expandedSection == i ? null : i;
            }),
            icon: Icons.checklist_rounded,
            iconColor: const Color(0xFF7C3AED), // purple
            iconBgColor: const Color(0xFF7C3AED).withValues(alpha: 0.05),
            title: context.l10n.bizReqPropInventory,
            subtitle: widget.inspection.inventory.isEmpty
                ? context.l10n.bizReqPropNoInventory
                : context.l10n.bizReqPropItemCount(widget.inspection.inventory.length),
            badgeCount: widget.inspection.inventory.length,
            child: _InventorySection(
              items: widget.inspection.inventory,
              readOnly: widget.readOnly,
              phase: widget.currentStatus == 'checked_in'
                  ? 'checkout'
                  : 'checkin',
              onChange: (items) {
                // Placeholder for onChange
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Collapsible Section Wrapper ──────────────────────────

class _ConditionSection extends StatelessWidget {
  final int index;
  final int? expandedIndex;
  final ValueChanged<int> onToggle;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final String? badge;
  final int badgeCount;
  final Widget child;

  const _ConditionSection({
    required this.index,
    required this.expandedIndex,
    required this.onToggle,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    this.badge,
    this.badgeCount = 0,
    required this.child,
  });

  bool get _isExpanded => expandedIndex == index;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      children: [
        GestureDetector(
          onTap: () => onToggle(index),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Icon(icon, size: 18, color: iconColor),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              title,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: cs.onSurface,
                              ),
                            ),
                          ),
                          if (badge != null) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.success
                                    .withValues(alpha: 0.1),
                                borderRadius: AppRadius.pill,
                              ),
                              child: Text(
                                badge!,
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                          if (badgeCount > 0 && badge == null) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: iconColor.withValues(alpha: 0.1),
                                borderRadius: AppRadius.pill,
                              ),
                              child: Text(
                                '$badgeCount',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: iconColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 10,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 20,
                  color: AppColors.textHint,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.md, 0, AppSpacing.md, AppSpacing.md,
            ),
            child: child,
          ),
      ],
    );
  }
}

// ─── Check-in/out Record Content ─────────────────────────

class _CheckRecordContent extends StatelessWidget {
  final PropertyConditionRecord? record;
  final bool canRecord;
  final VoidCallback onStartRecording;

  const _CheckRecordContent({
    this.record,
    required this.canRecord,
    required this.onStartRecording,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (record != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Photo grid
          if (record!.photos.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: record!.photos.map((photo) {
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Stack(
                    children: [
                      const Center(
                        child: Icon(
                          Icons.image,
                          size: 20,
                          color: AppColors.textHint,
                        ),
                      ),
                      if (photo.area != null)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(AppRadius.sm),
                                bottomRight: Radius.circular(AppRadius.sm),
                              ),
                            ),
                            child: Text(
                              photo.area!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 8,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),

          // Notes
          if (record!.notes.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: cs.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.notes, size: 10, color: cs.onSurfaceVariant),
                      const SizedBox(width: 4),
                      Text(
                        context.l10n.bizReqPropNotes,
                        style: TextStyle(
                          fontSize: 10,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    record!.notes,
                    style: TextStyle(fontSize: 11, color: cs.onSurface),
                  ),
                ],
              ),
            ),
          ],
        ],
      );
    }

    // Not yet recorded
    if (!canRecord) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Text(
            context.l10n.bizReqPropNotAvailable,
            style: TextStyle(fontSize: 11, color: cs.onSurfaceVariant),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onStartRecording,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.3),
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.camera_alt_outlined,
              size: 24,
              color: AppColors.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 6),
            Text(
              context.l10n.bizReqPropStartCheckIn,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Damage Section ──────────────────────────────────────

class _DamageSection extends StatefulWidget {
  final List<DamageReport> damages;
  final bool readOnly;
  final ValueChanged<List<DamageReport>> onChange;

  const _DamageSection({
    required this.damages,
    required this.readOnly,
    required this.onChange,
  });

  @override
  State<_DamageSection> createState() => _DamageSectionState();
}

class _DamageSectionState extends State<_DamageSection> {
  bool _showAddForm = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      children: [
        if (widget.damages.isEmpty && !_showAddForm)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Text(
              context.l10n.bizReqPropNoDamages,
              style: TextStyle(fontSize: 11, color: cs.onSurfaceVariant),
            ),
          ),

        ...widget.damages.map((d) => _buildDamageCard(context, d)),

        if (_showAddForm)
          _AddDamageForm(
            onSave: (damage) {
              widget.onChange([...widget.damages, damage]);
              setState(() => _showAddForm = false);
            },
            onCancel: () => setState(() => _showAddForm = false),
          ),

        if (!widget.readOnly && !_showAddForm) ...[
          const SizedBox(height: AppSpacing.sm),
          GestureDetector(
            onTap: () => setState(() => _showAddForm = true),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(
                  color: AppColors.textHint,
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 14, color: AppColors.textHint),
                  const SizedBox(width: 4),
                  Text(
                    context.l10n.bizReqPropAddDamage,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDamageCard(BuildContext context, DamageReport d) {
    final cs = Theme.of(context).colorScheme;
    final isSevere = d.severity == DamageSeverity.severe;
    final severityColor = isSevere ? AppColors.error : AppColors.warning;
    final resolutionResolved =
        d.resolution != DamageResolution.pending &&
            d.resolution != DamageResolution.disputed;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: cs.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: 14,
              color: severityColor,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    d.description,
                    style: TextStyle(
                      fontSize: 13,
                      color: cs.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: [
                      Text(
                        d.area,
                        style: TextStyle(
                          fontSize: 9,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: severityColor.withValues(alpha: 0.1),
                          borderRadius: AppRadius.pill,
                        ),
                        child: Text(
                          d.severity.label,
                          style: TextStyle(
                            fontSize: 9,
                            color: severityColor,
                          ),
                        ),
                      ),
                      if (d.costEstimate > 0)
                        Text(
                          context.l10n.bizReqPropEstimated(d.costMoney.toFormattedArabic()),
                          style: TextStyle(
                            fontSize: 9,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: resolutionResolved
                              ? AppColors.success.withValues(alpha: 0.1)
                              : AppColors.error.withValues(alpha: 0.05),
                          borderRadius: AppRadius.pill,
                        ),
                        child: Text(
                          d.resolution.label,
                          style: TextStyle(
                            fontSize: 9,
                            color: resolutionResolved
                                ? AppColors.success
                                : AppColors.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Add Damage Form ────────────────────────────────────

class _AddDamageForm extends StatefulWidget {
  final ValueChanged<DamageReport> onSave;
  final VoidCallback onCancel;
  const _AddDamageForm({required this.onSave, required this.onCancel});

  @override
  State<_AddDamageForm> createState() => _AddDamageFormState();
}

class _AddDamageFormState extends State<_AddDamageForm> {
  final _descController = TextEditingController();
  final _costController = TextEditingController();
  String _area = kPropertyAreas.first;
  DamageSeverity _severity = DamageSeverity.minor;

  bool get _canSave => _descController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _descController.dispose();
    _costController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.bizReqPropDamageFormTitle,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Description
          TextField(
            controller: _descController,
            maxLines: 2,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: context.l10n.bizReqPropDamageDescHint,
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
              contentPadding: const EdgeInsets.all(10),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Area picker
          Text(
            context.l10n.bizReqPropLocation,
            style: TextStyle(fontSize: 10, color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: kPropertyAreas.map((area) {
              final isActive = _area == area;
              return GestureDetector(
                onTap: () => setState(() => _area = area),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.error.withValues(alpha: 0.1)
                        : cs.surface,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(
                      color: isActive ? AppColors.error : AppColors.border,
                    ),
                  ),
                  child: Text(
                    area,
                    style: TextStyle(
                      fontSize: 10,
                      color: isActive ? AppColors.error : cs.onSurfaceVariant,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Severity + Cost
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.bizReqPropSeverity,
                      style: TextStyle(
                        fontSize: 10,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: DamageSeverity.values.map((s) {
                        final isActive = _severity == s;
                        final sColor = s == DamageSeverity.severe
                            ? AppColors.error
                            : AppColors.warning;
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              end: s != DamageSeverity.severe ? 4 : 0,
                            ),
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _severity = s),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? sColor.withValues(alpha: 0.1)
                                      : cs.surface,
                                  borderRadius: BorderRadius.circular(
                                    AppRadius.sm,
                                  ),
                                  border: Border.all(
                                    color: isActive
                                        ? sColor
                                        : AppColors.border,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  s.label,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: isActive
                                        ? sColor
                                        : cs.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              SizedBox(
                width: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.bizReqPropCost,
                      style: TextStyle(
                        fontSize: 10,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _costController,
                      keyboardType: TextInputType.number,
                      textDirection: Directionality.of(context),
                      decoration: InputDecoration(
                        hintText: context.l10n.bizReqPropCostHint,
                        hintStyle: const TextStyle(fontSize: 13),
                        filled: true,
                        fillColor: cs.surface,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppRadius.sm),
                          borderSide:
                              BorderSide(color: AppColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppRadius.sm),
                          borderSide:
                              BorderSide(color: AppColors.border),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        isDense: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Photo placeholder
          GestureDetector(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(color: AppColors.textHint),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt_outlined,
                      size: 14, color: AppColors.textHint),
                  const SizedBox(width: 6),
                  Text(
                    context.l10n.bizReqPropAttachPhotos,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Buttons
          Row(
            textDirection: Directionality.of(context),
            children: [
              GestureDetector(
                onTap: widget.onCancel,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Text(
                    context.l10n.bizReqPropCancel,
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: GestureDetector(
                  onTap: _canSave
                      ? () {
                          final cost =
                              (int.tryParse(_costController.text) ?? 0) * 100;
                          widget.onSave(DamageReport(
                            id: 'dmg_${DateTime.now().millisecondsSinceEpoch}',
                            description: _descController.text.trim(),
                            area: _area,
                            costEstimate: cost,
                            severity: _severity,
                            reportedAt: DateTime.now().toIso8601String(),
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
                          context.l10n.bizReqPropRecord,
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

// ─── Inventory Section ──────────────────────────────────

class _InventorySection extends StatefulWidget {
  final List<InventoryItem> items;
  final bool readOnly;
  final String phase; // 'checkin' | 'checkout'
  final ValueChanged<List<InventoryItem>> onChange;

  const _InventorySection({
    required this.items,
    required this.readOnly,
    required this.phase,
    required this.onChange,
  });

  @override
  State<_InventorySection> createState() => _InventorySectionState();
}

class _InventorySectionState extends State<_InventorySection> {
  final _newItemController = TextEditingController();

  @override
  void dispose() {
    _newItemController.dispose();
    super.dispose();
  }

  void _addItem() {
    final name = _newItemController.text.trim();
    if (name.isEmpty) return;
    widget.onChange([
      ...widget.items,
      InventoryItem(
        id: 'inv_${DateTime.now().millisecondsSinceEpoch}',
        name: name,
      ),
    ]);
    _newItemController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const purple = Color(0xFF7C3AED);

    return Column(
      children: [
        if (widget.items.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Text(
              context.l10n.bizReqPropEmptyInventory,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: cs.onSurfaceVariant),
            ),
          ),

        ...widget.items.map((item) {
          final isChecked = widget.phase == 'checkin'
              ? item.checkedIn
              : item.checkedOut;

          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: cs.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Row(
                children: [
                  if (!widget.readOnly)
                    GestureDetector(
                      onTap: () {
                        final updated = widget.items.map((i) {
                          if (i.id != item.id) return i;
                          return widget.phase == 'checkin'
                              ? i.copyWith(checkedIn: !i.checkedIn)
                              : i.copyWith(checkedOut: !i.checkedOut);
                        }).toList();
                        widget.onChange(updated);
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        margin: const EdgeInsetsDirectional.only(end: 8),
                        decoration: BoxDecoration(
                          color: isChecked
                              ? AppColors.success
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: isChecked
                                ? AppColors.success
                                : AppColors.textHint,
                            width: 2,
                          ),
                        ),
                        child: isChecked
                            ? const Icon(
                                Icons.check,
                                size: 14,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                  Expanded(
                    child: Text(
                      item.name,
                      style: TextStyle(fontSize: 13, color: cs.onSurface),
                    ),
                  ),
                  Text(
                    'x${item.quantity}',
                    style: TextStyle(
                      fontSize: 10,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),

        if (!widget.readOnly) ...[
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _newItemController,
                  onSubmitted: (_) => _addItem(),
                  decoration: InputDecoration(
                    hintText: context.l10n.bizReqPropAddItemHint,
                    hintStyle: const TextStyle(fontSize: 12),
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
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              GestureDetector(
                onTap: _addItem,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: purple.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Icon(Icons.add, size: 18, color: purple),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
