import 'package:flutter/material.dart';

/// Unclaimed page lockout state.
class UnclaimedInsightsState extends StatelessWidget {
  const UnclaimedInsightsState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock_outline, size: 40, color: Color(0xFFD1D5DB)),
            SizedBox(height: 16),
            Text(
              'الإحصائيات غير متاحة',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'هذه الصفحة لم تتم المطالبة بها بعد',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
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
          const Text(
            'فعّل الطلبات لعرض إحصائيات متقدمة',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          const Text(
            'صفحتك حالياً في وضع الواجهة فقط',
            style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 36,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Navigate to engagement settings
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A73E8),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('تفعيل الطلبات', style: TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}
