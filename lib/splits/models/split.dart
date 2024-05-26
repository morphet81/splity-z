import 'package:equatable/equatable.dart';
import 'package:splity_z/splits/models/models.dart';

final class Split extends Equatable {
  const Split({
    required this.id,
    required this.name,
    required this.splitees,
    required this.expenses,
  });

  final int id;
  final String name;
  final List<Splitee> splitees;
  final List<Expense> expenses;

  @override
  List<Object?> get props => [id, name, splitees, expenses];
}
