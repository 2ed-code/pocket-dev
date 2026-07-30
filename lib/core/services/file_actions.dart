import 'dart:io';

class FileActions {
  Future<void> newFile(String path) async {
    final file = File(path);
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
  }

  Future<void> newFolder(String path) async {
    final dir = Directory(path);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
  }

  Future<void> delete(String path) async {
    final type = FileSystemEntity.typeSync(path);

    if (type == FileSystemEntityType.file) {
      await File(path).delete();
    } else if (type == FileSystemEntityType.directory) {
      await Directory(path).delete(recursive: true);
    }
  }

  Future<void> rename(String oldPath, String newPath) async {
    final type = FileSystemEntity.typeSync(oldPath);

    if (type == FileSystemEntityType.file) {
      await File(oldPath).rename(newPath);
    } else if (type == FileSystemEntityType.directory) {
      await Directory(oldPath).rename(newPath);
    }
  }

  Future<void> duplicate(String source, String target) async {
    final file = File(source);

    if (await file.exists()) {
      await file.copy(target);
    }
  }
}
