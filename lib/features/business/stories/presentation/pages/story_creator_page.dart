import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/features/business/stories/domain/entities/my_story.dart';
import 'package:honak/features/business/stories/presentation/providers/story_creator_provider.dart';
import 'package:honak/features/business/stories/presentation/widgets/publish_options.dart';
import 'package:honak/features/business/stories/presentation/widgets/text_layer_editor.dart';
import 'package:honak/shared/widgets/confirm_dialog.dart';

/// Dark immersive story creator — single-view with unified toolbar.
/// Canvas always visible. All controls (background, text, font, color)
/// in one compact toolbar. Publish via AppBar button → bottom sheet.
///
/// Supports two modes:
/// - **Create** (default): fresh story from scratch
/// - **Edit**: pre-populated from an existing [MyStory] via [editStory]
class StoryCreatorPage extends ConsumerStatefulWidget {
  /// Existing story to edit. If null, creates a new story.
  final MyStory? editStory;

  /// Called after successful save in edit mode.
  /// Receives the story ID so the caller can update its state.
  final ValueChanged<String>? onSaved;

  const StoryCreatorPage({super.key, this.editStory, this.onSaved});

  static const _bg = Color(0xFF111827);

  @override
  ConsumerState<StoryCreatorPage> createState() => _StoryCreatorPageState();
}

class _StoryCreatorPageState extends ConsumerState<StoryCreatorPage> {
  @override
  void initState() {
    super.initState();
    if (widget.editStory != null) {
      // Schedule after first frame so the provider is accessible
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(storyCreatorProvider.notifier)
            .loadFromStory(widget.editStory!);
      });
    }
  }

  bool get _isEditMode => widget.editStory != null;

  bool get _hasUnsavedChanges {
    final state = ref.read(storyCreatorProvider);
    return state.bgType == BgType.image ||
        state.textLayers.any((l) => l.text.trim().isNotEmpty);
  }

  Future<void> _handleBack() async {
    if (!_hasUnsavedChanges) {
      ref.read(storyCreatorProvider.notifier).reset();
      if (mounted) Navigator.of(context).pop();
      return;
    }
    final discard = await ConfirmDialog.show(
      context,
      title: context.l10n.unsavedChangesTitle,
      message: context.l10n.unsavedChangesMessage,
      confirmLabel: context.l10n.discard,
      isDestructive: true,
    );
    if (discard && mounted) {
      ref.read(storyCreatorProvider.notifier).reset();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(storyCreatorProvider);
    final hasContent = state.bgType == BgType.image ||
        state.textLayers.any((l) => l.text.trim().isNotEmpty);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) return;
          _handleBack();
        },
        child: Scaffold(
        backgroundColor: StoryCreatorPage._bg,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 22),
            color: Colors.white70,
            onPressed: _handleBack,
          ),
          title: Text(
            _isEditMode
                ? context.l10n.storyEditTitle
                : context.l10n.storyCreate,
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: FilledButton.icon(
                onPressed: hasContent
                    ? () => _onPublish(context, ref)
                    : () => context.showSnackBar(
                          context.l10n.storyAddContentFirst,
                        ),
                icon: Icon(
                  _isEditMode ? Icons.check : Icons.send,
                  size: 14,
                ),
                label: Text(
                  _isEditMode
                      ? context.l10n.storyEdit
                      : context.l10n.storyPublish,
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: hasContent
                      ? const Color(0xFF43A047)
                      : const Color(0xFF43A047).withValues(alpha: 0.4),
                  foregroundColor: Theme.of(context).colorScheme.surface,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  minimumSize: const Size(0, 32),
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: const TextLayerEditor(),
      ),
      ),
    );
  }

  Future<void> _onPublish(BuildContext context, WidgetRef ref) async {
    if (_isEditMode) {
      // Edit mode: save changes and pop
      widget.onSaved?.call(widget.editStory!.id);
      ref.read(storyCreatorProvider.notifier).reset();
      if (context.mounted) {
        context.showSnackBar(context.l10n.storyUpdated);
        Navigator.of(context).pop();
      }
    } else {
      // Create mode: show publish options sheet
      final published = await PublishSheet.show(context);
      if (published && context.mounted) {
        ref.read(storyCreatorProvider.notifier).reset();
        Navigator.of(context).pop();
      }
    }
  }
}
