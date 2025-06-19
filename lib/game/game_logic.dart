import 'dart:io';
import '../models/direction.dart';
import '../models/point.dart';
import '../models/snake.dart';
import '../models/food.dart';
import '../models/game_map.dart';
import '../utils/terminal.dart';

bool isValidDirection(Direction newDir, Direction dir) {
  return newDir != dir && (newDir == Direction.up && dir != Direction.down) ||
      (newDir == Direction.down && dir != Direction.up) ||
      (newDir == Direction.left && dir != Direction.right) ||
      (newDir == Direction.right && dir != Direction.left);
}

void handleInput(int byte, List<Direction> inputQueue, bool isPaused) {
  switch (byte) {
    case 119: // w
      inputQueue.add(Direction.up);
      break;
    case 115: // s
      inputQueue.add(Direction.down);
      break;
    case 97: // a
      inputQueue.add(Direction.left);
      break;
    case 100: // d
      inputQueue.add(Direction.right);
      break;
    case 112: // p
      // pause() will be handled in main
      break;
    case 113: // q
      gameOver();
      break;
  }
}

void updateDirectionChange(
    Direction dir, Snake snake, GameMap gameMap, Set<Food> foods) {
  final didMove = snake.move(
    dir,
    walls: gameMap.walls,
  );

  if (!didMove) {
    gameOver();
  }
  final updated = gameMap.updateEmptyPoints(snake.points);
  if (!updated) {
    gameOver();
  }

  if (foods.any((f) => f.point == snake.head)) {
    eatFood(snake.head, foods, snake, gameMap);
  }
}

void eatFood(Point foodPoint, Set<Food> foods, Snake snake, GameMap gameMap) {
  foods.removeWhere((f) => f.point == foodPoint);
  snake.grow();
  gameMap.updateEmptyPoints(snake.points);

  addNewFood(foods, gameMap);
}

void addNewFood(Set<Food> foods, GameMap gameMap) {
  final foodPoint = gameMap.getRandomEmptyPoint();
  if (foodPoint != null) {
    foods.add(Food(foodPoint));
    gameMap.updateEmptyPoints(foods.map((f) => f.point).toSet());
  } else {
    gameOver(isWon: true);
  }
}

void gameOver({bool isWon = false}) {
  moveCursor(Point(0, 19));
  clearLine(19);
  if (isWon) {
    stdout.writeln('You won 🎉');
  } else {
    stdout.writeln('Game over 💀');
  }
  exit(0);
}
