import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/features/business/stories/presentation/providers/story_creator_provider.dart';
import 'package:honak/features/stories/domain/entities/text_layer.dart';
import 'package:honak/shared/widgets/app_image.dart';

/// Unified dark toolbar — background, text, font, color in one compact panel.
/// Context-aware: hints when actions need text selection first.
/// When editing text inline, shows only a Done button.
class CreatorToolbar extends ConsumerStatefulWidget {
  final VoidCallback onDoneEditing;

  const CreatorToolbar({super.key, required this.onDoneEditing});

  @override
  ConsumerState<CreatorToolbar> createState() => _CreatorToolbarState();
}

class _CreatorToolbarState extends ConsumerState<CreatorToolbar> {
  String? _expandedPanel; // 'bg' | 'font' | 'color'

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(storyCreatorProvider);
    final notifier = ref.read(storyCreatorProvider.notifier);
    final isEditing = state.editingLayerId != null;
    final hasSelection = state.selectedLayerId != null;
    final selectedLayer = hasSelection
        ? state.textLayers
            .where((l) => l.id == state.selectedLayerId)
            .firstOrNull
        : null;

    // Auto-close font/color panels when selection is lost
    if (!hasSelection &&
        (_expandedPanel == 'font' || _expandedPanel == 'color')) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _expandedPanel = null);
      });
    }

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xF01F2937),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Expandable panel area (smooth height animation)
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            alignment: Alignment.topCenter,
            child: _buildPanel(state, notifier, selectedLayer, isEditing),
          ),

          // Primary action buttons
          if (isEditing)
            _buildEditingRow()
          else
            _buildMainRow(context, state, notifier, hasSelection),
        ],
      ),
    );
  }

  // ─── Expanded panels ─────────────────────────────────────────

  Widget _buildPanel(
    StoryCreatorState state,
    StoryCreatorNotifier notifier,
    TextLayer? selected,
    bool isEditing,
  ) {
    if (isEditing) return const SizedBox.shrink();

    return switch (_expandedPanel) {
      'bg' => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _BgPanel(state: state, notifier: notifier),
        ),
      'font' when selected != null => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _FontPanel(
            layer: selected,
            onUpdate: (u) => notifier.updateTextLayer(selected.id, u),
          ),
        ),
      'color' when selected != null => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _ColorPanel(
            layer: selected,
            onUpdate: (u) => notifier.updateTextLayer(selected.id, u),
          ),
        ),
      _ => const SizedBox.shrink(),
    };
  }

  // ─── Button rows ─────────────────────────────────────────────

  Widget _buildEditingRow() {
    return Center(
      child: _ActionPill(
        icon: Icons.check_rounded,
        label: 'تم',
        isActive: true,
        activeColor: const Color(0xFF1A73E8),
        expand: false,
        onTap: () {
          setState(() => _expandedPanel = null);
          widget.onDoneEditing();
        },
      ),
    );
  }

  Widget _buildMainRow(
    BuildContext context,
    StoryCreatorState state,
    StoryCreatorNotifier notifier,
    bool hasSelection,
  ) {
    void hint() => context.showSnackBar('أضف نصاً أو اختر نصاً أولاً');

    return Row(
      children: [
        _ActionPill(
          icon: Icons.color_lens_outlined,
          label: 'خلفية',
          isActive: _expandedPanel == 'bg',
          onTap: () => _toggle('bg'),
        ),
        const SizedBox(width: 6),
        _ActionPill(
          icon: Icons.add,
          label: 'نص جديد',
          onTap: () {
            setState(() => _expandedPanel = null);
            notifier.addTextLayer();
          },
        ),
        const SizedBox(width: 6),
        _ActionPill(
          icon: Icons.format_bold,
          label: 'الخط',
          isActive: _expandedPanel == 'font',
          dimmed: !hasSelection,
          onTap: hasSelection ? () => _toggle('font') : hint,
        ),
        const SizedBox(width: 6),
        _ActionPill(
          icon: Icons.palette_outlined,
          label: 'اللون',
          isActive: _expandedPanel == 'color',
          dimmed: !hasSelection,
          onTap: hasSelection ? () => _toggle('color') : hint,
        ),
        if (hasSelection) ...[
          const SizedBox(width: 6),
          _ActionPill(
            icon: Icons.delete_outline,
            label: 'حذف',
            color: const Color(0xFFEF5350),
            onTap: () {
              setState(() => _expandedPanel = null);
              notifier.deleteTextLayer(state.selectedLayerId!);
            },
          ),
        ],
      ],
    );
  }

  void _toggle(String panel) {
    setState(() => _expandedPanel = _expandedPanel == panel ? null : panel);
  }
}

// ═══════════════════════════════════════════════════════════════
// Action pill — compact vertical [icon + label] button
// ═══════════════════════════════════════════════════════════════

class _ActionPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final bool dimmed;
  final bool expand;
  final Color? color;
  final Color? activeColor;
  final VoidCallback? onTap;

  const _ActionPill({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.dimmed = false,
    this.expand = true,
    this.color,
    this.activeColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isActive
        ? (activeColor ?? Colors.white)
        : Colors.white.withValues(alpha: 0.08);
    final fg = isActive
        ? (activeColor != null ? Colors.white : const Color(0xFF111827))
        : dimmed
            ? Colors.white30
            : (color ?? Colors.white70);

    final child = GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: fg),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(fontSize: 10, color: fg),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );

    return expand ? Expanded(child: child) : SizedBox(width: 80, child: child);
  }
}

// ═══════════════════════════════════════════════════════════════
// Background panel — gradient / solid / image tabs + swatches
// ═══════════════════════════════════════════════════════════════

class _BgPanel extends StatelessWidget {
  final StoryCreatorState state;
  final StoryCreatorNotifier notifier;

  const _BgPanel({required this.state, required this.notifier});

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
    '#1A73E8',
    '#E53935',
    '#43A047',
    '#FF9800',
    '#9C27B0',
    '#00695C',
    '#F44336',
    '#1a1a2e',
    '#263238',
    '#4E342E',
  ];

  static const _sampleImages = [
    'https://images.unsplash.com/photo-1680381724318-c8ac9fe3a484?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080&q=80',
    'https://images.unsplash.com/photo-1760888549074-5d885d859782?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080&q=80',
    'https://images.unsplash.com/photo-1583665354191-634609954d54?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080&q=80',
    'https://images.unsplash.com/photo-1584827387179-355517d8a5fb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080&q=80',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tabs
        Row(
          children: [
            _BgTab(
              label: context.l10n.storyGradient,
              selected: state.bgType == BgType.gradient,
              onTap: () => notifier.setBgGradient(
                state.bgGradient ?? _gradients[0],
              ),
            ),
            const SizedBox(width: 6),
            _BgTab(
              label: context.l10n.storySolidColor,
              selected: state.bgType == BgType.solid,
              onTap: () => notifier.setBgColor(
                state.bgColor ?? _solidColors[0],
              ),
            ),
            const SizedBox(width: 6),
            _BgTab(
              label: context.l10n.storyImage,
              selected: state.bgType == BgType.image,
              onTap: () => notifier.setBgImage(_sampleImages[0]),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Swatches
        SizedBox(
          height: state.bgType == BgType.image ? 56 : 44,
          child: switch (state.bgType) {
            BgType.gradient => _GradientSwatches(
                selected: state.bgGradient,
                onSelect: notifier.setBgGradient,
              ),
            BgType.solid => _SolidSwatches(
                selected: state.bgColor,
                onSelect: notifier.setBgColor,
              ),
            BgType.image => _ImageSwatches(onSelect: notifier.setBgImage),
          },
        ),
      ],
    );
  }
}

class _BgTab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _BgTab({
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
          padding: const EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.white10,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: selected ? const Color(0xFF111827) : Colors.white60,
              fontSize: 11,
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientSwatches extends StatelessWidget {
  final List<String>? selected;
  final ValueChanged<List<String>> onSelect;

  const _GradientSwatches({this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: _BgPanel._gradients.length,
      separatorBuilder: (_, __) => const SizedBox(width: 10),
      itemBuilder: (context, index) {
        final g = _BgPanel._gradients[index];
        final isSel = selected != null &&
            selected!.length >= 2 &&
            selected![0] == g[0] &&
            selected![1] == g[1];
        return GestureDetector(
          onTap: () => onSelect(g),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: g.map(_parseHex).toList(),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border:
                  isSel ? Border.all(color: Theme.of(context).colorScheme.surface, width: 2.5) : null,
            ),
          ),
        );
      },
    );
  }
}

class _SolidSwatches extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onSelect;

  const _SolidSwatches({this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: _BgPanel._solidColors.length,
      separatorBuilder: (_, __) => const SizedBox(width: 10),
      itemBuilder: (context, index) {
        final c = _BgPanel._solidColors[index];
        final isSel = selected == c;
        return GestureDetector(
          onTap: () => onSelect(c),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _parseHex(c),
              borderRadius: BorderRadius.circular(10),
              border:
                  isSel ? Border.all(color: Theme.of(context).colorScheme.surface, width: 2.5) : null,
            ),
          ),
        );
      },
    );
  }
}

class _ImageSwatches extends StatelessWidget {
  final ValueChanged<String> onSelect;

  const _ImageSwatches({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: _BgPanel._sampleImages.length,
      separatorBuilder: (_, __) => const SizedBox(width: 10),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onSelect(_BgPanel._sampleImages[index]),
          child: AppImage(
            url: _BgPanel._sampleImages[index],
            width: 56,
            height: 56,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Font panel — font style + font size rows
// ═══════════════════════════════════════════════════════════════

class _FontPanel extends StatelessWidget {
  final TextLayer layer;
  final ValueChanged<TextLayer> onUpdate;

  const _FontPanel({required this.layer, required this.onUpdate});

  static const _fonts = ['default', 'bold', 'elegant', 'light', 'mono'];
  static const _fontLabels = {
    'default': 'عادي',
    'bold': 'عريض',
    'elegant': 'مزخرف',
    'light': 'رفيع',
    'mono': 'آلة كاتبة',
  };
  static const _sizes = [16.0, 20.0, 28.0, 36.0];
  // Visual أ preview sizes (proportional to actual sizes)
  static const _previewSizes = [11.0, 14.0, 17.0, 21.0];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Font style — each label styled in its own font
        Row(
          children: _fonts.map((f) {
            final isSel = layer.font == f;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: GestureDetector(
                  onTap: () => onUpdate(layer.copyWith(font: f)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isSel ? Theme.of(context).colorScheme.surface : Colors.white10,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _fontLabels[f]!,
                      style: TextStyle(
                        color: isSel
                            ? const Color(0xFF111827)
                            : Colors.white60,
                        fontSize: 10,
                        fontWeight: f == 'bold' ? FontWeight.w800 : null,
                        fontStyle: f == 'elegant' ? FontStyle.italic : null,
                        fontFamily: f == 'mono' ? 'monospace' : null,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 6),
        // Font size — visual أ in increasing sizes (no labels to read)
        Row(
          children: List.generate(_sizes.length, (i) {
            final isSel = layer.fontSize == _sizes[i];
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: GestureDetector(
                  onTap: () => onUpdate(layer.copyWith(fontSize: _sizes[i])),
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      color: isSel
                          ? const Color(0xFF1A73E8)
                          : Colors.white10,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'أ',
                      style: TextStyle(
                        color: isSel ? Theme.of(context).colorScheme.surface : Colors.white54,
                        fontSize: _previewSizes[i],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Color panel — circular color swatches
// ═══════════════════════════════════════════════════════════════

class _ColorPanel extends StatelessWidget {
  final TextLayer layer;
  final ValueChanged<TextLayer> onUpdate;

  const _ColorPanel({required this.layer, required this.onUpdate});

  static const _colors = [
    '#FFFFFF', '#000000', '#FFD700', '#FF6B6B', '#4ECDC4',
    '#45B7D1', '#96CEB4', '#FFEAA7', '#DDA0DD', '#FF9800',
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: _colors.map((hex) {
        final isSel = layer.color == hex;
        return GestureDetector(
          onTap: () => onUpdate(layer.copyWith(color: hex)),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: _parseHex(hex),
              shape: BoxShape.circle,
              border: Border.all(
                color: isSel
                    ? Colors.white
                    : (hex == '#FFFFFF'
                        ? Colors.white30
                        : Colors.transparent),
                width: isSel ? 3 : 1,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════

Color _parseHex(String hex) {
  final buffer = StringBuffer();
  if (hex.length == 7) buffer.write('FF');
  buffer.write(hex.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
