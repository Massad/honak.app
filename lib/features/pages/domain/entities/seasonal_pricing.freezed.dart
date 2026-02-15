// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seasonal_pricing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SeasonRule _$SeasonRuleFromJson(Map<String, dynamic> json) {
  return _SeasonRule.fromJson(json);
}

/// @nodoc
mixin _$SeasonRule {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_month')
  int get startMonth => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_day')
  int get startDay => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_month')
  int get endMonth => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_day')
  int get endDay => throw _privateConstructorUsedError;
  @JsonKey(name: 'weekday_cents')
  int get weekdayCents => throw _privateConstructorUsedError;
  @JsonKey(name: 'weekend_cents')
  int get weekendCents => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;

  /// Serializes this SeasonRule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SeasonRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeasonRuleCopyWith<SeasonRule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeasonRuleCopyWith<$Res> {
  factory $SeasonRuleCopyWith(
    SeasonRule value,
    $Res Function(SeasonRule) then,
  ) = _$SeasonRuleCopyWithImpl<$Res, SeasonRule>;
  @useResult
  $Res call({
    String id,
    String name,
    String icon,
    @JsonKey(name: 'start_month') int startMonth,
    @JsonKey(name: 'start_day') int startDay,
    @JsonKey(name: 'end_month') int endMonth,
    @JsonKey(name: 'end_day') int endDay,
    @JsonKey(name: 'weekday_cents') int weekdayCents,
    @JsonKey(name: 'weekend_cents') int weekendCents,
    String currency,
    bool active,
    String color,
  });
}

/// @nodoc
class _$SeasonRuleCopyWithImpl<$Res, $Val extends SeasonRule>
    implements $SeasonRuleCopyWith<$Res> {
  _$SeasonRuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeasonRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = null,
    Object? startMonth = null,
    Object? startDay = null,
    Object? endMonth = null,
    Object? endDay = null,
    Object? weekdayCents = null,
    Object? weekendCents = null,
    Object? currency = null,
    Object? active = null,
    Object? color = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            icon: null == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String,
            startMonth: null == startMonth
                ? _value.startMonth
                : startMonth // ignore: cast_nullable_to_non_nullable
                      as int,
            startDay: null == startDay
                ? _value.startDay
                : startDay // ignore: cast_nullable_to_non_nullable
                      as int,
            endMonth: null == endMonth
                ? _value.endMonth
                : endMonth // ignore: cast_nullable_to_non_nullable
                      as int,
            endDay: null == endDay
                ? _value.endDay
                : endDay // ignore: cast_nullable_to_non_nullable
                      as int,
            weekdayCents: null == weekdayCents
                ? _value.weekdayCents
                : weekdayCents // ignore: cast_nullable_to_non_nullable
                      as int,
            weekendCents: null == weekendCents
                ? _value.weekendCents
                : weekendCents // ignore: cast_nullable_to_non_nullable
                      as int,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
            color: null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SeasonRuleImplCopyWith<$Res>
    implements $SeasonRuleCopyWith<$Res> {
  factory _$$SeasonRuleImplCopyWith(
    _$SeasonRuleImpl value,
    $Res Function(_$SeasonRuleImpl) then,
  ) = __$$SeasonRuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String icon,
    @JsonKey(name: 'start_month') int startMonth,
    @JsonKey(name: 'start_day') int startDay,
    @JsonKey(name: 'end_month') int endMonth,
    @JsonKey(name: 'end_day') int endDay,
    @JsonKey(name: 'weekday_cents') int weekdayCents,
    @JsonKey(name: 'weekend_cents') int weekendCents,
    String currency,
    bool active,
    String color,
  });
}

/// @nodoc
class __$$SeasonRuleImplCopyWithImpl<$Res>
    extends _$SeasonRuleCopyWithImpl<$Res, _$SeasonRuleImpl>
    implements _$$SeasonRuleImplCopyWith<$Res> {
  __$$SeasonRuleImplCopyWithImpl(
    _$SeasonRuleImpl _value,
    $Res Function(_$SeasonRuleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SeasonRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = null,
    Object? startMonth = null,
    Object? startDay = null,
    Object? endMonth = null,
    Object? endDay = null,
    Object? weekdayCents = null,
    Object? weekendCents = null,
    Object? currency = null,
    Object? active = null,
    Object? color = null,
  }) {
    return _then(
      _$SeasonRuleImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        icon: null == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String,
        startMonth: null == startMonth
            ? _value.startMonth
            : startMonth // ignore: cast_nullable_to_non_nullable
                  as int,
        startDay: null == startDay
            ? _value.startDay
            : startDay // ignore: cast_nullable_to_non_nullable
                  as int,
        endMonth: null == endMonth
            ? _value.endMonth
            : endMonth // ignore: cast_nullable_to_non_nullable
                  as int,
        endDay: null == endDay
            ? _value.endDay
            : endDay // ignore: cast_nullable_to_non_nullable
                  as int,
        weekdayCents: null == weekdayCents
            ? _value.weekdayCents
            : weekdayCents // ignore: cast_nullable_to_non_nullable
                  as int,
        weekendCents: null == weekendCents
            ? _value.weekendCents
            : weekendCents // ignore: cast_nullable_to_non_nullable
                  as int,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
        color: null == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SeasonRuleImpl implements _SeasonRule {
  const _$SeasonRuleImpl({
    required this.id,
    required this.name,
    this.icon = 'calendar_today',
    @JsonKey(name: 'start_month') required this.startMonth,
    @JsonKey(name: 'start_day') required this.startDay,
    @JsonKey(name: 'end_month') required this.endMonth,
    @JsonKey(name: 'end_day') required this.endDay,
    @JsonKey(name: 'weekday_cents') required this.weekdayCents,
    @JsonKey(name: 'weekend_cents') required this.weekendCents,
    this.currency = 'JOD',
    this.active = true,
    this.color = '#1A73E8',
  });

  factory _$SeasonRuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeasonRuleImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String icon;
  @override
  @JsonKey(name: 'start_month')
  final int startMonth;
  @override
  @JsonKey(name: 'start_day')
  final int startDay;
  @override
  @JsonKey(name: 'end_month')
  final int endMonth;
  @override
  @JsonKey(name: 'end_day')
  final int endDay;
  @override
  @JsonKey(name: 'weekday_cents')
  final int weekdayCents;
  @override
  @JsonKey(name: 'weekend_cents')
  final int weekendCents;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey()
  final bool active;
  @override
  @JsonKey()
  final String color;

  @override
  String toString() {
    return 'SeasonRule(id: $id, name: $name, icon: $icon, startMonth: $startMonth, startDay: $startDay, endMonth: $endMonth, endDay: $endDay, weekdayCents: $weekdayCents, weekendCents: $weekendCents, currency: $currency, active: $active, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeasonRuleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.startMonth, startMonth) ||
                other.startMonth == startMonth) &&
            (identical(other.startDay, startDay) ||
                other.startDay == startDay) &&
            (identical(other.endMonth, endMonth) ||
                other.endMonth == endMonth) &&
            (identical(other.endDay, endDay) || other.endDay == endDay) &&
            (identical(other.weekdayCents, weekdayCents) ||
                other.weekdayCents == weekdayCents) &&
            (identical(other.weekendCents, weekendCents) ||
                other.weekendCents == weekendCents) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    icon,
    startMonth,
    startDay,
    endMonth,
    endDay,
    weekdayCents,
    weekendCents,
    currency,
    active,
    color,
  );

  /// Create a copy of SeasonRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeasonRuleImplCopyWith<_$SeasonRuleImpl> get copyWith =>
      __$$SeasonRuleImplCopyWithImpl<_$SeasonRuleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SeasonRuleImplToJson(this);
  }
}

abstract class _SeasonRule implements SeasonRule {
  const factory _SeasonRule({
    required final String id,
    required final String name,
    final String icon,
    @JsonKey(name: 'start_month') required final int startMonth,
    @JsonKey(name: 'start_day') required final int startDay,
    @JsonKey(name: 'end_month') required final int endMonth,
    @JsonKey(name: 'end_day') required final int endDay,
    @JsonKey(name: 'weekday_cents') required final int weekdayCents,
    @JsonKey(name: 'weekend_cents') required final int weekendCents,
    final String currency,
    final bool active,
    final String color,
  }) = _$SeasonRuleImpl;

  factory _SeasonRule.fromJson(Map<String, dynamic> json) =
      _$SeasonRuleImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get icon;
  @override
  @JsonKey(name: 'start_month')
  int get startMonth;
  @override
  @JsonKey(name: 'start_day')
  int get startDay;
  @override
  @JsonKey(name: 'end_month')
  int get endMonth;
  @override
  @JsonKey(name: 'end_day')
  int get endDay;
  @override
  @JsonKey(name: 'weekday_cents')
  int get weekdayCents;
  @override
  @JsonKey(name: 'weekend_cents')
  int get weekendCents;
  @override
  String get currency;
  @override
  bool get active;
  @override
  String get color;

  /// Create a copy of SeasonRule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeasonRuleImplCopyWith<_$SeasonRuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HolidaySurcharge _$HolidaySurchargeFromJson(Map<String, dynamic> json) {
  return _HolidaySurcharge.fromJson(json);
}

/// @nodoc
mixin _$HolidaySurcharge {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_date')
  String get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_date')
  String get endDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'surcharge_percent')
  int get surchargePercent => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;

  /// Serializes this HolidaySurcharge to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HolidaySurcharge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HolidaySurchargeCopyWith<HolidaySurcharge> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HolidaySurchargeCopyWith<$Res> {
  factory $HolidaySurchargeCopyWith(
    HolidaySurcharge value,
    $Res Function(HolidaySurcharge) then,
  ) = _$HolidaySurchargeCopyWithImpl<$Res, HolidaySurcharge>;
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'start_date') String startDate,
    @JsonKey(name: 'end_date') String endDate,
    @JsonKey(name: 'surcharge_percent') int surchargePercent,
    bool active,
  });
}

/// @nodoc
class _$HolidaySurchargeCopyWithImpl<$Res, $Val extends HolidaySurcharge>
    implements $HolidaySurchargeCopyWith<$Res> {
  _$HolidaySurchargeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HolidaySurcharge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? surchargePercent = null,
    Object? active = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as String,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as String,
            surchargePercent: null == surchargePercent
                ? _value.surchargePercent
                : surchargePercent // ignore: cast_nullable_to_non_nullable
                      as int,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HolidaySurchargeImplCopyWith<$Res>
    implements $HolidaySurchargeCopyWith<$Res> {
  factory _$$HolidaySurchargeImplCopyWith(
    _$HolidaySurchargeImpl value,
    $Res Function(_$HolidaySurchargeImpl) then,
  ) = __$$HolidaySurchargeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(name: 'start_date') String startDate,
    @JsonKey(name: 'end_date') String endDate,
    @JsonKey(name: 'surcharge_percent') int surchargePercent,
    bool active,
  });
}

/// @nodoc
class __$$HolidaySurchargeImplCopyWithImpl<$Res>
    extends _$HolidaySurchargeCopyWithImpl<$Res, _$HolidaySurchargeImpl>
    implements _$$HolidaySurchargeImplCopyWith<$Res> {
  __$$HolidaySurchargeImplCopyWithImpl(
    _$HolidaySurchargeImpl _value,
    $Res Function(_$HolidaySurchargeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HolidaySurcharge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? surchargePercent = null,
    Object? active = null,
  }) {
    return _then(
      _$HolidaySurchargeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as String,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as String,
        surchargePercent: null == surchargePercent
            ? _value.surchargePercent
            : surchargePercent // ignore: cast_nullable_to_non_nullable
                  as int,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HolidaySurchargeImpl implements _HolidaySurcharge {
  const _$HolidaySurchargeImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'start_date') required this.startDate,
    @JsonKey(name: 'end_date') required this.endDate,
    @JsonKey(name: 'surcharge_percent') required this.surchargePercent,
    this.active = true,
  });

  factory _$HolidaySurchargeImpl.fromJson(Map<String, dynamic> json) =>
      _$$HolidaySurchargeImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: 'start_date')
  final String startDate;
  @override
  @JsonKey(name: 'end_date')
  final String endDate;
  @override
  @JsonKey(name: 'surcharge_percent')
  final int surchargePercent;
  @override
  @JsonKey()
  final bool active;

  @override
  String toString() {
    return 'HolidaySurcharge(id: $id, name: $name, startDate: $startDate, endDate: $endDate, surchargePercent: $surchargePercent, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HolidaySurchargeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.surchargePercent, surchargePercent) ||
                other.surchargePercent == surchargePercent) &&
            (identical(other.active, active) || other.active == active));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    startDate,
    endDate,
    surchargePercent,
    active,
  );

  /// Create a copy of HolidaySurcharge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HolidaySurchargeImplCopyWith<_$HolidaySurchargeImpl> get copyWith =>
      __$$HolidaySurchargeImplCopyWithImpl<_$HolidaySurchargeImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$HolidaySurchargeImplToJson(this);
  }
}

abstract class _HolidaySurcharge implements HolidaySurcharge {
  const factory _HolidaySurcharge({
    required final String id,
    required final String name,
    @JsonKey(name: 'start_date') required final String startDate,
    @JsonKey(name: 'end_date') required final String endDate,
    @JsonKey(name: 'surcharge_percent') required final int surchargePercent,
    final bool active,
  }) = _$HolidaySurchargeImpl;

  factory _HolidaySurcharge.fromJson(Map<String, dynamic> json) =
      _$HolidaySurchargeImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'start_date')
  String get startDate;
  @override
  @JsonKey(name: 'end_date')
  String get endDate;
  @override
  @JsonKey(name: 'surcharge_percent')
  int get surchargePercent;
  @override
  bool get active;

  /// Create a copy of HolidaySurcharge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HolidaySurchargeImplCopyWith<_$HolidaySurchargeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EarlyBirdDiscount _$EarlyBirdDiscountFromJson(Map<String, dynamic> json) {
  return _EarlyBirdDiscount.fromJson(json);
}

/// @nodoc
mixin _$EarlyBirdDiscount {
  @JsonKey(name: 'days_ahead')
  int get daysAhead => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_percent')
  int get discountPercent => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;

  /// Serializes this EarlyBirdDiscount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EarlyBirdDiscount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EarlyBirdDiscountCopyWith<EarlyBirdDiscount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarlyBirdDiscountCopyWith<$Res> {
  factory $EarlyBirdDiscountCopyWith(
    EarlyBirdDiscount value,
    $Res Function(EarlyBirdDiscount) then,
  ) = _$EarlyBirdDiscountCopyWithImpl<$Res, EarlyBirdDiscount>;
  @useResult
  $Res call({
    @JsonKey(name: 'days_ahead') int daysAhead,
    @JsonKey(name: 'discount_percent') int discountPercent,
    bool active,
  });
}

/// @nodoc
class _$EarlyBirdDiscountCopyWithImpl<$Res, $Val extends EarlyBirdDiscount>
    implements $EarlyBirdDiscountCopyWith<$Res> {
  _$EarlyBirdDiscountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EarlyBirdDiscount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? daysAhead = null,
    Object? discountPercent = null,
    Object? active = null,
  }) {
    return _then(
      _value.copyWith(
            daysAhead: null == daysAhead
                ? _value.daysAhead
                : daysAhead // ignore: cast_nullable_to_non_nullable
                      as int,
            discountPercent: null == discountPercent
                ? _value.discountPercent
                : discountPercent // ignore: cast_nullable_to_non_nullable
                      as int,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EarlyBirdDiscountImplCopyWith<$Res>
    implements $EarlyBirdDiscountCopyWith<$Res> {
  factory _$$EarlyBirdDiscountImplCopyWith(
    _$EarlyBirdDiscountImpl value,
    $Res Function(_$EarlyBirdDiscountImpl) then,
  ) = __$$EarlyBirdDiscountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'days_ahead') int daysAhead,
    @JsonKey(name: 'discount_percent') int discountPercent,
    bool active,
  });
}

/// @nodoc
class __$$EarlyBirdDiscountImplCopyWithImpl<$Res>
    extends _$EarlyBirdDiscountCopyWithImpl<$Res, _$EarlyBirdDiscountImpl>
    implements _$$EarlyBirdDiscountImplCopyWith<$Res> {
  __$$EarlyBirdDiscountImplCopyWithImpl(
    _$EarlyBirdDiscountImpl _value,
    $Res Function(_$EarlyBirdDiscountImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EarlyBirdDiscount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? daysAhead = null,
    Object? discountPercent = null,
    Object? active = null,
  }) {
    return _then(
      _$EarlyBirdDiscountImpl(
        daysAhead: null == daysAhead
            ? _value.daysAhead
            : daysAhead // ignore: cast_nullable_to_non_nullable
                  as int,
        discountPercent: null == discountPercent
            ? _value.discountPercent
            : discountPercent // ignore: cast_nullable_to_non_nullable
                  as int,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EarlyBirdDiscountImpl implements _EarlyBirdDiscount {
  const _$EarlyBirdDiscountImpl({
    @JsonKey(name: 'days_ahead') this.daysAhead = 14,
    @JsonKey(name: 'discount_percent') this.discountPercent = 10,
    this.active = false,
  });

  factory _$EarlyBirdDiscountImpl.fromJson(Map<String, dynamic> json) =>
      _$$EarlyBirdDiscountImplFromJson(json);

  @override
  @JsonKey(name: 'days_ahead')
  final int daysAhead;
  @override
  @JsonKey(name: 'discount_percent')
  final int discountPercent;
  @override
  @JsonKey()
  final bool active;

  @override
  String toString() {
    return 'EarlyBirdDiscount(daysAhead: $daysAhead, discountPercent: $discountPercent, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarlyBirdDiscountImpl &&
            (identical(other.daysAhead, daysAhead) ||
                other.daysAhead == daysAhead) &&
            (identical(other.discountPercent, discountPercent) ||
                other.discountPercent == discountPercent) &&
            (identical(other.active, active) || other.active == active));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, daysAhead, discountPercent, active);

  /// Create a copy of EarlyBirdDiscount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EarlyBirdDiscountImplCopyWith<_$EarlyBirdDiscountImpl> get copyWith =>
      __$$EarlyBirdDiscountImplCopyWithImpl<_$EarlyBirdDiscountImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EarlyBirdDiscountImplToJson(this);
  }
}

abstract class _EarlyBirdDiscount implements EarlyBirdDiscount {
  const factory _EarlyBirdDiscount({
    @JsonKey(name: 'days_ahead') final int daysAhead,
    @JsonKey(name: 'discount_percent') final int discountPercent,
    final bool active,
  }) = _$EarlyBirdDiscountImpl;

  factory _EarlyBirdDiscount.fromJson(Map<String, dynamic> json) =
      _$EarlyBirdDiscountImpl.fromJson;

  @override
  @JsonKey(name: 'days_ahead')
  int get daysAhead;
  @override
  @JsonKey(name: 'discount_percent')
  int get discountPercent;
  @override
  bool get active;

  /// Create a copy of EarlyBirdDiscount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EarlyBirdDiscountImplCopyWith<_$EarlyBirdDiscountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LastMinuteDeal _$LastMinuteDealFromJson(Map<String, dynamic> json) {
  return _LastMinuteDeal.fromJson(json);
}

/// @nodoc
mixin _$LastMinuteDeal {
  @JsonKey(name: 'hours_before_checkin')
  int get hoursBeforeCheckin => throw _privateConstructorUsedError;
  @JsonKey(name: 'days_ahead')
  int get daysAhead => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_percent')
  int get discountPercent => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;

  /// Serializes this LastMinuteDeal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LastMinuteDeal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LastMinuteDealCopyWith<LastMinuteDeal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LastMinuteDealCopyWith<$Res> {
  factory $LastMinuteDealCopyWith(
    LastMinuteDeal value,
    $Res Function(LastMinuteDeal) then,
  ) = _$LastMinuteDealCopyWithImpl<$Res, LastMinuteDeal>;
  @useResult
  $Res call({
    @JsonKey(name: 'hours_before_checkin') int hoursBeforeCheckin,
    @JsonKey(name: 'days_ahead') int daysAhead,
    @JsonKey(name: 'discount_percent') int discountPercent,
    bool active,
    String label,
  });
}

/// @nodoc
class _$LastMinuteDealCopyWithImpl<$Res, $Val extends LastMinuteDeal>
    implements $LastMinuteDealCopyWith<$Res> {
  _$LastMinuteDealCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LastMinuteDeal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hoursBeforeCheckin = null,
    Object? daysAhead = null,
    Object? discountPercent = null,
    Object? active = null,
    Object? label = null,
  }) {
    return _then(
      _value.copyWith(
            hoursBeforeCheckin: null == hoursBeforeCheckin
                ? _value.hoursBeforeCheckin
                : hoursBeforeCheckin // ignore: cast_nullable_to_non_nullable
                      as int,
            daysAhead: null == daysAhead
                ? _value.daysAhead
                : daysAhead // ignore: cast_nullable_to_non_nullable
                      as int,
            discountPercent: null == discountPercent
                ? _value.discountPercent
                : discountPercent // ignore: cast_nullable_to_non_nullable
                      as int,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LastMinuteDealImplCopyWith<$Res>
    implements $LastMinuteDealCopyWith<$Res> {
  factory _$$LastMinuteDealImplCopyWith(
    _$LastMinuteDealImpl value,
    $Res Function(_$LastMinuteDealImpl) then,
  ) = __$$LastMinuteDealImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'hours_before_checkin') int hoursBeforeCheckin,
    @JsonKey(name: 'days_ahead') int daysAhead,
    @JsonKey(name: 'discount_percent') int discountPercent,
    bool active,
    String label,
  });
}

/// @nodoc
class __$$LastMinuteDealImplCopyWithImpl<$Res>
    extends _$LastMinuteDealCopyWithImpl<$Res, _$LastMinuteDealImpl>
    implements _$$LastMinuteDealImplCopyWith<$Res> {
  __$$LastMinuteDealImplCopyWithImpl(
    _$LastMinuteDealImpl _value,
    $Res Function(_$LastMinuteDealImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LastMinuteDeal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hoursBeforeCheckin = null,
    Object? daysAhead = null,
    Object? discountPercent = null,
    Object? active = null,
    Object? label = null,
  }) {
    return _then(
      _$LastMinuteDealImpl(
        hoursBeforeCheckin: null == hoursBeforeCheckin
            ? _value.hoursBeforeCheckin
            : hoursBeforeCheckin // ignore: cast_nullable_to_non_nullable
                  as int,
        daysAhead: null == daysAhead
            ? _value.daysAhead
            : daysAhead // ignore: cast_nullable_to_non_nullable
                  as int,
        discountPercent: null == discountPercent
            ? _value.discountPercent
            : discountPercent // ignore: cast_nullable_to_non_nullable
                  as int,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LastMinuteDealImpl implements _LastMinuteDeal {
  const _$LastMinuteDealImpl({
    @JsonKey(name: 'hours_before_checkin') this.hoursBeforeCheckin = 48,
    @JsonKey(name: 'days_ahead') this.daysAhead = 2,
    @JsonKey(name: 'discount_percent') this.discountPercent = 20,
    this.active = false,
    this.label = 'عرض اللحظة الأخيرة',
  });

  factory _$LastMinuteDealImpl.fromJson(Map<String, dynamic> json) =>
      _$$LastMinuteDealImplFromJson(json);

  @override
  @JsonKey(name: 'hours_before_checkin')
  final int hoursBeforeCheckin;
  @override
  @JsonKey(name: 'days_ahead')
  final int daysAhead;
  @override
  @JsonKey(name: 'discount_percent')
  final int discountPercent;
  @override
  @JsonKey()
  final bool active;
  @override
  @JsonKey()
  final String label;

  @override
  String toString() {
    return 'LastMinuteDeal(hoursBeforeCheckin: $hoursBeforeCheckin, daysAhead: $daysAhead, discountPercent: $discountPercent, active: $active, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LastMinuteDealImpl &&
            (identical(other.hoursBeforeCheckin, hoursBeforeCheckin) ||
                other.hoursBeforeCheckin == hoursBeforeCheckin) &&
            (identical(other.daysAhead, daysAhead) ||
                other.daysAhead == daysAhead) &&
            (identical(other.discountPercent, discountPercent) ||
                other.discountPercent == discountPercent) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    hoursBeforeCheckin,
    daysAhead,
    discountPercent,
    active,
    label,
  );

  /// Create a copy of LastMinuteDeal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LastMinuteDealImplCopyWith<_$LastMinuteDealImpl> get copyWith =>
      __$$LastMinuteDealImplCopyWithImpl<_$LastMinuteDealImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LastMinuteDealImplToJson(this);
  }
}

abstract class _LastMinuteDeal implements LastMinuteDeal {
  const factory _LastMinuteDeal({
    @JsonKey(name: 'hours_before_checkin') final int hoursBeforeCheckin,
    @JsonKey(name: 'days_ahead') final int daysAhead,
    @JsonKey(name: 'discount_percent') final int discountPercent,
    final bool active,
    final String label,
  }) = _$LastMinuteDealImpl;

  factory _LastMinuteDeal.fromJson(Map<String, dynamic> json) =
      _$LastMinuteDealImpl.fromJson;

  @override
  @JsonKey(name: 'hours_before_checkin')
  int get hoursBeforeCheckin;
  @override
  @JsonKey(name: 'days_ahead')
  int get daysAhead;
  @override
  @JsonKey(name: 'discount_percent')
  int get discountPercent;
  @override
  bool get active;
  @override
  String get label;

  /// Create a copy of LastMinuteDeal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LastMinuteDealImplCopyWith<_$LastMinuteDealImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SeasonalPricing _$SeasonalPricingFromJson(Map<String, dynamic> json) {
  return _SeasonalPricing.fromJson(json);
}

/// @nodoc
mixin _$SeasonalPricing {
  List<SeasonRule> get seasons => throw _privateConstructorUsedError;
  List<HolidaySurcharge> get holidays => throw _privateConstructorUsedError;
  @JsonKey(name: 'early_bird')
  EarlyBirdDiscount? get earlyBird => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_minute')
  LastMinuteDeal? get lastMinute => throw _privateConstructorUsedError;

  /// Serializes this SeasonalPricing to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SeasonalPricing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeasonalPricingCopyWith<SeasonalPricing> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeasonalPricingCopyWith<$Res> {
  factory $SeasonalPricingCopyWith(
    SeasonalPricing value,
    $Res Function(SeasonalPricing) then,
  ) = _$SeasonalPricingCopyWithImpl<$Res, SeasonalPricing>;
  @useResult
  $Res call({
    List<SeasonRule> seasons,
    List<HolidaySurcharge> holidays,
    @JsonKey(name: 'early_bird') EarlyBirdDiscount? earlyBird,
    @JsonKey(name: 'last_minute') LastMinuteDeal? lastMinute,
  });

  $EarlyBirdDiscountCopyWith<$Res>? get earlyBird;
  $LastMinuteDealCopyWith<$Res>? get lastMinute;
}

/// @nodoc
class _$SeasonalPricingCopyWithImpl<$Res, $Val extends SeasonalPricing>
    implements $SeasonalPricingCopyWith<$Res> {
  _$SeasonalPricingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeasonalPricing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seasons = null,
    Object? holidays = null,
    Object? earlyBird = freezed,
    Object? lastMinute = freezed,
  }) {
    return _then(
      _value.copyWith(
            seasons: null == seasons
                ? _value.seasons
                : seasons // ignore: cast_nullable_to_non_nullable
                      as List<SeasonRule>,
            holidays: null == holidays
                ? _value.holidays
                : holidays // ignore: cast_nullable_to_non_nullable
                      as List<HolidaySurcharge>,
            earlyBird: freezed == earlyBird
                ? _value.earlyBird
                : earlyBird // ignore: cast_nullable_to_non_nullable
                      as EarlyBirdDiscount?,
            lastMinute: freezed == lastMinute
                ? _value.lastMinute
                : lastMinute // ignore: cast_nullable_to_non_nullable
                      as LastMinuteDeal?,
          )
          as $Val,
    );
  }

  /// Create a copy of SeasonalPricing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EarlyBirdDiscountCopyWith<$Res>? get earlyBird {
    if (_value.earlyBird == null) {
      return null;
    }

    return $EarlyBirdDiscountCopyWith<$Res>(_value.earlyBird!, (value) {
      return _then(_value.copyWith(earlyBird: value) as $Val);
    });
  }

  /// Create a copy of SeasonalPricing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LastMinuteDealCopyWith<$Res>? get lastMinute {
    if (_value.lastMinute == null) {
      return null;
    }

    return $LastMinuteDealCopyWith<$Res>(_value.lastMinute!, (value) {
      return _then(_value.copyWith(lastMinute: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SeasonalPricingImplCopyWith<$Res>
    implements $SeasonalPricingCopyWith<$Res> {
  factory _$$SeasonalPricingImplCopyWith(
    _$SeasonalPricingImpl value,
    $Res Function(_$SeasonalPricingImpl) then,
  ) = __$$SeasonalPricingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<SeasonRule> seasons,
    List<HolidaySurcharge> holidays,
    @JsonKey(name: 'early_bird') EarlyBirdDiscount? earlyBird,
    @JsonKey(name: 'last_minute') LastMinuteDeal? lastMinute,
  });

  @override
  $EarlyBirdDiscountCopyWith<$Res>? get earlyBird;
  @override
  $LastMinuteDealCopyWith<$Res>? get lastMinute;
}

/// @nodoc
class __$$SeasonalPricingImplCopyWithImpl<$Res>
    extends _$SeasonalPricingCopyWithImpl<$Res, _$SeasonalPricingImpl>
    implements _$$SeasonalPricingImplCopyWith<$Res> {
  __$$SeasonalPricingImplCopyWithImpl(
    _$SeasonalPricingImpl _value,
    $Res Function(_$SeasonalPricingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SeasonalPricing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seasons = null,
    Object? holidays = null,
    Object? earlyBird = freezed,
    Object? lastMinute = freezed,
  }) {
    return _then(
      _$SeasonalPricingImpl(
        seasons: null == seasons
            ? _value._seasons
            : seasons // ignore: cast_nullable_to_non_nullable
                  as List<SeasonRule>,
        holidays: null == holidays
            ? _value._holidays
            : holidays // ignore: cast_nullable_to_non_nullable
                  as List<HolidaySurcharge>,
        earlyBird: freezed == earlyBird
            ? _value.earlyBird
            : earlyBird // ignore: cast_nullable_to_non_nullable
                  as EarlyBirdDiscount?,
        lastMinute: freezed == lastMinute
            ? _value.lastMinute
            : lastMinute // ignore: cast_nullable_to_non_nullable
                  as LastMinuteDeal?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SeasonalPricingImpl implements _SeasonalPricing {
  const _$SeasonalPricingImpl({
    final List<SeasonRule> seasons = const [],
    final List<HolidaySurcharge> holidays = const [],
    @JsonKey(name: 'early_bird') this.earlyBird,
    @JsonKey(name: 'last_minute') this.lastMinute,
  }) : _seasons = seasons,
       _holidays = holidays;

  factory _$SeasonalPricingImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeasonalPricingImplFromJson(json);

  final List<SeasonRule> _seasons;
  @override
  @JsonKey()
  List<SeasonRule> get seasons {
    if (_seasons is EqualUnmodifiableListView) return _seasons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_seasons);
  }

  final List<HolidaySurcharge> _holidays;
  @override
  @JsonKey()
  List<HolidaySurcharge> get holidays {
    if (_holidays is EqualUnmodifiableListView) return _holidays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_holidays);
  }

  @override
  @JsonKey(name: 'early_bird')
  final EarlyBirdDiscount? earlyBird;
  @override
  @JsonKey(name: 'last_minute')
  final LastMinuteDeal? lastMinute;

  @override
  String toString() {
    return 'SeasonalPricing(seasons: $seasons, holidays: $holidays, earlyBird: $earlyBird, lastMinute: $lastMinute)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeasonalPricingImpl &&
            const DeepCollectionEquality().equals(other._seasons, _seasons) &&
            const DeepCollectionEquality().equals(other._holidays, _holidays) &&
            (identical(other.earlyBird, earlyBird) ||
                other.earlyBird == earlyBird) &&
            (identical(other.lastMinute, lastMinute) ||
                other.lastMinute == lastMinute));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_seasons),
    const DeepCollectionEquality().hash(_holidays),
    earlyBird,
    lastMinute,
  );

  /// Create a copy of SeasonalPricing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeasonalPricingImplCopyWith<_$SeasonalPricingImpl> get copyWith =>
      __$$SeasonalPricingImplCopyWithImpl<_$SeasonalPricingImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SeasonalPricingImplToJson(this);
  }
}

abstract class _SeasonalPricing implements SeasonalPricing {
  const factory _SeasonalPricing({
    final List<SeasonRule> seasons,
    final List<HolidaySurcharge> holidays,
    @JsonKey(name: 'early_bird') final EarlyBirdDiscount? earlyBird,
    @JsonKey(name: 'last_minute') final LastMinuteDeal? lastMinute,
  }) = _$SeasonalPricingImpl;

  factory _SeasonalPricing.fromJson(Map<String, dynamic> json) =
      _$SeasonalPricingImpl.fromJson;

  @override
  List<SeasonRule> get seasons;
  @override
  List<HolidaySurcharge> get holidays;
  @override
  @JsonKey(name: 'early_bird')
  EarlyBirdDiscount? get earlyBird;
  @override
  @JsonKey(name: 'last_minute')
  LastMinuteDeal? get lastMinute;

  /// Create a copy of SeasonalPricing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeasonalPricingImplCopyWith<_$SeasonalPricingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
