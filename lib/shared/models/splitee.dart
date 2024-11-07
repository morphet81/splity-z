import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:splity_z/shared/models/models.dart';

abstract class Splitee extends Equatable {
  const Splitee({
    required this.id,
    required this.name,
    required this.expensesTypes,
  });

  Splitee.withoutId({
    required String name,
    required List<ExpenseType> expensesTypes,
  }) : this(id: UniqueKey(), name: name, expensesTypes: expensesTypes);

  final UniqueKey id;
  final String name;
  final List<ExpenseType> expensesTypes;

  Splitee copyWith({String? name, List<ExpenseType>? expensesTypes});

  bool isBlank();

  bool isSameAs(Splitee splitee);

  @override
  String toString() {
    return 'Splitee($name)';
  }

  @override
  List<Object?> get props => [id, name, expensesTypes];
}

final class SpliteeImpl extends Splitee {
  const SpliteeImpl._({
    required super.id,
    required super.name,
    required super.expensesTypes,
  });

  SpliteeImpl.withoutId({
    required String name,
    required List<ExpenseType> expensesTypes,
  }) : this._(id: UniqueKey(), name: name, expensesTypes: expensesTypes);

  const SpliteeImpl.withId({
    required super.id,
    required super.name,
    required super.expensesTypes,
  });

  SpliteeImpl.blank()
      : this.withId(id: UniqueKey(), name: '', expensesTypes: []);

  @override
  bool isBlank() {
    return name.isEmpty;
  }

  @override
  SpliteeImpl copyWith({String? name, List<ExpenseType>? expensesTypes}) {
    return SpliteeImpl.withId(
      id: id,
      name: name ?? this.name,
      expensesTypes: expensesTypes ?? this.expensesTypes,
    );
  }

  @override
  bool isSameAs(Splitee splitee) {
    return id == splitee.id;
  }
}
