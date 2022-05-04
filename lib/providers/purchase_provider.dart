import 'package:colimita/callables.dart' as callables;
import 'package:colimita/pages/payments/card_model.dart';
import 'package:colimita/pages/payments/card_verification_model.dart';
import 'package:colimita/providers/cards_provider.dart';
import 'package:colimita/providers/ongoing_purchase.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final purchaseProvider =
    StateNotifierProvider<PurchaseStateNotifier, OngoingPurchase>(
  (ref) {
    final cardsNotifier = ref.watch(cardsProvider.notifier);
    return PurchaseStateNotifier(cardsNotifier);
  },
);

class PurchaseStateNotifier extends StateNotifier<OngoingPurchase> {
  CardsNotifier cardsNotifier;
  PurchaseStateNotifier(this.cardsNotifier)
      : super(
          OngoingPurchase(
            amount: 0,
            purchase: const AsyncLoading(),
            saveCard: false,
          ),
        );

  void setAmount(num amount) {
    state = state.copyWith(
      amount: amount,
    );
  }

  void setSaveCard({bool saveCard = true}) {
    state = state.copyWith(saveCard: saveCard);
  }

  void setEitherCardOrVerification(
      Either<CardModel, CardVerificationModel> eitherCardOrverification) {
    state = state.copyWith(
      eitherCardOrVerification: eitherCardOrverification,
    );
  }

  Future<dynamic> purchase(String cardToken) async {
    if (state.saveCard) {
      cardsNotifier.saveCard(cardToken);
    }
    final resp = await callables.recharge({
      "value": state.amount,
      "cardToken": cardToken,
    });
    return resp.data;
  }
}
