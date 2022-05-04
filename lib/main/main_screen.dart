// ignore_for_file: body_might_complete_normally_nullable, implementation_imports

import 'package:flame/components.dart';
import 'package:flame/src/gestures/events.dart';
import 'package:flamegame/common/background.dart';
import 'package:flamegame/game_manager.dart';
import 'package:flamegame/main/text.dart';

class MainScreen extends Component with HasGameRef<GameManager> {
  final Function _onStartClicked;
  late TextComponent _scoreText;
  int bestScore = 0;
  MainScreen(this._onStartClicked);

  @override
  Future<void>? onLoad() {
    add(Background(40));
    add(StartText('TAP TO START')
      ..anchor = Anchor.center
      ..position = (gameRef.size / 2));

    _scoreText = TextComponent(
      text: "Score: 0",
      position: Vector2(gameRef.size.toRect().width / 2, 10),
      anchor: Anchor.topCenter,
    );

    add(_scoreText);
  }

  void onPanStart(DragStartInfo info) {
    if (isMounted) _onStartClicked();
  }

  void setScore(int score) {
    if (score > bestScore) {
      bestScore = score;
    }
    _scoreText.text = "Meilleur score : $bestScore";
  }
}
