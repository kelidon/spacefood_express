import 'package:flutter/material.dart';

class LevelStartAlert extends StatelessWidget {
  final String foodName;
  final String image;

  const LevelStartAlert({super.key, required this.foodName, required this.image});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Align(alignment: Alignment.bottomCenter, child: Text('Твоя цель: $foodName')),
      content: Image.asset(
        'assets/images/$image.png',
        height: 200,
        width: 200,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Start'),
        ),
      ],
    );
  }
}
