// ignore_for_file: body_might_complete_normally_nullable

import 'package:flame/components.dart';
import 'package:flamegame/common/star.dart';
import 'package:flamegame/game_manager.dart';

class Background extends Component with HasGameRef<GameManager> {
  int nbStars;
  Background(this.nbStars);

  @override
  Future<void>? onLoad() {
    for (int i = 0; i < nbStars; i++) {
      add(Star());
    }
  }
}
