import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:honak/config/business_type_config.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_radius.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';

// ─── Icon map for QR targets ────────────────────────────────────────────────
const _iconMap = <String, IconData>{
  'store': Icons.store_outlined,
  'utensils-crossed': Icons.restaurant_outlined,
  'scissors': Icons.content_cut_outlined,
  'package': Icons.inventory_2_outlined,
  'info': Icons.info_outline,
  'wrench': Icons.build_outlined,
  'image': Icons.image_outlined,
  'users': Icons.people_outlined,
  'tag': Icons.sell_outlined,
  'home': Icons.home_outlined,
  'menu_book': Icons.menu_book_outlined,
  'grid_view': Icons.grid_view_outlined,
  'list': Icons.list_outlined,
  'category': Icons.category_outlined,
};

IconData _mapIcon(String name) => _iconMap[name] ?? Icons.link_outlined;

// ═══════════════════════════════════════════════════════════════════════════
// QrCodeSection — full-screen settings sub-screen
// ═══════════════════════════════════════════════════════════════════════════

class QrCodeSection extends StatefulWidget {
  final VoidCallback onClose;
  final List<QRTarget> targets;
  final String pageHandle;

  const QrCodeSection({
    super.key,
    required this.onClose,
    required this.targets,
    required this.pageHandle,
  });

  @override
  State<QrCodeSection> createState() => _QrCodeSectionState();
}

class _QrCodeSectionState extends State<QrCodeSection> {
  late String _selectedTargetId;
  bool _copied = false;

  @override
  void initState() {
    super.initState();
    _selectedTargetId =
        widget.targets.isNotEmpty ? widget.targets.first.id : 'page';
  }

  QRTarget? get _selectedTarget =>
      widget.targets.where((t) => t.id == _selectedTargetId).firstOrNull;

  /// Build the URL that the QR code points to.
  String get _qrUrl {
    final handle = widget.pageHandle.replaceAll('@', '');
    final section = _selectedTarget?.section ?? '';
    if (section.isEmpty || section == 'page') {
      return 'honak.app/$handle';
    }
    return 'honak.app/$handle/$section';
  }

  Future<void> _handleCopy() async {
    await Clipboard.setData(ClipboardData(text: 'https://$_qrUrl'));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubScreenAppBar(title: 'رمز QR', onClose: widget.onClose),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              // ── Target selector ──────────────────────────────────────────
              Text(
                'عند مسح الرمز، العميل يصل إلى:',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              _TargetChips(
                targets: widget.targets,
                selectedId: _selectedTargetId,
                onSelected: (id) => setState(() => _selectedTargetId = id),
              ),
              const SizedBox(height: AppSpacing.lg),

              // ── QR code display ──────────────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xxl,
                  vertical: AppSpacing.xxl,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Column(
                  children: [
                    // QR code painted via CustomPainter
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: CustomPaint(
                          size: const Size(200, 200),
                          painter: _QrCodePainter(url: _qrUrl),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // URL + copy button
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs + 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: _handleCopy,
                            child: Icon(
                              _copied ? Icons.check : Icons.copy,
                              size: 14,
                              color: _copied
                                  ? AppColors.success
                                  : Colors.grey.shade400,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Flexible(
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(
                                _qrUrl,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.primary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // ── Action buttons ───────────────────────────────────────────
              Row(
                textDirection: TextDirection.ltr,
                children: [
                  // Share button (secondary)
                  Expanded(
                    child: _ActionButton(
                      label: 'مشاركة',
                      icon: Icons.share_outlined,
                      filled: false,
                      onTap: () => context.showSnackBar('قريباً'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  // Download button (primary)
                  Expanded(
                    child: _ActionButton(
                      label: 'تحميل',
                      icon: Icons.download_outlined,
                      filled: true,
                      onTap: () => context.showSnackBar('قريباً'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // ── Tip ──────────────────────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: const Text(
                  'اطبع رمز QR وضعه على طاولات المطعم، واجهة المحل، '
                  'أو بطاقات العمل. العملاء يمسحون الرمز ويصلون '
                  'لصفحتك مباشرة!',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.primary,
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// _TargetChips — horizontal wrapping chip selector
// ═══════════════════════════════════════════════════════════════════════════

class _TargetChips extends StatelessWidget {
  final List<QRTarget> targets;
  final String selectedId;
  final ValueChanged<String> onSelected;

  const _TargetChips({
    required this.targets,
    required this.selectedId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: targets.map((t) {
        final isActive = t.id == selectedId;
        return GestureDetector(
          onTap: () => onSelected(t.id),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs + 2,
            ),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : Colors.grey.shade100,
              borderRadius: AppRadius.pill,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _mapIcon(t.icon),
                  size: 14,
                  color: isActive ? Colors.white : Colors.grey.shade600,
                ),
                const SizedBox(width: AppSpacing.xs + 2),
                Text(
                  t.labelAr,
                  style: TextStyle(
                    fontSize: 12,
                    color: isActive ? Colors.white : Colors.grey.shade600,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// _ActionButton — download / share styled button
// ═══════════════════════════════════════════════════════════════════════════

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool filled;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.filled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: filled ? AppColors.primary : Colors.grey.shade100,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: filled ? Colors.white : Colors.grey.shade600,
              ),
              const SizedBox(width: AppSpacing.xs + 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: filled ? Colors.white : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// _QrCodePainter — deterministic QR-like pattern using CustomPainter
// Mirrors the Figma canvas drawing logic exactly.
// ═══════════════════════════════════════════════════════════════════════════

class _QrCodePainter extends CustomPainter {
  final String url;

  _QrCodePainter({required this.url});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // ── White background ────────────────────────────────────────────────
    paint.color = Colors.white;
    canvas.drawRect(Offset.zero & size, paint);

    // ── Grid setup ──────────────────────────────────────────────────────
    const double margin = 20;
    const double cellSize = 6;
    final int grid = ((size.width - margin * 2) / cellSize).floor();

    // ── Corner finder patterns ──────────────────────────────────────────
    _drawFinder(canvas, margin, margin, cellSize);
    _drawFinder(canvas, margin + (grid - 7) * cellSize, margin, cellSize);
    _drawFinder(canvas, margin, margin + (grid - 7) * cellSize, cellSize);

    // ── Data modules (seeded from URL hash) ─────────────────────────────
    int seed = 0;
    for (int i = 0; i < url.length; i++) {
      seed = ((seed << 5) - seed + url.codeUnitAt(i)) & 0x7FFFFFFF;
    }

    paint.color = const Color(0xFF1A1A1A);

    for (int r = 0; r < grid; r++) {
      for (int c = 0; c < grid; c++) {
        // Skip finder pattern areas (8-cell zones in 3 corners)
        if ((r < 8 && c < 8) ||
            (r < 8 && c >= grid - 8) ||
            (r >= grid - 8 && c < 8)) {
          continue;
        }

        seed = (seed * 16807) % 2147483647;
        if (seed % 3 == 0) {
          canvas.drawRect(
            Rect.fromLTWH(
              margin + c * cellSize,
              margin + r * cellSize,
              cellSize - 1,
              cellSize - 1,
            ),
            paint,
          );
        }
      }
    }

    // ── Center logo — white circle → blue circle → "ح" ─────────────────
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Outer white circle (clears QR data behind logo)
    paint.color = Colors.white;
    canvas.drawCircle(Offset(cx, cy), 18, paint);

    // Inner blue circle
    paint.color = AppColors.primary;
    canvas.drawCircle(Offset(cx, cy), 14, paint);

    // "ح" text centered
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'ح',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1,
        ),
      ),
      textDirection: TextDirection.rtl,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(
        cx - textPainter.width / 2,
        cy - textPainter.height / 2 + 1,
      ),
    );
  }

  /// Draw a 7x7 finder pattern at (x, y): outer black, middle white, inner
  /// black — the three concentric squares at QR code corners.
  void _drawFinder(Canvas canvas, double x, double y, double cell) {
    final paint = Paint();

    // Outer black 7x7
    paint.color = const Color(0xFF1A1A1A);
    canvas.drawRect(
      Rect.fromLTWH(x, y, cell * 7, cell * 7),
      paint,
    );

    // Middle white 5x5
    paint.color = Colors.white;
    canvas.drawRect(
      Rect.fromLTWH(x + cell, y + cell, cell * 5, cell * 5),
      paint,
    );

    // Inner black 3x3
    paint.color = const Color(0xFF1A1A1A);
    canvas.drawRect(
      Rect.fromLTWH(x + cell * 2, y + cell * 2, cell * 3, cell * 3),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _QrCodePainter oldDelegate) =>
      oldDelegate.url != url;
}
