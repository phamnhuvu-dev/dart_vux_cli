import 'package:dart_vux_cli/template/class_template.dart';
import 'package:dart_vux_cli/common.dart';
import 'package:recase/recase.dart';

const String import = """
import 'dart:async';
""";
const String rxDart = "import 'package:rxdart/rxdart.dart';";

////////// Bloc Service //////////
String getBlocService(String name, bool isMulti) {
  String lower = name.toLowerCase();
  String import = """
import 'dart:async';
import 'package:$packageProject/feature/${lower}/${lower}_bloc.dart';
import 'package:$packageProject/feature/${lower}/model/${lower}.dart';
import 'package:rxdart/rxdart.dart';
""";
  
  return getClass(
    import: import,
    name: "${name}BlocService",
    implement: "${name}Bloc",
    body: _getBodyService(name, isMulti)
  );
}

String _getBodyService(String name, bool isMulti) {
  ReCase reCase = ReCase(name);
  String pascal = reCase.pascalCase;
  String camel = reCase.camelCase;

  String multi = """
  final ${pascal}Repository ${camel}Repository;
  ${pascal}BlocService({this.${camel}Repository});
  
  //// List
  final BehaviorSubject<List<$pascal>> _${camel}sSubject = BehaviorSubject();
  
  @override
  Stream<List<$pascal>> get ${camel}sStream => _${camel}sSubject.stream;
  
    @override
  Future<void> load${pascal}s() {
  
  }
  
  //// Current
  final BehaviorSubject<$pascal> _current${pascal}Subject = BehaviorSubject();
  
  @override
  Stream<$pascal> get current${pascal}Stream => _current${pascal}Subject.stream;

  @override
  Future<void> tapCurrent$pascal() {
  
  }

  @override
  Future<void> tap${pascal}OnList($pascal $camel) {
  
  }
  
  @override
  Future<void> dispose() async {
    _${camel}sSubject.close();
    _current${pascal}Subject.close();
  }
""";

  String single = """
  final ${pascal}Repository ${camel}Repository;
  DemoBlocService({this.${camel}Repository});
  
  final BehaviorSubject<$pascal> _${camel}Subject = BehaviorSubject();
  
  @override
  Stream<$pascal> get current${camel}Stream => _${camel}Subject.stream;
  
  @override
  Future<void> load${pascal}() {
  
  }
  
  @override
  Future<void> dispose() async {
    _${camel}Subject.close();
  }
""";
  return isMulti? multi : single;
}


////////// Bloc Abstract //////////
String getBlocAbstract(String name, bool isMulti) {
  String lower = name.toLowerCase();
  String import = """
import 'dart:async';
import 'package:$packageProject/feature/$lower/model/$lower.dart';
import 'package:$packageProject/feature/bloc.dart';
""";
  
  return getClass(
    isAbstract: true,
    import: import,
    name: "${name}Bloc",
    implement: "Bloc",
    body: _getBodyAbstract(name, isMulti)
  );
}

String _getBodyAbstract(String name, bool isMulti) {
  ReCase reCase = ReCase(name);
  String camel = reCase.camelCase;
  String pascal = reCase.pascalCase;
  return !isMulti
? """
  Stream<$name> get ${reCase.camelCase}Stream;
  
  Future<void> load${pascal}();
"""
: """
  Stream<List<$name>> get ${reCase.camelCase}sStream;
  
  Stream<$name> get current${reCase.pascalCase}Stream;
  
  Future<void> load${pascal}s();

  Future<void> tapCurrent$pascal();

  Future<void> tap${pascal}OnList($pascal $camel);
""";
}
