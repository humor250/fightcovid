import 'dart:math';
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:fightcovid/components/backyard.dart';
import 'package:fightcovid/components/covid19.dart';
import 'package:fightcovid/components/house-fly.dart';
import 'package:fightcovid/components/agile-fly.dart';
import 'package:fightcovid/components/drooler-fly.dart';
import 'package:fightcovid/components/hungry-fly.dart';
import 'package:fightcovid/components/macho-fly.dart';
import 'package:fightcovid/view.dart';
import 'package:fightcovid/views/home-view.dart';
import 'package:fightcovid/components/start-button.dart';
import 'package:fightcovid/views/lost-view.dart';
import 'package:fightcovid/controllers/spawner.dart';
import 'package:fightcovid/components/credit-button.dart';
import 'package:fightcovid/components/help-button.dart';
import 'package:fightcovid/components/highscoredisplay.dart';
import 'package:fightcovid/components/music-button.dart';
import 'package:fightcovid/components/sound-button.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fightcovid/views/help-view.dart';
import 'package:fightcovid/views/credit-view.dart';
import 'package:fightcovid/components/score-display.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Fcovid19Game extends Game {
  final SharedPreferences sp;

  Size screenSize;
  double tileSize;
  Random random;

  Backyard background;
  List<Covid19> covid19s;
  StartButton startButton;
  HelpButton helpButton;
  CreditButton creditButton;
  MusicButton musicButton;
  SoundButton soundButton;
  AudioPlayer homeBGM;
  AudioPlayer playingBGM;

  ScoreDisplay scoreDisplay;
  HighscoreDisplay highscoreDisplay;

  Covid19Spawner spawner;

  View activeView = View.home;
  HomeView homeView;
  LostView lostView;
  HelpView helpView;
  CreditView creditView;

  int score;

  Fcovid19Game(this.sp) {
    initialize();
  }

  Future<void> initialize() async {
    random = Random();
    covid19s = List<Covid19>();
    score = 0;
    resize(await Flame.util.initialDimensions());

    background = Backyard(this);
    startButton = StartButton(this);
    helpButton = HelpButton(this);
    creditButton = CreditButton(this);
    musicButton = MusicButton(this);
    soundButton = SoundButton(this);
    scoreDisplay = ScoreDisplay(this);
    highscoreDisplay = HighscoreDisplay(this);
    spawner = Covid19Spawner(this);
    homeView = HomeView(this);
    lostView = LostView(this);
    helpView = HelpView(this);
    creditView = CreditView(this);

    homeBGM = await Flame.audio.loopLongAudio('bgm/home.mp3', volume: .25);
    homeBGM.pause();
    playingBGM =
        await Flame.audio.loopLongAudio('bgm/playing.mp3', volume: .25);
    playingBGM.pause();

    playHomeBGM();
  }

  void playHomeBGM() {
    playingBGM.pause();
    playingBGM.seek(Duration.zero);
    homeBGM.resume();
  }

  void playPlayingBGM() {
    homeBGM.pause();
    homeBGM.seek(Duration.zero);
    playingBGM.resume();
  }

  void spawnCovid19() {
    double x = random.nextDouble() * (screenSize.width - (tileSize * 1.35));
    double y =
        (random.nextDouble() * (screenSize.height - (tileSize * 2.025))) +
            (tileSize * 1.5);
    switch (random.nextInt(5)) {
      case 0:
        covid19s.add(HouseFly(this, x, y));
        break;
      case 1:
        covid19s.add(DroolerFly(this, x, y));
        break;
      case 2:
        covid19s.add(AgileFly(this, x, y));
        break;
      case 3:
        covid19s.add(MachoFly(this, x, y));
        break;
      case 4:
        covid19s.add(HungryFly(this, x, y));
        break;
    }
  }

  void render(Canvas canvas) {
    background.render(canvas);
    highscoreDisplay.render(canvas);

    if (activeView == View.playing || activeView == View.lost) {
      scoreDisplay.render(canvas);
    }
    covid19s.forEach((Covid19 covid19) => covid19.render(canvas));
    if (activeView == View.home) homeView.render(canvas);
    if (activeView == View.lost) lostView.render(canvas);
    if (activeView == View.home || activeView == View.lost) {
      startButton.render(canvas);
      helpButton.render(canvas);
      creditButton.render(canvas);
    }
    musicButton.render(canvas);
    soundButton.render(canvas);

    if (activeView == View.help) helpView.render(canvas);
    if (activeView == View.credits) creditView.render(canvas);
  }

  void update(double t) {
    spawner.update(t);
    covid19s.forEach((Covid19 covid19) => covid19.update(t));
    covid19s.removeWhere((Covid19 covid19) => covid19.isOffScreen);
    if (activeView == View.playing) scoreDisplay.update(t);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    // Popup Windows
    if (!isHandled) {
      if (activeView == View.help || activeView == View.credits) {
        activeView = View.home;
        isHandled = true;
      }
    }

    // music button
    if (!isHandled && musicButton.rect.contains(d.globalPosition)) {
      musicButton.onTapDown();
      isHandled = true;
    }

    // sound button
    if (!isHandled && soundButton.rect.contains(d.globalPosition)) {
      soundButton.onTapDown();
      isHandled = true;
    }

    // Help Button
    if (!isHandled && helpButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        helpButton.onTapDown();
        isHandled = true;
      }
    }

    // Credit Button
    if (!isHandled && creditButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        creditButton.onTapDown();
        isHandled = true;
      }
    }

    // Start Button
    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        startButton.onTapDown();
        isHandled = true;
      }
    }

    if (!isHandled) {
      bool didHitACovid19 = false;
      covid19s.forEach((Covid19 covid19) {
        if (covid19.covid19Rect.contains(d.globalPosition)) {
          covid19.onTapDown();
          isHandled = true;
          didHitACovid19 = true;
        }
      });
      if (activeView == View.playing && !didHitACovid19) {
        if (soundButton.isEnabled) {
          Flame.audio
              .play('sfx/haha' + (random.nextInt(5) + 1).toString() + '.mp3');
        }
        //BGM.play(BGMType.home);
        playHomeBGM();
        activeView = View.lost;
      }
    }
  }
}
