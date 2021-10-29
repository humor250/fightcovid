import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:fightcovid/components/covid19.dart';
import 'package:fightcovid/fcovid19-game.dart';

class MachoFly extends Covid19 {
  double get speed => game.tileSize * 2.5;

  MachoFly(Fcovid19Game game, double x, double y) : super(game) {
    covid19Rect =
        Rect.fromLTWH(x, y, game.tileSize * 1.35, game.tileSize * 1.35);
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('covid19s/macho-fly-1.png'));
    flyingSprite.add(Sprite('covid19s/macho-fly-2.png'));
    deadSprite = Sprite('covid19s/macho-fly-dead.png');
  }
}
