import 'package:fightcovid/fcovid19-game.dart';
import 'package:fightcovid/components/covid19.dart';

class Covid19Spawner {
  final Fcovid19Game game;
  final int maxSpawnInterval = 3000;
  final int minSpawnInterval = 250;
  final int intervalChange = 3;
  final int maxFliesOnScreen = 7;

  int currentInterval;
  int nextSpawn;

  Covid19Spawner(this.game) {
    start();
    game.spawnCovid19();
  }

  void start() {
    killAll();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void killAll() {
    game.covid19s.forEach((Covid19 covid19) => covid19.isDead = true);
  }

  void update(double t) {
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

    int livingFlies = 0;
    game.covid19s.forEach((Covid19 covid19) {
      if (!covid19.isDead) livingFlies += 1;
    });

    if (nowTimestamp >= nextSpawn && livingFlies < maxFliesOnScreen) {
      game.spawnCovid19();
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * .02).toInt();
      }
      nextSpawn = nowTimestamp + currentInterval;
    }
  }
}
