import 'package:flame/components.dart';
import 'package:flamegame/game_manager.dart';

class StartText extends TextComponent with HasGameRef<GameManager> {
  StartText(String text)
      : super(
          text: text,
          textRenderer: TextPaint(),
        );
}
