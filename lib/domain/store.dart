class Store {
  final String name;
  final String photoUrl;

  Store({required this.name, required this.photoUrl});

  static Store? fromMap(Map<String, dynamic>? map) {
    print(map);
    if (map != null) {
      return Store(
        name: map['name'],
        photoUrl: map['photoUrl'],
      );
    }
  }
}
