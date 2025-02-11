import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:splity_z/shared/models/models.dart';

part 'share.freezed.dart';

@Freezed(toJson: false, fromJson: false)
class Share with _$Share {
  const Share._();

  const factory Share({
    required Splitee from,
    required Splitee to,
    required double amount,
  }) = _Share;

  @override
  String toString() {
    return '${from.name} owes ${to.name} the amount $amount';
  }

  int compateTo(Share share) {
    return from.name.compareTo(share.from.name);
  }

  bool isSimilarTo(Share share) {
    return from == share.from && to == share.to;
  }

  static int compareShares(Share a, Share b) {
    return a.compateTo(b);
  }

  static Share sharesListReducer(Share value, Share element) {
    return value.copyWith(amount: value.amount + element.amount);
  }
}
