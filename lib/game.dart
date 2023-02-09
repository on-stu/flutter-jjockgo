import 'dart:math';

import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:jjockgo/components/background.dart';
import 'package:jjockgo/components/title.dart';
import 'package:jjockgo/constants/game_status.dart';
import 'components/chur.dart';
import 'components/cat.dart';

GameStatus gameStatus = GameStatus.ready;

class MyGame extends FlameGame with HasTappableComponents {
  late Cat cat;
  late Chur upChur;
  late Chur downChur;
  late Title title;

  @override
  void update(double dt) {
    super.update(dt);
    if (cat.position.y > size.y) {
      gameStatus = GameStatus.gameOver;
    } else if (cat.position.y < 0) {
      gameStatus = GameStatus.gameOver;
    }

    if (upChur.position.x <= -size.x) {
      // get new pair of churs yLevel
      final churYLevelPair = getChursYLevelPair();
      upChur.setYLevel(churYLevelPair[0]);
      downChur.setYLevel(churYLevelPair[1]);
      // reset churs position
      upChur.goToStart();
      downChur.goToStart();
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final backgrounds = await BackGround.getList(size);
    for (BackGround background in backgrounds) {
      add(background);
    }

    title = await Title.get(size);
    add(title);
    cat = await Cat.get(size);
    final churYLevelPair = getChursYLevelPair();
    upChur = await Chur.get(size, churYLevelPair[0]);
    downChur = await Chur.get(size, churYLevelPair[1]);
    add(cat);
    add(upChur);
    add(downChur);
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (gameStatus == GameStatus.ready) {
      gameStatus = GameStatus.playing;
      removeAll([cat]);
      onLoad();
    }
    if (gameStatus == GameStatus.gameOver) {
      gameStatus = GameStatus.ready;
      removeAll([cat]);
      onLoad();
    }
    cat.jump();
  }

  // get pair of churs yLevel
  // yLevel for upChur can be -4 ~ -1
  // yLevel for downChur can be 1 ~ 4
  // available pairs are (-4, 1), (-3, 2), (-2, 3), (-1, 4)
  // so get random pair from this list
  List<int> getChursYLevelPair() {
    final random = Random();
    final upChurYLevel = random.nextInt(4) - 4;
    final downChurYLevel = upChurYLevel + 5;
    return [upChurYLevel, downChurYLevel];
  }
}
