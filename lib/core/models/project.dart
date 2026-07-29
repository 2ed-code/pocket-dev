class Project {
  final String name;
  final String path;
  final String language;
  final bool favorite;

  const Project({
    required this.name,
    required this.path,
    required this.language,
    this.favorite = false,
  });
}
