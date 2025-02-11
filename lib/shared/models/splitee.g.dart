// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splitee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpliteeImpl _$$SpliteeImplFromJson(Map<String, dynamic> json) =>
    _$SpliteeImpl(
      id: const UniqueKeyConverter().fromJson(json['id'] as String),
      name: json['name'] as String,
      expensesTypes: (json['expensesTypes'] as List<dynamic>)
          .map((e) => $enumDecode(_$ExpenseTypeEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$$SpliteeImplToJson(_$SpliteeImpl instance) =>
    <String, dynamic>{
      'id': const UniqueKeyConverter().toJson(instance.id),
      'name': instance.name,
      'expensesTypes':
          instance.expensesTypes.map((e) => _$ExpenseTypeEnumMap[e]!).toList(),
    };

const _$ExpenseTypeEnumMap = {
  ExpenseType.food: 'food',
  ExpenseType.soft: 'soft',
  ExpenseType.alcohol: 'alcohol',
  ExpenseType.taxi: 'taxi',
};
