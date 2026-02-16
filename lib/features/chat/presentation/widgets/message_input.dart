import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/chat/domain/entities/message.dart';
import 'package:honak/shared/widgets/button.dart';

class MessageInput extends StatefulWidget {
  final void Function(String text) onSend;
  final bool isBusinessMode;
  final VoidCallback? onZapTap;
  final Message? editingMessage;
  final VoidCallback? onCancelEdit;

  const MessageInput({
    super.key,
    required this.onSend,
    this.isBusinessMode = false,
    this.onZapTap,
    this.editingMessage,
    this.onCancelEdit,
  });

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final hasText = _controller.text.trim().isNotEmpty;
      if (hasText != _hasText) {
        setState(() => _hasText = hasText);
      }
    });
  }

  @override
  void didUpdateWidget(covariant MessageInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // When entering edit mode, prefill the text
    if (widget.editingMessage != null &&
        widget.editingMessage != oldWidget.editingMessage) {
      _controller.text = widget.editingMessage!.content;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
    // When leaving edit mode, clear if text matches the old message
    if (widget.editingMessage == null && oldWidget.editingMessage != null) {
      if (_controller.text == oldWidget.editingMessage!.content) {
        _controller.clear();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onSend(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    final isEditing = widget.editingMessage != null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isEditing)
          Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: cs.surface,
              border: Border(
                top: BorderSide(color: cs.outlineVariant, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.edit_rounded,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
                const Expanded(
                  child: Text(
                    'تعديل الرسالة',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: widget.onCancelEdit,
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        Container(
          padding: EdgeInsetsDirectional.only(
            start: AppSpacing.sm,
            end: AppSpacing.sm,
            top: AppSpacing.sm,
            bottom: AppSpacing.sm + MediaQuery.of(context).padding.bottom,
          ),
          decoration: BoxDecoration(
            color: cs.surface,
            border: isEditing
                ? null
                : Border(
                    top: BorderSide(color: cs.outlineVariant, width: 0.5),
                  ),
          ),
          child: Row(
            children: [
              Button(
                onPressed: () {},
                icon: ButtonIcon(Icons.attach_file_rounded, size: 22, color: cs.onSurfaceVariant),
                variant: Variant.text,
                size: ButtonSize.small,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _handleSend(),
                    maxLines: 4,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: 'اكتب رسالة...',
                      hintStyle: TextStyle(
                        color: cs.onSurfaceVariant,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsetsDirectional.only(
                        start: AppSpacing.lg,
                        end: AppSpacing.lg,
                        top: AppSpacing.sm,
                        bottom: AppSpacing.sm,
                      ),
                      isDense: true,
                    ),
                    style: TextStyle(
                      fontSize: 14,
                      color: cs.onSurface,
                    ),
                  ),
                ),
              ),
              if (widget.isBusinessMode && widget.onZapTap != null) ...[
                const SizedBox(width: 2),
                SizedBox(
                  width: 36,
                  height: 36,
                  child: Material(
                    color: Colors.transparent,
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: widget.onZapTap,
                      customBorder: const CircleBorder(),
                      child: const Center(
                        child: Icon(
                          Icons.electric_bolt,
                          size: 22,
                          color: AppColors.warning,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(width: AppSpacing.xs),
              SizedBox(
                width: 40,
                height: 40,
                child: Material(
                  color: _hasText ? AppColors.primary : cs.onSurfaceVariant,
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: _hasText ? _handleSend : null,
                    customBorder: const CircleBorder(),
                    child: const Center(
                      child: Icon(
                        Icons.send_rounded,
                        size: 20,
                        color: AppColors.white,
                      ),
                    ),
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
