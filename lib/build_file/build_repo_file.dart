import 'dart:io';

import 'package:dart_vux_cli/template/class_template.dart';
import 'package:dart_vux_cli/common.dart';
import 'package:dart_vux_cli/template/repo_template.dart';

void buildRepo(String rootPath, String name) {
  rootPath = "$rootPath/feature";
  String lowerName = name.toLowerCase();

  // Bloc Abstract
  String pathAbstract = "$rootPath/$lowerName";
  Directory(pathAbstract).createSync(recursive: true);
  Directory.current = pathAbstract;
  final fileB = new File('${lowerName}_repository.dart');
  fileB.writeAsStringSync(getRepoAbstract(name));

  // Bloc Service
  String pathService = "$rootPath/$lowerName/service";
  Directory(pathService).createSync(recursive: true);
  Directory.current = pathService;
  final fileS = new File('${lowerName}_repository_service.dart');
  fileS.writeAsStringSync(getRepoService(name));

  //Model
  String pathModel = "$rootPath/$lowerName/model";
  Directory(pathModel).createSync(recursive: true);
  Directory.current = pathModel;
  final fileM = new File("$lowerName.dart");
  fileM.writeAsStringSync(getClass(name: name));

  String pathDto = "$rootPath/$lowerName/dto";
  Directory(pathDto).createSync(recursive: true);
  Directory.current = pathDto;
  final fileQ = new File("${lowerName}_request.dart");
  fileQ.writeAsStringSync(getClass(isAbstract: true, name: "${name}Request"));
  final fileSs = new File("${lowerName}_response.dart");
  fileSs.writeAsStringSync(getClass(isAbstract: true, name: "${name}Response"));

  buildDto(rootPath, name, "Get");
  buildDto(rootPath, name, "Insert");
  buildDto(rootPath, name, "Update");
  buildDto(rootPath, name, "Delete");

  buildChildRepo(rootPath, name, "Api");
  buildChildRepo(rootPath, name, "Db");
}

void buildDto(String rootPath, String name, String type) {
  String lowerName = name.toLowerCase();
  String lowerType = type.toLowerCase();
  String pathDtoType = "$rootPath/$lowerName/dto/$lowerType";
  Directory(pathDtoType).createSync(recursive: true);
  Directory.current = pathDtoType;
  final fileApi = File("${lowerType}_${lowerName}_api_request.dart");
  fileApi.writeAsStringSync(getClass(
    import: "import 'package:$packageProject/feature/$lowerName/dto/${lowerName}_request.dart';",
    name: "$type${name}ApiRequest",
    implement: "${name}Request",
  ));
  final fileDb = File("${lowerType}_${lowerName}_db_request.dart");
  fileDb.writeAsStringSync(getClass(
    import: "import 'package:$packageProject/feature/$lowerName/dto/${lowerName}_request.dart';",
    name: "$type${name}DbRequest",
    implement: "${name}Request",
  ));
  final fileRs = File("${lowerType}_${lowerName}_response.dart");
  fileRs.writeAsStringSync(getClass(
    import: "import 'package:$packageProject/feature/$lowerName/dto/${lowerName}_response.dart';",
    name: "$type${name}Response",
    implement: "${name}Response",
  ));
}

void buildChildRepo(String rootPath, String name, String type) {
  String lowerName = name.toLowerCase();
  String pathService = "$rootPath/$lowerName/service";
  Directory(pathService).createSync(recursive: true);
  Directory.current = pathService;
  final fileS = new File('${lowerName}_${type.toLowerCase()}_service.dart');
  fileS.writeAsStringSync(getChildService(name, type));
}
