import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/account/domain/entities/address.dart';
import 'package:honak/features/account/presentation/widgets/address_form.dart';
import 'package:honak/features/account/presentation/widgets/sub_screen_header.dart';
import 'package:honak/shared/widgets/app_screen.dart';

class MyAddressesPage extends StatefulWidget {
  const MyAddressesPage({super.key});

  @override
  State<MyAddressesPage> createState() => _MyAddressesPageState();
}

class _MyAddressesPageState extends State<MyAddressesPage> {
  List<Address>? _addresses;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    final jsonStr = await rootBundle.loadString(
      'assets/api/auth/addresses.json',
    );
    final list = jsonDecode(jsonStr) as List;
    setState(() {
      _addresses = list
          .map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList();
      _loading = false;
    });
  }

  void _setDefault(int index) {
    setState(() {
      _addresses = _addresses!.asMap().entries.map((e) {
        return e.value.copyWith(isDefault: e.key == index);
      }).toList();
    });
    context.showSnackBar('تم تغيير العنوان الافتراضي');
  }

  void _delete(int index) {
    setState(() => _addresses!.removeAt(index));
    context.showSnackBar('تم حذف العنوان');
  }

  void _openAddForm() {
    Navigator.of(context).push<Address>(
      MaterialPageRoute(
        builder: (_) => AddressFormPage(
          onSave: (addr) {
            final newAddr = addr.copyWith(
              id: 'addr_${DateTime.now().millisecondsSinceEpoch}',
            );
            setState(() {
              if (newAddr.isDefault) {
                _addresses = _addresses!
                    .map((a) => a.copyWith(isDefault: false))
                    .toList();
              }
              _addresses!.add(newAddr);
            });
            context.showSnackBar('تم إضافة العنوان');
          },
        ),
      ),
    );
  }

  void _openEditForm(int index) {
    Navigator.of(context).push<Address>(
      MaterialPageRoute(
        builder: (_) => AddressFormPage(
          address: _addresses![index],
          onSave: (updated) {
            setState(() {
              if (updated.isDefault) {
                _addresses = _addresses!
                    .map((a) => a.copyWith(isDefault: false))
                    .toList();
              }
              _addresses![index] = updated;
            });
            context.showSnackBar('تم حفظ التعديلات');
          },
        ),
      ),
    );
  }

  IconData _iconForLabel(String labelIcon) {
    switch (labelIcon) {
      case 'briefcase':
        return Icons.work_outline;
      case 'users':
        return Icons.people_outline;
      case 'home':
      default:
        return Icons.home_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      backgroundColor: context.colorScheme.surfaceContainerLowest,
      appBar: const SubScreenHeader(title: 'عناويني'),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _addresses!.isEmpty
          ? _EmptyState(onAdd: _openAddForm)
          : ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.lg,
              ),
              children: [
                ..._addresses!.asMap().entries.map((entry) {
                  final i = entry.key;
                  final addr = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: i < _addresses!.length - 1 ? AppSpacing.md : 0,
                    ),
                    child: _AddressCard(
                      address: addr,
                      iconData: _iconForLabel(addr.labelIcon),
                      onSetDefault: () => _setDefault(i),
                      onEdit: () => _openEditForm(i),
                      onDelete: () => _delete(i),
                    ),
                  );
                }),
                const SizedBox(height: AppSpacing.md),
                _AddButton(onTap: _openAddForm),
              ],
            ),
    );
  }
}

// ── Address Card ──

class _AddressCard extends StatelessWidget {
  final Address address;
  final IconData iconData;
  final VoidCallback onSetDefault;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _AddressCard({
    required this.address,
    required this.iconData,
    required this.onSetDefault,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: address.isDefault
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : context.colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(
                  iconData,
                  size: 18,
                  color: address.isDefault
                      ? AppColors.primary
                      : AppColors.textHint,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          address.label,
                          style: context.textTheme.bodyMedium,
                        ),
                        if (address.isDefault) ...[
                          const SizedBox(width: AppSpacing.sm),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: AppRadius.pill,
                            ),
                            child: Text(
                              'افتراضي',
                              style: context.textTheme.labelSmall?.copyWith(
                                fontSize: 9,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${address.area}، ${address.city}',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      [
                        address.street,
                        if (address.building.isNotEmpty) address.building,
                        if (address.floor.isNotEmpty) 'ط${address.floor}',
                      ].join(' \u00b7 '),
                      style: context.textTheme.labelSmall?.copyWith(
                        color: AppColors.textHint,
                      ),
                    ),
                    if (address.notes.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        address.notes,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.textHint,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.only(top: AppSpacing.md),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: context.colorScheme.surfaceContainerLowest,
                ),
              ),
            ),
            child: Row(
              children: [
                if (!address.isDefault)
                  _ActionBtn(
                    icon: Icons.star_outline,
                    label: 'تعيين افتراضي',
                    color: AppColors.primary,
                    onTap: onSetDefault,
                  ),
                _ActionBtn(
                  icon: Icons.edit_outlined,
                  label: 'تعديل',
                  color: AppColors.textSecondary,
                  onTap: onEdit,
                ),
                const Spacer(),
                _ActionBtn(
                  icon: Icons.delete_outline,
                  label: 'حذف',
                  color: AppColors.error,
                  onTap: onDelete,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.sm),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 10, color: color),
            const SizedBox(width: AppSpacing.xs),
            Text(label, style: TextStyle(fontSize: 10, color: color)),
          ],
        ),
      ),
    );
  }
}

// ── Empty State ──

class _EmptyState extends StatelessWidget {
  final VoidCallback onAdd;

  const _EmptyState({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 40,
              color: AppColors.divider,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'لا توجد عناوين محفوظة',
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.textHint,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'أضف عنوانك لتسهيل الطلبات',
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.textHint,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            _AddButton(onTap: onAdd),
          ],
        ),
      ),
    );
  }
}

// ── Add Button (dashed border) ──

class _AddButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.surface,
      borderRadius: AppRadius.card,
      child: InkWell(
        borderRadius: AppRadius.card,
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            borderRadius: AppRadius.card,
            border: Border.all(
              color: AppColors.divider,
              style: BorderStyle.solid,
              // Flutter doesn't support dashed borders natively;
              // using a solid gray-200 border as visual equivalent
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 18, color: AppColors.textSecondary),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'إضافة عنوان جديد',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
