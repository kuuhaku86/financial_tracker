import 'dart:io';

import 'package:financial_tracker/Applications/usecase/add_source_usecase.dart';
import 'package:financial_tracker/Applications/usecase/add_transaction_usecase.dart';
import 'package:financial_tracker/Applications/usecase/delete_source_usecase.dart';
import 'package:financial_tracker/Applications/usecase/get_period_usecase.dart';
import 'package:financial_tracker/Applications/usecase/get_periods_usecase.dart';
import 'package:financial_tracker/Applications/usecase/get_recurring_transaction_usecase.dart';
import 'package:financial_tracker/Applications/usecase/get_source_usecase.dart';
import 'package:financial_tracker/Applications/usecase/get_sources_usecase.dart';
import 'package:financial_tracker/Applications/usecase/get_transaction_types_usecase.dart';
import 'package:financial_tracker/Applications/usecase/get_transaction_usecase.dart';
import 'package:financial_tracker/Applications/usecase/get_transactions_usecase.dart';
import 'package:financial_tracker/Applications/usecase/update_source_usecase.dart';
import 'package:financial_tracker/Applications/utils/file_manager.dart';
import 'package:financial_tracker/Applications/utils/uuid_generator.dart';
import 'package:financial_tracker/Commons/exceptions/domain_error_translator.dart';
import 'package:financial_tracker/Domains/sources/source_repository.dart';
import 'package:financial_tracker/Domains/transactions/transaction_repository.dart';
import 'package:financial_tracker/Infrastructures/database/sqlite/db.dart';
import 'package:financial_tracker/Infrastructures/repository/source_repository_sqlite.dart';
import 'package:financial_tracker/Infrastructures/repository/transaction_repository_sqlite.dart';
import 'package:financial_tracker/Infrastructures/utils/native_file_manager.dart';
import 'package:financial_tracker/Infrastructures/utils/uuid_utils.dart';

class Container {
  static late Container container;
  late Map<Type, Object> mapping;

  static init() async {
    Container.container = Container();
    DomainErrorTranslator errorTranslator = DomainErrorTranslator();
    SqliteDB db = SqliteDB();
    await db.init();
    TransactionRepository transactionRepository =
        TransactionRepositorySQLite(db: db, errorTranslator: errorTranslator);
    SourceRepository sourceRepository =
        SourceRepositorySQLite(db: db, errorTranslator: errorTranslator);
    UuidGenerator uuidGenerator = UuidUtils();
    FileManager fileManager = NativeFileManager(uuidGenerator);

    container.mapping = <Type, Object>{
      SqliteDB: db,
      UuidGenerator: uuidGenerator,
      FileManager: fileManager,
      TransactionRepository: transactionRepository,
      SourceRepository: sourceRepository,
      AddSourceUsecase: AddSourceUsecase(
          sourceRepository: sourceRepository, fileManager: fileManager),
      GetSourceUsecase: GetSourceUsecase(sourceRepository: sourceRepository),
      GetSourcesUsecase: GetSourcesUsecase(sourceRepository: sourceRepository),
      UpdateSourceUsecase: UpdateSourceUsecase(
          sourceRepository: sourceRepository, fileManager: fileManager),
      DeleteSourceUsecase: DeleteSourceUsecase(
          sourceRepository: sourceRepository, fileManager: fileManager),
      AddTransactionUsecase: AddTransactionUsecase(
          sourceRepository: sourceRepository,
          transactionRepository: transactionRepository),
      GetPeriodUsecase:
          GetPeriodUsecase(transactionRepository: transactionRepository),
      GetPeriodsUsecase:
          GetPeriodsUsecase(transactionRepository: transactionRepository),
      GetRecurringTransactionUsecase: GetRecurringTransactionUsecase(
          transactionRepository: transactionRepository),
      GetTransactionTypesUsecase: GetTransactionTypesUsecase(
          transactionRepository: transactionRepository),
      GetTransactionUsecase:
          GetTransactionUsecase(transactionRepository: transactionRepository),
      GetTransactionsUsecase:
          GetTransactionsUsecase(transactionRepository: transactionRepository),
    };
  }

  Object getInstance(Type type) {
    return mapping[type]!;
  }
}
