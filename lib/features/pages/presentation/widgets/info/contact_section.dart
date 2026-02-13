import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/pages/domain/entities/page_sub_entities.dart';

/// Contact section: phone, WhatsApp, CliQ, external links.
class ContactSection extends StatelessWidget {
  final String? phone;
  final String? whatsapp;
  final String? cliqAlias;
  final List<ExternalLink> externalLinks;

  const ContactSection({
    super.key,
    this.phone,
    this.whatsapp,
    this.cliqAlias,
    this.externalLinks = const [],
  });

  @override
  Widget build(BuildContext context) {
    final hasContent = phone != null ||
        whatsapp != null ||
        cliqAlias != null ||
        externalLinks.isNotEmpty;

    if (!hasContent) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('التواصل', style: context.textTheme.titleSmall),
        SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            if (phone != null)
              _ContactButton(
                icon: Icons.phone,
                label: 'اتصال',
                color: Colors.green,
                onTap: () {},
              ),
            if (whatsapp != null)
              _ContactButton(
                icon: Icons.chat,
                label: 'واتساب',
                color: const Color(0xFF25D366),
                onTap: () {},
              ),
            if (cliqAlias != null)
              _ContactButton(
                icon: Icons.copy,
                label: 'كليك: $cliqAlias',
                color: context.colorScheme.primary,
                onTap: () {
                  Clipboard.setData(ClipboardData(text: cliqAlias!));
                  context.showSnackBar('تم نسخ معرّف كليك');
                },
              ),
          ],
        ),
        if (externalLinks.isNotEmpty) ...[
          SizedBox(height: AppSpacing.md),
          ...externalLinks.map((link) => _ExternalLinkTile(link: link)),
        ],
      ],
    );
  }
}

class _ContactButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ContactButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18, color: color),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color.withValues(alpha: 0.4)),
      ),
    );
  }
}

class _ExternalLinkTile extends StatelessWidget {
  final ExternalLink link;

  const _ExternalLinkTile({required this.link});

  IconData get _icon => switch (link.platform) {
    'instagram' => Icons.camera_alt_outlined,
    'facebook' => Icons.facebook_outlined,
    'twitter' => Icons.alternate_email,
    'website' => Icons.language,
    'tiktok' => Icons.music_note_outlined,
    _ => Icons.link,
  };

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(_icon, color: context.colorScheme.primary),
      title: Text(link.label, style: context.textTheme.bodyMedium),
      trailing: const Icon(Icons.open_in_new, size: 16),
      onTap: () {},
    );
  }
}
