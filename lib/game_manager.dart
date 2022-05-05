// ignore_for_file: body_might_complete_normally_nullable

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flamegame/game/game_screen.dart';
import 'package:flamegame/main/main_screen.dart';
//import 'package:flutter/material.dart';

class GameManager extends FlameGame with HasCollisionDetection, PanDetector {
  late GameScreen _gameScreen;
  late MainScreen _mainScreen;

  GameManager() {
    _mainScreen = MainScreen(() {
      remove(_mainScreen);
      _gameScreen = GameScreen();
      add(_gameScreen);
    });
  }

  @override
  Future<void>? onLoad() {
    add(_mainScreen);
  }
/*
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      GameManager().paused = true;
    } else {
      print(state.toString());
    }
  }
*/

  @override
  void onPanStart(DragStartInfo info) {
    super.onPanStart(info);
    _mainScreen.onPanStart(info);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    super.onPanUpdate(info);
    _gameScreen.onPanUpdate(info);
  }

  void endGame(int score) {
    remove(_gameScreen);
    _mainScreen.setScore(score);
    add(_mainScreen);
  }
}
