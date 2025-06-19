import 'dart:io';
import '../models/point.dart';

void clearScreen() {
  print('\x1B[2J\x1B[0;0H');
}

void drawChar(Point point, String char) {
  moveCursor(point);
  stdout.write(char);
}

void moveCursor(Point point) {
  stdout.write('\x1B[${point.y + 1};${point.x * 2 + 1}H');
}

void clearLine(int row) {
  moveCursor(Point(0, row));
  stdout.write('\x1B[K');
}
