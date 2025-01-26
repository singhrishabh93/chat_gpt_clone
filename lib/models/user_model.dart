class User {
  final String id;
  final String name;
  final String? avatarUrl;

  const User({
    required this.id, 
    required this.name, 
    this.avatarUrl
  });
}
