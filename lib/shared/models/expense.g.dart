// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExpenseImpl _$$ExpenseImplFromJson(Map<String, dynamic> json) =>
    _$ExpenseImpl(
      id: const UniqueKeyConverter().fromJson(json['id'] as String),
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      paidBy: Splitee.fromJson(json['paidBy'] as Map<String, dynamic>),
      paidFor: (json['paidFor'] as List<dynamic>)
          .map((e) => Splitee.fromJson(e as Map<String, dynamic>))
          .toList(),
      expensesTypes: (json['expensesTypes'] as List<dynamic>)
          .map((e) => $enumDecode(_$ExpenseTypeEnumMap, e))
          .toList(),
      automaticSharing: json['automaticSharing'] as bool,
      manualPaidFor: (json['manualPaidFor'] as List<dynamic>?)
          ?.map((e) => Splitee.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ExpenseImplToJson(_$ExpenseImpl instance) =>
    <String, dynamic>{
      'id': const UniqueKeyConverter().toJson(instance.id),
      'name': instance.name,
      'amount': instance.amount,
      'paidBy': instance.paidBy,
      'paidFor': instance.paidFor,
      'expensesTypes':
          instance.expensesTypes.map((e) => _$ExpenseTypeEnumMap[e]!).toList(),
      'automaticSharing': instance.automaticSharing,
      'manualPaidFor': instance.manualPaidFor,
    };

const _$ExpenseTypeEnumMap = {
  ExpenseType.food: 'food',
  ExpenseType.soft: 'soft',
  ExpenseType.alcohol: 'alcohol',
  ExpenseType.taxi: 'taxi',
};
