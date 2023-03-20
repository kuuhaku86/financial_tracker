
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/sources/source_repository.dart';

class UpdateSourceUsecase {
  SourceRepository sourceRepository;

  UpdateSourceUsecase({required this.sourceRepository});

  Future<void> execute(Source payload) async {
    await sourceRepository.updateSource(payload);
  }
}