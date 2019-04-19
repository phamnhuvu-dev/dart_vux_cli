import 'dart:io';

import 'package:args/args.dart';
import 'package:dart_vux_cli/build_file/build_bloc_file.dart';
import 'package:dart_vux_cli/build_file/build_init_file.dart';
import 'package:dart_vux_cli/build_file/build_repo_file.dart';
import 'package:dart_vux_cli/common.dart';

const lineNumber = 'line-number';
const service = 'service';
const output = 'output';
const init = 'init';
ArgResults argResults;


main(List<String> arguments) {
//  print('Hello world: ${dart_vux.calculate()}!');

  exitCode = 0; //presume success
//  final parser = new ArgParser()..addFlag(lineNumber, negatable: false, abbr: 'text');
  final parser = ArgParser()
    ..addFlag(init, negatable: false, abbr: "i")
    ..addOption(service, defaultsTo: "", abbr: "s")
    ..addOption(output, defaultsTo: "", abbr: "o");
  argResults = parser.parse(arguments);

  String currentPath = Directory.current.path;
  if (currentPath.contains('lib') ||
      Directory("$currentPath/lib").existsSync()) {
    if (currentPath.contains('lib')) {
      RegExp exp = new RegExp(r"(lib)");
      Directory.current =
          currentPath.substring(0, exp.firstMatch(currentPath).end);
    } else {
      Directory.current = "$currentPath/lib";
    }
//    print(Directory.current.path);
//    print(Directory.current.parent.path);
    RegExp exp = new RegExp(r"([^/]+$)");
    packageProject = exp.stringMatch(Directory.current.parent.path);
    print(packageProject);
  } else {
    print("Error: Please use command line in your project");
  }

  String name = argResults[service];
  String rootPath = Directory.current.path;
  if (name.isNotEmpty) {
    buildBloc(rootPath, name, true);
    buildRepo(rootPath, name);
  } else if (argResults[init]) {
    buildInit(rootPath);
  }
}
