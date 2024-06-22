import 'package:flutter/material.dart' hide Split;
import 'package:provider/provider.dart';
import 'package:splity_z/shared/bloc/split_bloc.dart';
import 'package:splity_z/shared/models/models.dart';

const slideValuePixels = 50.0;

class SpliteeListItemDeleteButton extends StatelessWidget {
  const SpliteeListItemDeleteButton({required this.split, required this.splitee, super.key});

  final Split split;
  final Splitee splitee;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      width: 40.0,
      child: IconButton(
        onPressed: () {
          context.read<SplitBloc>().add(DeleteSplitee(split: split, splitee: splitee));
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
    );
  }
}
