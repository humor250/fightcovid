import 'dart:math';
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:fightcovid/components/covid19.dart';
import 'package:fightcovid/view.dart';

class Callout {
  final Covid19 covid19;
  Rect rect;
  Sprite sprite;
  double value;

  TextPainter tp;
  TextStyle textStyle;
  Offset textOffset;

  Callout(this.covid19) {
    sprite = Sprite('ui/callout.png');
    value = 1;
    tp = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textStyle = TextStyle(
      color: Color(0xff000000),
      fontSize: 15,
    );
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
    tp.paint(c, textOffset);
  }

  void resize() {
    rect = Rect.fromLTWH(
      covid19.covid19Rect.left - (covid19.game.tileSize * .25),
      covid19.covid19Rect.top - (covid19.game.tileSize * .5),
      covid19.game.tileSize * .75,
      covid19.game.tileSize * .75,
    );
  }

  void update(double t) {
    if (covid19.game.activeView == View.playing) {
      value = value - .5 * t;
      if (value <= 0) {
        if (covid19.game.soundButton.isEnabled) {
          Flame.audio.play('sfx/haha' +
              (covid19.game.random.nextInt(5) + 1).toString() +
              '.mp3');
          covid19.game.playHomeBGM();
        }
        covid19.game.activeView = View.lost;
      }
    }
    resize();

    tp.text = TextSpan(
      text: (value * 10).toInt().toString(),
      style: textStyle,
    );
    tp.layout();
    textOffset = Offset(
      rect.center.dx - (tp.width / 2),
      rect.top + (rect.height * .4) - (tp.height / 2),
    );
  }
}
