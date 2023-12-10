import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/inventory/inventory_bloc.dart';

class TemperatureInfo extends StatelessWidget {
  const TemperatureInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventoryBloc, InventoryState>(builder: (context, state) {
      return AnimatedContainer(
        height: 50,
        padding: const EdgeInsets.all(10),
        color: Colors.orange,
        duration: const Duration(milliseconds: 400),
        child: const Text('temp'),
      );
    });
  }
}
