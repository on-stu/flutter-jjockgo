import 'dart:math';

import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:jjockgo/components/background.dart';
import 'package:jjockgo/components/gameover_modal.dart';
import 'package:jjockgo/components/score.dart';
import 'package:jjockgo/components/start_button.dart';
import 'package:jjockgo/components/title.dart';
import 'package:jjockgo/constants/game_status.dart';
import 'components/chur.dart';
import 'components/cat.dart';

GameStatus gameStatus = GameStatus.ready;

class MyGame extends FlameGame
    with HasTappableComponents, HasCollisionDetection {
  late Cat cat;
  late Chur upChur;
  late Chur downChur;
  late Title title;
  late StartButton startButton;
  late GameOverModal gameOverModal;
  int score = 0;
  List<Score> scores = [];
  bool shouldRenderScores = true;

  @override
  void update(double dt) {
    super.update(dt);
    if (gameStatus == GameStatus.playing && cat.position.y > size.y) {
      gameOver();
    } else if (gameStatus == GameStatus.playing && cat.position.y < 0) {
      gameOver();
    }

    if (gameStatus == GameStatus.playing &&
        upChur.position.x > cat.position.x) {
      shouldRenderScores = true;
    }

    if (gameStatus == GameStatus.playing &&
        upChur.position.x <= cat.position.x &&
        shouldRenderScores) {
      score++;
      shouldRenderScores = false;
      renderScores();
    }

    if (upChur.position.x <= -size.x) {
      score++;
      // get new pair of churs yLevel
      final churYLevelPair = getChursYLevelPair();
      upChur.setYLevel(churYLevelPair[0]);
      downChur.setYLevel(churYLevelPair[1]);
      // reset churs position
      upChur.goToStart();
      downChur.goToStart();
    }
  }

  void renderScores() async {
    removeScores();
    scores = await Score.getList(size, score);
    for (Score score in scores) {
      add(score);
    }
  }

  void removeScores() {
    for (Score score in scores) {
      score.removeFromParent();
    }
    scores = [];
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    shouldRenderScores = true;
    score = 0;
    scores = await Score.getList(size, score);
    if (gameStatus == GameStatus.playing) {
      renderScores();
    }
    final backgrounds = await BackGround.getList(size);
    for (BackGround background in backgrounds) {
      add(background);
    }

    title = await Title.get(size);
    add(title);

    startButton = await StartButton.get(size, start);
    add(startButton);

    cat = await Cat.get(size);
    add(cat);

    final churYLevelPair = getChursYLevelPair();
    upChur = await Chur.get(size, churYLevelPair[0], gameOver);
    downChur = await Chur.get(size, churYLevelPair[1], gameOver);
    add(upChur);
    add(downChur);

    gameOverModal = await GameOverModal.get(size, onRestart);
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);

    cat.jump();
  }

  void onRestart() {
    gameStatus = GameStatus.ready;
    score = 0;
    scores = [];
    add(title);
    shouldRenderScores = true;
    onLoad();
  }

  List<int> getChursYLevelPair() {
    final random = Random();
    final upChurYLevel = random.nextInt(4) - 4;
    final downChurYLevel = upChurYLevel + 5;
    return [upChurYLevel, downChurYLevel];
  }

  void start() {
    gameStatus = GameStatus.playing;
    title.removeFromParent();
    startButton.removeFromParent();
    renderScores();
  }

  void gameOver() {
    gameStatus = GameStatus.gameOver;
    add(gameOverModal);
    FlameAudio.play('hit.wav', volume: 0.5);
  }
}
