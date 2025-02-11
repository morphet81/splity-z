// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'split.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SplitImpl _$$SplitImplFromJson(Map<String, dynamic> json) => _$SplitImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      splitees: (json['splitees'] as List<dynamic>)
          .map((e) => Splitee.fromJson(e as Map<String, dynamic>))
          .toList(),
      expenses: (json['expenses'] as List<dynamic>)
          .map((e) => Expense.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SplitImplToJson(_$SplitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'splitees': instance.splitees,
      'expenses': instance.expenses,
    };
