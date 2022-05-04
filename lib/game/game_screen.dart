// ignore_for_file: body_might_complete_normally_nullable, implementation_imports

import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/src/gestures/events.dart';
import 'package:flamegame/common/background.dart';
import 'package:flamegame/game/bullet.dart';
import 'package:flamegame/game/enemies.dart';
import 'package:flamegame/game/explosion.dart';
import 'package:flamegame/game/pause.dart';
import 'package:flamegame/game/player.dart';
import 'package:flamegame/game_manager.dart';

class GameScreen extends Component with HasGameRef<GameManager> {
  static const int playerLevelByScore = 20;
  late Player _player;
  late Pause _pauseButton;
  late Timer enemySpawn;
  late Timer bulletSpawn;
  int score = 0;
  int health = 3;

  @override
  Future<void>? onLoad() {
    enemySpawn = Timer(2, onTick: _spawnEnemy, repeat: true);
    bulletSpawn = Timer(1.5, onTick: _spawnBullet, repeat: true);
    add(Background(40));
    _player = Player(_onPlayerTouch);
    _pauseButton = Pause();
    add(_pauseButton);
    add(_player);
    add(_scoreText);
    add(_healthText);
  }

  final _scoreText = TextComponent(text: "Score: 0")
    ..position = Vector2(10, 10);

  final _healthText = TextComponent(text: "Health: 3")
    ..position = Vector2(10, 50);

  void _spawnBullet() {
    var bullet = Bullet();
    bullet.position = _player.position.clone();
    add(bullet);
  }

  void _spawnEnemy() {
    for (int i = 0; i <= min(score ~/ playerLevelByScore, 2); i++) {
      add(Enemy(_onEnemiesTouch));
    }
  }

  void _onPlayerTouch(Vector2 position) {
    health--;
    _healthText.text = 'Health: $health';
    if (health == 0) {
      gameRef.paused = true;
    }
  }

  void _onEnemiesTouch(Vector2 position) {
    var explosion = Explosion();
    explosion.position = position;
    add(explosion);
    score++;
    _scoreText.text = 'Score: $score';
  }

  @override
  void onMount() {
    super.onMount();
    enemySpawn.start();
    bulletSpawn.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    enemySpawn.update(dt);
    bulletSpawn.update(dt);
  }

  @override
  void onRemove() {
    super.onRemove();
    enemySpawn.stop();
    bulletSpawn.stop();
  }

  void onPanUpdate(DragUpdateInfo info) {
    if (isMounted) {
      _player.move(info.delta.game);
    }
  }
}
