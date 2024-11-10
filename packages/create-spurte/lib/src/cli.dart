import 'package:args/args.dart';
import 'package:cli_dialog/cli_dialog.dart';

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
      allowed: ["vanilla"]
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
    cli(results);
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
void cli(ArgResults results) {
  String name;

  final normalDialogQuestions = [];
  final orderOfQuestions = [];

  // Questions
  if (results.rest.isEmpty) {
    
  }

  // 1. Name of project
  
}