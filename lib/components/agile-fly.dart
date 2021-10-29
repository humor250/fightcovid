import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:fightcovid/components/covid19.dart';
import 'package:fightcovid/fcovid19-game.dart';

class AgileFly extends Covid19 {
  double get speed => game.tileSize * 5;

  AgileFly(Fcovid19Game game, double x, double y) : super(game) {
    covid19Rect = Rect.fromLTWH(x, y, game.tileSize * 1, game.tileSize * 1);
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('covid19s/agile-fly-1.png'));
    flyingSprite.add(Sprite('covid19s/agile-fly-2.png'));
    deadSprite = Sprite('covid19s/agile-fly-dead.png');
  }
}
