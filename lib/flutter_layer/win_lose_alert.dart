import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/strings.dart';

class WinLoseAlert extends StatelessWidget {
  final bool isWinning;
  final bool? isFreeze;
  final Function () onContinue;

  const WinLoseAlert({super.key, required this.isWinning, required this.onContinue, this.isFreeze});

  String? passedLevel(bool win) {
    if (win) {
      return Strings().positiveFeedback[Random().nextInt(5)];
    } else {
      return '${Strings().negativeFeedback[Random().nextInt(5)]} ${isFreeze!?"freezed!":"burn!"}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(passedLevel(isWinning)?? ''),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onContinue();
          },
          child: Text(isWinning ? 'Next' : 'Replay'),
        ),
      ],
    );
  }
}
