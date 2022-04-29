import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flamegame/game_manager.dart';
import 'package:flutter/cupertino.dart';

class Player extends SpriteAnimationComponent with HasGameRef<GameManager> {
  final VoidCallback onTouch;

  Player(this.onTouch);

  @override
  Future<void>? onLoad() async {
    var spritePlayer = SpriteSheet(
        image: await Images().load('player.png'), srcSize: Vector2(32.0, 48.0));
    animation = spritePlayer.createAnimation(row: 0, stepTime: 0.2);
    position = gameRef.size / 2;
    width = 80;
    height = 120;
    anchor = Anchor.center;
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}
