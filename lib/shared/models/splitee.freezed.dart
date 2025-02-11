// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'splitee.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Splitee _$SpliteeFromJson(Map<String, dynamic> json) {
  return _Splitee.fromJson(json);
}

/// @nodoc
mixin _$Splitee {
  @UniqueKeyConverter()
  UniqueKey get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<ExpenseType> get expensesTypes => throw _privateConstructorUsedError;

  /// Serializes this Splitee to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Splitee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpliteeCopyWith<Splitee> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpliteeCopyWith<$Res> {
  factory $SpliteeCopyWith(Splitee value, $Res Function(Splitee) then) =
      _$SpliteeCopyWithImpl<$Res, Splitee>;
  @useResult
  $Res call(
      {@UniqueKeyConverter() UniqueKey id,
      String name,
      List<ExpenseType> expensesTypes});
}

/// @nodoc
class _$SpliteeCopyWithImpl<$Res, $Val extends Splitee>
    implements $SpliteeCopyWith<$Res> {
  _$SpliteeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Splitee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? expensesTypes = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as UniqueKey,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      expensesTypes: null == expensesTypes
          ? _value.expensesTypes
          : expensesTypes // ignore: cast_nullable_to_non_nullable
              as List<ExpenseType>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SpliteeImplCopyWith<$Res> implements $SpliteeCopyWith<$Res> {
  factory _$$SpliteeImplCopyWith(
          _$SpliteeImpl value, $Res Function(_$SpliteeImpl) then) =
      __$$SpliteeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@UniqueKeyConverter() UniqueKey id,
      String name,
      List<ExpenseType> expensesTypes});
}

/// @nodoc
class __$$SpliteeImplCopyWithImpl<$Res>
    extends _$SpliteeCopyWithImpl<$Res, _$SpliteeImpl>
    implements _$$SpliteeImplCopyWith<$Res> {
  __$$SpliteeImplCopyWithImpl(
      _$SpliteeImpl _value, $Res Function(_$SpliteeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Splitee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? expensesTypes = null,
  }) {
    return _then(_$SpliteeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as UniqueKey,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      expensesTypes: null == expensesTypes
          ? _value._expensesTypes
          : expensesTypes // ignore: cast_nullable_to_non_nullable
              as List<ExpenseType>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SpliteeImpl extends _Splitee with DiagnosticableTreeMixin {
  const _$SpliteeImpl(
      {@UniqueKeyConverter() required this.id,
      required this.name,
      required final List<ExpenseType> expensesTypes})
      : _expensesTypes = expensesTypes,
        super._();

  factory _$SpliteeImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpliteeImplFromJson(json);

  @override
  @UniqueKeyConverter()
  final UniqueKey id;
  @override
  final String name;
  final List<ExpenseType> _expensesTypes;
  @override
  List<ExpenseType> get expensesTypes {
    if (_expensesTypes is EqualUnmodifiableListView) return _expensesTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expensesTypes);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Splitee(id: $id, name: $name, expensesTypes: $expensesTypes)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Splitee'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('expensesTypes', expensesTypes));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpliteeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._expensesTypes, _expensesTypes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name,
      const DeepCollectionEquality().hash(_expensesTypes));

  /// Create a copy of Splitee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpliteeImplCopyWith<_$SpliteeImpl> get copyWith =>
      __$$SpliteeImplCopyWithImpl<_$SpliteeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpliteeImplToJson(
      this,
    );
  }
}

abstract class _Splitee extends Splitee {
  const factory _Splitee(
      {@UniqueKeyConverter() required final UniqueKey id,
      required final String name,
      required final List<ExpenseType> expensesTypes}) = _$SpliteeImpl;
  const _Splitee._() : super._();

  factory _Splitee.fromJson(Map<String, dynamic> json) = _$SpliteeImpl.fromJson;

  @override
  @UniqueKeyConverter()
  UniqueKey get id;
  @override
  String get name;
  @override
  List<ExpenseType> get expensesTypes;

  /// Create a copy of Splitee
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpliteeImplCopyWith<_$SpliteeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
