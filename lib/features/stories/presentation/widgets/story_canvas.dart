import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:honak/features/stories/domain/entities/story_slide.dart';
import 'package:honak/features/stories/domain/entities/text_layer.dart';

/// Renders a story slide: background (gradient/solid/image) + text overlay.
///
/// Two modes:
/// - **View mode** (`interactive: false`): read-only rendering for viewer
/// - **Edit mode** (`interactive: true`): tap-to-select, double-tap-to-edit,
///   drag-to-reposition text layers
class StoryCanvas extends StatelessWidget {
  final StorySlide? slide;

  // Edit mode overrides (when building from creator state)
  final List<String>? bgGradient;
  final String? bgColor;
  final String? bgImage;
  final List<TextLayer> textLayers;
  final String? selectedLayerId;

  final bool interactive;
  final ValueChanged<String>? onLayerTap;
  final ValueChanged<String>? onLayerDoubleTap;
  final void Function(String id, Offset delta)? onLayerDrag;

  const StoryCanvas({
    super.key,
    this.slide,
    this.bgGradient,
    this.bgColor,
    this.bgImage,
    this.textLayers = const [],
    this.selectedLayerId,
    this.interactive = false,
    this.onLayerTap,
    this.onLayerDoubleTap,
    this.onLayerDrag,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: interactive ? BorderRadius.circular(16) : BorderRadius.zero,
      child: Container(
        decoration: BoxDecoration(
          color: _resolveColor(),
          gradient: _resolveGradient(),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            if (_resolveImage() != null)
              CachedNetworkImage(
                imageUrl: _resolveImage()!,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 200),
                fadeOutDuration: Duration.zero,
                placeholder: (_, __) => Container(color: Colors.black),
                errorWidget: (_, __, ___) => Container(
                  color: Colors.black,
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.white24, size: 32),
                  ),
                ),
              ),

            // Dark overlay for image stories (better text readability)
            if (_resolveImage() != null)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.1),
                      Colors.black.withValues(alpha: 0.5),
                    ],
                  ),
                ),
              ),

            // Simple text overlay (from slide data)
            if (slide?.text != null && textLayers.isEmpty)
              _SimpleTextOverlay(slide: slide!),

            // Multi-layer text (from creator or advanced slides)
            for (final layer in textLayers)
              _PositionedTextLayer(
                layer: layer,
                isSelected: layer.id == selectedLayerId,
                interactive: interactive,
                onTap: onLayerTap != null ? () => onLayerTap!(layer.id) : null,
                onDoubleTap: onLayerDoubleTap != null
                    ? () => onLayerDoubleTap!(layer.id)
                    : null,
                onDrag: onLayerDrag != null
                    ? (delta) => onLayerDrag!(layer.id, delta)
                    : null,
              ),
          ],
        ),
      ),
    );
  }

  String? _resolveImage() => bgImage ?? slide?.image;

  Color? _resolveColor() {
    final color = bgColor ?? slide?.bgColor;
    if (color != null) return _parseColor(color);
    if (_resolveGradient() == null && _resolveImage() == null) {
      return Colors.black;
    }
    return null;
  }

  LinearGradient? _resolveGradient() {
    final colors = bgGradient ?? slide?.bgGradient;
    if (colors == null || colors.length < 2) return null;
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: colors.map(_parseColor).toList(),
    );
  }

  static Color _parseColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 7) buffer.write('FF');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class _SimpleTextOverlay extends StatelessWidget {
  final StorySlide slide;

  const _SimpleTextOverlay({required this.slide});

  @override
  Widget build(BuildContext context) {
    final alignment = switch (slide.textPosition) {
      'top' => Alignment.topCenter,
      'bottom' => Alignment.bottomCenter,
      _ => Alignment.center,
    };

    final padding = switch (slide.textPosition) {
      'top' => const EdgeInsets.only(top: 80, left: 24, right: 24),
      'bottom' => const EdgeInsets.only(bottom: 120, left: 24, right: 24),
      _ => const EdgeInsets.symmetric(horizontal: 24),
    };

    return Align(
      alignment: alignment,
      child: Padding(
        padding: padding,
        child: Text(
          slide.text!,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _parseHexColor(slide.textColor),
            fontSize: _fontSizeFor(slide.font),
            fontWeight: _fontWeightFor(slide.font),
            fontStyle: slide.font == 'elegant' ? FontStyle.italic : null,
            shadows: const [
              Shadow(
                offset: Offset(0, 1),
                blurRadius: 4,
                color: Colors.black54,
              ),
            ],
            height: 1.4,
          ),
        ),
      ),
    );
  }

  double _fontSizeFor(String font) {
    return switch (font) {
      'bold' => 28,
      'elegant' => 26,
      _ => 22,
    };
  }

  FontWeight _fontWeightFor(String font) {
    return switch (font) {
      'bold' => FontWeight.w800,
      'elegant' => FontWeight.w500,
      _ => FontWeight.w600,
    };
  }

  Color _parseHexColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 7) buffer.write('FF');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class _PositionedTextLayer extends StatelessWidget {
  final TextLayer layer;
  final bool isSelected;
  final bool interactive;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final ValueChanged<Offset>? onDrag;

  const _PositionedTextLayer({
    required this.layer,
    required this.isSelected,
    required this.interactive,
    this.onTap,
    this.onDoubleTap,
    this.onDrag,
  });

  @override
  Widget build(BuildContext context) {
    final textAlign = switch (layer.align) {
      'left' => TextAlign.left,
      'right' => TextAlign.right,
      _ => TextAlign.center,
    };

    final child = Container(
      padding: isSelected
          ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
          : null,
      decoration: isSelected
          ? BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.5),
              borderRadius: BorderRadius.circular(8),
            )
          : null,
      child: Text(
        layer.text,
        textAlign: textAlign,
        style: TextStyle(
          color: StoryCanvas._parseColor(layer.color),
          fontSize: layer.fontSize,
          fontWeight: layer.font == 'bold' ? FontWeight.w800 : FontWeight.w600,
          fontStyle: layer.font == 'elegant' ? FontStyle.italic : null,
          shadows: const [
            Shadow(
              offset: Offset(0, 1),
              blurRadius: 4,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );

    return Positioned.fill(
      child: Align(
        alignment: Alignment(
          layer.positionX * 2 - 1,
          layer.positionY * 2 - 1,
        ),
        child: interactive
            ? GestureDetector(
                onTap: onTap,
                onDoubleTap: onDoubleTap,
                onPanUpdate: onDrag != null
                    ? (details) => onDrag!(details.delta)
                    : null,
                child: child,
              )
            : child,
      ),
    );
  }
}
