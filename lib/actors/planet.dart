import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

import '../flame_layer/spacefood_game.dart';

class PlanetComponent extends SpriteAnimationComponent
    with HasGameReference<SpaceFoodGame>, CollisionCallbacks {
  PlanetComponent(
    this.radius,
    this.xCenter,
    this.yCenter,
    this.dAngle,
    this.height,
    this.width,
  ) : super(position: Vector2(xCenter, yCenter), size: Vector2.all(25)) {
    add(RectangleHitbox(collisionType: CollisionType.passive));
  }

  final double radius;
  final double xCenter;
  final double yCenter;
  final double dAngle;
  @override
  final double height;
  @override
  final double width;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = await game.loadSpriteAnimation(
      'reign.png',
      SpriteAnimationData.sequenced(
        stepTime: 0.2,
        amount: 4,
        textureSize: Vector2(512.25, 417),
      ),
    );
    size = Vector2(height, width);
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (y >= game.size.y) {
      removeFromParent();
    }
  }
}
