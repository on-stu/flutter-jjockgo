import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

class GameOverModal extends SpriteComponent with TapCallbacks {
  Function onPressed;
  GameOverModal(Sprite sprite, this.onPressed) : super(sprite: sprite);

  static Future<GameOverModal> get(
      Vector2 deviceSize, Function onPressed) async {
    final sprite = await Sprite.load('gameover_modal.png');
    final gameoverModal = GameOverModal(sprite, onPressed);
    const ratio = 888 / 1226;
    gameoverModal.anchor = Anchor.center;
    gameoverModal.position = Vector2(deviceSize.x / 2, deviceSize.y / 2);
    gameoverModal.size =
        Vector2(deviceSize.x / 1.5, deviceSize.x / 1.5 / ratio);
    return gameoverModal;
  }

  @override
  void onTapDown(dynamic event) {
    super.onTapDown(event);
    onPressed();
    removeFromParent();
  }
}
