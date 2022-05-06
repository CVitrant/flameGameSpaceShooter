import 'package:flame/assets.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flamegame/game/health.dart';
import 'package:flamegame/game/enemies.dart';
import 'package:flamegame/game/weapon.dart';
import 'package:flamegame/game_manager.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<GameManager>, CollisionCallbacks {
  final Function(Vector2) onPlayerHeal;
  final Function(Vector2) onPlayerCollision;
  final Function(Vector2) onPlayerWeaponUp;
  var hitboxRectangle = RectangleHitbox();

  Player(this.onPlayerCollision, this.onPlayerHeal, this.onPlayerWeaponUp);

  @override
  Future<void>? onLoad() async {
    var spritePlayer = SpriteSheet(
        image: await Images().load('player.png'), srcSize: Vector2(32.0, 48.0));
    animation = spritePlayer.createAnimation(row: 0, stepTime: 0.2);
    position = gameRef.size / 2;
    width = 80;
    height = 120;
    anchor = Anchor.center;

    add(hitboxRectangle);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Enemy) {
      onPlayerCollision.call(other.position);
    }
    if (other is Health) {
      onPlayerHeal.call(other.position);
    }
    if (other is Weapon) {
      onPlayerWeaponUp.call(other.position);
    }
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}
