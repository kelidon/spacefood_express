import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/services.dart';
import 'package:spacefood_express/actors/planet.dart';
import 'package:spacefood_express/blocs/game_stats/game_stats_bloc.dart';
import 'package:spacefood_express/blocs/inventory/inventory_bloc.dart';
import 'package:spacefood_express/flame_layer/spacefood_game.dart';

class PlayerController extends Component
    with HasGameReference<SpaceFoodGame>, FlameBlocListenable<GameStatsBloc, GameStatsState> {
  @override
  bool listenWhen(GameStatsState previousState, GameStatsState newState) {
    return previousState.status != newState.status;
  }

  @override
  void onNewState(GameStatsState state) {
    if (state.status == GameStatus.respawn || state.status == GameStatus.initial) {
      game.statsBloc.add(const PlayerRespawned());
      // parent?.add(
      //   game.player = PlayerComponent(
      //     PlanetComponent(
      //       20,
      //       105,
      //       505,
      //       -0.05,
      //       100,
      //       100,
      //       PlanetType.normal,
      //     ),
      //   ),
      // );
    }
  }
}

class PlayerComponent extends SpriteAnimationComponent
    with
        HasGameReference<SpaceFoodGame>,
        CollisionCallbacks,
        KeyboardHandler,
        FlameBlocListenable<InventoryBloc, InventoryState> {
  bool destroyed = false;
  bool isFlying = false;

  PlanetComponent planet;

  late double dY;
  late double dX;

  PlayerComponent(this.planet) : super(size: Vector2(50, 75), position: Vector2(100, 500)) {
    add(RectangleHitbox());
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = await game.loadSpriteAnimation(
      'player.png',
      SpriteAnimationData.sequenced(
        stepTime: 0.2,
        amount: 4,
        textureSize: Vector2(32, 48),
      ),
    );
  }

  InventoryState? state;

  @override
  void onNewState(InventoryState state) {
    this.state = state;
  }

  void move(double deltaX, double deltaY) {
    x += deltaX;
    y += deltaY;
  }

  void _circle() {
    double t = atan2(y - planet.yCenter, x - planet.xCenter);

    x = planet.xCenter + planet.radius * cos(t + planet.dAngle);
    y = planet.yCenter + planet.radius * sin(t + planet.dAngle);
  }

  void liftoff() {
    isFlying = true;

    double t = atan2(y - planet.yCenter, x - planet.xCenter);
    dX = -x + planet.xCenter + planet.radius * cos(t + planet.dAngle);
    dY = -y + planet.yCenter + planet.radius * sin(t + planet.dAngle);

    angle = t;
  }

  void _flyAway() {
    x += dX;
    y += dY;
  }

  ///
  void hitPlanet(
    PlanetComponent planetComponent,
  ) {
    isFlying = false;
    planet = planetComponent;

    //todo
    // game.levelScene.currentLevel.resetLevel();
    // game.statsBloc.add(NextLevel());
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isFlying) {
      _flyAway();
    } else {
      _circle();
    }

    if (destroyed) {
      removeFromParent();
    }
  }

  @override
  bool onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (keysPressed.contains(LogicalKeyboardKey.tab)) {
      //todo

      return true;
    }
    return false;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is PlanetComponent && isFlying) {
      hitPlanet(other);
    }
  }
}
