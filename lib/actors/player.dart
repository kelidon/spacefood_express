import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/services.dart';

import '../blocs/game_stats/game_stats_bloc.dart';
import '../blocs/inventory/inventory_bloc.dart';
import '../flame_layer/spacefood_game.dart';

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
      parent?.add(game.player = PlayerComponent());
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

  double dAngle = -0.05;

  //todo class
  double xc = 105;
  double yc = 512;
  double r = 13;

  late double dY;
  late double dX;

  PlayerComponent() : super(size: Vector2(50, 75), position: Vector2(100, 500)) {
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
    double t = atan2(y - yc, x - xc);

    x = xc + r * cos(t + dAngle);
    y = yc + r * sin(t + dAngle);
  }

  void liftoff() {
    isFlying = true;

    double t = atan2(y - yc, x - xc);
    dX = -x + xc + r * cos(t + dAngle);
    dY = -y + yc + r * sin(t + dAngle);
  }

  void _flyAway() {
    x += dX;
    y += dY;
  }

  ///
  void hitPlanet() {
    isFlying = false;
    xc = x + 21;
    yc = y - 20;
    r = 29;
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

    ///
    // if (other is PlanetComponent) {
    //   hitPlanet(other);
    // }
  }
}