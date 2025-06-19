part of '../terminal_snake.dart';

void drawMetadata() {
  moveCursor(Point(0, height));
  clearLine(height);
  stdout.write('q: quit, p: pause, w,s,a,d: move, space: 🐌/🚂');
  moveCursor(Point(0, height + 1));
  clearLine(height + 1);
  stdout.write('speed: ${speed.toStringAsFixed(2)} units/sec ${isBoosting ? '🚂' : '🐌'}');
  moveCursor(Point(0, height + 2));
  clearLine(height + 2);
  stdout.writeln(
      'move queue: {${inputQueue.map((e) => e.toString().replaceAll("Direction.", "")).join(", ")}}');
  moveCursor(Point(0, height + 3));
  clearLine(height + 3);
  stdout.write('score: ${snake.points.length}');

  moveCursor(Point(0, height + 4));
  clearLine(height + 4);
  if (isPaused) {
    stdout.write('Paused');
  } else {
    stdout.write('Playing');
  }
}

void pause() {
  isPaused = !isPaused;
}
