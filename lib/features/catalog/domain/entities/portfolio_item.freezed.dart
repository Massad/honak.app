// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portfolio_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PortfolioItem _$PortfolioItemFromJson(Map<String, dynamic> json) {
  return _PortfolioItem.fromJson(json);
}

/// @nodoc
mixin _$PortfolioItem {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'title_en')
  String? get titleEn => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'description_en')
  String? get descriptionEn => throw _privateConstructorUsedError;
  List<Media> get images => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_ar')
  String? get categoryAr => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_id')
  String? get pageId => throw _privateConstructorUsedError;

  /// Serializes this PortfolioItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PortfolioItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PortfolioItemCopyWith<PortfolioItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PortfolioItemCopyWith<$Res> {
  factory $PortfolioItemCopyWith(
    PortfolioItem value,
    $Res Function(PortfolioItem) then,
  ) = _$PortfolioItemCopyWithImpl<$Res, PortfolioItem>;
  @useResult
  $Res call({
    String id,
    String title,
    @JsonKey(name: 'title_en') String? titleEn,
    String? description,
    @JsonKey(name: 'description_en') String? descriptionEn,
    List<Media> images,
    String category,
    @JsonKey(name: 'category_ar') String? categoryAr,
    List<String> tags,
    String? date,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'page_id') String? pageId,
  });
}

/// @nodoc
class _$PortfolioItemCopyWithImpl<$Res, $Val extends PortfolioItem>
    implements $PortfolioItemCopyWith<$Res> {
  _$PortfolioItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PortfolioItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? titleEn = freezed,
    Object? description = freezed,
    Object? descriptionEn = freezed,
    Object? images = null,
    Object? category = null,
    Object? categoryAr = freezed,
    Object? tags = null,
    Object? date = freezed,
    Object? sortOrder = null,
    Object? pageId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            titleEn: freezed == titleEn
                ? _value.titleEn
                : titleEn // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            descriptionEn: freezed == descriptionEn
                ? _value.descriptionEn
                : descriptionEn // ignore: cast_nullable_to_non_nullable
                      as String?,
            images: null == images
                ? _value.images
                : images // ignore: cast_nullable_to_non_nullable
                      as List<Media>,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryAr: freezed == categoryAr
                ? _value.categoryAr
                : categoryAr // ignore: cast_nullable_to_non_nullable
                      as String?,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            date: freezed == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String?,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            pageId: freezed == pageId
                ? _value.pageId
                : pageId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PortfolioItemImplCopyWith<$Res>
    implements $PortfolioItemCopyWith<$Res> {
  factory _$$PortfolioItemImplCopyWith(
    _$PortfolioItemImpl value,
    $Res Function(_$PortfolioItemImpl) then,
  ) = __$$PortfolioItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    @JsonKey(name: 'title_en') String? titleEn,
    String? description,
    @JsonKey(name: 'description_en') String? descriptionEn,
    List<Media> images,
    String category,
    @JsonKey(name: 'category_ar') String? categoryAr,
    List<String> tags,
    String? date,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'page_id') String? pageId,
  });
}

/// @nodoc
class __$$PortfolioItemImplCopyWithImpl<$Res>
    extends _$PortfolioItemCopyWithImpl<$Res, _$PortfolioItemImpl>
    implements _$$PortfolioItemImplCopyWith<$Res> {
  __$$PortfolioItemImplCopyWithImpl(
    _$PortfolioItemImpl _value,
    $Res Function(_$PortfolioItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PortfolioItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? titleEn = freezed,
    Object? description = freezed,
    Object? descriptionEn = freezed,
    Object? images = null,
    Object? category = null,
    Object? categoryAr = freezed,
    Object? tags = null,
    Object? date = freezed,
    Object? sortOrder = null,
    Object? pageId = freezed,
  }) {
    return _then(
      _$PortfolioItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        titleEn: freezed == titleEn
            ? _value.titleEn
            : titleEn // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        descriptionEn: freezed == descriptionEn
            ? _value.descriptionEn
            : descriptionEn // ignore: cast_nullable_to_non_nullable
                  as String?,
        images: null == images
            ? _value._images
            : images // ignore: cast_nullable_to_non_nullable
                  as List<Media>,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryAr: freezed == categoryAr
            ? _value.categoryAr
            : categoryAr // ignore: cast_nullable_to_non_nullable
                  as String?,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        date: freezed == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String?,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        pageId: freezed == pageId
            ? _value.pageId
            : pageId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PortfolioItemImpl implements _PortfolioItem {
  const _$PortfolioItemImpl({
    required this.id,
    required this.title,
    @JsonKey(name: 'title_en') this.titleEn,
    this.description,
    @JsonKey(name: 'description_en') this.descriptionEn,
    final List<Media> images = const [],
    required this.category,
    @JsonKey(name: 'category_ar') this.categoryAr,
    final List<String> tags = const [],
    this.date,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    @JsonKey(name: 'page_id') this.pageId,
  }) : _images = images,
       _tags = tags;

  factory _$PortfolioItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PortfolioItemImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @JsonKey(name: 'title_en')
  final String? titleEn;
  @override
  final String? description;
  @override
  @JsonKey(name: 'description_en')
  final String? descriptionEn;
  final List<Media> _images;
  @override
  @JsonKey()
  List<Media> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  final String category;
  @override
  @JsonKey(name: 'category_ar')
  final String? categoryAr;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final String? date;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey(name: 'page_id')
  final String? pageId;

  @override
  String toString() {
    return 'PortfolioItem(id: $id, title: $title, titleEn: $titleEn, description: $description, descriptionEn: $descriptionEn, images: $images, category: $category, categoryAr: $categoryAr, tags: $tags, date: $date, sortOrder: $sortOrder, pageId: $pageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PortfolioItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.titleEn, titleEn) || other.titleEn == titleEn) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.descriptionEn, descriptionEn) ||
                other.descriptionEn == descriptionEn) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.categoryAr, categoryAr) ||
                other.categoryAr == categoryAr) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.pageId, pageId) || other.pageId == pageId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    titleEn,
    description,
    descriptionEn,
    const DeepCollectionEquality().hash(_images),
    category,
    categoryAr,
    const DeepCollectionEquality().hash(_tags),
    date,
    sortOrder,
    pageId,
  );

  /// Create a copy of PortfolioItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PortfolioItemImplCopyWith<_$PortfolioItemImpl> get copyWith =>
      __$$PortfolioItemImplCopyWithImpl<_$PortfolioItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PortfolioItemImplToJson(this);
  }
}

abstract class _PortfolioItem implements PortfolioItem {
  const factory _PortfolioItem({
    required final String id,
    required final String title,
    @JsonKey(name: 'title_en') final String? titleEn,
    final String? description,
    @JsonKey(name: 'description_en') final String? descriptionEn,
    final List<Media> images,
    required final String category,
    @JsonKey(name: 'category_ar') final String? categoryAr,
    final List<String> tags,
    final String? date,
    @JsonKey(name: 'sort_order') final int sortOrder,
    @JsonKey(name: 'page_id') final String? pageId,
  }) = _$PortfolioItemImpl;

  factory _PortfolioItem.fromJson(Map<String, dynamic> json) =
      _$PortfolioItemImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  @JsonKey(name: 'title_en')
  String? get titleEn;
  @override
  String? get description;
  @override
  @JsonKey(name: 'description_en')
  String? get descriptionEn;
  @override
  List<Media> get images;
  @override
  String get category;
  @override
  @JsonKey(name: 'category_ar')
  String? get categoryAr;
  @override
  List<String> get tags;
  @override
  String? get date;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  @JsonKey(name: 'page_id')
  String? get pageId;

  /// Create a copy of PortfolioItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PortfolioItemImplCopyWith<_$PortfolioItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
