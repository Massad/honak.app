import 'package:flutter/material.dart';
import 'package:honak/config/archetype.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/power_chat_types.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/button.dart';

class UpdateBuilderSheet extends StatefulWidget {
  final Archetype? archetype;
  final void Function(UpdateCardData data) onSend;

  const UpdateBuilderSheet({super.key, this.archetype, required this.onSend});

  @override
  State<UpdateBuilderSheet> createState() => _UpdateBuilderSheetState();
}

class _UpdateBuilderSheetState extends State<UpdateBuilderSheet> {
  String? _selectedId;

  List<_UpdatePreset> get _presets {
    return switch (widget.archetype) {
      Archetype.serviceBooking => const [
        _UpdatePreset(
          id: 'booking_confirmed',
          text: 'تم تأكيد الموعد',
          status: 'confirmed',
          icon: Icons.event_available_outlined,
          tone: _PresetTone.success,
        ),
        _UpdatePreset(
          id: 'on_the_way',
          text: 'الفني في الطريق إليك',
          status: 'in_progress',
          icon: Icons.near_me_outlined,
          tone: _PresetTone.primary,
        ),
        _UpdatePreset(
          id: 'service_done',
          text: 'تم الانتهاء من الخدمة بنجاح',
          status: 'completed',
          icon: Icons.check_circle_outline_rounded,
          tone: _PresetTone.success,
        ),
      ],
      Archetype.reservation => const [
        _UpdatePreset(
          id: 'reservation_confirmed',
          text: 'تم تأكيد الحجز',
          status: 'confirmed',
          icon: Icons.event_available_outlined,
          tone: _PresetTone.success,
        ),
        _UpdatePreset(
          id: 'ready_for_check_in',
          text: 'الوحدة جاهزة للاستقبال',
          status: 'ready',
          icon: Icons.key_outlined,
          tone: _PresetTone.primary,
        ),
        _UpdatePreset(
          id: 'check_in_reminder',
          text: 'تذكير: موعد تسجيل الدخول اليوم',
          status: 'reminder',
          icon: Icons.notifications_outlined,
          tone: _PresetTone.secondary,
        ),
      ],
      _ => const [
        _UpdatePreset(
          id: 'order_confirmed',
          text: 'تم تأكيد الطلب',
          status: 'confirmed',
          icon: Icons.task_alt_outlined,
          tone: _PresetTone.success,
        ),
        _UpdatePreset(
          id: 'in_preparation',
          text: 'جاري تجهيز الطلب',
          status: 'in_progress',
          icon: Icons.inventory_2_outlined,
          tone: _PresetTone.secondary,
        ),
        _UpdatePreset(
          id: 'out_for_delivery',
          text: 'الطلب خرج للتسليم',
          status: 'on_delivery',
          icon: Icons.local_shipping_outlined,
          tone: _PresetTone.primary,
        ),
        _UpdatePreset(
          id: 'completed',
          text: 'تم تنفيذ الطلب بنجاح',
          status: 'completed',
          icon: Icons.check_circle_outline_rounded,
          tone: _PresetTone.success,
        ),
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    final selected = _presets.where((p) => p.id == _selectedId).firstOrNull;

    return AppSheetScaffold(
      title: 'أرسل تحديث',
      variant: AppSheetVariant.compact,
      headerCompact: true,
      showBodyDivider: false,
      showFooterDivider: false,
      bodyPadding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      footerPadding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      body: Column(
        children: _presets
            .map(
              (preset) => Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: AppSpacing.sm,
                ),
                child: _PresetTile(
                  preset: preset,
                  selected: preset.id == _selectedId,
                  onTap: () {
                    setState(() {
                      _selectedId = _selectedId == preset.id ? null : preset.id;
                    });
                  },
                ),
              ),
            )
            .toList(),
      ),
      footer: Button(
        onPressed: selected == null
            ? null
            : () {
                widget.onSend(
                  UpdateCardData(
                    title: 'تحديث الحالة',
                    body: selected.text,
                    status: selected.status,
                  ),
                );
                Navigator.of(context).pop();
              },
        label: 'إرسال التحديث',
        icon: const ButtonIcon(Icons.send_rounded, size: 16),
        expand: true,
      ),
    );
  }
}

class _PresetTile extends StatelessWidget {
  final _UpdatePreset preset;
  final bool selected;
  final VoidCallback onTap;

  const _PresetTile({
    required this.preset,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = _resolveTone(context, preset.tone);
    return Material(
      color: selected
          ? color.withValues(alpha: 0.08)
          : context.colorScheme.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsetsDirectional.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? color.withValues(alpha: 0.45)
                  : context.colorScheme.outlineVariant,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: selected ? color : color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  selected ? Icons.send_rounded : preset.icon,
                  size: 16,
                  color: selected ? context.colorScheme.onPrimary : color,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  preset.text,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: selected ? color : context.colorScheme.onSurface,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _resolveTone(BuildContext context, _PresetTone tone) {
    final cs = context.colorScheme;
    return switch (tone) {
      _PresetTone.primary => cs.primary,
      _PresetTone.secondary => cs.secondary,
      _PresetTone.success => cs.tertiary,
    };
  }
}

enum _PresetTone { primary, secondary, success }

class _UpdatePreset {
  final String id;
  final String text;
  final String status;
  final IconData icon;
  final _PresetTone tone;

  const _UpdatePreset({
    required this.id,
    required this.text,
    required this.status,
    required this.icon,
    required this.tone,
  });
}
