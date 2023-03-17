import 'package:financial_tracker/Commons/exceptions/domain_error_translator.dart';
import 'package:financial_tracker/Domains/sources/entities/add_source.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Infrastructures/repository/source_repository_sqlite.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/sqlite_db.mocks.dart';

void main() {
  group("SourceRepositorySQLite Class", () {
    const id = 123;
    const tableName = "sources";
    const name = "source_repository_sqlite_test_name";
    const imageRoute = "source_repository_sqlite_test_image_route";

    group("getSource function", () {
      test('throws exception if not found any record', () {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository =
            SourceRepositorySQLite(db: db, errorTranslator: errorTranslator);

        when(db.get(tableName, id)).thenAnswer((_) async => null);

        expect(repository.getSource(id),
            throwsA(errorTranslator.translate(ExceptionEnum.sourceNotFound)));
      });

      test('execution success', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository =
            SourceRepositorySQLite(db: db, errorTranslator: errorTranslator);
        final source = Source(id: id, name: name, imageRoute: imageRoute);

        when(db.get(tableName, id)).thenAnswer((_) async => <dynamic, dynamic>{
              "id": id,
              "name": name,
              "image_route": imageRoute
            });

        final result = await repository.getSource(id);

        expect(result.id, source.id);
        expect(result.name, source.name);
        expect(result.imageRoute, source.imageRoute);
      });
    });

    group("getSources function", () {
      test('return empty array if no record found', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository =
            SourceRepositorySQLite(db: db, errorTranslator: errorTranslator);

        when(db.getAll(tableName)).thenAnswer((_) async => []);

        var result = await repository.getSources();
        expect(result.length, 0);
      });

      test('return result more than one', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository =
            SourceRepositorySQLite(db: db, errorTranslator: errorTranslator);
        final source = Source(id: id, name: name, imageRoute: imageRoute);
        final map = <dynamic, dynamic>{
          "id": source.id,
          "name": source.name,
          "image_route": source.imageRoute,
        };

        when(db.getAll(tableName)).thenAnswer((_) async => [map, map, map]);

        var result = await repository.getSources();
        expect(result.length, 3);
        expect(result[0].id, source.id);
        expect(result[0].name, source.name);
        expect(result[0].imageRoute, source.imageRoute);
      });
    });

    group("addSource function", () {
      test('throw error if insertion failed', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository =
            SourceRepositorySQLite(db: db, errorTranslator: errorTranslator);
        final addSource = AddSource(name: name, imageRoute: imageRoute);

        when(db.insert(tableName, addSource)).thenAnswer((_) async => 0);

        expect(repository.addSource(addSource),
            throwsA(errorTranslator.translate(ExceptionEnum.addSourceFailed)));
      });

      test('return Source object when insertion success', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository =
            SourceRepositorySQLite(db: db, errorTranslator: errorTranslator);
        final addSource = AddSource(name: name, imageRoute: imageRoute);
        final source = Source(id: id, name: name, imageRoute: imageRoute);
        final map = <dynamic, dynamic>{
          "id": source.id,
          "name": source.name,
          "image_route": source.imageRoute,
        };

        when(db.insert(tableName, addSource)).thenAnswer((_) async => id);
        when(db.get(tableName, id)).thenAnswer((_) async => map);

        var result = await repository.addSource(addSource);
        expect(result.id, source.id);
        expect(result.name, source.name);
        expect(result.imageRoute, source.imageRoute);
      });
    });
  });
}
