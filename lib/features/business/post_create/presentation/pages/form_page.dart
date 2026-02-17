import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/business/post_create/presentation/providers/provider.dart';
import 'package:honak/shared/providers/business_page_provider.dart';
import 'package:honak/shared/widgets/button.dart';

class PostFormPage extends ConsumerStatefulWidget {
  final String postTypeKey;
  final String postTypeLabel;
  final IconData postTypeIcon;
  final Color postTypeColor;

  const PostFormPage({
    super.key,
    required this.postTypeKey,
    required this.postTypeLabel,
    required this.postTypeIcon,
    required this.postTypeColor,
  });

  @override
  ConsumerState<PostFormPage> createState() => _PostFormPageState();
}

class _PostFormPageState extends ConsumerState<PostFormPage> {
  final _captionController = TextEditingController();
  bool _isPublishing = false;
  int? _selectedStatusColorIndex;

  static const _statusColors = [
    Color(0xFF43A047), // green
    Color(0xFF1A73E8), // blue
    Color(0xFFFF9800), // orange
    Color(0xFFE53935), // red
    Color(0xFF9C27B0), // purple
  ];

  bool get _isStatusType => widget.postTypeKey == 'status';

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  bool get _canPublish {
    if (_isPublishing) return false;
    return _captionController.text.trim().isNotEmpty;
  }

  Future<void> _handlePublish() async {
    if (!_canPublish) return;

    final bizContext = ref.read(businessContextProvider);
    if (bizContext == null) return;

    setState(() => _isPublishing = true);

    try {
      final repo = ref.read(postRepositoryProvider);
      final data = <String, dynamic>{
        'type': widget.postTypeKey,
        'caption': _captionController.text.trim(),
      };

      if (_isStatusType && _selectedStatusColorIndex != null) {
        final color = _statusColors[_selectedStatusColorIndex!];
        data['status_color'] =
            '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}';
      }

      await repo.createPost(bizContext.page.id, data);

      if (mounted) {
        context.showSnackBar(context.l10n.postPublished);
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar(context.l10n.postPublishError, isError: true);
        setState(() => _isPublishing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.postTypeLabel),
            const SizedBox(width: AppSpacing.sm),
            Icon(
              widget.postTypeIcon,
              size: 20,
              color: widget.postTypeColor,
            ),
          ],
        ),
        centerTitle: true,
        // Back button always on the left — in RTL, actions = left side
        actions: [
          IconButton(
            icon: const Directionality(
              textDirection: TextDirection.ltr,
              child: Icon(Icons.arrow_back_ios_new, size: 20),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // Caption field
          _buildCaptionField(),
          const SizedBox(height: AppSpacing.lg),

          // Image picker placeholder
          _buildImagePlaceholder(),

          // Status color picker (for status type only)
          if (_isStatusType) ...[
            const SizedBox(height: AppSpacing.lg),
            _buildStatusColorPicker(),
          ],

          const SizedBox(height: AppSpacing.xl),

          // Preview
          _buildPreview(),

          const SizedBox(height: AppSpacing.xxl),

          // Publish button
          _buildPublishButton(),

          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }

  Widget _buildCaptionField() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _captionController,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        maxLines: 5,
        minLines: 3,
        maxLength: 500,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          hintText: _isStatusType
              ? context.l10n.postStatusHint
              : context.l10n.postCaptionHint,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.all(AppSpacing.lg),
          counterStyle: TextStyle(
            fontSize: 11,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return GestureDetector(
      onTap: () => context.showSnackBar(context.l10n.postAddPhotoComingSoon),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            style: BorderStyle.solid,
          ),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: CustomPaint(
          painter: _DashedBorderPainter(
            color: Theme.of(context).colorScheme.outline,
            borderRadius: 14,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add_photo_alternate_outlined,
                  size: 32,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  context.l10n.postAddPhoto,
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusColorPicker() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            context.l10n.postStatusColor,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_statusColors.length, (i) {
              final color = _statusColors[i];
              final isSelected = _selectedStatusColorIndex == i;
              return Padding(
                padding: EdgeInsetsDirectional.only(
                  start: i > 0 ? AppSpacing.md : 0,
                ),
                child: GestureDetector(
                  onTap: () => setState(() {
                    _selectedStatusColorIndex =
                        _selectedStatusColorIndex == i ? null : i;
                  }),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: Theme.of(context).colorScheme.surface, width: 3)
                          : null,
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: color.withValues(alpha: 0.5),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ]
                          : null,
                    ),
                    child: isSelected
                        ? Icon(
                            Icons.check,
                            size: 20,
                            color: Theme.of(context).colorScheme.surface,
                          )
                        : null,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildPreview() {
    final caption = _captionController.text.trim();
    if (caption.isEmpty) return const SizedBox.shrink();

    final statusColor = _isStatusType && _selectedStatusColorIndex != null
        ? _statusColors[_selectedStatusColorIndex!]
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          context.l10n.postPreview,
          style: context.textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: statusColor != null
                ? Border.all(
                    color: statusColor.withValues(alpha: 0.3),
                    width: 2,
                  )
                : Border.all(color: Theme.of(context).colorScheme.outlineVariant),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Post type badge
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: widget.postTypeColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.postTypeLabel,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: widget.postTypeColor,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          widget.postTypeIcon,
                          size: 14,
                          color: widget.postTypeColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              // Caption text
              if (statusColor != null)
                Container(
                  width: 4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  margin: const EdgeInsetsDirectional.only(start: 8),
                ),
              Text(
                caption,
                textDirection: TextDirection.rtl,
                style: context.textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPublishButton() {
    return Button(
      onPressed: _canPublish ? _handlePublish : null,
      label: context.l10n.postPublish,
      size: ButtonSize.large,
      expand: true,
      isLoading: _isPublishing,
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Dashed border painter for image placeholder
// ═══════════════════════════════════════════════════════════════

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double borderRadius;
  static const double _dashWidth = 6;
  static const double _dashSpace = 4;

  _DashedBorderPainter({
    required this.color,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    final dashPath = Path();
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final end = (distance + _dashWidth).clamp(0.0, metric.length);
        dashPath.addPath(
          metric.extractPath(distance, end),
          Offset.zero,
        );
        distance += _dashWidth + _dashSpace;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
