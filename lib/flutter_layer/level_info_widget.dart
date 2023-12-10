import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/game_stats/game_stats_bloc.dart';

class LevelInfo extends StatelessWidget {
  const LevelInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameStatsBloc, GameStatsState>(builder: (context, state) {
      return AnimatedContainer(
        height: 50,
        padding: const EdgeInsets.all(10),
        color: Colors.orange,
        duration: const Duration(milliseconds: 400),
        child: Text("Level ${state.level}"),
      );
    });
  }
}
