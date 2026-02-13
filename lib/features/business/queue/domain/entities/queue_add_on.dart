import 'package:freezed_annotation/freezed_annotation.dart';

part 'queue_add_on.freezed.dart';
part 'queue_add_on.g.dart';

@freezed
class QueueAddOn with _$QueueAddOn {
  const factory QueueAddOn({
    required String name,
    @JsonKey(name: 'price_cents') required int price,
  }) = _QueueAddOn;

  factory QueueAddOn.fromJson(Map<String, dynamic> json) =>
      _$QueueAddOnFromJson(json);
}
