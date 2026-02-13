import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';

class VenueSettings extends ConsumerStatefulWidget {
  final VoidCallback onClose;
  const VenueSettings({super.key, required this.onClose});

  @override
  ConsumerState<VenueSettings> createState() => _VenueSettingsState();
}

class _VenueSettingsState extends ConsumerState<VenueSettings> {
  int _capacity = 100;
  final Set<String> _selectedSetups = {'theater', 'wedding'};
  bool _requiresDeposit = false;
  String _depositType = 'percentage';
  int _depositPercentage = 25;
  final _fixedAmountCtrl = TextEditingController(text: '50');

  static const _setups = <String, (IconData, String)>{
    'theater': (Icons.event_seat, 'مسرحي'),
    'banquet': (Icons.table_restaurant, 'مائدة مستديرة'),
    'cocktail': (Icons.local_bar, 'كوكتيل'),
    'classroom': (Icons.school, 'صف دراسي'),
    'u_shape': (Icons.border_bottom, 'شكل U'),
    'wedding': (Icons.celebration, 'حفل زفاف'),
  };

  @override
  void dispose() {
    _fixedAmountCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubScreenAppBar(title: 'إعدادات القاعة', onClose: widget.onClose),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              _buildCapacity(),
              const SizedBox(height: AppSpacing.xl),
              _buildSetups(),
              const SizedBox(height: AppSpacing.xl),
              _buildDeposit(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCapacity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text('السعة القصوى', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: AppSpacing.md),
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => setState(() => _capacity += 10),
                icon: const Icon(Icons.add, size: 18),
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                style: IconButton.styleFrom(backgroundColor: AppColors.primary.withValues(alpha: 0.08)),
              ),
              const SizedBox(width: AppSpacing.lg),
              Column(children: [
                Text('$_capacity', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.primary)),
                Text('شخص', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
              ]),
              const SizedBox(width: AppSpacing.lg),
              IconButton(
                onPressed: _capacity > 10 ? () => setState(() => _capacity -= 10) : null,
                icon: const Icon(Icons.remove, size: 18),
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                style: IconButton.styleFrom(backgroundColor: Colors.grey.shade50),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSetups() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text('أنماط الترتيب', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: AppSpacing.sm),
        Text('اختر أنماط الترتيب المتاحة', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: 8, runSpacing: 8, alignment: WrapAlignment.end,
          children: _setups.entries.map((e) {
            final on = _selectedSetups.contains(e.key);
            return _chip(e.value.$2, e.value.$1, on, () {
              setState(() => on ? _selectedSetups.remove(e.key) : _selectedSetups.add(e.key));
            });
          }).toList(),
        ),
      ],
    );
  }

  Widget _chip(String label, IconData icon, bool on, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: on ? AppColors.primary.withValues(alpha: 0.08) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: on ? AppColors.primary.withValues(alpha: 0.3) : Colors.grey.shade200),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(label, style: TextStyle(fontSize: 12, color: on ? AppColors.primary : Colors.grey.shade700, fontWeight: on ? FontWeight.w500 : FontWeight.normal)),
          const SizedBox(width: 4),
          Icon(icon, size: 16, color: on ? AppColors.primary : Colors.grey.shade400),
        ]),
      ),
    );
  }

  Widget _buildDeposit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade100)),
          child: Row(children: [
            Switch(value: _requiresDeposit, onChanged: (v) => setState(() => _requiresDeposit = v), activeTrackColor: AppColors.primary),
            const Spacer(),
            const Text('يتطلب عربون', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ]),
        ),
        if (_requiresDeposit) ...[
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade100)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              _depositRadio('percentage', 'نسبة من المبلغ'),
              if (_depositType == 'percentage') ...[
                const SizedBox(height: AppSpacing.sm),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  for (final p in [10, 25, 50])
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 8),
                      child: GestureDetector(
                        onTap: () => setState(() => _depositPercentage = p),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _depositPercentage == p ? AppColors.primary.withValues(alpha: 0.08) : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: _depositPercentage == p ? AppColors.primary.withValues(alpha: 0.3) : Colors.grey.shade200),
                          ),
                          child: Text('$p%', style: TextStyle(fontSize: 12, fontWeight: _depositPercentage == p ? FontWeight.w600 : FontWeight.normal, color: _depositPercentage == p ? AppColors.primary : Colors.grey.shade700)),
                        ),
                      ),
                    ),
                ]),
              ],
              const SizedBox(height: AppSpacing.md),
              _depositRadio('fixed', 'مبلغ ثابت'),
              if (_depositType == 'fixed') ...[
                const SizedBox(height: AppSpacing.sm),
                SizedBox(
                  width: 120,
                  child: TextField(
                    controller: _fixedAmountCtrl,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      suffixText: 'د.أ', isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ],
            ]),
          ),
        ],
      ],
    );
  }

  Widget _depositRadio(String value, String label) {
    return GestureDetector(
      onTap: () => setState(() => _depositType = value),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text(label, style: TextStyle(fontSize: 13, color: _depositType == value ? AppColors.primary : Colors.grey.shade700)),
        const SizedBox(width: 8),
        Radio<String>(value: value, groupValue: _depositType, onChanged: (v) => setState(() => _depositType = v!), activeColor: AppColors.primary, visualDensity: VisualDensity.compact),
      ]),
    );
  }
}
