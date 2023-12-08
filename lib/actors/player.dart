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
  double speed = 10.0;


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

  @override
  void update(double dt) {
    super.update(dt);

    if (destroyed) {
      removeFromParent();
    }
  }

  // void takeHit() {
  //   game.add(ExplosionComponent(x, y));
  //   removeFromParent();
  //   game.statsBloc.add(const PlayerDied());
  // }

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
    // if (other is EnemyComponent) {
    //   takeHit();
    //   other.takeHit();
    // }
  }
}
