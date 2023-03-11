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
      throw errorTranslator.translate(ExceptionEnum.transactionNotFound);
    }

    return Source.fromMap(record as Map<String, Object>);
  }

  @override
  Future<List<Source>> getSources() async {
    var records = await db.getAll("sources");

    return records
        .map((record) => Source.fromMap(record as Map<String, Object>))
        .toList();
  }

  @override
  Future<Source> addSource(AddSource payload) async {
    int id = await db.insert("sources", payload);

    if (id == 0) {
      throw errorTranslator.translate(ExceptionEnum.addTransactionFailed);
    }

    return await getSource(id);
  }
}
