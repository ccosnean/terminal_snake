import 'package:terminal_snake/models/direction.dart';

class GameConfig {
  final int width;
  final int height;
  final double speed;
  final bool isPaused;
  final bool isAutoSpeedGameMode;
  final Direction direction;

  GameConfig({
    required this.width,
    required this.height,
    required this.speed,
    required this.isPaused,
    required this.direction,
    required this.isAutoSpeedGameMode,
  });

  bool get isValid => width > 0 && height > 0 && speed > 0;

  @override
  String toString() {
    return 'GameConfig(width: $width, height: $height, speed: $speed, isPaused: $isPaused, direction: $direction, isAutoSpeedGameMode: $isAutoSpeedGameMode)';
  }
}