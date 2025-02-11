import 'package:freezed_annotation/freezed_annotation.dart';

part 'splitee_summary.freezed.dart';

@Freezed(toJson: false, fromJson: false)
class SpliteeSummary with _$SpliteeSummary {
  const factory SpliteeSummary({
    required double paid,
    required double owe,
  }) = _SpliteeSummary;
}
