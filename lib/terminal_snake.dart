import 'dart:async';
import 'dart:io';

import 'package:terminal_snake/game/game_config.dart';
import 'package:terminal_snake/models/direction.dart';
import 'package:terminal_snake/models/food.dart';
import 'package:terminal_snake/models/game_map.dart';
import 'package:terminal_snake/models/point.dart';
import 'package:terminal_snake/models/snake.dart';
import 'package:terminal_snake/utils/terminal.dart';

part 'game/game_logic.dart';
part 'game/ui.dart';

late Set<Food> foods;
late final Snake snake;
late final GameMap gameMap;
late bool isPaused = false;
bool shouldPauseNextFrame = false;
bool isAutoSpeedGameMode = false;
bool isBoosting = false;

late int width;
late int height;
final inputQueue = <Direction>[];
Direction dir = Direction.right;
double speed = 5; // also fps

Timer? updateTimer;

void runGame(GameConfig gameConfig) {
  stdin.echoMode = false;
  stdin.lineMode = false;

  width = gameConfig.width;
  height = gameConfig.height;
  speed = gameConfig.speed;
  shouldPauseNextFrame = gameConfig.isPaused;
  dir = gameConfig.direction;
  isAutoSpeedGameMode = gameConfig.isAutoSpeedGameMode;

  setup();
  resetUpdateTimer();

  stdin.listen((List<int> data) {
    for (var byte in data) {
      handleInput(byte);
    }
  });
}

void resetUpdateTimer() {
  if (updateTimer != null) {
    updateTimer!.cancel();
  }

  int frameTime = ((1 / speed) * 1000).toInt();
  updateTimer = Timer.periodic(Duration(milliseconds: frameTime), (timer) {
    update();
  });
}

void setup() {
  clearScreen();

  foods = {};
  gameMap = GameMap(width, height);

  snake = Snake(gameMap.spawnPoint);
  addNewFood(foods, gameMap);

  gameMap.draw();
}

void update() {
  if (isPaused) {
    drawMetadata(height, speed, inputQueue, snake.points.length, isPaused);
    return;
  }

  if (shouldPauseNextFrame) {
    isPaused = true;
    shouldPauseNextFrame = false;
  }

  if (inputQueue.isNotEmpty) {
    final newDir = inputQueue.removeAt(0);
    if (isValidDirection(newDir, dir)) {
      dir = newDir;
    }
  }

  updateDirectionChange(dir);
  snake.draw();
  foods.forEach((f) => f.draw());
  drawMetadata(height, speed, inputQueue, snake.points.length, isPaused);
}
