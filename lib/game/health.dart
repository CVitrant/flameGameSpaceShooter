import 'dart:math';

import 'package:flame/assets.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flamegame/game/player.dart';

import 'package:flamegame/game_manager.dart';

class Health extends SpriteComponent
    with HasGameRef<GameManager>, CollisionCallbacks {
  final double _speed = 200;
  var hitboxRectangle = RectangleHitbox();
  @override
  Future<void>? onLoad() async {
    var spritePlayer = await Images().load('heart.png');
    var size = 30.0;
    sprite = Sprite(spritePlayer);
    position = Vector2(
        Random()
            .nextInt((gameRef.size.toRect().width - size).toInt())
            .toDouble(),
        size);
    width = size;
    height = size;
    anchor = Anchor.center;

    add(hitboxRectangle);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      removeFromParent();
      remove(hitboxRectangle);
    }
  }

  void move(Vector2 delta) {
    position.add(delta);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, 1) * _speed * dt;
    if (position.y > gameRef.size.y) {
      removeFromParent();
      remove(hitboxRectangle);
    }
  }
}
