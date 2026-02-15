import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address with _$Address {
  const factory Address({
    required String id,
    required String label,
    @JsonKey(name: 'label_icon') @Default('home') String labelIcon,
    required String area,
    @Default('عمّان') String city,
    @Default('') String street,
    @Default('') String building,
    @Default('') String floor,
    @Default('') String apartment,
    @Default('') String notes,
    @JsonKey(name: 'is_default') @Default(false) bool isDefault,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}
