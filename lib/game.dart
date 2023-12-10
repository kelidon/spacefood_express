import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacefood_express/utils/audio_manager.dart';

import 'blocs/game_stats/game_stats_bloc.dart';
import 'blocs/inventory/inventory_bloc.dart';
import 'flame_layer/spacefood_game.dart';
import 'flutter_layer/flutter_layer.dart';
import 'flutter_layer/win_lose_alert.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<GameStatsBloc>(create: (_) => GameStatsBloc()),
          BlocProvider<InventoryBloc>(create: (_) => InventoryBloc()),
        ],
        child: const GameView(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(onPressed: () {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    const WinLoseAlert(isWinning: true));
            AudioManager.playSpecialEffects('pick.wav');
          }),
        ],
      ),
    );
  }
}

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned.fill(child: Game()),
        FlutterLayer(),
      ],
    );
  }
}

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: SpaceFoodGame(
        statsBloc: context.read<GameStatsBloc>(),
        inventoryBloc: context.read<InventoryBloc>(),
      ),
    );
  }
}
