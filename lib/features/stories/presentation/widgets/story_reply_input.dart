import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';

/// Height of the reply bar (input + padding). Used by the creator
/// to reserve a dead zone at the bottom of the canvas.
const kStoryReplyBarHeight = 56.0;

/// Instagram-style transparent reply bar overlaid at the bottom of the story.
///
/// Layout (visual RTL): `[أرسل رسالة... -------] [share]`
///
/// - Pauses story timer when the text field is focused.
/// - Share shows a mock snackbar (no backend yet).
/// - Send via keyboard action (no explicit send button, matching Figma).
/// - [enabled] = false renders a visual-only preview (for creator / admin preview).
class StoryReplyInput extends StatefulWidget {
  final VoidCallback? onPause;
  final VoidCallback? onResume;
  final bool enabled;

  const StoryReplyInput({
    super.key,
    this.onPause,
    this.onResume,
    this.enabled = true,
  });

  @override
  State<StoryReplyInput> createState() => _StoryReplyInputState();
}

class _StoryReplyInputState extends State<StoryReplyInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    if (widget.enabled) {
      _focusNode.addListener(_onFocusChange);
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
    final focused = _focusNode.hasFocus;
    if (focused != _hasFocus) {
      setState(() => _hasFocus = focused);
      if (focused) {
        widget.onPause?.call();
      } else {
        widget.onResume?.call();
      }
    }
  }

  void _send() {
    if (_controller.text.trim().isEmpty) return;
    _controller.clear();
    _focusNode.unfocus();
    context.showSnackBar(context.l10n.storyReplySent);
  }

  void _share() {
    context.showSnackBar(context.l10n.storyShareCopied);
  }

  @override
  Widget build(BuildContext context) {
    final alpha = widget.enabled ? 1.0 : 0.5;

    final bar = Padding(
      padding: EdgeInsetsDirectional.only(
        start: AppSpacing.md,
        end: AppSpacing.md,
        bottom: AppSpacing.sm,
      ),
      child: Row(
        children: [
          // Reply text field
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1 * alpha),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2 * alpha),
                  width: 0.5,
                ),
              ),
              child: widget.enabled
                  ? TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 14),
                      textInputAction: TextInputAction.send,
                      decoration: InputDecoration(
                        hintText: context.l10n.storyReply,
                        hintStyle: TextStyle(
                          color: Colors.white
                              .withValues(alpha: 0.45 * alpha),
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        isDense: true,
                      ),
                      onSubmitted: (_) => _send(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Text(
                        context.l10n.storyReply,
                        style: TextStyle(
                          color: Colors.white
                              .withValues(alpha: 0.45 * alpha),
                          fontSize: 14,
                        ),
                      ),
                    ),
            ),
          ),
          SizedBox(width: AppSpacing.sm),

          // Share button
          GestureDetector(
            onTap: widget.enabled ? _share : null,
            child: Icon(
              Icons.share_outlined,
              color: Colors.white.withValues(alpha: 0.85 * alpha),
              size: 24,
            ),
          ),
        ],
      ),
    );

    if (!widget.enabled) {
      return IgnorePointer(child: bar);
    }

    return bar;
  }
}
