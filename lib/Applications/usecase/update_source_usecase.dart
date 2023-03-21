import 'package:financial_tracker/Applications/utils/file_manager.dart';
import 'package:financial_tracker/Domains/sources/entities/add_source.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/sources/source_repository.dart';

class UpdateSourceUsecase {
  SourceRepository sourceRepository;
  FileManager fileManager;

  UpdateSourceUsecase(
      {required this.sourceRepository, required this.fileManager});

  Future<void> execute(Source source, AddSource newData) async {
    if (source.imageRoute != newData.image.path) {
      String newFilePath = await fileManager.addFile(newData.image);

      await fileManager.deleteFile(source.imageRoute);

      source.imageRoute = newFilePath;
    }

    source.name = newData.name;

    await sourceRepository.updateSource(source);
  }
}
