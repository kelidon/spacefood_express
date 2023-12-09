import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../flame_layer/spacefood_game.dart';

class PlanetComponent extends SpriteAnimationComponent
    with HasGameReference<SpaceFoodGame>, CollisionCallbacks {
  PlanetComponent(double x, double y) : super(position: Vector2(x, y), size: Vector2.all(25)) {
    add(RectangleHitbox(collisionType: CollisionType.passive));
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = await game.loadSpriteAnimation(
      'planet.png',
      SpriteAnimationData.sequenced(
        stepTime: 0.2,
        amount: 4,
        textureSize: Vector2.all(16),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (y >= game.size.y) {
      removeFromParent();
    }
  }
}
