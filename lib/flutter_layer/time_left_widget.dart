import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/inventory/inventory_bloc.dart';

class TimeLeftWidget extends StatelessWidget {
  const TimeLeftWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventoryBloc, InventoryState>(builder: (context, state) {
      return AnimatedContainer(
        duration: const Duration(seconds: 3),
        color: Colors.blue,
        height: 100,
        width: 20,
        child: Text(state.time.toString()),
      );
    });
  }
}
