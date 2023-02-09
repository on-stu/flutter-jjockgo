import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:jjockgo/constants/game_status.dart';
import 'package:jjockgo/game.dart';

const double gravity = 900;

class Cat extends SpriteAnimationComponent {
  late List<Sprite> sprites;
  late Vector2 deviceSize;

  double speed = 0.0;

  Cat(SpriteAnimation animation, Vector2 size, this.deviceSize)
      : super(animation: animation, size: size);

  static get(Vector2 deviceSize) async {
    final sprite1 = await Sprite.load('Cat1.png');
    final sprite2 = await Sprite.load('Cat2.png');

    final sprites = [sprite1, sprite2];
    final animation = SpriteAnimation.spriteList(sprites, stepTime: 0.5);

    return Cat(animation, Vector2.all(100), deviceSize);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameStatus != GameStatus.playing) return;
    speed += gravity * dt;
    position.y += speed * dt / 2;
  }

  @override
  void onLoad() async {
    position =
        Vector2(deviceSize.x / 2 - size.x / 2, deviceSize.y / 2 - size.y / 2);
    super.onLoad();
  }

  void jump() {
    speed = -400;
    FlameAudio.play('bubble_pop.mp3', volume: 0.5);
  }
}
