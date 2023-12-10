import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:spacefood_express/flame_layer/levels_scene.dart';

import '../blocs/compass/compass_cubit.dart';
import '../blocs/game_stats/game_stats_bloc.dart';
import '../blocs/inventory/inventory_bloc.dart';
import '../utils/audio_manager.dart';

class GameStatsController extends Component
    with HasGameReference<SpaceFoodGame> {
  @override
  Future<void>? onLoad() async {
    add(
      FlameBlocListener<GameStatsBloc, GameStatsState>(
        listenWhen: (previousState, newState) {
          return previousState.status != newState.status &&
              newState.status == GameStatus.initial;
        },
        onNewState: (state) {
          //game.removeWhere((element) => element is EnemyComponent);
        },
      ),
    );
  }
}

class SpaceFoodGame extends FlameGame
    with PanDetector, HasCollisionDetection, HasKeyboardHandlerComponents {
  TiledComponent? mapComponent;

  final GameStatsBloc statsBloc;
  final InventoryBloc inventoryBloc;
  final CompassCubit compassCubit;

  SpaceFoodGame({
    required this.inventoryBloc,
    required this.statsBloc,
    required this.compassCubit,
  });

  late LevelsScene levelScene;

  @override
  Future<void> onLoad() async {
    //debug camera
    //camera.viewport = FixedResolutionViewport(resolution: Vector2(2000, 2000));

    //load map
    const double zoom = 1;
    camera.viewfinder.zoom = zoom;
    mapComponent = await TiledComponent.load('testmap.tmx', Vector2.all(32));

    //set bounds for the camera
    final cameraVisibleArea = Rectangle.fromLTRB(
      camera.viewport.size.x / 2,
      camera.viewport.size.y / 2,
      mapComponent!.size.x - camera.viewport.size.x / 2,
      mapComponent!.size.y - camera.viewport.size.y / 2,
    );
    camera.setBounds(cameraVisibleArea, considerViewport: false);

    levelScene = LevelsScene();
    await world.add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<GameStatsBloc, GameStatsState>.value(
            value: statsBloc,
          ),
          FlameBlocProvider<InventoryBloc, InventoryState>.value(
            value: inventoryBloc,
          ),
          FlameBlocProvider<CompassCubit, CompassState>.value(
            value: compassCubit,
          ),
        ],
        children: [mapComponent!, levelScene],
      ),
    );
    await add(world);
    statsBloc.state.level;
    AudioManager.playBackgroundMusic(
      Sounds.fromLevel(1),
    );
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    //set bounds if resized
    if (mapComponent != null) {
      if (camera.viewfinder.firstChild<BoundedPositionBehavior>() != null) {
        final cameraVisibleArea = Rectangle.fromRect(
          Rect.fromLTRB(
            camera.viewport.size.x / 2,
            camera.viewport.size.y / 2,
            mapComponent!.size.x - camera.viewport.size.x / 2,
            mapComponent!.size.y - camera.viewport.size.y / 2,
          ),
        );
        camera.setBounds(cameraVisibleArea, considerViewport: false);
      }
    }
  }

  @override
  Color backgroundColor() => Colors.deepPurple;

  @override
  void onPanDown(DragDownInfo info) {
    if (!levelScene.currentLevel.player.isFlying) {
      levelScene.currentLevel.player.liftoff();
    }
  }

  void resetLevel(GameStatsEvent event) {
    levelScene.currentLevel.resetPlayer();
    statsBloc.add(event);
  }
}
