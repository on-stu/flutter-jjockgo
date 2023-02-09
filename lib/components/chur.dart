import 'package:flame/components.dart';
import 'package:jjockgo/constants/game_status.dart';
import '../game.dart';

class Chur extends SpriteComponent {
  late int yLevel;
  late double yPosition;
  double deviceHeight;
  Chur(Vector2 size, Sprite sprite, this.deviceHeight)
      : super(size: size, sprite: sprite);

  static Future<Chur> get(Vector2 deviceSize, int yLevel) async {
    final sprite = await Sprite.load('chur.png');
    final chur = Chur(Vector2(100, deviceSize.y), sprite, deviceSize.y);
    chur.yLevel = yLevel;
    chur.yPosition = chur.getYposition(yLevel, deviceSize.y);
    return chur;
  }

  @override
  void onMount() {
    super.onMount();
    goToStart();
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
    position = Vector2.array([size.y - 10, yPosition]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameStatus != GameStatus.playing) return;

    position = Vector2.array([position.x - 7, yPosition]);
  }
}
