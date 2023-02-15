import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:jjockgo/components/cat.dart';
import 'package:jjockgo/constants/game_status.dart';
import '../game.dart';

class Chur extends SpriteComponent with CollisionCallbacks {
  late int yLevel;
  late double yPosition;
  double deviceHeight;
  Function onGameOver;
  Chur(Vector2 size, Sprite sprite, this.deviceHeight, this.onGameOver)
      : super(size: size, sprite: sprite);

  static Future<Chur> get(
      Vector2 deviceSize, int yLevel, Function onGameOver) async {
    final sprite = await Sprite.load('chur.png');
    final chur =
        Chur(Vector2(100, deviceSize.y), sprite, deviceSize.y, onGameOver);
    chur.yLevel = yLevel;
    chur.yPosition = chur.getYposition(yLevel, deviceSize.y);
    return chur;
  }

  @override
  void onLoad() {
    super.onLoad();
    goToStart();
    add(RectangleHitbox());
  }

  getYposition(int yLevel, double deviceHeight) {
    final yLevelAbs = yLevel.abs();
    final unit = deviceHeight / 7;
    if (yLevel < 0) {
      return -deviceHeight + unit * yLevelAbs;
    } else if (yLevel > 0) {
      return deviceHeight - unit * yLevelAbs;
    }
  }

  setYLevel(int yLevel) {
    this.yLevel = yLevel;
    yPosition = getYposition(yLevel, deviceHeight);
  }

  goToStart() {
    position = Vector2.array([size.y - 5, yPosition]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameStatus == GameStatus.gameOver) {
      removeFromParent();
    }
    if (gameStatus != GameStatus.playing) return;

    position = Vector2.array([position.x - 5, yPosition]);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Cat) {
      onGameOver();
      other.removeFromParent();
    }
  }
}
