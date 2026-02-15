import 'package:flutter/material.dart';
import 'package:honak/config/archetype.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Config-driven mapping: which Power Chat actions each archetype supports.
const _archetypeActions = <Archetype, List<String>>{
  Archetype.catalogOrder: ['send_product', 'ask_info', 'send_quote'],
  Archetype.menuOrder: ['send_product', 'ask_info', 'send_quote'],
  Archetype.serviceBooking: [
    'send_product',
    'send_availability',
    'ask_info',
    'send_quote',
  ],
  Archetype.quoteRequest: [
    'ask_info',
    'send_quote',
    'send_availability',
    'send_product',
  ],
  Archetype.portfolioInquiry: [
    'send_product',
    'ask_info',
    'send_availability',
    'send_quote',
  ],
  Archetype.reservation: [
    'send_availability',
    'ask_info',
    'send_quote',
    'send_product',
  ],
  Archetype.followOnly: [],
  Archetype.directory: [],
};

/// Archetype-aware product-action labels.
const _productLabels = <Archetype, String>{
  Archetype.catalogOrder: 'أرسل منتج',
  Archetype.menuOrder: 'أرسل طبق',
  Archetype.serviceBooking: 'أرسل خدمة',
  Archetype.quoteRequest: 'أرسل خدمة',
  Archetype.portfolioInquiry: 'أرسل نموذج',
  Archetype.reservation: 'أرسل باقة',
};

class _ActionDef {
  final String key;
  final String label;
  final IconData icon;
  final Color color;

  const _ActionDef({
    required this.key,
    required this.label,
    required this.icon,
    required this.color,
  });
}

/// Whether the given archetype has any Power Chat actions.
bool hasPowerChatActions(Archetype archetype) {
  final actions = _archetypeActions[archetype];
  return actions != null && actions.isNotEmpty;
}

/// Bottom sheet showing the Power Chat action grid.
class PowerChatMenu extends StatelessWidget {
  final Archetype archetype;
  final VoidCallback onSendProduct;
  final VoidCallback onSendAvailability;
  final VoidCallback onSendQuote;
  final VoidCallback onAskInfo;
  final VoidCallback onClose;

  const PowerChatMenu({
    super.key,
    required this.archetype,
    required this.onSendProduct,
    required this.onSendAvailability,
    required this.onSendQuote,
    required this.onAskInfo,
    required this.onClose,
  });

  List<_ActionDef> get _actions {
    final keys = _archetypeActions[archetype] ?? [];
    return keys.map((key) {
      return switch (key) {
        'send_product' => _ActionDef(
            key: key,
            label: _productLabels[archetype] ?? 'أرسل منتج',
            icon: Icons.shopping_bag_outlined,
            color: AppColors.primary,
          ),
        'send_availability' => const _ActionDef(
            key: 'send_availability',
            label: 'أوقات متاحة',
            icon: Icons.schedule,
            color: AppColors.success,
          ),
        'ask_info' => const _ActionDef(
            key: 'ask_info',
            label: 'طلب معلومات',
            icon: Icons.help_outline_rounded,
            color: AppColors.warning,
          ),
        'send_quote' => const _ActionDef(
            key: 'send_quote',
            label: 'عرض سعر',
            icon: Icons.receipt_long_outlined,
            color: AppColors.warning,
          ),
        _ => null,
      };
    }).whereType<_ActionDef>().toList();
  }

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    final actions = _actions;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: AppSpacing.sm),
            // Drag handle
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: cs.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: AppSpacing.lg,
                end: AppSpacing.sm,
                top: AppSpacing.md,
                bottom: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'إجراءات سريعة',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: cs.onSurface,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onClose,
                    icon: const Icon(Icons.close, size: 20),
                    color: cs.onSurfaceVariant,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: AppSpacing.lg,
                end: AppSpacing.lg,
                bottom: AppSpacing.lg,
              ),
              child: Row(
                mainAxisAlignment: actions.length <= 2
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.spaceEvenly,
                children: actions.map((action) {
                  return Padding(
                    padding: EdgeInsetsDirectional.only(
                      end: actions.length <= 2 ? AppSpacing.lg : 0,
                    ),
                    child: _ActionButton(
                      action: action,
                      onTap: () {
                        onClose();
                        switch (action.key) {
                          case 'send_product':
                            onSendProduct();
                          case 'send_availability':
                            onSendAvailability();
                          case 'ask_info':
                            onAskInfo();
                          case 'send_quote':
                            onSendQuote();
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final _ActionDef action;
  final VoidCallback onTap;

  const _ActionButton({required this.action, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: action.color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(action.icon, size: 24, color: action.color),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            action.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
