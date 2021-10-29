import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:fightcovid/fcovid19-game.dart';

class CreditView {
  final Fcovid19Game game;
  Rect rect;
  Sprite sprite;

  CreditView(this.game) {
    resize();
    sprite = Sprite('ui/dialog-credits.png');
  }

  void resize() {
    rect = Rect.fromLTWH(
      game.tileSize * .5,
      (game.screenSize.height / 2) - (game.tileSize * 6),
      game.tileSize * 8,
      game.tileSize * 12,
    );
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }
}
