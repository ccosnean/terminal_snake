import 'dart:async';
import 'dart:io';

import 'models/direction.dart';
import 'models/snake.dart';
import 'models/food.dart';
import 'models/game_map.dart';
import 'game/game_logic.dart';
import 'game/ui.dart';
import 'utils/terminal.dart';

late Set<Food> foods;
late final Snake snake;
late final GameMap gameMap;
late bool isPaused = false;

const int width = 20;
const int height = 15;
final inputQueue = <Direction>[];
Direction dir = Direction.right;
double speed = 5; // also fps

Timer? updateTimer;

void runGame() {
  stdin.echoMode = false;
  stdin.lineMode = false;

  setup();
  resetUpdateTimer();

  stdin.listen((List<int> data) {
    for (var byte in data) {
      handleInput(byte, inputQueue, isPaused);
      if (byte == 112) {
        // p key
        isPaused = !isPaused;
        pause(height, isPaused);
      } else if (byte == 43) {
        // + key
        speed += 0.5;
        resetUpdateTimer();
      } else if (byte == 45) {
        // - key
        speed -= 0.5;
        resetUpdateTimer();
      }
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

  inputQueue.add(Direction.down);

  snake = Snake(gameMap.spawnPoint);
  addNewFood(foods, gameMap);

  gameMap.draw();
}

void update() {
  if (isPaused) {
    drawMetadata(height, speed, inputQueue, snake.points.length, isPaused);
    return;
  }

  if (inputQueue.isNotEmpty) {
    final newDir = inputQueue.removeAt(0);
    if (isValidDirection(newDir, dir)) {
      dir = newDir;
    }
  }

  updateDirectionChange(dir, snake, gameMap, foods);
  gameMap.draw();
  snake.draw();
  foods.forEach((f) => f.draw());
  drawMetadata(height, speed, inputQueue, snake.points.length, isPaused);
}
