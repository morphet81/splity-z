import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:splity_z/shared/models/models.dart';

abstract class Splitee extends Equatable {
  Splitee({required this.id, required this.name, required this.expensesTypes});

  Splitee.withoutId({required String name, required List<ExpenseType> expensesTypes}) : this(id: UniqueKey(), name: name, expensesTypes: expensesTypes);

  final UniqueKey id;
  final String name;
  final List<ExpenseType> expensesTypes;

  Splitee copyWith({String? name, List<ExpenseType>? expensesTypes});

  bool isBlank();

  @override
  String toString() {
    return 'Splitee($name)';
  }

  @override
  List<Object?> get props => [id, name, expensesTypes];
}

final class SpliteeImpl extends Splitee {
  SpliteeImpl({required name, required expensesTypes}) : super.withoutId(name: name, expensesTypes: expensesTypes);

  SpliteeImpl.withId({required UniqueKey id, required String name, required List<ExpenseType> expensesTypes}) : super(id: id, name: name, expensesTypes: expensesTypes);

  SpliteeImpl.blank() : this.withId(id: UniqueKey(), name: '', expensesTypes: []);

  bool isBlank() {
    return name.isEmpty;
  }

  @override
  SpliteeImpl copyWith({String? name, List<ExpenseType>? expensesTypes}) {
    return SpliteeImpl.withId(id: this.id, name: name ?? this.name, expensesTypes: expensesTypes ?? this.expensesTypes);
  }
}
