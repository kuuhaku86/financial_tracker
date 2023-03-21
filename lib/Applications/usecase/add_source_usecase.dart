import 'package:financial_tracker/Applications/utils/file_manager.dart';
import 'package:financial_tracker/Domains/sources/entities/add_source.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/sources/source_repository.dart';

class AddSourceUsecase {
  SourceRepository sourceRepository;
  FileManager fileManager;

  AddSourceUsecase({required this.sourceRepository, required this.fileManager});

  Future<Source> execute(AddSource payload) async {
    String fileRoute = await fileManager.addFile(payload.image);

    return await sourceRepository.addSource(<String, Object>{
      "name": payload.name,
      "image_route": fileRoute,
    });
  }
}
