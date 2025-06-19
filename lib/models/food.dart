import 'dart:math';
import 'point.dart';
import '../utils/terminal.dart';

class Food {
  final Point point;
  static const _foods = [
    '🍎',
    '🍌',
    '🍇',
    '🍓',
    '🍒',
    '🍑',
    '🍍',
    '🍐',
    '🍊',
    '🍋'
  ];
  final int foodIndex;

  Food(this.point) : foodIndex = Random().nextInt(_foods.length);

  void draw() {
    drawChar(point, _foods[foodIndex]);
  }

  @override
  bool operator ==(Object other) {
    if (other is Food) {
      return point == other.point && foodIndex == other.foodIndex;
    }
    return false;
  }

  @override
  int get hashCode => point.hashCode ^ foodIndex.hashCode;
}
