import 'dart:io';
import 'package:financial_tracker/Applications/utils/file_manager.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:financial_tracker/Applications/utils/uuid_generator.dart';

class NativeFileManager extends FileManager{
  UuidGenerator uuid;

  NativeFileManager(this.uuid);

  @override
  Future<String> addFile(File file) async {
    final String path = (await getApplicationDocumentsDirectory()).path;
    final String filename = uuid.generateUuid();
    final String fileExtension = extension(file.path);
    final String newFilePath = '$path/$filename$fileExtension';

    await file.copy(newFilePath);

    return newFilePath;
  }

  @override
  Future<void> deleteFile(String path) async {
    await File(path).delete();
  }
}
