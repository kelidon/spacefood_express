import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/strings.dart';

class WinLoseAlert extends StatelessWidget {
  final bool isWinning;
  final bool? isFreeze;
  final String image;
  final Function() onContinue;

  const WinLoseAlert(
      {super.key,
      required this.isWinning,
      required this.onContinue,
      this.isFreeze,
      required this.image});

  String? passedLevel(bool win) {
    if (win) {
      return Strings().positiveFeedback[Random().nextInt(5)];
    } else {
      return '${Strings().negativeFeedback[Random().nextInt(5)]} ${isFreeze! ? "It's frozen!" : "It's burned!"}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white.withOpacity(0.6),
      title: Text(
        passedLevel(isWinning) ?? '',
        style: const TextStyle(color: Colors.black, fontSize: 22),
      ),
      content: Column(
        children: [
          Image.asset(
            'assets/images/food/$image.png',
            height: 150,
            width: 150,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onContinue();
          },
          child: Text(
            isWinning ? 'Next' : 'Replay',
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w800, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
