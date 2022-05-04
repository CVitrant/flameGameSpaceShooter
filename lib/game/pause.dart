import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flamegame/game_manager.dart';

class Pause extends SpriteComponent with HasGameRef<GameManager> {
  @override
  Future<void>? onLoad() async {
    var pauseButton = await Images().load('pause.png');
    sprite = Sprite(pauseButton);
    width = 40;
    height = 40;
  }
}
