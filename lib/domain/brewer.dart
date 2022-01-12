class Brewer {
  final String name;
  final String photoUrl;

  Brewer({
    required this.name,
    required this.photoUrl,
  });

  static Brewer? fromMap(Map<String, dynamic>? map) {
    if (map != null) {
      return Brewer(name: map['name'], photoUrl: map['photoUrl']);
    }
  }
}
