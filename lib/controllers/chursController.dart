import 'package:flame/components.dart';
import 'package:jjockgo/constants/game_status.dart';

class ChursController {
  late SpriteComponent upperChur;
  late SpriteComponent lowerChur;
  GameStatus gameStatus;
  Vector2 size;

  ChursController(
    Sprite sprite,
    this.gameStatus,
    this.size,
  );

  getChurs() async {
    final upperChurSprite = await Sprite.load('chur.png');
    final lowerChurSprite = await Sprite.load('chur.png');
  }

  getEachPoints() async {
    final upperChurSprite = await Sprite.load('chur.png');
    final lowerChurSprite = await Sprite.load('chur.png');
  }
}
