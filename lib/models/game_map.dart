import 'dart:math';
import 'point.dart';
import '../utils/terminal.dart';

class GameMap {
  final int width;
  final int height;
  final Set<Point> walls = {};
  final Set<Point> _baseEmpty = {};
  final Set<Point> empty = {};

  Point get spawnPoint => Point(width ~/ 2, height ~/ 2);

  GameMap(this.width, this.height) {
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        if (x == 0 || x == width - 1 || y == 0 || y == height - 1) {
          walls.add(Point(x, y));
        } else {
          _baseEmpty.add(Point(x, y));
        }
      }
    }
    empty.addAll(_baseEmpty);
  }

  Point? getRandomEmptyPoint() {
    if (empty.isEmpty) {
      return null;
    }

    final index = Random().nextInt(empty.length);
    return empty.elementAt(index);
  }

  bool updateEmptyPoints(Set<Point> points) {
    if (points.intersection(walls).isNotEmpty) {
      return false;
    }

    empty.addAll(_baseEmpty);
    empty.removeAll(points);

    return true;
  }

  void draw() {
    for (var point in empty) {
      drawChar(point, ' ');
    }

    for (var point in walls) {
      drawChar(point, '🟫');
    }
  }
}
