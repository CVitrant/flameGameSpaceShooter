import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flamegame/game_manager.dart';
import 'package:flutter/painting.dart';

class StartText extends TextBoxComponent with HasGameRef<GameManager> {
  StartText(String text)
      : super(
            text: text,
            textRenderer: TextPaint(),
            boxConfig: TextBoxConfig(timePerChar: 0.05));

  @override
  void drawBackground(Canvas c) {
    Rect rect = Rect.fromLTWH(0, 0, width, height);
    c.drawRect(rect, Paint()..color = const Color.fromARGB(255, 79, 105, 160));
    c.drawRect(
      rect.deflate(double.infinity),
      BasicPalette.black.paint()..style = PaintingStyle.stroke,
    );
  }
}
