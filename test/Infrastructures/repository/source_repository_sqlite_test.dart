import 'package:financial_tracker/Commons/exceptions/domain_error_translator.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Infrastructures/repository/source_repository_sqlite.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/sqlite_db.mocks.dart';

void main() {
  group("SourceRepositorySQLite Class", () {
    const id = 123;
    const dbName = "sources";
    const name = "source_repository_sqlite_test_name";
    const imageRoute = "source_repository_sqlite_test_image_route";

    group("getSource function", () {
      test('throws exception if not found any record', () {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository =
            SourceRepositorySQLite(db: db, errorTranslator: errorTranslator);

        when(db.get(dbName, id)).thenAnswer((_) async => null);

        expect(repository.getSource(id),
            throwsA(errorTranslator.translate(ExceptionEnum.sourceNotFound)));
      });

      test('execution success', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository =
            SourceRepositorySQLite(db: db, errorTranslator: errorTranslator);
        final source = Source(id: id, name: name, imageRoute: imageRoute);

        when(db.get(dbName, id)).thenAnswer((_) async => <dynamic,dynamic> {
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

    // group("getSources function", () {
    //   test('throws exception if not found any record', () {
    //     final db = MockSqliteDB();
    //     final errorTranslator = DomainErrorTranslator();
    //     final repository =
    //         SourceRepositorySQLite(db: db, errorTranslator: errorTranslator);

    //     when(db.get(dbName, sourceId)).thenAnswer((_) async => null);

    //     expect(repository.getSource(sourceId),
    //         throwsA(errorTranslator.translate(ExceptionEnum.sourceNotFound)));
    //   });
    // });
  });
}
