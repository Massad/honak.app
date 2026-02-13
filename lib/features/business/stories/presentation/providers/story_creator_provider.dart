import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/features/business/stories/domain/entities/my_story.dart';
import 'package:honak/features/stories/domain/entities/text_layer.dart';
import 'package:uuid/uuid.dart';

enum CreatorStep { background, text, publish }

enum BgType { gradient, solid, image }

class StoryCreatorState {
  final CreatorStep step;
  final BgType bgType;
  final List<String>? bgGradient;
  final String? bgColor;
  final String? bgImage;
  final List<TextLayer> textLayers;
  final String? selectedLayerId;
  final String? editingLayerId;
  final String audience;
  final DateTime? scheduledAt;

  const StoryCreatorState({
    this.step = CreatorStep.background,
    this.bgType = BgType.gradient,
    this.bgGradient = const ['#1A73E8', '#4DA3FF'],
    this.bgColor,
    this.bgImage,
    this.textLayers = const [],
    this.selectedLayerId,
    this.editingLayerId,
    this.audience = 'followers',
    this.scheduledAt,
  });

  StoryCreatorState copyWith({
    CreatorStep? step,
    BgType? bgType,
    List<String>? bgGradient,
    String? bgColor,
    String? bgImage,
    List<TextLayer>? textLayers,
    String? selectedLayerId,
    String? editingLayerId,
    String? audience,
    DateTime? scheduledAt,
    bool clearScheduledAt = false,
    bool clearSelectedLayer = false,
    bool clearEditingLayer = false,
  }) {
    return StoryCreatorState(
      step: step ?? this.step,
      bgType: bgType ?? this.bgType,
      bgGradient: bgGradient ?? this.bgGradient,
      bgColor: bgColor ?? this.bgColor,
      bgImage: bgImage ?? this.bgImage,
      textLayers: textLayers ?? this.textLayers,
      selectedLayerId:
          clearSelectedLayer ? null : (selectedLayerId ?? this.selectedLayerId),
      editingLayerId:
          clearEditingLayer ? null : (editingLayerId ?? this.editingLayerId),
      audience: audience ?? this.audience,
      scheduledAt:
          clearScheduledAt ? null : (scheduledAt ?? this.scheduledAt),
    );
  }
}

final storyCreatorProvider =
    NotifierProvider<StoryCreatorNotifier, StoryCreatorState>(
  StoryCreatorNotifier.new,
);

class StoryCreatorNotifier extends Notifier<StoryCreatorState> {
  static const _uuid = Uuid();

  @override
  StoryCreatorState build() => const StoryCreatorState();

  void setStep(CreatorStep step) {
    state = state.copyWith(step: step);
  }

  void nextStep() {
    if (state.step == CreatorStep.background) {
      state = state.copyWith(step: CreatorStep.text);
    } else if (state.step == CreatorStep.text) {
      state = state.copyWith(step: CreatorStep.publish);
    }
  }

  void previousStep() {
    if (state.step == CreatorStep.publish) {
      state = state.copyWith(step: CreatorStep.text);
    } else if (state.step == CreatorStep.text) {
      state = state.copyWith(step: CreatorStep.background);
    }
  }

  void setBgGradient(List<String> colors) {
    state = state.copyWith(
      bgType: BgType.gradient,
      bgGradient: colors,
    );
  }

  void setBgColor(String color) {
    state = state.copyWith(
      bgType: BgType.solid,
      bgColor: color,
    );
  }

  void setBgImage(String url) {
    state = state.copyWith(
      bgType: BgType.image,
      bgImage: url,
    );
  }

  void addTextLayer() {
    // Offset each new layer slightly so they don't stack exactly
    final offset = (state.textLayers.length % 5) * 0.06;
    final layer = TextLayer(
      id: _uuid.v4(),
      text: '',
      positionX: 0.5,
      positionY: 0.5 + offset,
    );
    state = state.copyWith(
      textLayers: [...state.textLayers, layer],
      selectedLayerId: layer.id,
      editingLayerId: layer.id,
    );
  }

  void updateTextLayer(String id, TextLayer updated) {
    state = state.copyWith(
      textLayers: [
        for (final l in state.textLayers)
          if (l.id == id) updated else l,
      ],
    );
  }

  void deleteTextLayer(String id) {
    state = state.copyWith(
      textLayers: state.textLayers.where((l) => l.id != id).toList(),
      clearSelectedLayer: state.selectedLayerId == id,
      clearEditingLayer: state.editingLayerId == id,
    );
  }

  void selectLayer(String? id) {
    state = state.copyWith(
      selectedLayerId: id ?? state.selectedLayerId,
      clearSelectedLayer: id == null,
    );
  }

  void startEditing(String id) {
    state = state.copyWith(editingLayerId: id);
  }

  void stopEditing() {
    state = state.copyWith(clearEditingLayer: true);
  }

  void moveLayer(String id, Offset delta, Size canvasSize) {
    final layer = state.textLayers.firstWhere((l) => l.id == id);
    // No clamping during drag — allow free movement
    final newX = layer.positionX + delta.dx / canvasSize.width;
    final newY = layer.positionY + delta.dy / canvasSize.height;
    updateTextLayer(
      id,
      layer.copyWith(positionX: newX, positionY: newY),
    );
  }

  /// Snap layer so the ENTIRE text stays within canvas bounds.
  /// [canvasSize] and [textSize] are in pixels — we compute the valid
  /// center-point range from the actual rendered text dimensions.
  /// [bottomReserved] — extra pixels reserved at the bottom (e.g. reply bar).
  void snapLayerToBounds(String id, Size canvasSize, Size textSize,
      {double bottomReserved = 0}) {
    final layer = state.textLayers.firstWhere((l) => l.id == id);

    // Half-dimensions as fraction of canvas, plus 4px edge padding
    const pad = 4.0;
    final halfW = ((textSize.width / 2) + pad) / canvasSize.width;
    final halfH = ((textSize.height / 2) + pad) / canvasSize.height;
    final bottomFraction = bottomReserved / canvasSize.height;

    // Valid center range — if text is wider/taller than canvas, just center it
    final minX = halfW;
    final maxX = 1.0 - halfW;
    final minY = halfH;
    final maxY = 1.0 - halfH - bottomFraction;

    final clampedX = minX >= maxX ? 0.5 : layer.positionX.clamp(minX, maxX);
    final clampedY = minY >= maxY ? 0.5 : layer.positionY.clamp(minY, maxY);

    if (clampedX != layer.positionX || clampedY != layer.positionY) {
      updateTextLayer(
        id,
        layer.copyWith(positionX: clampedX, positionY: clampedY),
      );
    }
  }

  void setAudience(String audience) {
    state = state.copyWith(audience: audience);
  }

  void setSchedule(DateTime? dateTime) {
    if (dateTime == null) {
      state = state.copyWith(clearScheduledAt: true);
    } else {
      state = state.copyWith(scheduledAt: dateTime);
    }
  }

  /// Pre-populate the creator from an existing story (for edit / republish).
  void loadFromStory(MyStory story) {
    final slide = story.slide;

    // Determine background type
    BgType bgType;
    if (slide.image != null) {
      bgType = BgType.image;
    } else if (slide.bgGradient != null && slide.bgGradient!.length >= 2) {
      bgType = BgType.gradient;
    } else if (slide.bgColor != null) {
      bgType = BgType.solid;
    } else {
      bgType = BgType.gradient;
    }

    // Convert slide's simple text + textLayers into creator text layers.
    // If the slide has textLayers, use those directly.
    // Otherwise, convert the simple text/font/color into a single layer.
    List<TextLayer> layers;
    if (slide.textLayers.isNotEmpty) {
      layers = slide.textLayers;
    } else if (slide.text != null && slide.text!.isNotEmpty) {
      layers = [
        TextLayer(
          id: _uuid.v4(),
          text: slide.text!,
          positionX: 0.5,
          positionY: switch (slide.textPosition) {
            'top' => 0.2,
            'bottom' => 0.8,
            _ => 0.5,
          },
          color: slide.textColor,
          font: slide.font,
          fontSize: slide.font == 'bold' ? 28 : (slide.font == 'elegant' ? 26 : 22),
        ),
      ];
    } else {
      layers = [];
    }

    state = StoryCreatorState(
      bgType: bgType,
      bgGradient: slide.bgGradient,
      bgColor: slide.bgColor,
      bgImage: slide.image,
      textLayers: layers,
      audience: story.audience,
    );
  }

  void reset() {
    state = const StoryCreatorState();
  }
}
