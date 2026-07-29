import 'dart:io';

class FileService {
  static List<FileSystemEntity> list(String path) {
    return Directory(path).listSync();
  }

  static Future<void> createFile(String path) async {
    await File(path).create(recursive: true);
  }

  static Future<void> createFolder(String path) async {
    await Directory(path).create(recursive: true);
  }

  static Future<void> delete(String path) async {
    final type = FileSystemEntity.typeSync(path);

    if (type == FileSystemEntityType.directory) {
      await Directory(path).delete(recursive: true);
    } else {
      await File(path).delete();
    }
  }

  static Future<void> rename(
    String oldPath,
    String newPath,
  ) async {
    final type = FileSystemEntity.typeSync(oldPath);

    if (type == FileSystemEntityType.directory) {
      await Directory(oldPath).rename(newPath);
    } else {
      await File(oldPath).rename(newPath);
    }
  }
}
