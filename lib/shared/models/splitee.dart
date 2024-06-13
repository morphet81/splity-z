import 'package:equatable/equatable.dart';
import 'package:splity_z/shared/models/models.dart';

abstract class Splitee extends Equatable {
  const Splitee({required this.name, required this.expensesTypes});

  final String name;
  final List<ExpenseType> expensesTypes;

  Splitee copyWith({String? name, List<ExpenseType>? expensesTypes});
}

final class SpliteeImpl extends Splitee {
  const SpliteeImpl({required this.name, required this.expensesTypes}) : super(name: name, expensesTypes: expensesTypes);

  final String name;
  final List<ExpenseType> expensesTypes;

  @override
  SpliteeImpl copyWith({String? name, List<ExpenseType>? expensesTypes}) {
    return SpliteeImpl(name: name ?? this.name, expensesTypes: expensesTypes ?? this.expensesTypes);
  }

  @override
  List<Object?> get props => [name, expensesTypes];
}
