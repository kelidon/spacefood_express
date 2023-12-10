import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacefood_express/actors/player.dart';

import '../blocs/inventory/inventory_bloc.dart';

class TemperatureInfo extends StatelessWidget {
  const TemperatureInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventoryBloc, InventoryState>(builder: (context, state) {
      var tempDiff = tempHigherBound - tempLowerBound;
      var part = (state.temperature - tempLowerBound) / tempDiff;
      var height = MediaQuery.of(context).size.height / 2;
      var tempHeight = (height-2) * part;

      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: height,
            constraints: BoxConstraints.loose(Size(25, height)),
            width: 25,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
          ),
          AnimatedContainer(
            margin: EdgeInsets.only(bottom: 1),
            height: tempHeight,
            alignment: Alignment.bottomCenter,
            constraints: BoxConstraints.loose(Size(23, tempHeight)),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            duration: const Duration(milliseconds: 400),
          ),
        ],
      );
    });
  }
}
