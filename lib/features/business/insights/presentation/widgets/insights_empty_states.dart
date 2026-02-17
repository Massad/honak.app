import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/shared/widgets/button.dart';

/// Unclaimed page lockout state.
class UnclaimedInsightsState extends StatelessWidget {
  const UnclaimedInsightsState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock_outline, size: 40, color: Color(0xFFD1D5DB)),
            const SizedBox(height: 16),
            Text(
              context.l10n.insightsUnavailable,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.insightsPageUnclaimed,
              style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            ),
          ],
        ),
      ),
    );
  }
}

/// Visibility-only page — limited insights with CTA to enable orders.
class VisibilityOnlyBanner extends StatelessWidget {
  const VisibilityOnlyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Icon(Icons.visibility_outlined, size: 24, color: Color(0xFF1A73E8)),
          const SizedBox(height: 8),
          Text(
            context.l10n.insightsEnableOrdersAdvanced,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            context.l10n.insightsVisibilityOnly,
            style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Button(
            onPressed: () {
              // TODO: Navigate to engagement settings
            },
            label: context.l10n.insightsEnableOrders,
            size: ButtonSize.small,
          ),
        ],
      ),
    );
  }
}
