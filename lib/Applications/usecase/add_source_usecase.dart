import 'package:financial_tracker/Domains/sources/entities/add_source.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/sources/source_repository.dart';

class AddSourceUsecase {
  SourceRepository sourceRepository;

  AddSourceUsecase({required this.sourceRepository});

  Future<Source> execute(AddSource payload) async {
    return await sourceRepository.addSource(payload);
  }
}
