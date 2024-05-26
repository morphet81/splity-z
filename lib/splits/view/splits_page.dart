import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splity_z/splits/bloc/split_bloc.dart';
import 'package:splity_z/splits/splits.dart';

class SplitsPage extends StatefulWidget {
  const SplitsPage({super.key});

  @override
  State<SplitsPage> createState() => _SplitsListState();
}

class _SplitsListState extends State<SplitsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
            create: (_) => SplitBloc(), child: const SplitsList()));
  }
}
