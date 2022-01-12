class User {
  final String id;
  final String name;
  final num balance;

  User({
    required this.id,
    required this.name,
    required this.balance,
  });

  static User? fromMap(String id, Map<String, dynamic>? map) {
    if (map != null) {
      return User(
        id: id,
        name: map['name'] ?? '',
        balance: (map['balance'] as num).toInt(),
      );
    }
  }
}
