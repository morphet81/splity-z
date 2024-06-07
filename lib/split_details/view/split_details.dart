import 'package:flutter/material.dart' hide Split;
import 'package:splity_z/shared/models/models.dart';
import 'package:splity_z/split_details/widgets/shares_list.dart';
import 'package:splity_z/split_details/widgets/splitees_list.dart';

class SplitDetails extends StatelessWidget {
  const SplitDetails({required this.split, required this.isInEditMode, super.key});

  final Split split;
  final bool isInEditMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpliteesList(
          split: split,
          isInEditMode: isInEditMode,
        ),
        SharesList(split: split),
      ],
    );
  }
}
