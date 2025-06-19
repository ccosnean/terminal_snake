import 'dart:io';
import 'package:terminal_snake/terminal_snake.dart' as terminal_snake;

import 'parsers/terminal_snale_arg_parser.dart';

void main(List<String> arguments) {
  final argParser = TerminalSnakeArgParser();
  final gameConfig = argParser.parse(arguments);

  if (gameConfig.isValid) {
    terminal_snake.runGame(gameConfig);
  } else {
    print('Invalid game config');
    exit(1);
  }
}
