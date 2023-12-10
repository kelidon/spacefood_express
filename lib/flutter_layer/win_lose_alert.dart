import 'package:flutter/material.dart';

import '../actors/player.dart';

class WinLoseAlert extends StatelessWidget {
  final bool isWinning;

  const WinLoseAlert({super.key, required this.isWinning});

  List<String> passedLevel(bool win) {
    if (win) {
      return ['Поздравляю с успешной доставкой', 'Ты настоящий роллеркостер вкусовых ощущений'];
    } else {
      return [
        'Негодник, ты подвёл меня и всю семью',
        'Мы несколько раз подумаем, прежде чем заказывать у вас снова',
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    PlayerController playerController = PlayerController();

    return AlertDialog(
      title: Text(passedLevel(isWinning)[0]),
      content: Text(passedLevel(isWinning)[1]),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            ///Респавн на текущий уровень
            Navigator.pop(context, 'Repeat');
          },
          child: const Text('Переиграть'),
        ),
        if (isWinning)
          TextButton(
            onPressed: () {
              ///Переход на следующий уровень
              Navigator.pop(context, 'Next');
            },
            child: const Text('Далее'),
          ),
      ],
    );
  }
}
