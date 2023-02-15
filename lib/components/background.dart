import 'package:flame/components.dart';
import 'package:jjockgo/constants/game_status.dart';
import '../game.dart';

class BackGround extends SpriteComponent {
  late List<Sprite> sprites;

  BackGround(Vector2 size, Sprite sprite, Vector2 position)
      : super(size: size, sprite: sprite, position: position);

  static getList(Vector2 size) async {
    final baseSize = Vector2.array([size.y, size.y]);

    final sprite1 = await Sprite.load('background/1.png');
    final sprite2 = await Sprite.load('background/2.png');
    final sprite3 = await Sprite.load('background/3.png');
    final sprite4 = await Sprite.load('background/4.png');
    final sprite5 = await Sprite.load('background/5.png');

    final sprites = [];

    sprites.add(BackGround(baseSize, sprite1, Vector2.array([size.y * 0, 0])));
    sprites.add(BackGround(baseSize, sprite2, Vector2.array([size.y * 1, 0])));
    sprites.add(BackGround(baseSize, sprite3, Vector2.array([size.y * 2, 0])));
    sprites.add(BackGround(baseSize, sprite4, Vector2.array([size.y * 3, 0])));
    sprites.add(BackGround(baseSize, sprite5, Vector2.array([size.y * 4, 0])));
    sprites.add(BackGround(baseSize, sprite4, Vector2.array([size.y * 5, 0])));
    sprites.add(BackGround(baseSize, sprite3, Vector2.array([size.y * 6, 0])));
    sprites.add(BackGround(baseSize, sprite2, Vector2.array([size.y * 7, 0])));

    return sprites;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameStatus != GameStatus.playing) return;

    if (position.x <= -size.x) {
      var dt = position.x + size.x;
      position = Vector2.array([size.y * 7 - 5 + dt, 0]);
    } else {
      position = Vector2.array([position.x - 3, position.y]);
    }
  }
}
