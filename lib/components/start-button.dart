import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:fightcovid/fcovid19-game.dart';
import 'package:fightcovid/view.dart';

class StartButton {
  final Fcovid19Game game;
  Rect rect;
  Sprite sprite;

  StartButton(this.game) {
    resize();
    sprite = Sprite('ui/start-button.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}

  void resize() {
    rect = Rect.fromLTWH(
      game.tileSize * 2,
      (game.screenSize.height * 0.9) - (game.tileSize * 1.5),
      game.tileSize * 5,
      game.tileSize * 2,
    );
  }

  void onTapDown() {
    game.activeView = View.playing;
    game.spawner.start();
    game.score = 0;
    game.playPlayingBGM();
  }
}
