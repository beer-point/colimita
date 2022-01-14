// import 'package:colimita/domain/payment_card.dart';
// import 'package:kt_dart/kt.dart';

class User {
  final String id;
  final String name;
  final num balance;
  // final KtList<PaymentCard>? cards;

  User({
    required this.id,
    required this.name,
    required this.balance,
    // this.cards = const KtList<PaymentCard>.empty(),
  });

  static User? fromMap(String id, Map<String, dynamic>? map) {
    if (map != null) {
      return User(
        id: id,
        name: map['name'] ?? '',
        balance: (map['balance'] as num).toInt(),
        // cards: KtList.from(map['cards']).map(
        //   (cardMap) => PaymentCard.fromMap(cardMap)!,
        // ),
      );
    }
  }
}
