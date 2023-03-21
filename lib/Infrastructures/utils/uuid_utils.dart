import 'package:financial_tracker/Applications/utils/uuid_generator.dart';
import 'package:uuid/uuid.dart';

class UuidUtils extends UuidGenerator {
  @override
  String generateUuid() {
    return const Uuid().v1();
  }
}
