import 'package:flutter/material.dart';

class LevelStartAlert extends StatelessWidget {
  final String foodName;
  final String image;
  final Function() onStart;

  const LevelStartAlert({super.key, required this.foodName, required this.image, required this.onStart});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white.withOpacity(0.4),
      title: Align(alignment: Alignment.bottomCenter, child: Text('Твоя цель: $foodName')),
      content: Image.asset(
        'assets/images/food/$image.png',
        height: 200,
        width: 200,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onStart();
          },
          child: const Text('Start', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
        ),
      ],
    );
  }
}
