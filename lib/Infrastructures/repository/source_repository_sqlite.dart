import 'package:financial_tracker/Commons/exceptions/domain_error_translator.dart';
import 'package:financial_tracker/Domains/sources/entities/add_source.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/sources/source_repository.dart';
import 'package:financial_tracker/Infrastructures/database/sqlite/db.dart';

class SourceRepositorySQLite extends SourceRepository {
  late SqliteDB db;
  late DomainErrorTranslator errorTranslator;

  SourceRepositorySQLite({required this.db, required this.errorTranslator});

  @override
  Future<Source> getSource(int sourceId) async {
    var record = await db.get("sources", sourceId);

    if (record == null) {
      throw errorTranslator.translate(ExceptionEnum.sourceNotFound);
    }

    return Source.fromMap(record);
  }

  @override
  Future<List<Source>> getSources() async {
    var records = await db.getAll("sources");

    return records.map((record) => Source.fromMap(record)).toList();
  }

  @override
  Future<Source> addSource(AddSource payload) async {
    int id = await db.insert("sources", payload);

    if (id == 0) {
      throw errorTranslator.translate(ExceptionEnum.addSourceFailed);
    }

    return await getSource(id);
  }

  @override
  Future<void> deleteSource(int sourceId) async {
    int id = await db.delete("sources", sourceId);

    if (id == 0) {
      throw errorTranslator.translate(ExceptionEnum.deleteSourceFailed);
    }
  }
}
