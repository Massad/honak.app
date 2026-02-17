import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';

// ═══════════════════════════════════════════════════════════════════
// Data Classes
// ═══════════════════════════════════════════════════════════════════

class FeatureItem {
  String id;
  String name;
  String type; // 'count' or 'toggle'
  int count;
  bool enabled;

  FeatureItem({
    required this.id,
    required this.name,
    this.type = 'toggle',
    this.count = 1,
    this.enabled = true,
  });

  FeatureItem copy() => FeatureItem(
      id: id, name: name, type: type, count: count, enabled: enabled);
}

class FeatureCategory {
  String id;
  String name;
  List<FeatureItem> items;

  FeatureCategory({
    required this.id,
    required this.name,
    List<FeatureItem>? items,
  }) : items = items ?? [];

  int get enabledCount => items.where((i) => i.enabled).length;
}

// ═══════════════════════════════════════════════════════════════════
// Icon Mapping
// ═══════════════════════════════════════════════════════════════════

class _IconEntry {
  final IconData icon;
  final Color color;
  const _IconEntry(this.icon, this.color);
}

const _iconMap = <String, _IconEntry>{
  'غرف نوم': _IconEntry(Icons.bed, AppColors.primary),
  'حمامات': _IconEntry(Icons.bathtub_outlined, AppColors.primary),
  'الحد الأقصى للضيوف': _IconEntry(Icons.people_outlined, AppColors.primary),
  'مسبح خاص': _IconEntry(Icons.water_drop_outlined, AppColors.primary),
  'مسبح': _IconEntry(Icons.water_drop_outlined, AppColors.primary),
  'جاكوزي': _IconEntry(Icons.water_drop_outlined, Colors.purple),
  'بركة ساخنة': _IconEntry(Icons.water_drop_outlined, Colors.purple),
  'حديقة': _IconEntry(Icons.park_outlined, Colors.green),
  'شواء BBQ': _IconEntry(Icons.local_fire_department, Colors.orange),
  'مقاعد سيارات': _IconEntry(Icons.directions_car_outlined, Colors.grey),
  'واي فاي': _IconEntry(Icons.wifi, AppColors.primary),
  'مكيف': _IconEntry(Icons.air, Colors.lightBlue),
  'مطبخ مجهز': _IconEntry(Icons.restaurant, Colors.amber),
  'غسالة ملابس': _IconEntry(Icons.local_laundry_service, Colors.grey),
  'تلفزيون': _IconEntry(Icons.tv, Colors.grey),
  'نظام صوتي': _IconEntry(Icons.music_note, Colors.purple),
  'ملعب أطفال': _IconEntry(Icons.child_friendly, Colors.pink),
  'أرجوحة': _IconEntry(Icons.child_friendly, Colors.pink),
  'منطقة شعلة نار': _IconEntry(Icons.local_fire_department, Colors.deepOrange),
  'شرفة': _IconEntry(Icons.balcony, Colors.amber),
  'إطلالة': _IconEntry(Icons.landscape, Colors.green),
  'مصعد': _IconEntry(Icons.apartment, Colors.grey),
  'كاميرات خارجية': _IconEntry(Icons.videocam_outlined, Colors.grey),
  'غرفة ألعاب': _IconEntry(Icons.sports_esports, Colors.indigo),
  'صالة رياضية': _IconEntry(Icons.fitness_center, Colors.red),
  'ساونا': _IconEntry(Icons.waves, Colors.amber),
  'نظام أمان': _IconEntry(Icons.security, Colors.green),
  'صالة معيشة': _IconEntry(Icons.weekend, AppColors.primary),
  'مطبخ خارجي': _IconEntry(Icons.outdoor_grill, Colors.amber),
  'غرفة خادمة': _IconEntry(Icons.room_service, Colors.grey),
};

Widget getItemIcon(String name) {
  final entry = _iconMap[name] ?? _findPartialMatch(name);
  return Icon(entry.icon, size: 14, color: entry.color);
}

_IconEntry _findPartialMatch(String name) {
  for (final e in _iconMap.entries) {
    if (name.contains(e.key) || e.key.contains(name)) return e.value;
  }
  return const _IconEntry(Icons.auto_awesome, AppColors.textHint);
}

// ═══════════════════════════════════════════════════════════════════
// Suggested Items
// ═══════════════════════════════════════════════════════════════════

const suggestedItems = <({String name, String type})>[
  (name: 'جاكوزي', type: 'toggle'),
  (name: 'بركة ساخنة', type: 'toggle'),
  (name: 'شرفة', type: 'toggle'),
  (name: 'إطلالة', type: 'toggle'),
  (name: 'مصعد', type: 'toggle'),
  (name: 'كاميرات خارجية', type: 'toggle'),
  (name: 'غرفة ألعاب', type: 'toggle'),
  (name: 'صالة رياضية', type: 'toggle'),
  (name: 'ساونا', type: 'toggle'),
  (name: 'نظام أمان', type: 'toggle'),
  (name: 'أرجوحة', type: 'toggle'),
  (name: 'صالة معيشة', type: 'count'),
  (name: 'مطبخ خارجي', type: 'toggle'),
  (name: 'غرفة خادمة', type: 'count'),
];

// ═══════════════════════════════════════════════════════════════════
// Default Categories Builder
// ═══════════════════════════════════════════════════════════════════

List<FeatureCategory> buildDefaultCategories({
  int maxGuests = 10,
  int bedrooms = 4,
  int bathrooms = 3,
  List<String> amenities = const [],
}) {
  bool has(String name) =>
      amenities.isEmpty || amenities.contains(name);

  return [
    FeatureCategory(id: 'basics', name: 'معلومات أساسية', items: [
      FeatureItem(id: 'max_guests', name: 'الحد الأقصى للضيوف',
          type: 'count', count: maxGuests),
      FeatureItem(id: 'bedrooms', name: 'غرف نوم',
          type: 'count', count: bedrooms),
      FeatureItem(id: 'bathrooms', name: 'حمامات',
          type: 'count', count: bathrooms),
    ]),
    FeatureCategory(id: 'outdoor', name: 'المرافق الخارجية', items: [
      FeatureItem(id: 'pool', name: 'مسبح خاص', enabled: has('مسبح خاص')),
      FeatureItem(id: 'garden', name: 'حديقة', enabled: has('حديقة')),
      FeatureItem(id: 'bbq', name: 'شواء BBQ', enabled: has('شواء BBQ')),
      FeatureItem(id: 'parking', name: 'مقاعد سيارات',
          enabled: has('مقاعد سيارات')),
      FeatureItem(id: 'playground', name: 'ملعب أطفال', enabled: false),
      FeatureItem(id: 'firepit', name: 'منطقة شعلة نار', enabled: false),
    ]),
    FeatureCategory(id: 'indoor', name: 'المرافق الداخلية', items: [
      FeatureItem(id: 'wifi', name: 'واي فاي', enabled: has('واي فاي')),
      FeatureItem(id: 'ac', name: 'مكيف', enabled: has('مكيف')),
      FeatureItem(id: 'kitchen', name: 'مطبخ مجهز',
          enabled: has('مطبخ مجهز')),
      FeatureItem(id: 'washer', name: 'غسالة ملابس',
          enabled: has('غسالة ملابس')),
      FeatureItem(id: 'tv', name: 'تلفزيون', enabled: has('تلفزيون')),
      FeatureItem(id: 'sound', name: 'نظام صوتي', enabled: false),
    ]),
  ];
}

// ═══════════════════════════════════════════════════════════════════
// Feature Item Row
// ═══════════════════════════════════════════════════════════════════

class FeatureItemRow extends StatelessWidget {
  final FeatureItem item;
  final bool reorderMode;
  final bool isFirst;
  final bool isLast;
  final bool isEditing;
  final TextEditingController? editCtrl;
  final VoidCallback onToggle;
  final ValueChanged<int> onCountChange;
  final VoidCallback onEditStart;
  final VoidCallback onEditSave;
  final VoidCallback onEditCancel;
  final VoidCallback onDelete;
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;

  const FeatureItemRow({
    super.key,
    required this.item,
    this.reorderMode = false,
    this.isFirst = false,
    this.isLast = false,
    this.isEditing = false,
    this.editCtrl,
    required this.onToggle,
    required this.onCountChange,
    required this.onEditStart,
    required this.onEditSave,
    required this.onEditCancel,
    required this.onDelete,
    this.onMoveUp,
    this.onMoveDown,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: item.enabled ? 1.0 : 0.5,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Row(
          children: [
            if (reorderMode) ...[
              Column(mainAxisSize: MainAxisSize.min, children: [
                GestureDetector(
                  onTap: isFirst ? null : onMoveUp,
                  child: Icon(Icons.arrow_upward, size: 10,
                      color: isFirst ? AppColors.divider : AppColors.primary),
                ),
                const SizedBox(height: 2),
                GestureDetector(
                  onTap: isLast ? null : onMoveDown,
                  child: Icon(Icons.arrow_downward, size: 10,
                      color: isLast ? AppColors.divider : AppColors.primary),
                ),
              ]),
              const SizedBox(width: AppSpacing.sm),
            ],
            getItemIcon(item.name),
            const SizedBox(width: AppSpacing.sm),
            if (isEditing && editCtrl != null)
              Expanded(child: Row(children: [
                Expanded(child: TextField(
                  controller: editCtrl,
                  autofocus: true,
                  style: const TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: context.colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      borderSide: BorderSide(
                          color: context.colorScheme.outlineVariant)),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                  ),
                  onSubmitted: (_) => onEditSave(),
                )),
                const SizedBox(width: 4),
                GestureDetector(onTap: onEditSave,
                    child: const Icon(Icons.check, size: 12,
                        color: AppColors.success)),
                const SizedBox(width: 4),
                GestureDetector(onTap: onEditCancel,
                    child: Icon(Icons.close, size: 12,
                        color: AppColors.textHint)),
              ]))
            else ...[
              Expanded(child: Text(item.name, style: TextStyle(fontSize: 12,
                  color: context.colorScheme.onSurface))),
              if (item.type == 'count') _buildStepper(context)
              else _buildToggle(),
              const SizedBox(width: 4),
              GestureDetector(onTap: onEditStart,
                  child: Icon(Icons.edit_outlined, size: 10,
                      color: AppColors.textHint.withValues(alpha: 0.5))),
              const SizedBox(width: 4),
              GestureDetector(onTap: onDelete,
                  child: Icon(Icons.delete_outline, size: 10,
                      color: AppColors.textHint.withValues(alpha: 0.5))),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStepper(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      _stepBtn(context, '−', () => onCountChange(item.count - 1)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Text('${item.count}', style: TextStyle(fontSize: 13,
            color: context.colorScheme.onSurface),
            textDirection: Directionality.of(context)),
      ),
      _stepBtn(context, '+', () => onCountChange(item.count + 1)),
    ]);
  }

  Widget _stepBtn(BuildContext context, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24, height: 24,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: context.colorScheme.outlineVariant),
        ),
        child: Center(child: Text(label, style: TextStyle(fontSize: 12,
            color: AppColors.textSecondary))),
      ),
    );
  }

  Widget _buildToggle() {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        width: 32, height: 18,
        decoration: BoxDecoration(
          color: item.enabled ? AppColors.success : AppColors.textHint,
          borderRadius: BorderRadius.circular(9),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 150),
          alignment: item.enabled
              ? AlignmentDirectional.centerEnd
              : AlignmentDirectional.centerStart,
          child: Container(
            width: 14, height: 14,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
              boxShadow: [BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1), blurRadius: 2)],
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// Add Item Form
// ═══════════════════════════════════════════════════════════════════

class AddItemForm extends StatefulWidget {
  final ValueChanged<FeatureItem> onAdd;
  final VoidCallback onCancel;

  const AddItemForm({
    super.key,
    required this.onAdd,
    required this.onCancel,
  });

  @override
  State<AddItemForm> createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _nameCtrl = TextEditingController();
  String _type = 'toggle';
  int _count = 1;

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) return;
    widget.onAdd(FeatureItem(
      id: 'f_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      type: _type,
      count: _type == 'count' ? _count : 1,
      enabled: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: const Color(0xFFBBDEFB)),
      ),
      child: Column(
        children: [
          TextField(
            controller: _nameCtrl,
            autofocus: true,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 12),
            decoration: InputDecoration(
              hintText: context.l10n.propFeatureItemName,
              filled: true,
              fillColor: context.colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                borderSide: BorderSide(
                    color: context.colorScheme.outlineVariant)),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
            ),
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(children: [
            Expanded(child: _typeChip(context.l10n.propFeatureToggle, 'toggle')),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: _typeChip(context.l10n.propFeatureCount, 'count')),
          ]),
          if (_type == 'count') ...[
            const SizedBox(height: AppSpacing.sm),
            Row(children: [
              Text(context.l10n.propFeatureCountLabel, style: const TextStyle(
                  fontSize: 10, color: AppColors.textSecondary)),
              const SizedBox(width: AppSpacing.sm),
              SizedBox(
                width: 60,
                child: TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  textDirection: Directionality.of(context),
                  style: const TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: context.colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      borderSide: BorderSide(
                          color: context.colorScheme.outlineVariant)),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 4, vertical: 6),
                  ),
                  controller: TextEditingController(text: '$_count'),
                  onChanged: (v) => _count = int.tryParse(v) ?? 1,
                ),
              ),
            ]),
          ],
          const SizedBox(height: AppSpacing.sm),
          Row(children: [
            Expanded(child: GestureDetector(
              onTap: _submit,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add, size: 12, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(context.l10n.propFeatureAdd, style: const TextStyle(
                        fontSize: 12, color: Colors.white)),
                  ],
                ),
              ),
            )),
            const SizedBox(width: AppSpacing.sm),
            GestureDetector(
              onTap: widget.onCancel,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Text(context.l10n.cancel, style: const TextStyle(
                    fontSize: 12, color: AppColors.textSecondary)),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _typeChip(String label, String type) {
    final active = _type == type;
    return GestureDetector(
      onTap: () => setState(() => _type = type),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : context.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: active ? null : Border.all(
              color: context.colorScheme.outlineVariant),
        ),
        child: Center(child: Text(label, style: TextStyle(
          fontSize: 10,
          color: active ? Colors.white : AppColors.textSecondary,
        ))),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// Suggestions Panel
// ═══════════════════════════════════════════════════════════════════

class SuggestionsPanel extends StatelessWidget {
  final List<String> existingNames;
  final ValueChanged<FeatureItem> onAdd;

  const SuggestionsPanel({
    super.key,
    required this.existingNames,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final available = suggestedItems
        .where((s) => !existingNames.contains(s.name))
        .toList();
    if (available.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: const Color(0xFFFFECB3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(context.l10n.propFeatureSuggestions,
              style: const TextStyle(fontSize: 9, color: Color(0xFFB45309))),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: 6, runSpacing: 6,
            alignment: WrapAlignment.end,
            children: available.map((s) => GestureDetector(
              onTap: () => onAdd(FeatureItem(
                id: 'f_${DateTime.now().millisecondsSinceEpoch}_${s.name.hashCode}',
                name: s.name,
                type: s.type,
                count: s.type == 'count' ? 1 : 1,
                enabled: true,
              )),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm, vertical: 6),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  border: Border.all(color: const Color(0xFFFFECB3)),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.add, size: 8, color: AppColors.textHint),
                  const SizedBox(width: 4),
                  Text(s.name, style: const TextStyle(
                      fontSize: 10, color: AppColors.textSecondary)),
                  const SizedBox(width: 4),
                  getItemIcon(s.name),
                ]),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
