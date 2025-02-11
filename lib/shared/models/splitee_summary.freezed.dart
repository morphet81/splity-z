// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'splitee_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SpliteeSummary {
  double get paid => throw _privateConstructorUsedError;
  double get owe => throw _privateConstructorUsedError;

  /// Create a copy of SpliteeSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpliteeSummaryCopyWith<SpliteeSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpliteeSummaryCopyWith<$Res> {
  factory $SpliteeSummaryCopyWith(
          SpliteeSummary value, $Res Function(SpliteeSummary) then) =
      _$SpliteeSummaryCopyWithImpl<$Res, SpliteeSummary>;
  @useResult
  $Res call({double paid, double owe});
}

/// @nodoc
class _$SpliteeSummaryCopyWithImpl<$Res, $Val extends SpliteeSummary>
    implements $SpliteeSummaryCopyWith<$Res> {
  _$SpliteeSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpliteeSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paid = null,
    Object? owe = null,
  }) {
    return _then(_value.copyWith(
      paid: null == paid
          ? _value.paid
          : paid // ignore: cast_nullable_to_non_nullable
              as double,
      owe: null == owe
          ? _value.owe
          : owe // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SpliteeSummaryImplCopyWith<$Res>
    implements $SpliteeSummaryCopyWith<$Res> {
  factory _$$SpliteeSummaryImplCopyWith(_$SpliteeSummaryImpl value,
          $Res Function(_$SpliteeSummaryImpl) then) =
      __$$SpliteeSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double paid, double owe});
}

/// @nodoc
class __$$SpliteeSummaryImplCopyWithImpl<$Res>
    extends _$SpliteeSummaryCopyWithImpl<$Res, _$SpliteeSummaryImpl>
    implements _$$SpliteeSummaryImplCopyWith<$Res> {
  __$$SpliteeSummaryImplCopyWithImpl(
      _$SpliteeSummaryImpl _value, $Res Function(_$SpliteeSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpliteeSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paid = null,
    Object? owe = null,
  }) {
    return _then(_$SpliteeSummaryImpl(
      paid: null == paid
          ? _value.paid
          : paid // ignore: cast_nullable_to_non_nullable
              as double,
      owe: null == owe
          ? _value.owe
          : owe // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$SpliteeSummaryImpl implements _SpliteeSummary {
  const _$SpliteeSummaryImpl({required this.paid, required this.owe});

  @override
  final double paid;
  @override
  final double owe;

  @override
  String toString() {
    return 'SpliteeSummary(paid: $paid, owe: $owe)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpliteeSummaryImpl &&
            (identical(other.paid, paid) || other.paid == paid) &&
            (identical(other.owe, owe) || other.owe == owe));
  }

  @override
  int get hashCode => Object.hash(runtimeType, paid, owe);

  /// Create a copy of SpliteeSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpliteeSummaryImplCopyWith<_$SpliteeSummaryImpl> get copyWith =>
      __$$SpliteeSummaryImplCopyWithImpl<_$SpliteeSummaryImpl>(
          this, _$identity);
}

abstract class _SpliteeSummary implements SpliteeSummary {
  const factory _SpliteeSummary(
      {required final double paid,
      required final double owe}) = _$SpliteeSummaryImpl;

  @override
  double get paid;
  @override
  double get owe;

  /// Create a copy of SpliteeSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpliteeSummaryImplCopyWith<_$SpliteeSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
