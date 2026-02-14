import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/features/business/stories/presentation/providers/story_creator_provider.dart';
import 'package:honak/features/stories/presentation/widgets/story_canvas.dart';
import 'package:honak/shared/widgets/app_image.dart';

/// Step 1: Dark immersive background picker — gradient / solid / image.
/// Canvas preview on top, picker panel on bottom with rounded top corners.
class BackgroundPicker extends ConsumerWidget {
  const BackgroundPicker({super.key});

  static const _gradients = [
    ['#1A73E8', '#4DA3FF'],
    ['#FF6B35', '#FF9800'],
    ['#9C27B0', '#E040FB'],
    ['#43A047', '#66BB6A'],
    ['#E53935', '#FF5722'],
    ['#1a1a2e', '#16213e'],
    ['#00695C', '#26A69A'],
    ['#BF360C', '#E64A19'],
    ['#0277BD', '#4FC3F7'],
    ['#AD1457', '#F06292'],
  ];

  static const _solidColors = [
    '#1A73E8', '#E53935', '#43A047', '#FF9800', '#9C27B0',
    '#00695C', '#F44336', '#1a1a2e', '#263238', '#4E342E',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(storyCreatorProvider);
    final notifier = ref.read(storyCreatorProvider.notifier);

    return Column(
      children: [
        // Canvas preview — centered
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 280),
              child: AspectRatio(
                aspectRatio: 9 / 16,
                child: StoryCanvas(
                  bgGradient: state.bgType == BgType.gradient
                      ? state.bgGradient
                      : null,
                  bgColor:
                      state.bgType == BgType.solid ? state.bgColor : null,
                  bgImage:
                      state.bgType == BgType.image ? state.bgImage : null,
                  interactive: false,
                ),
              ),
            ),
          ),
        ),

        // Bottom picker panel
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F2937).withValues(alpha: 0.8),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Tabs: Gradient / Solid / Image
              Row(
                children: [
                  _PickerTab(
                    label: context.l10n.storyGradient,
                    selected: state.bgType == BgType.gradient,
                    onTap: () => notifier.setBgGradient(
                      state.bgGradient ?? _gradients[0],
                    ),
                  ),
                  const SizedBox(width: 8),
                  _PickerTab(
                    label: context.l10n.storySolidColor,
                    selected: state.bgType == BgType.solid,
                    onTap: () => notifier.setBgColor(
                      state.bgColor ?? _solidColors[0],
                    ),
                  ),
                  const SizedBox(width: 8),
                  _PickerTab(
                    label: context.l10n.storyImage,
                    selected: state.bgType == BgType.image,
                    onTap: () {
                      notifier.setBgImage(
                        'https://images.unsplash.com/photo-1680381724318-c8ac9fe3a484?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080&q=80',
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Swatches
              SizedBox(
                height: state.bgType == BgType.image ? 64 : 48,
                child: state.bgType == BgType.gradient
                    ? _GradientSwatches(
                        selected: state.bgGradient,
                        onSelect: notifier.setBgGradient,
                      )
                    : state.bgType == BgType.solid
                        ? _SolidSwatches(
                            selected: state.bgColor,
                            onSelect: notifier.setBgColor,
                          )
                        : _ImageSwatches(
                            onSelect: notifier.setBgImage,
                          ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Picker tab button — dark mode
// ═══════════════════════════════════════════════════════════════

class _PickerTab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _PickerTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.white10,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: selected
                  ? const Color(0xFF111827)
                  : Colors.white60,
              fontSize: 12,
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Gradient swatches — horizontal scroll
// ═══════════════════════════════════════════════════════════════

class _GradientSwatches extends StatelessWidget {
  final List<String>? selected;
  final ValueChanged<List<String>> onSelect;

  const _GradientSwatches({this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: BackgroundPicker._gradients.length,
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (context, index) {
        final gradient = BackgroundPicker._gradients[index];
        final isSelected = selected != null &&
            selected!.length >= 2 &&
            selected![0] == gradient[0] &&
            selected![1] == gradient[1];
        return GestureDetector(
          onTap: () => onSelect(gradient),
          child: Transform.scale(
            scale: isSelected ? 1.1 : 1.0,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: gradient.map(_parseColor).toList(),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: isSelected
                    ? Border.all(color: Theme.of(context).colorScheme.surface, width: 2.5)
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Solid color swatches
// ═══════════════════════════════════════════════════════════════

class _SolidSwatches extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onSelect;

  const _SolidSwatches({this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: BackgroundPicker._solidColors.length,
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (context, index) {
        final color = BackgroundPicker._solidColors[index];
        final isSelected = selected == color;
        return GestureDetector(
          onTap: () => onSelect(color),
          child: Transform.scale(
            scale: isSelected ? 1.1 : 1.0,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _parseColor(color),
                borderRadius: BorderRadius.circular(12),
                border: isSelected
                    ? Border.all(color: Theme.of(context).colorScheme.surface, width: 2.5)
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Image swatches
// ═══════════════════════════════════════════════════════════════

class _ImageSwatches extends StatelessWidget {
  final ValueChanged<String> onSelect;

  const _ImageSwatches({required this.onSelect});

  static const _samples = [
    'https://images.unsplash.com/photo-1680381724318-c8ac9fe3a484?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080&q=80',
    'https://images.unsplash.com/photo-1760888549074-5d885d859782?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080&q=80',
    'https://images.unsplash.com/photo-1583665354191-634609954d54?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080&q=80',
    'https://images.unsplash.com/photo-1584827387179-355517d8a5fb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080&q=80',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: _samples.length,
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onSelect(_samples[index]),
          child: AppImage(
            url: _samples[index],
            width: 64,
            height: 64,
            borderRadius: BorderRadius.circular(12),
          ),
        );
      },
    );
  }
}

Color _parseColor(String hex) {
  final buffer = StringBuffer();
  if (hex.length == 7) buffer.write('FF');
  buffer.write(hex.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
