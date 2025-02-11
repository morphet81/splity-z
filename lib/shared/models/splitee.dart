import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:splity_z/shared/models/converters/unique_key_converter.dart';
import 'package:splity_z/shared/models/models.dart';

part 'splitee.freezed.dart';
part 'splitee.g.dart';

@freezed
class Splitee with _$Splitee {
  const Splitee._();

  const factory Splitee({
    @UniqueKeyConverter() required UniqueKey id,
    required String name,
    required List<ExpenseType> expensesTypes,
  }) = _Splitee;

  bool isSameAs(Splitee splitee) {
    return id == splitee.id;
  }

  bool isBlank() {
    return name.isEmpty;
  }

  factory Splitee.withoutId({
    required String name,
    required List<ExpenseType> expensesTypes,
  }) {
    return Splitee(id: UniqueKey(), name: name, expensesTypes: expensesTypes);
  }

  factory Splitee.blank() {
    return Splitee(id: UniqueKey(), name: '', expensesTypes: []);
  }

  factory Splitee.fromJson(Map<String, Object?> json) =>
      _$SpliteeFromJson(json);
}
