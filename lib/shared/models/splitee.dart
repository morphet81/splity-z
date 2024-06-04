import 'package:equatable/equatable.dart';

final class Splitee extends Equatable {
  const Splitee({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];

  static List<Splitee> ascendingSortList(List<Splitee> splitees) {
    return splitees..sort((a, b) => a.name.compareTo(b.name));
  }
}
