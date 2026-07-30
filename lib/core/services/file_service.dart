import 'dart:io';

import '../models/file_node.dart';

class FileService {
  Future<List<FileNode>> load(String path) async {
    final dir = Directory(path);

    if (!await dir.exists()) return [];

    return _scan(dir);
  }

  Future<List<FileNode>> _scan(Directory dir) async {
    final nodes = <FileNode>[];

    final entities = dir.listSync()..sort((a, b) => a.path.compareTo(b.path));

    for (final entity in entities) {
      if (entity is Directory) {
        nodes.add(
          FileNode(
            name: entity.uri.pathSegments[entity.uri.pathSegments.length - 2],
            path: entity.path,
            isDirectory: true,
            children: await _scan(entity),
          ),
        );
      } else if (entity is File) {
        nodes.add(
          FileNode(
            name: entity.uri.pathSegments.last,
            path: entity.path,
            isDirectory: false,
          ),
        );
      }
    }

    return nodes;
  }

  Future<void> delete(String path) async {
    final entity = FileSystemEntity.typeSync(path);

    switch (entity) {
      case FileSystemEntityType.file:
        await File(path).delete();
        break;
      case FileSystemEntityType.directory:
        await Directory(path).delete(recursive: true);
        break;
      default:
        break;
    }
  }

  Future<void> rename(String oldPath, String newPath) async {
    final entity = FileSystemEntity.typeSync(oldPath);

    switch (entity) {
      case FileSystemEntityType.file:
        await File(oldPath).rename(newPath);
        break;
      case FileSystemEntityType.directory:
        await Directory(oldPath).rename(newPath);
        break;
      default:
        break;
    }
  }
}
