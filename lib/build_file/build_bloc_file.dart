import 'dart:io';

import 'package:dart_vux_cli/template/bloc_template.dart';


void buildBloc(String rootPath, String name, bool isMulti) {
  rootPath = "$rootPath/feature";
  String lowerName = name.toLowerCase();

  // Bloc Abstract
  String pathAbstract = "$rootPath/$lowerName";
  Directory(pathAbstract).createSync(recursive: true);
  Directory.current = pathAbstract;
  final fileB = new File('${lowerName}_bloc.dart');
  fileB.writeAsStringSync(getBlocAbstract(name, isMulti));

  // Bloc Service
  String pathService = "$rootPath/$lowerName/service";
  Directory(pathService).createSync(recursive: true);
  Directory.current = pathService;
  final fileS = new File('${lowerName}_bloc_service.dart');
  fileS.writeAsStringSync(getBlocService(name, isMulti));
}
