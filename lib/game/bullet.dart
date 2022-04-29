import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flamegame/game/enemies.dart';
import 'package:flamegame/game_manager.dart';

class Bullet extends SpriteComponent
    with HasGameRef<GameManager>, CollisionCallbacks {
  final double _speed = 450;
  var hitboxRectangle = RectangleHitbox();

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('bullet.png');
    width = 32;
    height = 16;

    anchor = Anchor.center;
    add(hitboxRectangle);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Enemy) {
      removeFromParent();
      remove(hitboxRectangle);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, -1) * _speed * dt;

    if (position.y < 0) {
      removeFromParent();
      remove(hitboxRectangle);
    }
  }
}
