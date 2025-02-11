// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Expense _$ExpenseFromJson(Map<String, dynamic> json) {
  return _Expense.fromJson(json);
}

/// @nodoc
mixin _$Expense {
  @UniqueKeyConverter()
  UniqueKey get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  Splitee get paidBy => throw _privateConstructorUsedError;
  List<Splitee> get paidFor => throw _privateConstructorUsedError;
  List<ExpenseType> get expensesTypes => throw _privateConstructorUsedError;
  bool get automaticSharing => throw _privateConstructorUsedError;
  List<Splitee>? get manualPaidFor => throw _privateConstructorUsedError;

  /// Serializes this Expense to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Expense
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpenseCopyWith<Expense> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseCopyWith<$Res> {
  factory $ExpenseCopyWith(Expense value, $Res Function(Expense) then) =
      _$ExpenseCopyWithImpl<$Res, Expense>;
  @useResult
  $Res call(
      {@UniqueKeyConverter() UniqueKey id,
      String name,
      double amount,
      Splitee paidBy,
      List<Splitee> paidFor,
      List<ExpenseType> expensesTypes,
      bool automaticSharing,
      List<Splitee>? manualPaidFor});

  $SpliteeCopyWith<$Res> get paidBy;
}

/// @nodoc
class _$ExpenseCopyWithImpl<$Res, $Val extends Expense>
    implements $ExpenseCopyWith<$Res> {
  _$ExpenseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Expense
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? amount = null,
    Object? paidBy = null,
    Object? paidFor = null,
    Object? expensesTypes = null,
    Object? automaticSharing = null,
    Object? manualPaidFor = freezed,
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
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      paidBy: null == paidBy
          ? _value.paidBy
          : paidBy // ignore: cast_nullable_to_non_nullable
              as Splitee,
      paidFor: null == paidFor
          ? _value.paidFor
          : paidFor // ignore: cast_nullable_to_non_nullable
              as List<Splitee>,
      expensesTypes: null == expensesTypes
          ? _value.expensesTypes
          : expensesTypes // ignore: cast_nullable_to_non_nullable
              as List<ExpenseType>,
      automaticSharing: null == automaticSharing
          ? _value.automaticSharing
          : automaticSharing // ignore: cast_nullable_to_non_nullable
              as bool,
      manualPaidFor: freezed == manualPaidFor
          ? _value.manualPaidFor
          : manualPaidFor // ignore: cast_nullable_to_non_nullable
              as List<Splitee>?,
    ) as $Val);
  }

  /// Create a copy of Expense
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SpliteeCopyWith<$Res> get paidBy {
    return $SpliteeCopyWith<$Res>(_value.paidBy, (value) {
      return _then(_value.copyWith(paidBy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExpenseImplCopyWith<$Res> implements $ExpenseCopyWith<$Res> {
  factory _$$ExpenseImplCopyWith(
          _$ExpenseImpl value, $Res Function(_$ExpenseImpl) then) =
      __$$ExpenseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@UniqueKeyConverter() UniqueKey id,
      String name,
      double amount,
      Splitee paidBy,
      List<Splitee> paidFor,
      List<ExpenseType> expensesTypes,
      bool automaticSharing,
      List<Splitee>? manualPaidFor});

  @override
  $SpliteeCopyWith<$Res> get paidBy;
}

/// @nodoc
class __$$ExpenseImplCopyWithImpl<$Res>
    extends _$ExpenseCopyWithImpl<$Res, _$ExpenseImpl>
    implements _$$ExpenseImplCopyWith<$Res> {
  __$$ExpenseImplCopyWithImpl(
      _$ExpenseImpl _value, $Res Function(_$ExpenseImpl) _then)
      : super(_value, _then);

  /// Create a copy of Expense
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? amount = null,
    Object? paidBy = null,
    Object? paidFor = null,
    Object? expensesTypes = null,
    Object? automaticSharing = null,
    Object? manualPaidFor = freezed,
  }) {
    return _then(_$ExpenseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as UniqueKey,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      paidBy: null == paidBy
          ? _value.paidBy
          : paidBy // ignore: cast_nullable_to_non_nullable
              as Splitee,
      paidFor: null == paidFor
          ? _value._paidFor
          : paidFor // ignore: cast_nullable_to_non_nullable
              as List<Splitee>,
      expensesTypes: null == expensesTypes
          ? _value._expensesTypes
          : expensesTypes // ignore: cast_nullable_to_non_nullable
              as List<ExpenseType>,
      automaticSharing: null == automaticSharing
          ? _value.automaticSharing
          : automaticSharing // ignore: cast_nullable_to_non_nullable
              as bool,
      manualPaidFor: freezed == manualPaidFor
          ? _value._manualPaidFor
          : manualPaidFor // ignore: cast_nullable_to_non_nullable
              as List<Splitee>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpenseImpl extends _Expense with DiagnosticableTreeMixin {
  const _$ExpenseImpl(
      {@UniqueKeyConverter() required this.id,
      required this.name,
      required this.amount,
      required this.paidBy,
      required final List<Splitee> paidFor,
      required final List<ExpenseType> expensesTypes,
      required this.automaticSharing,
      final List<Splitee>? manualPaidFor})
      : _paidFor = paidFor,
        _expensesTypes = expensesTypes,
        _manualPaidFor = manualPaidFor,
        super._();

  factory _$ExpenseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpenseImplFromJson(json);

  @override
  @UniqueKeyConverter()
  final UniqueKey id;
  @override
  final String name;
  @override
  final double amount;
  @override
  final Splitee paidBy;
  final List<Splitee> _paidFor;
  @override
  List<Splitee> get paidFor {
    if (_paidFor is EqualUnmodifiableListView) return _paidFor;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paidFor);
  }

  final List<ExpenseType> _expensesTypes;
  @override
  List<ExpenseType> get expensesTypes {
    if (_expensesTypes is EqualUnmodifiableListView) return _expensesTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expensesTypes);
  }

  @override
  final bool automaticSharing;
  final List<Splitee>? _manualPaidFor;
  @override
  List<Splitee>? get manualPaidFor {
    final value = _manualPaidFor;
    if (value == null) return null;
    if (_manualPaidFor is EqualUnmodifiableListView) return _manualPaidFor;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Expense(id: $id, name: $name, amount: $amount, paidBy: $paidBy, paidFor: $paidFor, expensesTypes: $expensesTypes, automaticSharing: $automaticSharing, manualPaidFor: $manualPaidFor)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Expense'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('amount', amount))
      ..add(DiagnosticsProperty('paidBy', paidBy))
      ..add(DiagnosticsProperty('paidFor', paidFor))
      ..add(DiagnosticsProperty('expensesTypes', expensesTypes))
      ..add(DiagnosticsProperty('automaticSharing', automaticSharing))
      ..add(DiagnosticsProperty('manualPaidFor', manualPaidFor));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.paidBy, paidBy) || other.paidBy == paidBy) &&
            const DeepCollectionEquality().equals(other._paidFor, _paidFor) &&
            const DeepCollectionEquality()
                .equals(other._expensesTypes, _expensesTypes) &&
            (identical(other.automaticSharing, automaticSharing) ||
                other.automaticSharing == automaticSharing) &&
            const DeepCollectionEquality()
                .equals(other._manualPaidFor, _manualPaidFor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      amount,
      paidBy,
      const DeepCollectionEquality().hash(_paidFor),
      const DeepCollectionEquality().hash(_expensesTypes),
      automaticSharing,
      const DeepCollectionEquality().hash(_manualPaidFor));

  /// Create a copy of Expense
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseImplCopyWith<_$ExpenseImpl> get copyWith =>
      __$$ExpenseImplCopyWithImpl<_$ExpenseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseImplToJson(
      this,
    );
  }
}

abstract class _Expense extends Expense {
  const factory _Expense(
      {@UniqueKeyConverter() required final UniqueKey id,
      required final String name,
      required final double amount,
      required final Splitee paidBy,
      required final List<Splitee> paidFor,
      required final List<ExpenseType> expensesTypes,
      required final bool automaticSharing,
      final List<Splitee>? manualPaidFor}) = _$ExpenseImpl;
  const _Expense._() : super._();

  factory _Expense.fromJson(Map<String, dynamic> json) = _$ExpenseImpl.fromJson;

  @override
  @UniqueKeyConverter()
  UniqueKey get id;
  @override
  String get name;
  @override
  double get amount;
  @override
  Splitee get paidBy;
  @override
  List<Splitee> get paidFor;
  @override
  List<ExpenseType> get expensesTypes;
  @override
  bool get automaticSharing;
  @override
  List<Splitee>? get manualPaidFor;

  /// Create a copy of Expense
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpenseImplCopyWith<_$ExpenseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
