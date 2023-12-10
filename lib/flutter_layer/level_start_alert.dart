import 'package:flutter/material.dart';

class LevelStartAlert extends StatelessWidget {
  final String foodName;
  final String image;
  final Function() onStart;

  const LevelStartAlert(
      {super.key, required this.foodName, required this.image, required this.onStart});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white.withOpacity(0.6),
      title: Align(
          alignment: Alignment.bottomCenter,
          child: Text('New order: $foodName', style: TextStyle(color: Colors.black))),
      content: Image.asset(
        'assets/images/food/$image.png',
        height: 150,
        width: 150,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onStart();
          },
          child: const Text(
            'Start',
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w800, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
