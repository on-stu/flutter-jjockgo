import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import '../constants/game_status.dart';
import '../game.dart';

class StartButton extends SpriteComponent with TapCallbacks {
  Function start;
  StartButton(Sprite sprite, this.start) : super(sprite: sprite);

  static Future<StartButton> get(Vector2 deviceSize, Function start) async {
    final sprite = await Sprite.load('start.png');
    final title = StartButton(sprite, start);
    title.anchor = Anchor.center;
    title.position = Vector2(deviceSize.x / 2, deviceSize.y / 4 * 3);
    return title;
  }

  @override
  void onTapDown(dynamic event) {
    super.onTapDown(event);
    start();
  }
}
