import 'package:flutter/material.dart';
import 'package:honak/config/archetype.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

/// Config-driven mapping: which Power Chat actions each archetype supports.
const _archetypeActions = <Archetype, List<String>>{
  Archetype.catalogOrder: [
    'send_product',
    'ask_info',
    'send_quote',
    'send_update',
    'send_receipt',
  ],
  Archetype.menuOrder: [
    'send_product',
    'ask_info',
    'send_quote',
    'send_update',
    'send_receipt',
  ],
  Archetype.serviceBooking: [
    'send_product',
    'send_availability',
    'ask_info',
    'send_quote',
    'send_update',
  ],
  Archetype.quoteRequest: [
    'ask_info',
    'send_quote',
    'send_availability',
    'send_product',
    'send_update',
  ],
  Archetype.portfolioInquiry: [
    'send_portfolio',
    'send_product',
    'ask_info',
    'send_availability',
    'send_quote',
  ],
  Archetype.reservation: [
    'send_availability',
    'ask_info',
    'send_product',
    'send_quote',
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
  final _ActionTone tone;

  const _ActionDef({
    required this.key,
    required this.label,
    required this.icon,
    required this.tone,
  });
}

enum _ActionTone { primary, secondary, tertiary }

/// Whether the given archetype has any Power Chat actions.
bool hasPowerChatActions(Archetype archetype) {
  final actions = _archetypeActions[archetype];
  return actions != null && actions.isNotEmpty;
}

/// Bottom sheet showing the Power Chat action grid.
class PowerChatMenu extends StatelessWidget {
  final Archetype archetype;
  final bool hasLocation;
  final VoidCallback onSendProduct;
  final VoidCallback onSendAvailability;
  final VoidCallback onSendQuote;
  final VoidCallback onAskInfo;
  final VoidCallback onSendUpdate;
  final VoidCallback onSendPortfolio;
  final VoidCallback onSendLocation;
  final VoidCallback onSendReceipt;
  final VoidCallback onClose;

  const PowerChatMenu({
    super.key,
    required this.archetype,
    this.hasLocation = false,
    required this.onSendProduct,
    required this.onSendAvailability,
    required this.onSendQuote,
    required this.onAskInfo,
    required this.onSendUpdate,
    required this.onSendPortfolio,
    required this.onSendLocation,
    required this.onSendReceipt,
    required this.onClose,
  });

  List<_ActionDef> get _actions {
    final baseKeys = _archetypeActions[archetype] ?? [];
    final keys = hasLocation && baseKeys.isNotEmpty
        ? [
            ...baseKeys,
            if (!baseKeys.contains('send_location')) 'send_location',
          ]
        : baseKeys;
    return keys
        .map((key) {
          return switch (key) {
            'send_product' => _ActionDef(
              key: key,
              label: _productLabels[archetype] ?? 'أرسل منتج',
              icon: Icons.shopping_bag_outlined,
              tone: _ActionTone.primary,
            ),
            'send_availability' => const _ActionDef(
              key: 'send_availability',
              label: 'أوقات متاحة',
              icon: Icons.schedule,
              tone: _ActionTone.tertiary,
            ),
            'ask_info' => const _ActionDef(
              key: 'ask_info',
              label: 'طلب معلومات',
              icon: Icons.help_outline_rounded,
              tone: _ActionTone.secondary,
            ),
            'send_quote' => const _ActionDef(
              key: 'send_quote',
              label: 'عرض سعر',
              icon: Icons.receipt_long_outlined,
              tone: _ActionTone.secondary,
            ),
            'send_update' => const _ActionDef(
              key: 'send_update',
              label: 'أرسل تحديث',
              icon: Icons.update_outlined,
              tone: _ActionTone.primary,
            ),
            'send_portfolio' => const _ActionDef(
              key: 'send_portfolio',
              label: 'أرسل أعمالي',
              icon: Icons.photo_library_outlined,
              tone: _ActionTone.primary,
            ),
            'send_location' => const _ActionDef(
              key: 'send_location',
              label: 'أرسل الموقع',
              icon: Icons.location_on_outlined,
              tone: _ActionTone.primary,
            ),
            'send_receipt' => const _ActionDef(
              key: 'send_receipt',
              label: 'أرسل إيصال',
              icon: Icons.receipt_outlined,
              tone: _ActionTone.tertiary,
            ),
            _ => null,
          };
        })
        .whereType<_ActionDef>()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final actions = _actions;

    return AppSheetScaffold(
      title: 'إجراءات سريعة',
      variant: AppSheetVariant.compact,
      headerCompact: true,
      scrollable: false,
      showBodyDivider: false,
      showFooterDivider: false,
      bodyPadding: const EdgeInsetsDirectional.only(
        start: AppSpacing.lg,
        end: AppSpacing.lg,
        bottom: AppSpacing.lg,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          const horizontalGap = AppSpacing.md;
          final itemWidth = (constraints.maxWidth - (horizontalGap * 2)) / 3;
          return Wrap(
            spacing: horizontalGap,
            runSpacing: AppSpacing.lg,
            children: actions.map((action) {
              return SizedBox(
                width: itemWidth,
                child: _ActionButton(
                  action: action,
                  color: _resolveTone(context, action.tone),
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
                      case 'send_update':
                        onSendUpdate();
                      case 'send_portfolio':
                        onSendPortfolio();
                      case 'send_location':
                        onSendLocation();
                      case 'send_receipt':
                        onSendReceipt();
                    }
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Color _resolveTone(BuildContext context, _ActionTone tone) {
    final cs = context.colorScheme;
    return switch (tone) {
      _ActionTone.primary => cs.primary,
      _ActionTone.secondary => cs.secondary,
      _ActionTone.tertiary => cs.tertiary,
    };
  }
}

class _ActionButton extends StatelessWidget {
  final _ActionDef action;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.action,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(action.icon, size: 24, color: color),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            action.label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
