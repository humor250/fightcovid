import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:fightcovid/fcovid19-game.dart';
import 'package:fightcovid/view.dart';

class CreditButton {
  final Fcovid19Game game;
  Rect rect;
  Sprite sprite;

  CreditButton(this.game) {
    resize();
    sprite = Sprite('ui/icon-credits.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void resize() {
    rect = Rect.fromLTWH(
      game.screenSize.width - (game.tileSize * 1.25),
      game.screenSize.height - (game.tileSize * 1.25),
      game.tileSize,
      game.tileSize,
    );
  }

  void onTapDown() {
    game.activeView = View.credits;
  }
}
