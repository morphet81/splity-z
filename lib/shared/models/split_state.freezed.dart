// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'split_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SplitState {
  List<Split> get splits => throw _privateConstructorUsedError;

  /// Create a copy of SplitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SplitStateCopyWith<SplitState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SplitStateCopyWith<$Res> {
  factory $SplitStateCopyWith(
          SplitState value, $Res Function(SplitState) then) =
      _$SplitStateCopyWithImpl<$Res, SplitState>;
  @useResult
  $Res call({List<Split> splits});
}

/// @nodoc
class _$SplitStateCopyWithImpl<$Res, $Val extends SplitState>
    implements $SplitStateCopyWith<$Res> {
  _$SplitStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SplitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? splits = null,
  }) {
    return _then(_value.copyWith(
      splits: null == splits
          ? _value.splits
          : splits // ignore: cast_nullable_to_non_nullable
              as List<Split>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SplitStateImplCopyWith<$Res>
    implements $SplitStateCopyWith<$Res> {
  factory _$$SplitStateImplCopyWith(
          _$SplitStateImpl value, $Res Function(_$SplitStateImpl) then) =
      __$$SplitStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Split> splits});
}

/// @nodoc
class __$$SplitStateImplCopyWithImpl<$Res>
    extends _$SplitStateCopyWithImpl<$Res, _$SplitStateImpl>
    implements _$$SplitStateImplCopyWith<$Res> {
  __$$SplitStateImplCopyWithImpl(
      _$SplitStateImpl _value, $Res Function(_$SplitStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SplitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? splits = null,
  }) {
    return _then(_$SplitStateImpl(
      splits: null == splits
          ? _value._splits
          : splits // ignore: cast_nullable_to_non_nullable
              as List<Split>,
    ));
  }
}

/// @nodoc

class _$SplitStateImpl extends _SplitState {
  const _$SplitStateImpl({final List<Split> splits = const <Split>[]})
      : _splits = splits,
        super._();

  final List<Split> _splits;
  @override
  @JsonKey()
  List<Split> get splits {
    if (_splits is EqualUnmodifiableListView) return _splits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_splits);
  }

  @override
  String toString() {
    return 'SplitState(splits: $splits)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SplitStateImpl &&
            const DeepCollectionEquality().equals(other._splits, _splits));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_splits));

  /// Create a copy of SplitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SplitStateImplCopyWith<_$SplitStateImpl> get copyWith =>
      __$$SplitStateImplCopyWithImpl<_$SplitStateImpl>(this, _$identity);
}

abstract class _SplitState extends SplitState {
  const factory _SplitState({final List<Split> splits}) = _$SplitStateImpl;
  const _SplitState._() : super._();

  @override
  List<Split> get splits;

  /// Create a copy of SplitState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SplitStateImplCopyWith<_$SplitStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
