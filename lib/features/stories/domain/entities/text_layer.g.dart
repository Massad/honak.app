// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_layer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TextLayerImpl _$$TextLayerImplFromJson(Map<String, dynamic> json) =>
    _$TextLayerImpl(
      id: json['id'] as String,
      text: json['text'] as String,
      positionX: (json['position_x'] as num?)?.toDouble() ?? 0.5,
      positionY: (json['position_y'] as num?)?.toDouble() ?? 0.5,
      color: json['color'] as String? ?? '#FFFFFF',
      font: json['font'] as String? ?? 'default',
      fontSize: (json['font_size'] as num?)?.toDouble() ?? 24.0,
      align: json['align'] as String? ?? 'center',
    );

Map<String, dynamic> _$$TextLayerImplToJson(_$TextLayerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'position_x': instance.positionX,
      'position_y': instance.positionY,
      'color': instance.color,
      'font': instance.font,
      'font_size': instance.fontSize,
      'align': instance.align,
    };
