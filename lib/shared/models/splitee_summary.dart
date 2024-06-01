import 'package:equatable/equatable.dart';

final class SpliteeSummary extends Equatable {
  SpliteeSummary({required this.paid, required this.owe});

  final double paid;
  final double owe;

  @override
  List<Object?> get props => [paid, owe];
}
