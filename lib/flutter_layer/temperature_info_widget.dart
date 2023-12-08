import 'package:flutter/material.dart';

class TemperatureInfo extends StatelessWidget {
  const TemperatureInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.orange,
      child: const Text('temp'),
    );
  }
}
