import 'dart:math';

import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flamegame/game_manager.dart';
import 'package:flutter/cupertino.dart';

class Enemy extends SpriteAnimationComponent with HasGameRef<GameManager> {
  final VoidCallback onEnemiesTouch;
  final double _speed = 250;

  Enemy(this.onEnemiesTouch);

  @override
  Future<void>? onLoad() async {
    var spritePlayer = SpriteSheet(
        image: await Images().load('enemy.png'), srcSize: Vector2(16.0, 16.0));
    animation = spritePlayer.createAnimation(row: 0, stepTime: 0.2);
    var size = 40.0;
    position = Vector2(
        Random()
            .nextInt((gameRef.size.toRect().width - size).toInt())
            .toDouble(),
        size);
    width = size;
    height = size;
    anchor = Anchor.center;
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
      //removeHitbox(hitboxRectangle);
    }
  }
}
