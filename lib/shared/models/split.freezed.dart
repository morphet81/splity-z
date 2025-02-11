// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'split.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Split _$SplitFromJson(Map<String, dynamic> json) {
  return _Split.fromJson(json);
}

/// @nodoc
mixin _$Split {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<Splitee> get splitees => throw _privateConstructorUsedError;
  List<Expense> get expenses => throw _privateConstructorUsedError;

  /// Serializes this Split to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Split
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SplitCopyWith<Split> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SplitCopyWith<$Res> {
  factory $SplitCopyWith(Split value, $Res Function(Split) then) =
      _$SplitCopyWithImpl<$Res, Split>;
  @useResult
  $Res call(
      {String id, String name, List<Splitee> splitees, List<Expense> expenses});
}

/// @nodoc
class _$SplitCopyWithImpl<$Res, $Val extends Split>
    implements $SplitCopyWith<$Res> {
  _$SplitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Split
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? splitees = null,
    Object? expenses = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      splitees: null == splitees
          ? _value.splitees
          : splitees // ignore: cast_nullable_to_non_nullable
              as List<Splitee>,
      expenses: null == expenses
          ? _value.expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as List<Expense>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SplitImplCopyWith<$Res> implements $SplitCopyWith<$Res> {
  factory _$$SplitImplCopyWith(
          _$SplitImpl value, $Res Function(_$SplitImpl) then) =
      __$$SplitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String name, List<Splitee> splitees, List<Expense> expenses});
}

/// @nodoc
class __$$SplitImplCopyWithImpl<$Res>
    extends _$SplitCopyWithImpl<$Res, _$SplitImpl>
    implements _$$SplitImplCopyWith<$Res> {
  __$$SplitImplCopyWithImpl(
      _$SplitImpl _value, $Res Function(_$SplitImpl) _then)
      : super(_value, _then);

  /// Create a copy of Split
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? splitees = null,
    Object? expenses = null,
  }) {
    return _then(_$SplitImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      splitees: null == splitees
          ? _value._splitees
          : splitees // ignore: cast_nullable_to_non_nullable
              as List<Splitee>,
      expenses: null == expenses
          ? _value._expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as List<Expense>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SplitImpl extends _Split with DiagnosticableTreeMixin {
  const _$SplitImpl(
      {required this.id,
      required this.name,
      required final List<Splitee> splitees,
      required final List<Expense> expenses})
      : _splitees = splitees,
        _expenses = expenses,
        super._();

  factory _$SplitImpl.fromJson(Map<String, dynamic> json) =>
      _$$SplitImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<Splitee> _splitees;
  @override
  List<Splitee> get splitees {
    if (_splitees is EqualUnmodifiableListView) return _splitees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_splitees);
  }

  final List<Expense> _expenses;
  @override
  List<Expense> get expenses {
    if (_expenses is EqualUnmodifiableListView) return _expenses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expenses);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Split(id: $id, name: $name, splitees: $splitees, expenses: $expenses)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Split'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('splitees', splitees))
      ..add(DiagnosticsProperty('expenses', expenses));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SplitImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._splitees, _splitees) &&
            const DeepCollectionEquality().equals(other._expenses, _expenses));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(_splitees),
      const DeepCollectionEquality().hash(_expenses));

  /// Create a copy of Split
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SplitImplCopyWith<_$SplitImpl> get copyWith =>
      __$$SplitImplCopyWithImpl<_$SplitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SplitImplToJson(
      this,
    );
  }
}

abstract class _Split extends Split {
  const factory _Split(
      {required final String id,
      required final String name,
      required final List<Splitee> splitees,
      required final List<Expense> expenses}) = _$SplitImpl;
  const _Split._() : super._();

  factory _Split.fromJson(Map<String, dynamic> json) = _$SplitImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<Splitee> get splitees;
  @override
  List<Expense> get expenses;

  /// Create a copy of Split
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SplitImplCopyWith<_$SplitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
