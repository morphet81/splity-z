import 'package:splity_z/shared/models/models.dart';

extension SpliteeListExtension on List<Splitee> {
  List<Splitee> ascendingSortList() {
    return this..sort((a, b) => a.name.compareTo(b.name));
  }
}
