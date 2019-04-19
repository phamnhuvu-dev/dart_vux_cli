
import 'dart:io';

void buildInit(String rootPath) {
  String pathFeature = "$rootPath/feature";
  Directory(pathFeature).createSync(recursive: true);
  Directory.current = pathFeature;

  File fileRepo = File("repository.dart");
  fileRepo.writeAsStringSync("""
import 'dart:async';

abstract class Repository<Q, S> {
  Future<S> get(Q request);

  Future<S> insert(Q request);

  Future<S> update(Q request);

  Future<S> delete(Q request);
}
""");

  File fileBloc = File("bloc.dart");
  fileBloc.writeAsStringSync("""
abstract class Bloc {
  Future<void> dispose();
}
""");

  String pathScreen = "$rootPath/screen";
  Directory(pathScreen).createSync(recursive: true);

  String pathStatic = "$rootPath/static";
  Directory(pathStatic).createSync(recursive: true);

  String pathWidget = "$rootPath/widget";
  Directory(pathWidget).createSync(recursive: true);
}