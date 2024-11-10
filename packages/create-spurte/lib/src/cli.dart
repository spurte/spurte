import 'dart:developer';
import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:cli_dialog/cli_dialog.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:create_spurte/src/fs/files.dart';
import 'package:create_spurte/src/scaffold.dart';
import 'package:create_spurte/templates/templates.dart';
import 'package:io/ansi.dart';

/// TODO: Exception object for Spurte
const String version = '0.0.1';

ArgParser buildParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Show additional command output.',
    )
    ..addFlag(
      'version',
      negatable: false,
      help: 'Print the tool version.',
    )
    ..addOption(
      'template',
      abbr: 't',
      help: 'Provide the template to use for the given project',
      allowed: templates.keys.map((k) => k.toLowerCase())
    )
    ;
}

String get description => '''
''';

void printUsage(ArgParser argParser) {
  print('Usage: create_spurte <flags> [arguments]');
  
  print(description);
  print(argParser.usage);
}

/// Pass arguments and run cli
void run(List<String> arguments) {
  final ArgParser argParser = buildParser();
  try {
    final ArgResults results = argParser.parse(arguments);
    bool verbose = false;

    // Process the parsed arguments.
    if (results.wasParsed('help')) {
      printUsage(argParser);
      return;
    }
    if (results.wasParsed('version')) {
      print('create_spurte version: $version');
      return;
    }
    if (results.wasParsed('verbose')) {
      verbose = true;
    }

    // Act on the arguments provided.
    cli(results, verbose: verbose);
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
  } on Exception catch (e) {
    print("An unknown error occured");
    print(e);
  }
}

/// Run the command line interface
void cli(ArgResults results, {bool verbose = false}) {
  var logger = verbose ? Logger.verbose() : Logger.standard();

  String name;
  String dir = '.';
  var templ;

  final normalDialogQuestions = [];
  final List<String> orderOfQuestions = [];

  // Questions
  if (results.rest.isEmpty) {
    normalDialogQuestions.add(['What is the name of your project', 'name']);
    orderOfQuestions.add('name');
  } else {
    name = results.rest[0];
  }

  final listDialogQuestions = [];
  
  if (results.wasParsed('template')) {
    templ = templates[templates.keys.singleWhere((k) => k.toLowerCase() == results['template'], orElse: () => throw Exception('Could not find given template'),)];
  } else {
    listDialogQuestions.add([
      {
        'question': 'Select the desired template to use',
        'options': templates.keys.toList()
      }, 
      'template'
    ]);
    orderOfQuestions.add('template');
  }  

  try {
    final dialog = CLI_Dialog(questions: normalDialogQuestions, listQuestions: listDialogQuestions, order: orderOfQuestions);
    final answer = dialog.ask();
    
    if (results.rest.isEmpty) {
      name = answer['name'];
    } else {
      throw Exception('Name not initialised. This must be an error from the system');
    }
    
    templ ??= templates[answer['template']]!;

    scaffoldProject(name, dir, templ, logger: logger);
  } on Exception catch (e) {
    stderr.writeln(red.wrap('An error occured: $e'));
  } catch (e) {
    stderr.writeln(red.wrap('Unknown error occured: $e'));
    rethrow;
  } finally {
    logger.flush();
  }
}
