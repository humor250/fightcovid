import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:fightcovid/fcovid19-game.dart';
// import 'package:fightcovid/bgm.dart';

class MusicButton {
  final Fcovid19Game game;
  Rect rect;
  Sprite enabledSprite;
  Sprite disabledSprite;
  bool isEnabled = true;

  MusicButton(this.game) {
    resize();
    enabledSprite = Sprite('ui/icon-music-enabled.png');
    disabledSprite = Sprite('ui/icon-music-disabled.png');
  }

  void resize() {
    rect = Rect.fromLTWH(
      game.tileSize * .25,
      game.tileSize * .25,
      game.tileSize,
      game.tileSize,
    );
  }

  void render(Canvas c) {
    if (isEnabled) {
      enabledSprite.renderRect(c, rect);
    } else {
      disabledSprite.renderRect(c, rect);
    }
  }

  void onTapDown() {
    if (isEnabled) {
      isEnabled = false;
      game.homeBGM.setVolume(0);
      game.playingBGM.setVolume(0);
      // BGM.pause();
    } else {
      isEnabled = true;
      game.homeBGM.setVolume(.25);
      game.playingBGM.setVolume(.25);
      // BGM.resume();
    }
  }
}
