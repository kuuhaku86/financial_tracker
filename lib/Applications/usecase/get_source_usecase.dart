import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/sources/source_repository.dart';

class GetSourceUsecase {
  SourceRepository sourceRepository;

  GetSourceUsecase({required this.sourceRepository});

  Future<Source> execute(int sourceId) async {
    return await sourceRepository.getSource(sourceId);
  }
}
