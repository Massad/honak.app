// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selected_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SelectedItem _$SelectedItemFromJson(Map<String, dynamic> json) {
  return _SelectedItem.fromJson(json);
}

/// @nodoc
mixin _$SelectedItem {
  String get itemId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  int get basePriceCents => throw _privateConstructorUsedError;
  Map<String, List<SelectedOption>> get selectedOptions =>
      throw _privateConstructorUsedError;
  Map<String, String> get textInputs => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String? get categoryName => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this SelectedItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SelectedItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelectedItemCopyWith<SelectedItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectedItemCopyWith<$Res> {
  factory $SelectedItemCopyWith(
    SelectedItem value,
    $Res Function(SelectedItem) then,
  ) = _$SelectedItemCopyWithImpl<$Res, SelectedItem>;
  @useResult
  $Res call({
    String itemId,
    String name,
    String? image,
    int basePriceCents,
    Map<String, List<SelectedOption>> selectedOptions,
    Map<String, String> textInputs,
    int quantity,
    String? categoryName,
    String? description,
  });
}

/// @nodoc
class _$SelectedItemCopyWithImpl<$Res, $Val extends SelectedItem>
    implements $SelectedItemCopyWith<$Res> {
  _$SelectedItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectedItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? name = null,
    Object? image = freezed,
    Object? basePriceCents = null,
    Object? selectedOptions = null,
    Object? textInputs = null,
    Object? quantity = null,
    Object? categoryName = freezed,
    Object? description = freezed,
  }) {
    return _then(
      _value.copyWith(
            itemId: null == itemId
                ? _value.itemId
                : itemId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            image: freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String?,
            basePriceCents: null == basePriceCents
                ? _value.basePriceCents
                : basePriceCents // ignore: cast_nullable_to_non_nullable
                      as int,
            selectedOptions: null == selectedOptions
                ? _value.selectedOptions
                : selectedOptions // ignore: cast_nullable_to_non_nullable
                      as Map<String, List<SelectedOption>>,
            textInputs: null == textInputs
                ? _value.textInputs
                : textInputs // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            categoryName: freezed == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SelectedItemImplCopyWith<$Res>
    implements $SelectedItemCopyWith<$Res> {
  factory _$$SelectedItemImplCopyWith(
    _$SelectedItemImpl value,
    $Res Function(_$SelectedItemImpl) then,
  ) = __$$SelectedItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String itemId,
    String name,
    String? image,
    int basePriceCents,
    Map<String, List<SelectedOption>> selectedOptions,
    Map<String, String> textInputs,
    int quantity,
    String? categoryName,
    String? description,
  });
}

/// @nodoc
class __$$SelectedItemImplCopyWithImpl<$Res>
    extends _$SelectedItemCopyWithImpl<$Res, _$SelectedItemImpl>
    implements _$$SelectedItemImplCopyWith<$Res> {
  __$$SelectedItemImplCopyWithImpl(
    _$SelectedItemImpl _value,
    $Res Function(_$SelectedItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SelectedItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? name = null,
    Object? image = freezed,
    Object? basePriceCents = null,
    Object? selectedOptions = null,
    Object? textInputs = null,
    Object? quantity = null,
    Object? categoryName = freezed,
    Object? description = freezed,
  }) {
    return _then(
      _$SelectedItemImpl(
        itemId: null == itemId
            ? _value.itemId
            : itemId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        image: freezed == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String?,
        basePriceCents: null == basePriceCents
            ? _value.basePriceCents
            : basePriceCents // ignore: cast_nullable_to_non_nullable
                  as int,
        selectedOptions: null == selectedOptions
            ? _value._selectedOptions
            : selectedOptions // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<SelectedOption>>,
        textInputs: null == textInputs
            ? _value._textInputs
            : textInputs // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        categoryName: freezed == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SelectedItemImpl extends _SelectedItem {
  const _$SelectedItemImpl({
    required this.itemId,
    required this.name,
    this.image,
    required this.basePriceCents,
    final Map<String, List<SelectedOption>> selectedOptions = const {},
    final Map<String, String> textInputs = const {},
    this.quantity = 1,
    this.categoryName,
    this.description,
  }) : _selectedOptions = selectedOptions,
       _textInputs = textInputs,
       super._();

  factory _$SelectedItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$SelectedItemImplFromJson(json);

  @override
  final String itemId;
  @override
  final String name;
  @override
  final String? image;
  @override
  final int basePriceCents;
  final Map<String, List<SelectedOption>> _selectedOptions;
  @override
  @JsonKey()
  Map<String, List<SelectedOption>> get selectedOptions {
    if (_selectedOptions is EqualUnmodifiableMapView) return _selectedOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_selectedOptions);
  }

  final Map<String, String> _textInputs;
  @override
  @JsonKey()
  Map<String, String> get textInputs {
    if (_textInputs is EqualUnmodifiableMapView) return _textInputs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_textInputs);
  }

  @override
  @JsonKey()
  final int quantity;
  @override
  final String? categoryName;
  @override
  final String? description;

  @override
  String toString() {
    return 'SelectedItem(itemId: $itemId, name: $name, image: $image, basePriceCents: $basePriceCents, selectedOptions: $selectedOptions, textInputs: $textInputs, quantity: $quantity, categoryName: $categoryName, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectedItemImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.basePriceCents, basePriceCents) ||
                other.basePriceCents == basePriceCents) &&
            const DeepCollectionEquality().equals(
              other._selectedOptions,
              _selectedOptions,
            ) &&
            const DeepCollectionEquality().equals(
              other._textInputs,
              _textInputs,
            ) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    itemId,
    name,
    image,
    basePriceCents,
    const DeepCollectionEquality().hash(_selectedOptions),
    const DeepCollectionEquality().hash(_textInputs),
    quantity,
    categoryName,
    description,
  );

  /// Create a copy of SelectedItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectedItemImplCopyWith<_$SelectedItemImpl> get copyWith =>
      __$$SelectedItemImplCopyWithImpl<_$SelectedItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SelectedItemImplToJson(this);
  }
}

abstract class _SelectedItem extends SelectedItem {
  const factory _SelectedItem({
    required final String itemId,
    required final String name,
    final String? image,
    required final int basePriceCents,
    final Map<String, List<SelectedOption>> selectedOptions,
    final Map<String, String> textInputs,
    final int quantity,
    final String? categoryName,
    final String? description,
  }) = _$SelectedItemImpl;
  const _SelectedItem._() : super._();

  factory _SelectedItem.fromJson(Map<String, dynamic> json) =
      _$SelectedItemImpl.fromJson;

  @override
  String get itemId;
  @override
  String get name;
  @override
  String? get image;
  @override
  int get basePriceCents;
  @override
  Map<String, List<SelectedOption>> get selectedOptions;
  @override
  Map<String, String> get textInputs;
  @override
  int get quantity;
  @override
  String? get categoryName;
  @override
  String? get description;

  /// Create a copy of SelectedItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectedItemImplCopyWith<_$SelectedItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SelectedOption _$SelectedOptionFromJson(Map<String, dynamic> json) {
  return _SelectedOption.fromJson(json);
}

/// @nodoc
mixin _$SelectedOption {
  String get id => throw _privateConstructorUsedError;
  String get labelAr => throw _privateConstructorUsedError;
  int get priceModifierCents => throw _privateConstructorUsedError;
  String? get colorHex => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this SelectedOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SelectedOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelectedOptionCopyWith<SelectedOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectedOptionCopyWith<$Res> {
  factory $SelectedOptionCopyWith(
    SelectedOption value,
    $Res Function(SelectedOption) then,
  ) = _$SelectedOptionCopyWithImpl<$Res, SelectedOption>;
  @useResult
  $Res call({
    String id,
    String labelAr,
    int priceModifierCents,
    String? colorHex,
    String? imageUrl,
  });
}

/// @nodoc
class _$SelectedOptionCopyWithImpl<$Res, $Val extends SelectedOption>
    implements $SelectedOptionCopyWith<$Res> {
  _$SelectedOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectedOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? labelAr = null,
    Object? priceModifierCents = null,
    Object? colorHex = freezed,
    Object? imageUrl = freezed,
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
            priceModifierCents: null == priceModifierCents
                ? _value.priceModifierCents
                : priceModifierCents // ignore: cast_nullable_to_non_nullable
                      as int,
            colorHex: freezed == colorHex
                ? _value.colorHex
                : colorHex // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SelectedOptionImplCopyWith<$Res>
    implements $SelectedOptionCopyWith<$Res> {
  factory _$$SelectedOptionImplCopyWith(
    _$SelectedOptionImpl value,
    $Res Function(_$SelectedOptionImpl) then,
  ) = __$$SelectedOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String labelAr,
    int priceModifierCents,
    String? colorHex,
    String? imageUrl,
  });
}

/// @nodoc
class __$$SelectedOptionImplCopyWithImpl<$Res>
    extends _$SelectedOptionCopyWithImpl<$Res, _$SelectedOptionImpl>
    implements _$$SelectedOptionImplCopyWith<$Res> {
  __$$SelectedOptionImplCopyWithImpl(
    _$SelectedOptionImpl _value,
    $Res Function(_$SelectedOptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SelectedOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? labelAr = null,
    Object? priceModifierCents = null,
    Object? colorHex = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$SelectedOptionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        labelAr: null == labelAr
            ? _value.labelAr
            : labelAr // ignore: cast_nullable_to_non_nullable
                  as String,
        priceModifierCents: null == priceModifierCents
            ? _value.priceModifierCents
            : priceModifierCents // ignore: cast_nullable_to_non_nullable
                  as int,
        colorHex: freezed == colorHex
            ? _value.colorHex
            : colorHex // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SelectedOptionImpl implements _SelectedOption {
  const _$SelectedOptionImpl({
    required this.id,
    required this.labelAr,
    this.priceModifierCents = 0,
    this.colorHex,
    this.imageUrl,
  });

  factory _$SelectedOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SelectedOptionImplFromJson(json);

  @override
  final String id;
  @override
  final String labelAr;
  @override
  @JsonKey()
  final int priceModifierCents;
  @override
  final String? colorHex;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'SelectedOption(id: $id, labelAr: $labelAr, priceModifierCents: $priceModifierCents, colorHex: $colorHex, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectedOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.labelAr, labelAr) || other.labelAr == labelAr) &&
            (identical(other.priceModifierCents, priceModifierCents) ||
                other.priceModifierCents == priceModifierCents) &&
            (identical(other.colorHex, colorHex) ||
                other.colorHex == colorHex) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    labelAr,
    priceModifierCents,
    colorHex,
    imageUrl,
  );

  /// Create a copy of SelectedOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectedOptionImplCopyWith<_$SelectedOptionImpl> get copyWith =>
      __$$SelectedOptionImplCopyWithImpl<_$SelectedOptionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SelectedOptionImplToJson(this);
  }
}

abstract class _SelectedOption implements SelectedOption {
  const factory _SelectedOption({
    required final String id,
    required final String labelAr,
    final int priceModifierCents,
    final String? colorHex,
    final String? imageUrl,
  }) = _$SelectedOptionImpl;

  factory _SelectedOption.fromJson(Map<String, dynamic> json) =
      _$SelectedOptionImpl.fromJson;

  @override
  String get id;
  @override
  String get labelAr;
  @override
  int get priceModifierCents;
  @override
  String? get colorHex;
  @override
  String? get imageUrl;

  /// Create a copy of SelectedOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectedOptionImplCopyWith<_$SelectedOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
