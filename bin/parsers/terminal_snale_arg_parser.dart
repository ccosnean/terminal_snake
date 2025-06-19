import 'dart:io';

import 'package:args/args.dart';
import 'package:terminal_snake/game/game_config.dart';
import 'package:terminal_snake/models/direction.dart';

class TerminalSnakeArgParser {
  late final ArgParser argParser;

  TerminalSnakeArgParser() {
    argParser = ArgParser(allowTrailingOptions: true);
    argParser.addOption(
      'width',
      abbr: 'w',
      help: 'Width of the game board',
      defaultsTo: '24',
    );

    argParser.addOption(
      'height',
      abbr: 'h',
      help: 'Height of the game board',
      defaultsTo: '16',
    );

    argParser.addOption(
      'speed',
      abbr: 's',
      help: 'Speed of the game (frames per second)',
      defaultsTo: '5.0',
    );

    argParser.addOption(
      'direction',
      abbr: 'd',
      help: 'Direction of the snake [s=down, w=up, a=left, d=right]',
      defaultsTo: 's',
      allowed: ['s', 'w', 'a', 'd'],
    );

    argParser.addFlag(
      'paused',
      abbr: 'p',
      help: 'Start the game in paused state',
      defaultsTo: false,
    );

    argParser.addFlag(
      'auto-speed',
      help: 'Enable auto speed game mode (base speed will be increased by a little every time you eat)',
      defaultsTo: true,
    );

    argParser.addFlag(
      'help',
      help: 'Show help --help',
      negatable: false,
      defaultsTo: false,
    );
  }

  GameConfig parse(List<String> arguments) {
    final argResults = argParser.parse(arguments);

    if (argResults.wasParsed('help')) {
      print('\nUsage: terminal_snake [options]');
      print('\nOptions:');
      print(argParser.usage);
      print('\nExamples:');
      print('  terminal_snake --width=24 --height=16 --speed=5 --paused');
      print('  terminal_snake -w20 -h10 -s6 -p');
      print('  terminal_snake --help');
      exit(64);
    }

    late Direction direction;
    final dirOption = argResults.option('direction');
    if (dirOption != null) {
      switch (dirOption) {
        case 's':
          direction = Direction.down;
          break;
        case 'w':
          direction = Direction.up;
          break;
        case 'a':
          direction = Direction.left;
          break;
        case 'd':
          direction = Direction.right;
          break;
        default:
          direction = Direction.down;
      }
    }

    return GameConfig(
      width: int.tryParse(argResults.option('width') ?? '24') ?? 24,
      height: int.tryParse(argResults.option('height') ?? '16') ?? 16,
      speed: double.tryParse(argResults.option('speed') ?? '5.0') ?? 5.0,
      isPaused: argResults.flag('paused'),
      direction: direction,
      isAutoSpeedGameMode: argResults.flag('auto-speed'),
    );
  }
}
