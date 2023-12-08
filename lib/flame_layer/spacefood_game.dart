import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';

import '../actors/player.dart';
import '../blocs/game_stats/game_stats_bloc.dart';
import '../blocs/inventory/inventory_bloc.dart';

class GameStatsController extends Component with HasGameReference<SpaceFoodGame> {
  @override
  Future<void>? onLoad() async {
    add(
      FlameBlocListener<GameStatsBloc, GameStatsState>(
        listenWhen: (previousState, newState) {
          return previousState.status != newState.status && newState.status == GameStatus.initial;
        },
        onNewState: (state) {
          //game.removeWhere((element) => element is EnemyComponent);
        },
      ),
    );
  }
}

class SpaceFoodGame extends FlameGame {
  late PlayerComponent player;

  final GameStatsBloc statsBloc;
  final InventoryBloc inventoryBloc;

  SpaceFoodGame({required this.inventoryBloc, required this.statsBloc});

  @override
  Future<void> onLoad() async {
    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<GameStatsBloc, GameStatsState>.value(
            value: statsBloc,
          ),
          FlameBlocProvider<InventoryBloc, InventoryState>.value(
            value: inventoryBloc,
          ),
        ],
        children: [
          player = PlayerComponent(),
          PlayerController(),
          GameStatsController(),
        ],
      ),
    );
  }

  @override
  Color backgroundColor() => Colors.deepPurple;
}
