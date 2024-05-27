import 'package:flutter/material.dart';
import 'package:splity_z/splits/models/models.dart';

class SpliteesList extends StatelessWidget {
  const SpliteesList({required this.splitees, super.key});

  final List<Splitee> splitees;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Splitees',
          // style: GoogleFonts.aBeeZee(),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Text(splitees[index].name);
          },
          itemCount: splitees.length,
        ),
      ],
    );
  }
}
