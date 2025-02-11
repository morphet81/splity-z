// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'split_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SplitStateImpl _$$SplitStateImplFromJson(Map<String, dynamic> json) =>
    _$SplitStateImpl(
      splits: (json['splits'] as List<dynamic>?)
              ?.map((e) => Split.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Split>[],
    );

Map<String, dynamic> _$$SplitStateImplToJson(_$SplitStateImpl instance) =>
    <String, dynamic>{
      'splits': instance.splits,
    };
