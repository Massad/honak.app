import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/features/business/stories/presentation/providers/story_creator_provider.dart';
import 'package:honak/features/business/stories/presentation/widgets/text_editor_toolbar.dart';
import 'package:honak/features/stories/domain/entities/text_layer.dart';
import 'package:honak/features/stories/presentation/widgets/story_canvas.dart';
import 'package:honak/features/stories/presentation/widgets/story_reply_input.dart';
import 'package:honak/shared/providers/business_page_provider.dart';
import 'package:honak/shared/widgets/app_image.dart';

/// Step 2: Dark immersive canvas with inline text editing.
/// Business avatar overlay, contextual hints, interactive layers.
class TextLayerEditor extends ConsumerStatefulWidget {
  const TextLayerEditor({super.key});

  @override
  ConsumerState<TextLayerEditor> createState() => _TextLayerEditorState();
}

class _TextLayerEditorState extends ConsumerState<TextLayerEditor> {
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(storyCreatorProvider);
    final notifier = ref.read(storyCreatorProvider.notifier);
    final bizContext = ref.watch(businessContextProvider);

    return Column(
      children: [
        // Canvas — nearly full screen, minimal padding
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (state.editingLayerId != null) {
                _finishEditing();
              } else if (state.selectedLayerId != null) {
                notifier.selectLayer(null);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Center(
                child: AspectRatio(
                  aspectRatio: 9 / 16,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final canvasSize = Size(
                        constraints.maxWidth,
                        constraints.maxHeight,
                      );
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          clipBehavior: Clip.hardEdge,
                          children: [
                            // Background canvas
                            SizedBox.expand(
                              child: StoryCanvas(
                                bgGradient:
                                    state.bgType == BgType.gradient
                                        ? state.bgGradient
                                        : null,
                                bgColor: state.bgType == BgType.solid
                                    ? state.bgColor
                                    : null,
                                bgImage: state.bgType == BgType.image
                                    ? state.bgImage
                                    : null,
                                interactive: false,
                              ),
                            ),

                            // Status bar (decorative)
                            Positioned(
                              top: 8,
                              left: 12,
                              right: 12,
                              child: Container(
                                height: 2,
                                decoration: BoxDecoration(
                                  color: Colors.white38,
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                            ),

                            // Business avatar + name overlay
                            if (bizContext != null)
                              Positioned(
                                top: 16,
                                right: 16,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      bizContext.page.name,
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.surface,
                                        fontSize: 12,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 8,
                                            color: Colors.black54,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white38,
                                        ),
                                      ),
                                      child: AppImage.avatar(
                                        url: bizContext.page.avatarUrl,
                                        name: bizContext.page.name,
                                        radius: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            // Guide lines during drag
                            if (_isDragging) ...[
                              Positioned(
                                top: canvasSize.height / 2,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 1,
                                  color: Colors.white24,
                                ),
                              ),
                              Positioned(
                                left: canvasSize.width / 2,
                                top: 0,
                                bottom: 0,
                                child: Container(
                                  width: 1,
                                  color: Colors.white24,
                                ),
                              ),
                            ],

                            // Empty state — dashed border placeholder
                            if (state.textLayers.isEmpty)
                              Positioned.fill(
                                child: GestureDetector(
                                  onTap: () => notifier.addTextLayer(),
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 16,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white38,
                                          width: 1.5,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.text_fields,
                                            size: 20,
                                            color: Colors.white54,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            context.l10n.storyAddText,
                                            style: const TextStyle(
                                              color: Colors.white54,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            // Interactive text layers
                            for (final layer in state.textLayers)
                              _InteractiveTextLayer(
                                layer: layer,
                                canvasSize: canvasSize,
                                isSelected:
                                    layer.id == state.selectedLayerId,
                                isEditing:
                                    layer.id == state.editingLayerId,
                                onTap: () =>
                                    notifier.selectLayer(layer.id),
                                onDoubleTap: () =>
                                    notifier.startEditing(layer.id),
                                onDragStart: () =>
                                    setState(() => _isDragging = true),
                                onDragEnd: (textSize) {
                                  setState(() => _isDragging = false);
                                  notifier.snapLayerToBounds(
                                    layer.id,
                                    canvasSize,
                                    textSize,
                                    bottomReserved: kStoryReplyBarHeight,
                                  );
                                },
                                onDrag: (delta) => notifier.moveLayer(
                                  layer.id,
                                  delta,
                                  canvasSize,
                                ),
                                onTextChanged: (text) =>
                                    notifier.updateTextLayer(
                                  layer.id,
                                  layer.copyWith(text: text),
                                ),
                                onEditComplete: (textSize) =>
                                    _finishEditing(canvasSize, textSize),
                              ),

                            // Disabled reply bar preview (shows customer view)
                            const Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: StoryReplyInput(enabled: false),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),

        // Contextual hint
        SizedBox(
          height: 24,
          child: Center(
            child: Text(
              _hintText(state),
              style: const TextStyle(
                color: Colors.white24,
                fontSize: 10,
              ),
            ),
          ),
        ),

        // Unified toolbar — background, text, font, color, all in one
        CreatorToolbar(
          onDoneEditing: () => _finishEditing(),
        ),
      ],
    );
  }

  String _hintText(StoryCreatorState state) {
    if (state.editingLayerId != null) return context.l10n.storyHintEditing;
    if (_isDragging) return '↕ ↔';
    if (state.selectedLayerId != null) {
      return context.l10n.storyHintSelected;
    }
    if (state.textLayers.isNotEmpty) return context.l10n.storyHintTapToSelect;
    return '';
  }

  void _finishEditing([Size? canvasSize, Size? textSize]) {
    final state = ref.read(storyCreatorProvider);
    final notifier = ref.read(storyCreatorProvider.notifier);
    if (state.editingLayerId != null) {
      final layer = state.textLayers
          .where((l) => l.id == state.editingLayerId)
          .firstOrNull;
      if (layer != null && layer.text.trim().isEmpty) {
        notifier.deleteTextLayer(layer.id);
      } else if (layer != null && canvasSize != null && textSize != null) {
        // Snap after editing in case text grew wider
        notifier.snapLayerToBounds(layer.id, canvasSize, textSize);
      }
      notifier.stopEditing();
    }
  }
}

// ═══════════════════════════════════════════════════════════════
// Interactive text layer — select, drag, inline edit
// All rendering stays within canvas bounds via ClipRRect parent.
// ═══════════════════════════════════════════════════════════════

class _InteractiveTextLayer extends StatefulWidget {
  final TextLayer layer;
  final Size canvasSize;
  final bool isSelected;
  final bool isEditing;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;
  final VoidCallback onDragStart;
  final void Function(Size textSize) onDragEnd;
  final ValueChanged<Offset> onDrag;
  final ValueChanged<String> onTextChanged;
  final void Function(Size textSize) onEditComplete;

  const _InteractiveTextLayer({
    required this.layer,
    required this.canvasSize,
    required this.isSelected,
    required this.isEditing,
    required this.onTap,
    required this.onDoubleTap,
    required this.onDragStart,
    required this.onDragEnd,
    required this.onDrag,
    required this.onTextChanged,
    required this.onEditComplete,
  });

  @override
  State<_InteractiveTextLayer> createState() => _InteractiveTextLayerState();
}

class _InteractiveTextLayerState extends State<_InteractiveTextLayer> {
  late TextEditingController _controller;
  final _focusNode = FocusNode();
  final _contentKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.layer.text);
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(covariant _InteractiveTextLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isEditing && !oldWidget.isEditing) {
      _controller.text = widget.layer.text;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();
      });
    }
    if (!widget.isEditing && widget.layer.text != _controller.text) {
      _controller.text = widget.layer.text;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus && widget.isEditing) {
      final rb =
          _contentKey.currentContext?.findRenderObject() as RenderBox?;
      widget.onEditComplete(rb?.size ?? const Size(50, 20));
    }
  }

  @override
  Widget build(BuildContext context) {
    final layer = widget.layer;
    final textAlign = switch (layer.align) {
      'left' => TextAlign.left,
      'right' => TextAlign.right,
      _ => TextAlign.center,
    };
    final color = _parseColor(layer.color);
    final style = TextStyle(
      color: color,
      fontSize: layer.fontSize,
      fontWeight: layer.font == 'bold' ? FontWeight.w800 : FontWeight.normal,
      fontStyle: layer.font == 'elegant' ? FontStyle.italic : null,
      fontFamily: layer.font == 'mono' ? 'monospace' : null,
      height: 1.4,
      shadows: const [
        Shadow(offset: Offset(0, 1), blurRadius: 4, color: Colors.black54),
      ],
    );

    // Position: center of text at (positionX%, positionY%) of canvas.
    // FractionalTranslation(-0.5, -0.5) shifts by half the ACTUAL child
    // size, so text truly centers on the point regardless of text width.
    final cx = layer.positionX * widget.canvasSize.width;
    final cy = layer.positionY * widget.canvasSize.height;

    return Positioned(
      left: cx,
      top: cy,
      child: FractionalTranslation(
        translation: const Offset(-0.5, -0.5),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          onDoubleTap: widget.onDoubleTap,
          onPanStart: (_) => widget.onDragStart(),
          onPanUpdate: (d) => widget.onDrag(d.delta),
          onPanEnd: (_) {
            final rb = _contentKey.currentContext?.findRenderObject()
                as RenderBox?;
            widget.onDragEnd(rb?.size ?? const Size(50, 20));
          },
          child: Container(
            key: _contentKey,
            constraints: BoxConstraints(
              maxWidth: widget.canvasSize.width * 0.9,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: widget.isSelected && !widget.isEditing
                ? BoxDecoration(
                    border: Border.all(
                      color: Colors.white54,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  )
                : null,
            child: widget.isEditing
                ? IntrinsicWidth(
                    child: Material(
                      color: Colors.transparent,
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        maxLines: null,
                        maxLength: 200,
                        textAlign: textAlign,
                        textDirection: TextDirection.rtl,
                        style: style,
                        cursorColor: color,
                        buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: false,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          hintText: context.l10n.storyTypeHere,
                          hintStyle: style.copyWith(
                            color: Colors.white38,
                          ),
                        ),
                        onChanged: widget.onTextChanged,
                      ),
                    ),
                  )
                : Text(
                    layer.text,
                    textAlign: textAlign,
                    textDirection: TextDirection.rtl,
                    style: style,
                  ),
          ),
        ),
      ),
    );
  }

  static Color _parseColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 7) buffer.write('FF');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
