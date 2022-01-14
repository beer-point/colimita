import 'package:colimita/callables.dart' as callables;
import 'package:colimita/domain/payment_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kt_dart/collection.dart';

final cardsProvider =
    StateNotifierProvider<CardsStateNotifier, AsyncValue<KtList<PaymentCard>>>(
  (ref) {
    return CardsStateNotifier();
  },
);

class CardsStateNotifier
    extends StateNotifier<AsyncValue<KtList<PaymentCard>>> {
  CardsStateNotifier() : super(const AsyncLoading()) {
    _getCards().then((cards) {
      state = AsyncData(cards);
    });
  }

  Future<KtList<PaymentCard>> _getCards() async {
    final getCardsResponse = await callables.getCards();
    final cards = getCardsResponse.data as List<Object?>;
    final paymentCards = cards.map((card) {
      final cardMap = Map<String, dynamic>.from(card as dynamic);
      final issuerMap = Map<String, dynamic>.from(cardMap['issuer'] as dynamic);

      final paymentMethodMap =
          Map<String, dynamic>.from(cardMap['payment_method'] as dynamic);

      cardMap['issuer'] = issuerMap;
      cardMap['payment_method'] = paymentMethodMap;
      return PaymentCard.fromMap(cardMap)!;
    });

    return KtList.from(paymentCards);
  }

  Future<void> refetchCards() async {
    state = const AsyncLoading();
    final cards = await _getCards();
    state = AsyncData(cards);
  }

  Future<void> saveCard(String token) async {
    await callables.saveCard({"cardToken": token});
    await refetchCards();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
