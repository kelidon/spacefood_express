import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:spacefood_express/actors/models/planet_type.dart';
import 'package:spacefood_express/actors/planet.dart';

import '../actors/player.dart';
import '../blocs/game_stats/game_stats_bloc.dart';
import '../blocs/inventory/inventory_bloc.dart';

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
  late PlayerComponent player;
  TiledComponent? mapComponent;

  final GameStatsBloc statsBloc;
  final InventoryBloc inventoryBloc;

  SpaceFoodGame({
    required this.inventoryBloc,
    required this.statsBloc,
  });

  @override
  Future<void> onLoad() async {
    //debug camera
    camera.viewport = FixedResolutionViewport(resolution: Vector2(2000, 2000));

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

    List<PlanetComponent> allPlanets = [];

    final objectGroup = mapComponent!.tileMap.getLayer<ObjectGroup>('planets');
    for (final object in objectGroup!.objects) {
      PlanetType planetType;
      Property? property = object.properties.byName['type'];
      if (property != null) {
        planetType = PlanetType.fromString(property.value);
      } else {
        planetType = PlanetType.normal;
      }
      allPlanets.add(
        PlanetComponent(
          object.height / 1.1,
          object.x,
          object.y,
          -0.02,
          object.height,
          object.width,
          planetType,
        ),
      );
    }

    player = PlayerComponent(
      allPlanets.firstWhere(
        (e) => e.planetType == PlanetType.spawn,
      ),
    );

    //center player relative to the camera;
    player.anchor = Anchor.center;

    //obviously;
    camera.follow(player);

    await world.add(
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
          mapComponent!,
          player,
        ],
      ),
    );
    world.addAll(allPlanets);
    await add(world);
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
  void update(double dt) {
    super.update(dt);
    //stop player when reach bounds
    if (mapComponent != null) {
      player.position = Vector2(
        player.position.x.clamp(0, mapComponent!.size.x),
        player.position.y.clamp(0, mapComponent!.size.y),
      );
    }
  }

  @override
  Color backgroundColor() => Colors.deepPurple;

  @override
  void onPanStart(_) {
    //player.beginFire();
  }

  @override
  void onPanEnd(_) {
    //player.stopFire();
  }

  @override
  void onPanCancel() {
    //player.stopFire();
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    //player.move(info.delta.global.x, info.delta.global.y);
  }

  @override
  void onPanDown(DragDownInfo info) {
    if (!player.isFlying) {
      player.liftoff();
    }
  }

  void increaseScore() {
    statsBloc.add(const ScoreEventAdded(100));
  }
}
