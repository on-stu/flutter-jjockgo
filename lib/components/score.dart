import 'package:flame/components.dart';

class Score extends SpriteComponent {
  Score(Vector2 position, Sprite sprite, Vector2 size)
      : super(position: position, sprite: sprite, size: size);

  static getList(Vector2 deviceSize, int score) async {
    String scoreString = getScoreString(score);
    List<Score> scoreList = [];
    for (int i = 0; i < scoreString.length; i++) {
      final sprite =
          await Sprite.load('numbers/${scoreString.split('')[i]}.png');
      final score = Score(
        Vector2(deviceSize.x / 2 - 30 * scoreString.length / 2 + 30 * i, 100),
        sprite,
        Vector2(30, 30),
      );
      scoreList.add(score);
    }

    return scoreList;
  }

  static getScoreString(int score) {
    return score.toString().padLeft(3, '0');
  }
}
