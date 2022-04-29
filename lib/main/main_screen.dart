// ignore_for_file: body_might_complete_normally_nullable, implementation_imports

import 'package:flame/components.dart';
import 'package:flame/src/gestures/events.dart';
import 'package:flamegame/common/background.dart';
import 'package:flamegame/game_manager.dart';
import 'package:flamegame/main/text.dart';

class MainScreen extends Component with HasGameRef<GameManager> {
  final Function _onStartClicked;

  MainScreen(this._onStartClicked);

  @override
  Future<void>? onLoad() {
    add(Background(40));
    add(StartText('TAP TO START')
      ..anchor = Anchor.center
      ..position = (gameRef.size / 2));
  }

  void onPanStart(DragStartInfo info) {
    if (isMounted) _onStartClicked();
  }
}
