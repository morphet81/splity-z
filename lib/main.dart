import 'package:flutter/material.dart';
import 'package:splity_z/app.dart';
import 'package:splity_z/shared/bloc/split_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final splitBloc = await SplitBloc.create();

  runApp(
    App(
      splitBloc: splitBloc,
    ),
  );
}
