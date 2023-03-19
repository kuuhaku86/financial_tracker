import 'package:financial_tracker/Domains/sources/entities/add_source.dart';

import 'entities/source.dart';

class SourceRepository {
  Future<Source> getSource(int sourceId) async {
    throw Exception("Not Implemented");
  }

  Future<List<Source>> getSources() async {
    throw Exception("Not Implemented");
  }

  Future<Source> addSource(AddSource payload) async {
    throw Exception("Not Implemented");
  }

  Future<void> deleteSource(int sourceId) async {
    throw Exception("Not Implemented");
  }

  Future<void> updateSource(Source source) async {
    throw Exception("Not Implemented");
  }
}
