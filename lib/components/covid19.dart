import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:fightcovid/fcovid19-game.dart';
import 'package:flame/sprite.dart';
import 'package:fightcovid/view.dart';
import 'package:fightcovid/components/callout.dart';

class Covid19 {
  final Fcovid19Game game;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;
  Rect covid19Rect;
  bool isDead = false;
  bool isOffScreen = false;
  Offset targetLocation;

  Callout callout;

  double get speed => game.tileSize * 3;

  Covid19(this.game) {
    callout = Callout(this);
    setTargetLocation();
  }

  void setTargetLocation() {
    double x = game.random.nextDouble() *
        (game.screenSize.width - (game.tileSize * 1.35));
    double y = (game.random.nextDouble() *
            (game.screenSize.height - (game.tileSize * 2.85))) +
        (game.tileSize * 1.5);
    targetLocation = Offset(x, y);
  }

  void render(Canvas c) {
    if (isDead) {
      deadSprite.renderRect(c, covid19Rect.inflate(covid19Rect.width / 2));
    } else {
      flyingSprite[flyingSpriteIndex.toInt()]
          .renderRect(c, covid19Rect.inflate(covid19Rect.width / 2));
      if (game.activeView == View.playing) {
        callout.render(c);
      }
    }
  }

  void update(double t) {
    if (isDead) {
      covid19Rect = covid19Rect.translate(0, game.tileSize * 12 * t);
      if (covid19Rect.top > game.screenSize.height) {
        isOffScreen = true;
      }
    } else {
      flyingSpriteIndex += 30 * t;
      while (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }

      double stepDistance = speed * t;
      Offset toTarget =
          targetLocation - Offset(covid19Rect.left, covid19Rect.top);
      if (stepDistance < toTarget.distance) {
        Offset stepToTarget =
            Offset.fromDirection(toTarget.direction, stepDistance);
        covid19Rect = covid19Rect.shift(stepToTarget);
      } else {
        covid19Rect = covid19Rect.shift(toTarget);
        setTargetLocation();
      }
      callout.update(t);
    }
  }

  void resize() {}

  void onTapDown() {
    if (!isDead) {
      if (game.soundButton.isEnabled) {
        Flame.audio.play(
            'sfx/ouch' + (game.random.nextInt(11) + 1).toString() + '.mp3');
      }
      isDead = true;
      if (game.activeView == View.playing) {
        game.score += 1;
        if (game.score > (game.sp.getInt('highscore') ?? 0)) {
          game.sp.setInt('highscore', game.score);
          game.highscoreDisplay.updateHighscore();
        }
      }
    }
  }
}
