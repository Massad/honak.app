// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'directory_manage_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DirectoryManageData _$DirectoryManageDataFromJson(Map<String, dynamic> json) {
  return _DirectoryManageData.fromJson(json);
}

/// @nodoc
mixin _$DirectoryManageData {
  List<Tenant> get tenants => throw _privateConstructorUsedError;
  List<DirectoryFloor> get floors => throw _privateConstructorUsedError;
  List<String> get categories => throw _privateConstructorUsedError;
  List<String> get amenities => throw _privateConstructorUsedError;
  @JsonKey(name: 'featured_tenant_ids')
  List<String> get featuredTenantIds => throw _privateConstructorUsedError;
  DirectoryManageStats? get stats => throw _privateConstructorUsedError;

  /// Serializes this DirectoryManageData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DirectoryManageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DirectoryManageDataCopyWith<DirectoryManageData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectoryManageDataCopyWith<$Res> {
  factory $DirectoryManageDataCopyWith(
    DirectoryManageData value,
    $Res Function(DirectoryManageData) then,
  ) = _$DirectoryManageDataCopyWithImpl<$Res, DirectoryManageData>;
  @useResult
  $Res call({
    List<Tenant> tenants,
    List<DirectoryFloor> floors,
    List<String> categories,
    List<String> amenities,
    @JsonKey(name: 'featured_tenant_ids') List<String> featuredTenantIds,
    DirectoryManageStats? stats,
  });

  $DirectoryManageStatsCopyWith<$Res>? get stats;
}

/// @nodoc
class _$DirectoryManageDataCopyWithImpl<$Res, $Val extends DirectoryManageData>
    implements $DirectoryManageDataCopyWith<$Res> {
  _$DirectoryManageDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DirectoryManageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tenants = null,
    Object? floors = null,
    Object? categories = null,
    Object? amenities = null,
    Object? featuredTenantIds = null,
    Object? stats = freezed,
  }) {
    return _then(
      _value.copyWith(
            tenants: null == tenants
                ? _value.tenants
                : tenants // ignore: cast_nullable_to_non_nullable
                      as List<Tenant>,
            floors: null == floors
                ? _value.floors
                : floors // ignore: cast_nullable_to_non_nullable
                      as List<DirectoryFloor>,
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            amenities: null == amenities
                ? _value.amenities
                : amenities // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            featuredTenantIds: null == featuredTenantIds
                ? _value.featuredTenantIds
                : featuredTenantIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            stats: freezed == stats
                ? _value.stats
                : stats // ignore: cast_nullable_to_non_nullable
                      as DirectoryManageStats?,
          )
          as $Val,
    );
  }

  /// Create a copy of DirectoryManageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DirectoryManageStatsCopyWith<$Res>? get stats {
    if (_value.stats == null) {
      return null;
    }

    return $DirectoryManageStatsCopyWith<$Res>(_value.stats!, (value) {
      return _then(_value.copyWith(stats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DirectoryManageDataImplCopyWith<$Res>
    implements $DirectoryManageDataCopyWith<$Res> {
  factory _$$DirectoryManageDataImplCopyWith(
    _$DirectoryManageDataImpl value,
    $Res Function(_$DirectoryManageDataImpl) then,
  ) = __$$DirectoryManageDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Tenant> tenants,
    List<DirectoryFloor> floors,
    List<String> categories,
    List<String> amenities,
    @JsonKey(name: 'featured_tenant_ids') List<String> featuredTenantIds,
    DirectoryManageStats? stats,
  });

  @override
  $DirectoryManageStatsCopyWith<$Res>? get stats;
}

/// @nodoc
class __$$DirectoryManageDataImplCopyWithImpl<$Res>
    extends _$DirectoryManageDataCopyWithImpl<$Res, _$DirectoryManageDataImpl>
    implements _$$DirectoryManageDataImplCopyWith<$Res> {
  __$$DirectoryManageDataImplCopyWithImpl(
    _$DirectoryManageDataImpl _value,
    $Res Function(_$DirectoryManageDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DirectoryManageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tenants = null,
    Object? floors = null,
    Object? categories = null,
    Object? amenities = null,
    Object? featuredTenantIds = null,
    Object? stats = freezed,
  }) {
    return _then(
      _$DirectoryManageDataImpl(
        tenants: null == tenants
            ? _value._tenants
            : tenants // ignore: cast_nullable_to_non_nullable
                  as List<Tenant>,
        floors: null == floors
            ? _value._floors
            : floors // ignore: cast_nullable_to_non_nullable
                  as List<DirectoryFloor>,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        amenities: null == amenities
            ? _value._amenities
            : amenities // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        featuredTenantIds: null == featuredTenantIds
            ? _value._featuredTenantIds
            : featuredTenantIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        stats: freezed == stats
            ? _value.stats
            : stats // ignore: cast_nullable_to_non_nullable
                  as DirectoryManageStats?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DirectoryManageDataImpl implements _DirectoryManageData {
  const _$DirectoryManageDataImpl({
    final List<Tenant> tenants = const [],
    final List<DirectoryFloor> floors = const [],
    final List<String> categories = const [],
    final List<String> amenities = const [],
    @JsonKey(name: 'featured_tenant_ids')
    final List<String> featuredTenantIds = const [],
    this.stats,
  }) : _tenants = tenants,
       _floors = floors,
       _categories = categories,
       _amenities = amenities,
       _featuredTenantIds = featuredTenantIds;

  factory _$DirectoryManageDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$DirectoryManageDataImplFromJson(json);

  final List<Tenant> _tenants;
  @override
  @JsonKey()
  List<Tenant> get tenants {
    if (_tenants is EqualUnmodifiableListView) return _tenants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tenants);
  }

  final List<DirectoryFloor> _floors;
  @override
  @JsonKey()
  List<DirectoryFloor> get floors {
    if (_floors is EqualUnmodifiableListView) return _floors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_floors);
  }

  final List<String> _categories;
  @override
  @JsonKey()
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<String> _amenities;
  @override
  @JsonKey()
  List<String> get amenities {
    if (_amenities is EqualUnmodifiableListView) return _amenities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_amenities);
  }

  final List<String> _featuredTenantIds;
  @override
  @JsonKey(name: 'featured_tenant_ids')
  List<String> get featuredTenantIds {
    if (_featuredTenantIds is EqualUnmodifiableListView)
      return _featuredTenantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_featuredTenantIds);
  }

  @override
  final DirectoryManageStats? stats;

  @override
  String toString() {
    return 'DirectoryManageData(tenants: $tenants, floors: $floors, categories: $categories, amenities: $amenities, featuredTenantIds: $featuredTenantIds, stats: $stats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DirectoryManageDataImpl &&
            const DeepCollectionEquality().equals(other._tenants, _tenants) &&
            const DeepCollectionEquality().equals(other._floors, _floors) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            const DeepCollectionEquality().equals(
              other._amenities,
              _amenities,
            ) &&
            const DeepCollectionEquality().equals(
              other._featuredTenantIds,
              _featuredTenantIds,
            ) &&
            (identical(other.stats, stats) || other.stats == stats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_tenants),
    const DeepCollectionEquality().hash(_floors),
    const DeepCollectionEquality().hash(_categories),
    const DeepCollectionEquality().hash(_amenities),
    const DeepCollectionEquality().hash(_featuredTenantIds),
    stats,
  );

  /// Create a copy of DirectoryManageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DirectoryManageDataImplCopyWith<_$DirectoryManageDataImpl> get copyWith =>
      __$$DirectoryManageDataImplCopyWithImpl<_$DirectoryManageDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DirectoryManageDataImplToJson(this);
  }
}

abstract class _DirectoryManageData implements DirectoryManageData {
  const factory _DirectoryManageData({
    final List<Tenant> tenants,
    final List<DirectoryFloor> floors,
    final List<String> categories,
    final List<String> amenities,
    @JsonKey(name: 'featured_tenant_ids') final List<String> featuredTenantIds,
    final DirectoryManageStats? stats,
  }) = _$DirectoryManageDataImpl;

  factory _DirectoryManageData.fromJson(Map<String, dynamic> json) =
      _$DirectoryManageDataImpl.fromJson;

  @override
  List<Tenant> get tenants;
  @override
  List<DirectoryFloor> get floors;
  @override
  List<String> get categories;
  @override
  List<String> get amenities;
  @override
  @JsonKey(name: 'featured_tenant_ids')
  List<String> get featuredTenantIds;
  @override
  DirectoryManageStats? get stats;

  /// Create a copy of DirectoryManageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DirectoryManageDataImplCopyWith<_$DirectoryManageDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
