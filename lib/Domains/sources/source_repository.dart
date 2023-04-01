import 'entities/source.dart';

class SourceRepository {
  Future<Source> getSource(int sourceId) async {
    throw Exception("Not Implemented");
  }

  Future<List<Source>> getSources() async {
    throw Exception("Not Implemented");
  }

  Future<Source> addSource(Map<String, Object> map) async {
    throw Exception("Not Implemented");
  }

  Future<void> deleteSource(int sourceId) async {
    throw Exception("Not Implemented");
  }

  Future<void> updateSource(Source source) async {
    throw Exception("Not Implemented");
  }
}
