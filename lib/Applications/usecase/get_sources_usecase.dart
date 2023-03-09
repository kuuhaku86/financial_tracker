import 'package:financial_tracker/Domains/sources/entities/add_source.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/sources/source_repository.dart';

class GetSourcesUsecase {
  SourceRepository sourceRepository;

  GetSourcesUsecase({required this.sourceRepository});

  Future<List<Source>> execute() async {
    return await sourceRepository.getSources();
  }
}
