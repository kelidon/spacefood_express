import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/game_stats/game_stats_bloc.dart';
import 'blocs/inventory/inventory_bloc.dart';
import 'flame_layer/spacefood_game.dart';
import 'flutter_layer/temperature_info_widget.dart';

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
    );
  }
}


class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        //GameStat(),
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(child: Game()),

              //todo - extra info on game screen
              Positioned(top: 50, right: 10, child: TemperatureInfo()),

              /// perfect ->  Stack(children: [FlameLayer(), FlutterLayer())
            ],
          ),
        ),
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
