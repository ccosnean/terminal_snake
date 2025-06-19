import 'dart:io';
import '../models/point.dart';
import '../models/direction.dart';
import '../utils/terminal.dart';

void drawMetadata(int height, double speed, List<Direction> inputQueue,
    int score, bool isPaused) {
  moveCursor(Point(0, height));
  clearLine(height);
  stdout.write('q: quit, p: pause, w,s,a,d: move, +,-: speed');
  moveCursor(Point(0, height + 1));
  clearLine(height + 1);
  stdout.write('speed: ${speed.toStringAsFixed(2)} units/sec');
  moveCursor(Point(0, height + 2));
  clearLine(height + 2);
  stdout.writeln(
      'move queue: {${inputQueue.map((e) => e.toString().replaceAll("Direction.", "")).join(", ")}}');
  moveCursor(Point(0, height + 3));
  clearLine(height + 3);
  stdout.write('score: ${score}');

  moveCursor(Point(0, height + 4));
  clearLine(height + 4);
  if (isPaused) {
    stdout.write('Paused');
  } else {
    stdout.write('Playing');
  }
}

void pause(int height, bool isPaused) {
  moveCursor(Point(0, height + 4));
  clearLine(height + 4);
  // Note: isPaused is returned as a new value, not modified in place
}
