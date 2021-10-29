import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fightcovid/bgm.dart';
import 'package:fightcovid/fcovid19-game.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  SharedPreferences sp = await SharedPreferences.getInstance();

  await Flame.images.loadAll(<String>[
    'bg/backyard.jpg',
    'covid19s/agile-fly-1.png',
    'covid19s/agile-fly-2.png',
    'covid19s/agile-fly-dead.png',
    'covid19s/drooler-fly-1.png',
    'covid19s/drooler-fly-2.png',
    'covid19s/drooler-fly-dead.png',
    'covid19s/house-fly-1.png',
    'covid19s/house-fly-2.png',
    'covid19s/house-fly-dead.png',
    'covid19s/hungry-fly-1.png',
    'covid19s/hungry-fly-2.png',
    'covid19s/hungry-fly-dead.png',
    'covid19s/macho-fly-1.png',
    'covid19s/macho-fly-2.png',
    'covid19s/macho-fly-dead.png',
    'bg/lose-splash.png',
    'branding/title.png',
    'ui/dialog-credits.png',
    'ui/dialog-help.png',
    'ui/icon-credits.png',
    'ui/icon-help.png',
    'ui/start-button.png',
    'ui/callout.png',
    'ui/icon-music-disabled.png',
    'ui/icon-music-enabled.png',
    'ui/icon-sound-disabled.png',
    'ui/icon-sound-enabled.png',
  ]);

  Flame.audio.disableLog();
  //await BGM.preload();
  await Flame.audio.loadAll([
    'sfx/haha1.mp3',
    'sfx/haha2.mp3',
    'sfx/haha3.mp3',
    'sfx/haha4.mp3',
    'sfx/haha5.mp3',
    'sfx/ouch1.mp3',
    'sfx/ouch2.mp3',
    'sfx/ouch3.mp3',
    'sfx/ouch4.mp3',
    'sfx/ouch5.mp3',
    'sfx/ouch6.mp3',
    'sfx/ouch7.mp3',
    'sfx/ouch8.mp3',
    'sfx/ouch9.mp3',
    'sfx/ouch10.mp3',
    'sfx/ouch11.mp3',
  ]);

  Fcovid19Game game = Fcovid19Game(sp);
  runApp(game.widget);
  SystemChrome.setEnabledSystemUIOverlays([]);
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);

  //WidgetsBinding.instance.addObserver(BGMHandler());
}
