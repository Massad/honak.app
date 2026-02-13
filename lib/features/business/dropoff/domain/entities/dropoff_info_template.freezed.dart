// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dropoff_info_template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DropoffInfoTemplate _$DropoffInfoTemplateFromJson(Map<String, dynamic> json) {
  return _DropoffInfoTemplate.fromJson(json);
}

/// @nodoc
mixin _$DropoffInfoTemplate {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'label_ar')
  String get labelAr => throw _privateConstructorUsedError;
  List<DropoffInfoTemplateItem> get items => throw _privateConstructorUsedError;

  /// Serializes this DropoffInfoTemplate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DropoffInfoTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DropoffInfoTemplateCopyWith<DropoffInfoTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DropoffInfoTemplateCopyWith<$Res> {
  factory $DropoffInfoTemplateCopyWith(
    DropoffInfoTemplate value,
    $Res Function(DropoffInfoTemplate) then,
  ) = _$DropoffInfoTemplateCopyWithImpl<$Res, DropoffInfoTemplate>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'label_ar') String labelAr,
    List<DropoffInfoTemplateItem> items,
  });
}

/// @nodoc
class _$DropoffInfoTemplateCopyWithImpl<$Res, $Val extends DropoffInfoTemplate>
    implements $DropoffInfoTemplateCopyWith<$Res> {
  _$DropoffInfoTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DropoffInfoTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? labelAr = null, Object? items = null}) {
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
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<DropoffInfoTemplateItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DropoffInfoTemplateImplCopyWith<$Res>
    implements $DropoffInfoTemplateCopyWith<$Res> {
  factory _$$DropoffInfoTemplateImplCopyWith(
    _$DropoffInfoTemplateImpl value,
    $Res Function(_$DropoffInfoTemplateImpl) then,
  ) = __$$DropoffInfoTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'label_ar') String labelAr,
    List<DropoffInfoTemplateItem> items,
  });
}

/// @nodoc
class __$$DropoffInfoTemplateImplCopyWithImpl<$Res>
    extends _$DropoffInfoTemplateCopyWithImpl<$Res, _$DropoffInfoTemplateImpl>
    implements _$$DropoffInfoTemplateImplCopyWith<$Res> {
  __$$DropoffInfoTemplateImplCopyWithImpl(
    _$DropoffInfoTemplateImpl _value,
    $Res Function(_$DropoffInfoTemplateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DropoffInfoTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? labelAr = null, Object? items = null}) {
    return _then(
      _$DropoffInfoTemplateImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        labelAr: null == labelAr
            ? _value.labelAr
            : labelAr // ignore: cast_nullable_to_non_nullable
                  as String,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<DropoffInfoTemplateItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DropoffInfoTemplateImpl implements _DropoffInfoTemplate {
  const _$DropoffInfoTemplateImpl({
    required this.id,
    @JsonKey(name: 'label_ar') required this.labelAr,
    required final List<DropoffInfoTemplateItem> items,
  }) : _items = items;

  factory _$DropoffInfoTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$DropoffInfoTemplateImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'label_ar')
  final String labelAr;
  final List<DropoffInfoTemplateItem> _items;
  @override
  List<DropoffInfoTemplateItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'DropoffInfoTemplate(id: $id, labelAr: $labelAr, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DropoffInfoTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.labelAr, labelAr) || other.labelAr == labelAr) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    labelAr,
    const DeepCollectionEquality().hash(_items),
  );

  /// Create a copy of DropoffInfoTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DropoffInfoTemplateImplCopyWith<_$DropoffInfoTemplateImpl> get copyWith =>
      __$$DropoffInfoTemplateImplCopyWithImpl<_$DropoffInfoTemplateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DropoffInfoTemplateImplToJson(this);
  }
}

abstract class _DropoffInfoTemplate implements DropoffInfoTemplate {
  const factory _DropoffInfoTemplate({
    required final String id,
    @JsonKey(name: 'label_ar') required final String labelAr,
    required final List<DropoffInfoTemplateItem> items,
  }) = _$DropoffInfoTemplateImpl;

  factory _DropoffInfoTemplate.fromJson(Map<String, dynamic> json) =
      _$DropoffInfoTemplateImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'label_ar')
  String get labelAr;
  @override
  List<DropoffInfoTemplateItem> get items;

  /// Create a copy of DropoffInfoTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DropoffInfoTemplateImplCopyWith<_$DropoffInfoTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DropoffInfoTemplateItem _$DropoffInfoTemplateItemFromJson(
  Map<String, dynamic> json,
) {
  return _DropoffInfoTemplateItem.fromJson(json);
}

/// @nodoc
mixin _$DropoffInfoTemplateItem {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'label_ar')
  String get labelAr => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Serializes this DropoffInfoTemplateItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DropoffInfoTemplateItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DropoffInfoTemplateItemCopyWith<DropoffInfoTemplateItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DropoffInfoTemplateItemCopyWith<$Res> {
  factory $DropoffInfoTemplateItemCopyWith(
    DropoffInfoTemplateItem value,
    $Res Function(DropoffInfoTemplateItem) then,
  ) = _$DropoffInfoTemplateItemCopyWithImpl<$Res, DropoffInfoTemplateItem>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'label_ar') String labelAr,
    String type,
  });
}

/// @nodoc
class _$DropoffInfoTemplateItemCopyWithImpl<
  $Res,
  $Val extends DropoffInfoTemplateItem
>
    implements $DropoffInfoTemplateItemCopyWith<$Res> {
  _$DropoffInfoTemplateItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DropoffInfoTemplateItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? labelAr = null, Object? type = null}) {
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
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DropoffInfoTemplateItemImplCopyWith<$Res>
    implements $DropoffInfoTemplateItemCopyWith<$Res> {
  factory _$$DropoffInfoTemplateItemImplCopyWith(
    _$DropoffInfoTemplateItemImpl value,
    $Res Function(_$DropoffInfoTemplateItemImpl) then,
  ) = __$$DropoffInfoTemplateItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'label_ar') String labelAr,
    String type,
  });
}

/// @nodoc
class __$$DropoffInfoTemplateItemImplCopyWithImpl<$Res>
    extends
        _$DropoffInfoTemplateItemCopyWithImpl<
          $Res,
          _$DropoffInfoTemplateItemImpl
        >
    implements _$$DropoffInfoTemplateItemImplCopyWith<$Res> {
  __$$DropoffInfoTemplateItemImplCopyWithImpl(
    _$DropoffInfoTemplateItemImpl _value,
    $Res Function(_$DropoffInfoTemplateItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DropoffInfoTemplateItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? labelAr = null, Object? type = null}) {
    return _then(
      _$DropoffInfoTemplateItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        labelAr: null == labelAr
            ? _value.labelAr
            : labelAr // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DropoffInfoTemplateItemImpl implements _DropoffInfoTemplateItem {
  const _$DropoffInfoTemplateItemImpl({
    required this.id,
    @JsonKey(name: 'label_ar') required this.labelAr,
    required this.type,
  });

  factory _$DropoffInfoTemplateItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$DropoffInfoTemplateItemImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'label_ar')
  final String labelAr;
  @override
  final String type;

  @override
  String toString() {
    return 'DropoffInfoTemplateItem(id: $id, labelAr: $labelAr, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DropoffInfoTemplateItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.labelAr, labelAr) || other.labelAr == labelAr) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, labelAr, type);

  /// Create a copy of DropoffInfoTemplateItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DropoffInfoTemplateItemImplCopyWith<_$DropoffInfoTemplateItemImpl>
  get copyWith =>
      __$$DropoffInfoTemplateItemImplCopyWithImpl<
        _$DropoffInfoTemplateItemImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DropoffInfoTemplateItemImplToJson(this);
  }
}

abstract class _DropoffInfoTemplateItem implements DropoffInfoTemplateItem {
  const factory _DropoffInfoTemplateItem({
    required final String id,
    @JsonKey(name: 'label_ar') required final String labelAr,
    required final String type,
  }) = _$DropoffInfoTemplateItemImpl;

  factory _DropoffInfoTemplateItem.fromJson(Map<String, dynamic> json) =
      _$DropoffInfoTemplateItemImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'label_ar')
  String get labelAr;
  @override
  String get type;

  /// Create a copy of DropoffInfoTemplateItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DropoffInfoTemplateItemImplCopyWith<_$DropoffInfoTemplateItemImpl>
  get copyWith => throw _privateConstructorUsedError;
}
