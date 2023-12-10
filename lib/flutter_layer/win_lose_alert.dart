import 'package:flutter/material.dart';

class WinLoseAlert extends StatelessWidget {
  final bool isWinning;
  final bool? isFreeze;
  final Function () onContinue;

  const WinLoseAlert({super.key, required this.isWinning, required this.onContinue, this.isFreeze});

  List<String> passedLevel(bool win) {
    if (win) {
      return ['Поздравляю с успешной доставкой', 'Ты настоящий роллеркостер вкусовых ощущений'];
    } else {
      return [
        'Негодник, ты подвёл меня и всю семью, ${isFreeze!?"freezed!":"burn!"}',
        'Мы несколько раз подумаем, прежде чем заказывать у вас снова',
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(passedLevel(isWinning)[0]),
      content: Text(passedLevel(isWinning)[1]),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onContinue();
          },
          child: Text(isWinning ? 'Далее' : 'Переиграть'),
        ),
      ],
    );
  }
}
