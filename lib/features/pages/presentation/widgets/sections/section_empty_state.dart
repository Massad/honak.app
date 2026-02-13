import 'package:flutter/material.dart';
import 'package:honak/config/archetype.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/domain/entities/page_detail.dart';
import 'package:honak/features/pages/presentation/widgets/shared/contact_prompt_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

/// Contextual empty states for business page sections.
/// Handles unclaimed pages, empty content.
/// Matches Figma: `SectionEmptyState.tsx`
class SectionEmptyState extends StatelessWidget {
  final PageDetail page;
  final Archetype archetype;
  final VoidCallback? onClaimPage;

  const SectionEmptyState({
    super.key,
    required this.page,
    required this.archetype,
    this.onClaimPage,
  });

  /// Content noun per archetype (Arabic)
  String get _contentNoun => switch (archetype) {
        Archetype.catalogOrder => 'المنتجات',
        Archetype.menuOrder => 'القائمة',
        Archetype.serviceBooking => 'الخدمات',
        Archetype.portfolioInquiry => 'الأعمال',
        Archetype.quoteRequest => 'الخدمات',
        Archetype.reservation => 'المساحات',
        _ => 'المنتجات',
      };

  bool get _isUnclaimed => page.claimStatus == 'unclaimed';
  bool get _hasPhone => page.phone != null && page.phone!.isNotEmpty;
  bool get _hasWhatsApp => page.whatsapp != null && page.whatsapp!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    if (_isUnclaimed) {
      return _UnclaimedState(
        page: page,
        contentNoun: _contentNoun,
        hasPhone: _hasPhone,
        hasWhatsApp: _hasWhatsApp,
        onClaimPage: onClaimPage,
      );
    }

    // Fallback: generic empty content (claimed but empty)
    return const SizedBox.shrink();
  }
}

/// Figma: Case 1 — Unclaimed page (pre-seeded from public data)
/// bg-blue-50 rounded-2xl p-5 border border-blue-100
class _UnclaimedState extends StatelessWidget {
  final PageDetail page;
  final String contentNoun;
  final bool hasPhone;
  final bool hasWhatsApp;
  final VoidCallback? onClaimPage;

  const _UnclaimedState({
    required this.page,
    required this.contentNoun,
    required this.hasPhone,
    required this.hasWhatsApp,
    this.onClaimPage,
  });

  static const _primary = Color(0xFF1A73E8);

  bool get _hasAnyContact => hasPhone || hasWhatsApp;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xl,
      ),
      child: Column(
        children: [
          // Blue info card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF), // blue-50
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFDBEAFE), // blue-100
              ),
            ),
            child: Column(
              children: [
                // Icon + text row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Store icon
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.storefront,
                        size: 20,
                        color: _primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'صفحة مُسجّلة تلقائياً',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF111827), // gray-900
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'تم إنشاء هذه الصفحة من بيانات عامة لتسهيل العثور على ${page.name}.\n$contentNoun غير متاحة حالياً.',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6B7280), // gray-500
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Contact buttons — show only available channels
                if (_hasAnyContact) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      if (hasPhone)
                        Expanded(
                          child: _ContactButton(
                            icon: Icons.phone_outlined,
                            label: 'اتصال مباشر',
                            onTap: () => ContactPromptSheet.show(
                              context,
                              businessName: page.name,
                              method: 'call',
                              onProceed: () => _launchPhone(context),
                            ),
                          ),
                        ),
                      if (hasPhone && hasWhatsApp)
                        const SizedBox(width: 8),
                      if (hasWhatsApp)
                        Expanded(
                          child: _ContactButton(
                            icon: Icons.chat_outlined,
                            label: 'واتساب',
                            onTap: () => ContactPromptSheet.show(
                              context,
                              businessName: page.name,
                              method: 'whatsapp',
                              onProceed: () => _launchWhatsApp(context),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],

                // Claim CTA button
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: Material(
                    color: _primary,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: onClaimPage,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.verified_user_outlined,
                              size: 14,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'هل أنت صاحب هذا النشاط؟ إثبات ملكية',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Follow suggestion
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB), // gray-50
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFF3F4F6), // gray-100
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.notifications_outlined,
                  size: 14,
                  color: Color(0xFF9CA3AF), // gray-400
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'تابع هذه الصفحة — سنُعلمك عند تفعيلها من صاحب النشاط',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF6B7280), // gray-500
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchPhone(BuildContext context) {
    final phone = page.phone;
    if (phone != null) {
      launchUrl(Uri.parse('tel:$phone'));
    }
  }

  void _launchWhatsApp(BuildContext context) {
    final wa = page.whatsapp;
    if (wa != null) {
      final clean = wa.replaceAll('+', '');
      launchUrl(Uri.parse('https://wa.me/$clean'));
    }
  }
}

/// Outlined contact button: bg-white border-blue-200 text-blue rounded-xl
class _ContactButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ContactButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  static const _primary = Color(0xFF1A73E8);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFBFDBFE), // blue-200
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 14, color: _primary),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
