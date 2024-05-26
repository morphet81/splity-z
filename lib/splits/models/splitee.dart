import 'package:equatable/equatable.dart';

final class Splitee extends Equatable {
  const Splitee({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}
