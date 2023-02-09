import 'package:flame/components.dart';

class Title extends SpriteComponent {
  Title(Sprite sprite) : super(sprite: sprite);

  static Future<Title> get(Vector2 deviceSize) async {
    final sprite = await Sprite.load('title.png');
    final title = Title(sprite);
    title.anchor = Anchor.center;
    title.position = Vector2(deviceSize.x / 2, deviceSize.y / 4);
    return title;
  }
}
