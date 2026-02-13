// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dropoff_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DropoffServiceCategory _$DropoffServiceCategoryFromJson(
  Map<String, dynamic> json,
) {
  return _DropoffServiceCategory.fromJson(json);
}

/// @nodoc
mixin _$DropoffServiceCategory {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_ar')
  String get nameAr => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  List<DropoffService> get services => throw _privateConstructorUsedError;

  /// Serializes this DropoffServiceCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DropoffServiceCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DropoffServiceCategoryCopyWith<DropoffServiceCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DropoffServiceCategoryCopyWith<$Res> {
  factory $DropoffServiceCategoryCopyWith(
    DropoffServiceCategory value,
    $Res Function(DropoffServiceCategory) then,
  ) = _$DropoffServiceCategoryCopyWithImpl<$Res, DropoffServiceCategory>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'name_ar') String nameAr,
    String icon,
    List<DropoffService> services,
  });
}

/// @nodoc
class _$DropoffServiceCategoryCopyWithImpl<
  $Res,
  $Val extends DropoffServiceCategory
>
    implements $DropoffServiceCategoryCopyWith<$Res> {
  _$DropoffServiceCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DropoffServiceCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nameAr = null,
    Object? icon = null,
    Object? services = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            nameAr: null == nameAr
                ? _value.nameAr
                : nameAr // ignore: cast_nullable_to_non_nullable
                      as String,
            icon: null == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String,
            services: null == services
                ? _value.services
                : services // ignore: cast_nullable_to_non_nullable
                      as List<DropoffService>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DropoffServiceCategoryImplCopyWith<$Res>
    implements $DropoffServiceCategoryCopyWith<$Res> {
  factory _$$DropoffServiceCategoryImplCopyWith(
    _$DropoffServiceCategoryImpl value,
    $Res Function(_$DropoffServiceCategoryImpl) then,
  ) = __$$DropoffServiceCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'name_ar') String nameAr,
    String icon,
    List<DropoffService> services,
  });
}

/// @nodoc
class __$$DropoffServiceCategoryImplCopyWithImpl<$Res>
    extends
        _$DropoffServiceCategoryCopyWithImpl<$Res, _$DropoffServiceCategoryImpl>
    implements _$$DropoffServiceCategoryImplCopyWith<$Res> {
  __$$DropoffServiceCategoryImplCopyWithImpl(
    _$DropoffServiceCategoryImpl _value,
    $Res Function(_$DropoffServiceCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DropoffServiceCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nameAr = null,
    Object? icon = null,
    Object? services = null,
  }) {
    return _then(
      _$DropoffServiceCategoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        nameAr: null == nameAr
            ? _value.nameAr
            : nameAr // ignore: cast_nullable_to_non_nullable
                  as String,
        icon: null == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String,
        services: null == services
            ? _value._services
            : services // ignore: cast_nullable_to_non_nullable
                  as List<DropoffService>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DropoffServiceCategoryImpl implements _DropoffServiceCategory {
  const _$DropoffServiceCategoryImpl({
    required this.id,
    @JsonKey(name: 'name_ar') required this.nameAr,
    required this.icon,
    required final List<DropoffService> services,
  }) : _services = services;

  factory _$DropoffServiceCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DropoffServiceCategoryImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'name_ar')
  final String nameAr;
  @override
  final String icon;
  final List<DropoffService> _services;
  @override
  List<DropoffService> get services {
    if (_services is EqualUnmodifiableListView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_services);
  }

  @override
  String toString() {
    return 'DropoffServiceCategory(id: $id, nameAr: $nameAr, icon: $icon, services: $services)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DropoffServiceCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            const DeepCollectionEquality().equals(other._services, _services));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    nameAr,
    icon,
    const DeepCollectionEquality().hash(_services),
  );

  /// Create a copy of DropoffServiceCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DropoffServiceCategoryImplCopyWith<_$DropoffServiceCategoryImpl>
  get copyWith =>
      __$$DropoffServiceCategoryImplCopyWithImpl<_$DropoffServiceCategoryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DropoffServiceCategoryImplToJson(this);
  }
}

abstract class _DropoffServiceCategory implements DropoffServiceCategory {
  const factory _DropoffServiceCategory({
    required final String id,
    @JsonKey(name: 'name_ar') required final String nameAr,
    required final String icon,
    required final List<DropoffService> services,
  }) = _$DropoffServiceCategoryImpl;

  factory _DropoffServiceCategory.fromJson(Map<String, dynamic> json) =
      _$DropoffServiceCategoryImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'name_ar')
  String get nameAr;
  @override
  String get icon;
  @override
  List<DropoffService> get services;

  /// Create a copy of DropoffServiceCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DropoffServiceCategoryImplCopyWith<_$DropoffServiceCategoryImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DropoffService _$DropoffServiceFromJson(Map<String, dynamic> json) {
  return _DropoffService.fromJson(json);
}

/// @nodoc
mixin _$DropoffService {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_ar')
  String get nameAr => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_cents')
  int get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_days')
  int get durationDays => throw _privateConstructorUsedError;

  /// Serializes this DropoffService to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DropoffService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DropoffServiceCopyWith<DropoffService> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DropoffServiceCopyWith<$Res> {
  factory $DropoffServiceCopyWith(
    DropoffService value,
    $Res Function(DropoffService) then,
  ) = _$DropoffServiceCopyWithImpl<$Res, DropoffService>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'name_ar') String nameAr,
    @JsonKey(name: 'price_cents') int price,
    @JsonKey(name: 'duration_days') int durationDays,
  });
}

/// @nodoc
class _$DropoffServiceCopyWithImpl<$Res, $Val extends DropoffService>
    implements $DropoffServiceCopyWith<$Res> {
  _$DropoffServiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DropoffService
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nameAr = null,
    Object? price = null,
    Object? durationDays = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            nameAr: null == nameAr
                ? _value.nameAr
                : nameAr // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int,
            durationDays: null == durationDays
                ? _value.durationDays
                : durationDays // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DropoffServiceImplCopyWith<$Res>
    implements $DropoffServiceCopyWith<$Res> {
  factory _$$DropoffServiceImplCopyWith(
    _$DropoffServiceImpl value,
    $Res Function(_$DropoffServiceImpl) then,
  ) = __$$DropoffServiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'name_ar') String nameAr,
    @JsonKey(name: 'price_cents') int price,
    @JsonKey(name: 'duration_days') int durationDays,
  });
}

/// @nodoc
class __$$DropoffServiceImplCopyWithImpl<$Res>
    extends _$DropoffServiceCopyWithImpl<$Res, _$DropoffServiceImpl>
    implements _$$DropoffServiceImplCopyWith<$Res> {
  __$$DropoffServiceImplCopyWithImpl(
    _$DropoffServiceImpl _value,
    $Res Function(_$DropoffServiceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DropoffService
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nameAr = null,
    Object? price = null,
    Object? durationDays = null,
  }) {
    return _then(
      _$DropoffServiceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        nameAr: null == nameAr
            ? _value.nameAr
            : nameAr // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int,
        durationDays: null == durationDays
            ? _value.durationDays
            : durationDays // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DropoffServiceImpl implements _DropoffService {
  const _$DropoffServiceImpl({
    required this.id,
    @JsonKey(name: 'name_ar') required this.nameAr,
    @JsonKey(name: 'price_cents') required this.price,
    @JsonKey(name: 'duration_days') required this.durationDays,
  });

  factory _$DropoffServiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$DropoffServiceImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'name_ar')
  final String nameAr;
  @override
  @JsonKey(name: 'price_cents')
  final int price;
  @override
  @JsonKey(name: 'duration_days')
  final int durationDays;

  @override
  String toString() {
    return 'DropoffService(id: $id, nameAr: $nameAr, price: $price, durationDays: $durationDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DropoffServiceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.durationDays, durationDays) ||
                other.durationDays == durationDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, nameAr, price, durationDays);

  /// Create a copy of DropoffService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DropoffServiceImplCopyWith<_$DropoffServiceImpl> get copyWith =>
      __$$DropoffServiceImplCopyWithImpl<_$DropoffServiceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DropoffServiceImplToJson(this);
  }
}

abstract class _DropoffService implements DropoffService {
  const factory _DropoffService({
    required final String id,
    @JsonKey(name: 'name_ar') required final String nameAr,
    @JsonKey(name: 'price_cents') required final int price,
    @JsonKey(name: 'duration_days') required final int durationDays,
  }) = _$DropoffServiceImpl;

  factory _DropoffService.fromJson(Map<String, dynamic> json) =
      _$DropoffServiceImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'name_ar')
  String get nameAr;
  @override
  @JsonKey(name: 'price_cents')
  int get price;
  @override
  @JsonKey(name: 'duration_days')
  int get durationDays;

  /// Create a copy of DropoffService
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DropoffServiceImplCopyWith<_$DropoffServiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DropoffAttribute _$DropoffAttributeFromJson(Map<String, dynamic> json) {
  return _DropoffAttribute.fromJson(json);
}

/// @nodoc
mixin _$DropoffAttribute {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'label_ar')
  String get labelAr => throw _privateConstructorUsedError;
  List<String> get values => throw _privateConstructorUsedError;
  bool get optional => throw _privateConstructorUsedError;

  /// Serializes this DropoffAttribute to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DropoffAttribute
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DropoffAttributeCopyWith<DropoffAttribute> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DropoffAttributeCopyWith<$Res> {
  factory $DropoffAttributeCopyWith(
    DropoffAttribute value,
    $Res Function(DropoffAttribute) then,
  ) = _$DropoffAttributeCopyWithImpl<$Res, DropoffAttribute>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'label_ar') String labelAr,
    List<String> values,
    bool optional,
  });
}

/// @nodoc
class _$DropoffAttributeCopyWithImpl<$Res, $Val extends DropoffAttribute>
    implements $DropoffAttributeCopyWith<$Res> {
  _$DropoffAttributeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DropoffAttribute
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? labelAr = null,
    Object? values = null,
    Object? optional = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            labelAr: null == labelAr
                ? _value.labelAr
                : labelAr // ignore: cast_nullable_to_non_nullable
                      as String,
            values: null == values
                ? _value.values
                : values // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            optional: null == optional
                ? _value.optional
                : optional // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DropoffAttributeImplCopyWith<$Res>
    implements $DropoffAttributeCopyWith<$Res> {
  factory _$$DropoffAttributeImplCopyWith(
    _$DropoffAttributeImpl value,
    $Res Function(_$DropoffAttributeImpl) then,
  ) = __$$DropoffAttributeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'label_ar') String labelAr,
    List<String> values,
    bool optional,
  });
}

/// @nodoc
class __$$DropoffAttributeImplCopyWithImpl<$Res>
    extends _$DropoffAttributeCopyWithImpl<$Res, _$DropoffAttributeImpl>
    implements _$$DropoffAttributeImplCopyWith<$Res> {
  __$$DropoffAttributeImplCopyWithImpl(
    _$DropoffAttributeImpl _value,
    $Res Function(_$DropoffAttributeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DropoffAttribute
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? labelAr = null,
    Object? values = null,
    Object? optional = null,
  }) {
    return _then(
      _$DropoffAttributeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        labelAr: null == labelAr
            ? _value.labelAr
            : labelAr // ignore: cast_nullable_to_non_nullable
                  as String,
        values: null == values
            ? _value._values
            : values // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        optional: null == optional
            ? _value.optional
            : optional // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DropoffAttributeImpl implements _DropoffAttribute {
  const _$DropoffAttributeImpl({
    required this.id,
    @JsonKey(name: 'label_ar') required this.labelAr,
    required final List<String> values,
    this.optional = true,
  }) : _values = values;

  factory _$DropoffAttributeImpl.fromJson(Map<String, dynamic> json) =>
      _$$DropoffAttributeImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'label_ar')
  final String labelAr;
  final List<String> _values;
  @override
  List<String> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  @JsonKey()
  final bool optional;

  @override
  String toString() {
    return 'DropoffAttribute(id: $id, labelAr: $labelAr, values: $values, optional: $optional)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DropoffAttributeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.labelAr, labelAr) || other.labelAr == labelAr) &&
            const DeepCollectionEquality().equals(other._values, _values) &&
            (identical(other.optional, optional) ||
                other.optional == optional));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    labelAr,
    const DeepCollectionEquality().hash(_values),
    optional,
  );

  /// Create a copy of DropoffAttribute
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DropoffAttributeImplCopyWith<_$DropoffAttributeImpl> get copyWith =>
      __$$DropoffAttributeImplCopyWithImpl<_$DropoffAttributeImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DropoffAttributeImplToJson(this);
  }
}

abstract class _DropoffAttribute implements DropoffAttribute {
  const factory _DropoffAttribute({
    required final String id,
    @JsonKey(name: 'label_ar') required final String labelAr,
    required final List<String> values,
    final bool optional,
  }) = _$DropoffAttributeImpl;

  factory _DropoffAttribute.fromJson(Map<String, dynamic> json) =
      _$DropoffAttributeImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'label_ar')
  String get labelAr;
  @override
  List<String> get values;
  @override
  bool get optional;

  /// Create a copy of DropoffAttribute
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DropoffAttributeImplCopyWith<_$DropoffAttributeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
