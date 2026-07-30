class FileNode {
  final String name;
  final String path;
  final bool isDirectory;
  bool expanded;
  List<FileNode> children;

  FileNode({
    required this.name,
    required this.path,
    required this.isDirectory,
    this.expanded = false,
    this.children = const [],
  });
}
