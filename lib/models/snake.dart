import 'dart:collection';
import 'point.dart';
import 'direction.dart';
import '../utils/terminal.dart';

class Snake {
  final Queue<Point> _points = Queue();
  final Set<Point> _foodPoints = {};

  Snake(Point head) {
    _points.add(head);
  }

  Point? _oldTail;
  Point get head => _points.first;
  Point get tail => _points.last;
  Set<Point> get points => _points.toSet();

  bool move(
    Direction dir, {
    required Set<Point> walls,
  }) {
    final newHead = Point(
      _points.first.x +
          (dir == Direction.right
              ? 1
              : dir == Direction.left
                  ? -1
                  : 0),
      _points.first.y +
          (dir == Direction.down
              ? 1
              : dir == Direction.up
                  ? -1
                  : 0),
    );

    if (walls.contains(newHead) || isCollidingWithPoint(newHead)) {
      return false;
    }

    _points.addFirst(newHead);
    _oldTail = _points.removeLast();
    if (_oldTail != null) {
      _foodPoints.remove(_oldTail!);
    }

    return true;
  }

  void grow() {
    final foodPoint = _points.first;
    _foodPoints.add(foodPoint);
    _points.addFirst(foodPoint);
  }

  bool isCollidingWithPoints(Set<Point> otherPoints) {
    return _points.any((p) => otherPoints.contains(p));
  }

  bool isCollidingWithPoint(Point point) {
    return _points.contains(point);
  }

  void drawKing() {
    drawChar(head, '👑');
  }

  void drawDead(Direction dir) {
    final ahead = Point(
        head.x +
            (dir == Direction.right
                ? 1
                : dir == Direction.left
                    ? -1
                    : 0),
        head.y +
            (dir == Direction.down
                ? 1
                : dir == Direction.up
                    ? -1
                    : 0));

    drawChar(head, '💀');
    drawChar(ahead, '💥');
  }

  void draw() {
    for (var point in _points) {
      if (point == head) {
        drawChar(point, '🟦');
      } else if (_foodPoints.contains(point)) {
        drawChar(point, '🟧');
      } else {
        drawChar(point, '🟩');
      }
    }

    if (_oldTail != null) {
      drawChar(_oldTail!, '  ');
    }
  }
}
