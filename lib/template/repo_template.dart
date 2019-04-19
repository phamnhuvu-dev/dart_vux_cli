import 'package:dart_vux_cli/template/class_template.dart';
import 'package:dart_vux_cli/common.dart';
import 'package:recase/recase.dart';

////////// Service //////////
String getRepoService(String name) {
  String lower = name.toLowerCase();
  String import = """
import 'dart:async';

import 'package:$packageProject/feature/$lower/dto/delete/delete_${lower}_api_request.dart';
import 'package:$packageProject/feature/$lower/dto/delete/delete_${lower}_db_request.dart';
import 'package:$packageProject/feature/$lower/dto/get/get_${lower}_api_request.dart';
import 'package:$packageProject/feature/$lower/dto/get/get_${lower}_db_request.dart';
import 'package:$packageProject/feature/$lower/dto/insert/insert_${lower}_api_request.dart';
import 'package:$packageProject/feature/$lower/dto/insert/insert_${lower}_db_request.dart';
import 'package:$packageProject/feature/$lower/dto/${lower}_request.dart';
import 'package:$packageProject/feature/$lower/dto/${lower}_response.dart';
import 'package:$packageProject/feature/$lower/dto/update/update_${lower}_api_request.dart';
import 'package:$packageProject/feature/$lower/dto/update/update_${lower}_db_request.dart';
import 'package:$packageProject/feature/$lower/${lower}_repository.dart';
""";

  return getClass(
      import: "$import",
      name: "${name}RepositoryService",
      implement: "${name}Repository",
      body: _getBodyService(name),
  );
}

String getChildService(String name, String type) {
  String lower = name.toLowerCase();
  String import = """
import 'dart:async';

import 'package:$packageProject/feature/$lower/dto/delete/delete_${lower}_api_request.dart';
import 'package:$packageProject/feature/$lower/dto/delete/delete_${lower}_db_request.dart';
import 'package:$packageProject/feature/$lower/dto/get/get_${lower}_api_request.dart';
import 'package:$packageProject/feature/$lower/dto/get/get_${lower}_db_request.dart';
import 'package:$packageProject/feature/$lower/dto/insert/insert_${lower}_api_request.dart';
import 'package:$packageProject/feature/$lower/dto/insert/insert_${lower}_db_request.dart';
import 'package:$packageProject/feature/$lower/dto/${lower}_request.dart';
import 'package:$packageProject/feature/$lower/dto/${lower}_response.dart';
import 'package:$packageProject/feature/$lower/dto/update/update_${lower}_api_request.dart';
import 'package:$packageProject/feature/$lower/dto/update/update_${lower}_db_request.dart';
import 'package:$packageProject/feature/$lower/${lower}_repository.dart';
""";

  return getClass(
    import: import,
    name: "${name}${type}Service",
    implement: "${name}Repository",
    body: _getBodyChildService(name, type),
  );
}

String _getBodyService(String name) {
  ReCase reCase = ReCase(name);
  String pascal = reCase.pascalCase;
  String camel = reCase.camelCase;

  return """
  final ${pascal}Repository api;
  final ${pascal}Repository db;

  ${pascal}RepositoryService({this.api, this.db});

  @override
  Future<${pascal}Response> get(${pascal}Request request) async {
    assert(request != null);
    
    switch (request.runtimeType) {
      case Get${pascal}ApiRequest:
        return api.get(request);

      case Get${pascal}DbRequest:
        return db.get(request);
    }
    return null;
  }

  @override
  Future<${pascal}Response> insert(${pascal}Request request) async {
    assert(request != null);
    
    switch (request.runtimeType) {
      case Insert${pascal}ApiRequest:
        return api.insert(request);

      case Insert${pascal}DbRequest:
        return db.insert(request);
    }
    return null;
  }

  @override
  Future<${pascal}Response> update(${pascal}Request request) async {
    assert(request != null);
    
    switch (request.runtimeType) {
      case Update${pascal}ApiRequest:
        return api.update(request);

      case Update${pascal}DbRequest:
        return db.update(request);
    }
    return null;
  }
  
  
  @override
  Future<${pascal}Response> delete(${pascal}Request request) async {
    assert(request != null);
    
    switch (request.runtimeType) {
      case Delete${pascal}ApiRequest:
        return api.delete(request);

      case Delete${pascal}DbRequest:
        return db.delete(request);
    }
    return null;
  }
""";
}

String _getBodyChildService(String name, String type) {
  ReCase reCase = ReCase(name);
  String pascal = reCase.pascalCase;
  String camel = reCase.camelCase;

  return """
  @override
  Future<${pascal}Response> get(${pascal}Request request) async {
    return null;
  }

  @override
  Future<${pascal}Response> insert(${pascal}Request request) async {
    return null;
  }

  @override
  Future<${pascal}Response> update(${pascal}Request request) async {
    return null;
  }
  
  
  @override
  Future<${pascal}Response> delete(${pascal}Request request) async {
    return null;
  }
""";
}



////////// Abstract //////////
String getRepoAbstract(String name) {
  String lower = name.toLowerCase();
  String import = """
import 'package:$packageProject/feature/$lower/dto/${lower}_response.dart';
import 'package:$packageProject/feature/$lower/dto/${lower}_request.dart';
import 'package:$packageProject/feature/repository.dart';
""";
  return getClass(
      isAbstract: true,
      import: import,
      name: "${name}Repository",
      extend: "Repository<${name}Request, ${name}Response>",
  );
}

