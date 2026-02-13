// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wizard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WizardState {
  int get step => throw _privateConstructorUsedError; // 1-6, 7 = done
  // Step 1: Business Type
  String? get selectedTypeId => throw _privateConstructorUsedError;
  String? get selectedTypeName => throw _privateConstructorUsedError;
  String? get selectedArchetype =>
      throw _privateConstructorUsedError; // Step 2: Handle
  String get handle => throw _privateConstructorUsedError;
  bool get handleAvailable => throw _privateConstructorUsedError;
  bool get handleChecking =>
      throw _privateConstructorUsedError; // Step 3: Page Info
  String get pageName => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError; // Step 4: Location
  String get address => throw _privateConstructorUsedError;
  bool get isOnlineOnly => throw _privateConstructorUsedError; // Step 5: Hours
  String get hoursPreset =>
      throw _privateConstructorUsedError; // weekdays | 247 | custom
  String get customHours =>
      throw _privateConstructorUsedError; // Step 6: Payment
  Set<int> get selectedPayments =>
      throw _privateConstructorUsedError; // 0=cash, 1=cliq, 2=bank, 3=wallet
  String get cliqAlias => throw _privateConstructorUsedError;

  /// Create a copy of WizardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WizardStateCopyWith<WizardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WizardStateCopyWith<$Res> {
  factory $WizardStateCopyWith(
    WizardState value,
    $Res Function(WizardState) then,
  ) = _$WizardStateCopyWithImpl<$Res, WizardState>;
  @useResult
  $Res call({
    int step,
    String? selectedTypeId,
    String? selectedTypeName,
    String? selectedArchetype,
    String handle,
    bool handleAvailable,
    bool handleChecking,
    String pageName,
    String description,
    String phone,
    String address,
    bool isOnlineOnly,
    String hoursPreset,
    String customHours,
    Set<int> selectedPayments,
    String cliqAlias,
  });
}

/// @nodoc
class _$WizardStateCopyWithImpl<$Res, $Val extends WizardState>
    implements $WizardStateCopyWith<$Res> {
  _$WizardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WizardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = null,
    Object? selectedTypeId = freezed,
    Object? selectedTypeName = freezed,
    Object? selectedArchetype = freezed,
    Object? handle = null,
    Object? handleAvailable = null,
    Object? handleChecking = null,
    Object? pageName = null,
    Object? description = null,
    Object? phone = null,
    Object? address = null,
    Object? isOnlineOnly = null,
    Object? hoursPreset = null,
    Object? customHours = null,
    Object? selectedPayments = null,
    Object? cliqAlias = null,
  }) {
    return _then(
      _value.copyWith(
            step: null == step
                ? _value.step
                : step // ignore: cast_nullable_to_non_nullable
                      as int,
            selectedTypeId: freezed == selectedTypeId
                ? _value.selectedTypeId
                : selectedTypeId // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedTypeName: freezed == selectedTypeName
                ? _value.selectedTypeName
                : selectedTypeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedArchetype: freezed == selectedArchetype
                ? _value.selectedArchetype
                : selectedArchetype // ignore: cast_nullable_to_non_nullable
                      as String?,
            handle: null == handle
                ? _value.handle
                : handle // ignore: cast_nullable_to_non_nullable
                      as String,
            handleAvailable: null == handleAvailable
                ? _value.handleAvailable
                : handleAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
            handleChecking: null == handleChecking
                ? _value.handleChecking
                : handleChecking // ignore: cast_nullable_to_non_nullable
                      as bool,
            pageName: null == pageName
                ? _value.pageName
                : pageName // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            isOnlineOnly: null == isOnlineOnly
                ? _value.isOnlineOnly
                : isOnlineOnly // ignore: cast_nullable_to_non_nullable
                      as bool,
            hoursPreset: null == hoursPreset
                ? _value.hoursPreset
                : hoursPreset // ignore: cast_nullable_to_non_nullable
                      as String,
            customHours: null == customHours
                ? _value.customHours
                : customHours // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedPayments: null == selectedPayments
                ? _value.selectedPayments
                : selectedPayments // ignore: cast_nullable_to_non_nullable
                      as Set<int>,
            cliqAlias: null == cliqAlias
                ? _value.cliqAlias
                : cliqAlias // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WizardStateImplCopyWith<$Res>
    implements $WizardStateCopyWith<$Res> {
  factory _$$WizardStateImplCopyWith(
    _$WizardStateImpl value,
    $Res Function(_$WizardStateImpl) then,
  ) = __$$WizardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int step,
    String? selectedTypeId,
    String? selectedTypeName,
    String? selectedArchetype,
    String handle,
    bool handleAvailable,
    bool handleChecking,
    String pageName,
    String description,
    String phone,
    String address,
    bool isOnlineOnly,
    String hoursPreset,
    String customHours,
    Set<int> selectedPayments,
    String cliqAlias,
  });
}

/// @nodoc
class __$$WizardStateImplCopyWithImpl<$Res>
    extends _$WizardStateCopyWithImpl<$Res, _$WizardStateImpl>
    implements _$$WizardStateImplCopyWith<$Res> {
  __$$WizardStateImplCopyWithImpl(
    _$WizardStateImpl _value,
    $Res Function(_$WizardStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WizardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = null,
    Object? selectedTypeId = freezed,
    Object? selectedTypeName = freezed,
    Object? selectedArchetype = freezed,
    Object? handle = null,
    Object? handleAvailable = null,
    Object? handleChecking = null,
    Object? pageName = null,
    Object? description = null,
    Object? phone = null,
    Object? address = null,
    Object? isOnlineOnly = null,
    Object? hoursPreset = null,
    Object? customHours = null,
    Object? selectedPayments = null,
    Object? cliqAlias = null,
  }) {
    return _then(
      _$WizardStateImpl(
        step: null == step
            ? _value.step
            : step // ignore: cast_nullable_to_non_nullable
                  as int,
        selectedTypeId: freezed == selectedTypeId
            ? _value.selectedTypeId
            : selectedTypeId // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedTypeName: freezed == selectedTypeName
            ? _value.selectedTypeName
            : selectedTypeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedArchetype: freezed == selectedArchetype
            ? _value.selectedArchetype
            : selectedArchetype // ignore: cast_nullable_to_non_nullable
                  as String?,
        handle: null == handle
            ? _value.handle
            : handle // ignore: cast_nullable_to_non_nullable
                  as String,
        handleAvailable: null == handleAvailable
            ? _value.handleAvailable
            : handleAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
        handleChecking: null == handleChecking
            ? _value.handleChecking
            : handleChecking // ignore: cast_nullable_to_non_nullable
                  as bool,
        pageName: null == pageName
            ? _value.pageName
            : pageName // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        isOnlineOnly: null == isOnlineOnly
            ? _value.isOnlineOnly
            : isOnlineOnly // ignore: cast_nullable_to_non_nullable
                  as bool,
        hoursPreset: null == hoursPreset
            ? _value.hoursPreset
            : hoursPreset // ignore: cast_nullable_to_non_nullable
                  as String,
        customHours: null == customHours
            ? _value.customHours
            : customHours // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedPayments: null == selectedPayments
            ? _value._selectedPayments
            : selectedPayments // ignore: cast_nullable_to_non_nullable
                  as Set<int>,
        cliqAlias: null == cliqAlias
            ? _value.cliqAlias
            : cliqAlias // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$WizardStateImpl implements _WizardState {
  const _$WizardStateImpl({
    this.step = 1,
    this.selectedTypeId,
    this.selectedTypeName,
    this.selectedArchetype,
    this.handle = '',
    this.handleAvailable = false,
    this.handleChecking = false,
    this.pageName = '',
    this.description = '',
    this.phone = '',
    this.address = '',
    this.isOnlineOnly = false,
    this.hoursPreset = 'weekdays',
    this.customHours = '',
    final Set<int> selectedPayments = const {0},
    this.cliqAlias = '',
  }) : _selectedPayments = selectedPayments;

  @override
  @JsonKey()
  final int step;
  // 1-6, 7 = done
  // Step 1: Business Type
  @override
  final String? selectedTypeId;
  @override
  final String? selectedTypeName;
  @override
  final String? selectedArchetype;
  // Step 2: Handle
  @override
  @JsonKey()
  final String handle;
  @override
  @JsonKey()
  final bool handleAvailable;
  @override
  @JsonKey()
  final bool handleChecking;
  // Step 3: Page Info
  @override
  @JsonKey()
  final String pageName;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String phone;
  // Step 4: Location
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final bool isOnlineOnly;
  // Step 5: Hours
  @override
  @JsonKey()
  final String hoursPreset;
  // weekdays | 247 | custom
  @override
  @JsonKey()
  final String customHours;
  // Step 6: Payment
  final Set<int> _selectedPayments;
  // Step 6: Payment
  @override
  @JsonKey()
  Set<int> get selectedPayments {
    if (_selectedPayments is EqualUnmodifiableSetView) return _selectedPayments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedPayments);
  }

  // 0=cash, 1=cliq, 2=bank, 3=wallet
  @override
  @JsonKey()
  final String cliqAlias;

  @override
  String toString() {
    return 'WizardState(step: $step, selectedTypeId: $selectedTypeId, selectedTypeName: $selectedTypeName, selectedArchetype: $selectedArchetype, handle: $handle, handleAvailable: $handleAvailable, handleChecking: $handleChecking, pageName: $pageName, description: $description, phone: $phone, address: $address, isOnlineOnly: $isOnlineOnly, hoursPreset: $hoursPreset, customHours: $customHours, selectedPayments: $selectedPayments, cliqAlias: $cliqAlias)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WizardStateImpl &&
            (identical(other.step, step) || other.step == step) &&
            (identical(other.selectedTypeId, selectedTypeId) ||
                other.selectedTypeId == selectedTypeId) &&
            (identical(other.selectedTypeName, selectedTypeName) ||
                other.selectedTypeName == selectedTypeName) &&
            (identical(other.selectedArchetype, selectedArchetype) ||
                other.selectedArchetype == selectedArchetype) &&
            (identical(other.handle, handle) || other.handle == handle) &&
            (identical(other.handleAvailable, handleAvailable) ||
                other.handleAvailable == handleAvailable) &&
            (identical(other.handleChecking, handleChecking) ||
                other.handleChecking == handleChecking) &&
            (identical(other.pageName, pageName) ||
                other.pageName == pageName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.isOnlineOnly, isOnlineOnly) ||
                other.isOnlineOnly == isOnlineOnly) &&
            (identical(other.hoursPreset, hoursPreset) ||
                other.hoursPreset == hoursPreset) &&
            (identical(other.customHours, customHours) ||
                other.customHours == customHours) &&
            const DeepCollectionEquality().equals(
              other._selectedPayments,
              _selectedPayments,
            ) &&
            (identical(other.cliqAlias, cliqAlias) ||
                other.cliqAlias == cliqAlias));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    step,
    selectedTypeId,
    selectedTypeName,
    selectedArchetype,
    handle,
    handleAvailable,
    handleChecking,
    pageName,
    description,
    phone,
    address,
    isOnlineOnly,
    hoursPreset,
    customHours,
    const DeepCollectionEquality().hash(_selectedPayments),
    cliqAlias,
  );

  /// Create a copy of WizardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WizardStateImplCopyWith<_$WizardStateImpl> get copyWith =>
      __$$WizardStateImplCopyWithImpl<_$WizardStateImpl>(this, _$identity);
}

abstract class _WizardState implements WizardState {
  const factory _WizardState({
    final int step,
    final String? selectedTypeId,
    final String? selectedTypeName,
    final String? selectedArchetype,
    final String handle,
    final bool handleAvailable,
    final bool handleChecking,
    final String pageName,
    final String description,
    final String phone,
    final String address,
    final bool isOnlineOnly,
    final String hoursPreset,
    final String customHours,
    final Set<int> selectedPayments,
    final String cliqAlias,
  }) = _$WizardStateImpl;

  @override
  int get step; // 1-6, 7 = done
  // Step 1: Business Type
  @override
  String? get selectedTypeId;
  @override
  String? get selectedTypeName;
  @override
  String? get selectedArchetype; // Step 2: Handle
  @override
  String get handle;
  @override
  bool get handleAvailable;
  @override
  bool get handleChecking; // Step 3: Page Info
  @override
  String get pageName;
  @override
  String get description;
  @override
  String get phone; // Step 4: Location
  @override
  String get address;
  @override
  bool get isOnlineOnly; // Step 5: Hours
  @override
  String get hoursPreset; // weekdays | 247 | custom
  @override
  String get customHours; // Step 6: Payment
  @override
  Set<int> get selectedPayments; // 0=cash, 1=cliq, 2=bank, 3=wallet
  @override
  String get cliqAlias;

  /// Create a copy of WizardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WizardStateImplCopyWith<_$WizardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
