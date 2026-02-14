import 'package:flutter/material.dart';

import 'package:honak/config/business_type_config.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/domain/entities/team_member.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

/// Shows a bottom sheet to add a new team member with phone, role suggestions,
/// and permission toggles.
Future<void> showAddMemberSheet(
  BuildContext context, {
  BusinessTypeConfig? config,
  required ValueChanged<TeamMember> onAdd,
}) {
  return showAppSheet(
    context,
    builder: (_) => _AddMemberContent(config: config, onAdd: onAdd),
  );
}

class _AddMemberContent extends StatefulWidget {
  final BusinessTypeConfig? config;
  final ValueChanged<TeamMember> onAdd;

  const _AddMemberContent({this.config, required this.onAdd});

  @override
  State<_AddMemberContent> createState() => _AddMemberContentState();
}

class _AddMemberContentState extends State<_AddMemberContent> {
  final _phoneCtrl = TextEditingController();
  final _roleCtrl = TextEditingController();
  String? _selectedRoleLabel;
  final Set<String> _selectedPermissions = {};

  List<SuggestedRole> get _suggestedRoles =>
      widget.config?.suggestedRoles ?? [];

  List<PermissionMeta> get _availablePerms =>
      widget.config?.availablePermissions ?? [];

  bool get _canAdd => _phoneCtrl.text.trim().length >= 10;

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _roleCtrl.dispose();
    super.dispose();
  }

  void _selectSuggestedRole(SuggestedRole role) {
    setState(() {
      _selectedRoleLabel = role.labelAr;
      _roleCtrl.text = role.labelAr;
      _selectedPermissions
        ..clear()
        ..addAll(role.defaultPermissions);
    });
  }

  void _togglePermission(String permId) {
    setState(() {
      if (_selectedPermissions.contains(permId)) {
        _selectedPermissions.remove(permId);
      } else {
        _selectedPermissions.add(permId);
      }
    });
  }

  void _submit() {
    final phone = _phoneCtrl.text.trim();
    if (phone.isEmpty) return;

    final role = _roleCtrl.text.trim();
    final member = TeamMember(
      id: 'tm_${DateTime.now().millisecondsSinceEpoch}',
      name: 'عضو جديد',
      phone: phone,
      role: role.isNotEmpty ? role : 'موظف',
      active: true,
      permissions: _selectedPermissions.toList(),
      joinedAt: DateTime.now().toIso8601String().split('T').first,
    );

    widget.onAdd(member);
    Navigator.pop(context);
  }

  // ─── Permission icon mapping ────────────────────────────────
  static const _permIcon = <String, IconData>{
    'manage_availability': Icons.calendar_today_outlined,
    'manage_catalog': Icons.inventory_2_outlined,
    'manage_orders': Icons.shopping_bag_outlined,
    'respond_chat': Icons.chat_bubble_outline,
    'post_updates': Icons.edit_outlined,
    'view_insights': Icons.bar_chart_outlined,
    'manage_settings': Icons.settings_outlined,
    'manage_team': Icons.people_outline,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Drag handle
        Center(
          child: Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(
              top: AppSpacing.sm,
              bottom: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),

        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Text(
              'إضافة عضو جديد',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        Flexible(
          child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg),
                  children: [
                    // Phone field
                    _FieldLabel(label: 'رقم الهاتف *'),
                    const SizedBox(height: AppSpacing.sm),
                    TextField(
                      controller: _phoneCtrl,
                      keyboardType: TextInputType.phone,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.right,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: '07XXXXXXXX',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.md,
                        ),
                        prefixIcon: Icon(
                          Icons.phone_outlined,
                          size: 18,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: AppColors.primary),
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Role section
                    _FieldLabel(label: 'الدور'),
                    const SizedBox(height: AppSpacing.sm),

                    // Suggested role pills
                    if (_suggestedRoles.isNotEmpty) ...[
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        textDirection: TextDirection.rtl,
                        children: _suggestedRoles.map((role) {
                          final isSelected =
                              _selectedRoleLabel == role.labelAr;
                          return GestureDetector(
                            onTap: () => _selectSuggestedRole(role),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary.withValues(alpha: 0.1)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : Theme.of(context).colorScheme.outline,
                                ),
                              ),
                              child: Text(
                                role.labelAr,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected
                                      ? AppColors.primary
                                      : Theme.of(context).colorScheme.onSurfaceVariant,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                    ],

                    // Custom role input
                    TextField(
                      controller: _roleCtrl,
                      decoration: InputDecoration(
                        hintText: 'أو اكتب الدور...',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.md,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: AppColors.primary),
                        ),
                      ),
                      onChanged: (_) =>
                          setState(() => _selectedRoleLabel = null),
                    ),

                    // Permissions grid
                    if (_availablePerms.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.xl),
                      _FieldLabel(label: 'الصلاحيات'),
                      const SizedBox(height: AppSpacing.sm),
                      ..._availablePerms.map((perm) {
                        final hasIt =
                            _selectedPermissions.contains(perm.id);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: InkWell(
                            onTap: () => _togglePermission(perm.id),
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 36,
                                    height: 24,
                                    child: FittedBox(
                                      child: Switch(
                                        value: hasIt,
                                        onChanged: (_) =>
                                            _togglePermission(perm.id),
                                        activeTrackColor: AppColors.primary.withValues(alpha: 0.4),
                                        activeThumbColor: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    perm.labelAr,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: hasIt
                                          ? Theme.of(context).colorScheme.onSurface
                                          : Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.sm),
                                  Icon(
                                    _permIcon[perm.id] ??
                                        Icons.check_circle_outline,
                                    size: 16,
                                    color: hasIt
                                        ? AppColors.primary.withValues(alpha: 0.6)
                                        : Theme.of(context).colorScheme.outline,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],

                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),

              // Submit button
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _canAdd ? _submit : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Theme.of(context).colorScheme.surface,
                      disabledBackgroundColor: Theme.of(context).colorScheme.outlineVariant,
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.md),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'إضافة العضو',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;

  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
