import 'package:flutter/material.dart';

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

  List<String> passedLevel(bool win) {
    if (win) {
      return ['Поздравляю с успешной доставкой', 'Ты настоящий роллеркостер вкусовых ощущений'];
    } else {
      return [
        'Негодник, ты подвёл меня и всю семью, ${isFreeze! ? "freezed!" : "burn!"}',
        'Мы несколько раз подумаем, прежде чем заказывать у вас снова',
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white.withOpacity(0.4),
      title: Text(
        passedLevel(isWinning)[0],
        style: TextStyle(color: Colors.white),
      ),
      content: Column(
        children: [
          // Text(passedLevel(isWinning)[1]),
          // SizedBox(height: 20,),
          Image.asset(
            'assets/images/food/$image.png',
            height: 180,
            width: 180,
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
            isWinning ? 'Далее' : 'Переиграть',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
