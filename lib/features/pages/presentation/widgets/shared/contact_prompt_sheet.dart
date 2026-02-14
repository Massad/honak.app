import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/shared/widgets/app_sheet.dart';

/// "Mention us" nudge shown when customers tap Call/WhatsApp on unclaimed pages.
/// Matches Figma: `ContactPromptSheet.tsx`
class ContactPromptSheet extends StatelessWidget {
  final String businessName;
  final String method; // 'call' | 'whatsapp'
  final VoidCallback onProceed;

  const ContactPromptSheet._({
    required this.businessName,
    required this.method,
    required this.onProceed,
  });

  /// Shows the contact prompt sheet, then proceeds with the actual action.
  static Future<void> show(
    BuildContext context, {
    required String businessName,
    required String method,
    required VoidCallback onProceed,
  }) {
    return showAppSheet<void>(
      context,
      builder: (_) => ContactPromptSheet._(
        businessName: businessName,
        method: method,
        onProceed: onProceed,
      ),
    );
  }

  bool get _isCall => method == 'call';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: context.colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          // Sparkle icon + message
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Amber gradient circle with sparkle
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFFBEB), // amber-50
                      Color(0xFFFFF7ED), // orange-50
                    ],
                  ),
                  border: Border.all(
                    color: const Color(0xFFFDE68A), // amber-100
                  ),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  size: 20,
                  color: Color(0xFFFF9800), // amber/orange
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 2),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          color: context.colorScheme.onSurface,
                          height: 1.6,
                        ),
                        children: [
                          const TextSpan(text: 'لما تحكي مع '),
                          TextSpan(
                            text: businessName,
                            style: const TextStyle(
                              color: Color(0xFF1A73E8),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const TextSpan(text: '، قلّهم إنك لقيتهم على '),
                          const TextSpan(
                            text: 'هناك',
                            style: TextStyle(
                              color: Color(0xFF1A73E8),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const TextSpan(text: '!'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'هيك بنساعدهم يفعّلوا صفحتهم ويوصلوا لزبائن أكثر',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Action button
          SizedBox(
            width: double.infinity,
            child: Material(
              color: _isCall
                  ? const Color(0xFF43A047) // green
                  : const Color(0xFF25D366), // whatsapp green
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Navigator.of(context).pop();
                  onProceed();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isCall ? Icons.phone : Icons.chat,
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _isCall ? 'اتصال' : 'فتح واتساب',
                        style: const TextStyle(
                          fontSize: 14,
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
    );
  }
}
