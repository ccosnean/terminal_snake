part of '../terminal_snake.dart';

void drawMetadata() {
  printText(
    Point(0, height),
    'q: quit, p: pause, w,s,a,d: move, space: 🐌/🚂',
  );
  printText(
    Point(0, height + 1),
    'speed: ${speed.toStringAsFixed(2)} units/sec ${isBoosting ? '🚂' : '🐌'}',
  );
  printText(
    Point(0, height + 2),
    'move queue: {${inputQueue.map((e) => e.toString().replaceAll("Direction.", "")).join(", ")}}',
  );
  printText(
    Point(0, height + 3),
    'score: ${snake.points.length}',
  );
  printText(
    Point(0, height + 4),
    isPaused ? 'Paused' : 'Playing',
  );
}

void printText(Point point, String text) {
  moveCursor(point);
  clearLine(point.y);
  stdout.writeln(text);
}

void pause() {
  isPaused = !isPaused;
}
