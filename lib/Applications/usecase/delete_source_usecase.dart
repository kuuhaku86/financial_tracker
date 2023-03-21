import 'package:financial_tracker/Applications/utils/file_manager.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/sources/source_repository.dart';

class DeleteSourceUsecase {
  SourceRepository sourceRepository;
  FileManager fileManager;

  DeleteSourceUsecase(
      {required this.sourceRepository, required this.fileManager});

  Future<void> execute(Source source) async {
    await fileManager.deleteFile(source.imageRoute);
    await sourceRepository.deleteSource(source.id);
  }
}
