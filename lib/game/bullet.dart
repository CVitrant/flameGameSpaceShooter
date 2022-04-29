import 'package:flame/components.dart';
import 'package:flamegame/game_manager.dart';

class Bullet extends SpriteComponent with HasGameRef<GameManager> {
  final double _speed = 450;

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('bullet.png');
    width = 32;
    height = 16;

    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, -1) * _speed * dt;

    if (position.y < 0) {
      removeFromParent();
    }
  }
}
