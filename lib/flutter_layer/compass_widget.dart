import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacefood_express/blocs/compass/compass_cubit.dart';

class CompassWidget extends StatelessWidget {
  const CompassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final compassCubit = context.watch<CompassCubit>();
    return Transform.rotate(
      angle: compassCubit.state.angle,
      child: Container(color: Colors.red, child: Text("i")),
    );
  }
}
