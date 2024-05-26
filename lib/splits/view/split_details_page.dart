import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splity_z/splits/view/split_details.dart';
import 'package:splity_z/splits/bloc/split_bloc.dart';

class SplitDetailsPage extends StatelessWidget {
  const SplitDetailsPage({required this.splitId, super.key});

  final int splitId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
          create: (_) => SplitBloc(), child: SplitDetails(splitId: splitId)),
    );
  }
}
