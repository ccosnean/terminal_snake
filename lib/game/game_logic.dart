part of '../terminal_snake.dart';

bool isValidDirection(Direction newDir, Direction dir) {
  return newDir != dir && (newDir == Direction.up && dir != Direction.down) ||
      (newDir == Direction.down && dir != Direction.up) ||
      (newDir == Direction.left && dir != Direction.right) ||
      (newDir == Direction.right && dir != Direction.left);
}

void handleInput(int byte) {
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
      pause();
      break;
    case 32: // space (boost) reset on release
      isBoosting = !isBoosting;
      speed += isBoosting ? 5 : -5;
      resetUpdateTimer();
      break;
    case 113: // q
      gameOver();
      break;
  }
}

void updateDirectionChange(Direction dir) {
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

  if (isAutoSpeedGameMode) {
    speed += 0.05;
    resetUpdateTimer();
  }

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
  if (isWon) {
    snake.drawKing();
    drawMetadata();

    printText(Point(0, height + 4), 'You won 🎉');
  } else {
    snake.drawDead(dir);
    drawMetadata();

    printText(Point(0, height + 4), 'Game over 💀');
  }
  exit(0);
}
