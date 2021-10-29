import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:fightcovid/fcovid19-game.dart';

class LostView {
  final Fcovid19Game game;
  Rect rect;
  Sprite sprite;

  LostView(this.game) {
    resize();
    sprite = Sprite('bg/lose-splash.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void resize() {
    rect = Rect.fromLTWH(
      game.tileSize * 1.5,
      (game.screenSize.height / 1.5) - (game.tileSize * 5),
      game.tileSize * 6,
      game.tileSize * 4,
    );
  }
}
