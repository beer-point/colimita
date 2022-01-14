import 'package:colimita/callables.dart' as callables;
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OngoingPurchase {
  num amount;
  AsyncValue<bool> purchase;

  OngoingPurchase({required this.amount, required this.purchase});
}

final purchaseProvider =
    StateNotifierProvider<PurchaseStateNotifier, OngoingPurchase>(
  (ref) {
    return PurchaseStateNotifier();
  },
);

class PurchaseStateNotifier extends StateNotifier<OngoingPurchase> {
  PurchaseStateNotifier()
      : super(OngoingPurchase(
          amount: 0,
          purchase: AsyncLoading(),
        ));

  void setAmount(num amount) {
    print("SETTING AMOUNT!!!");
    state = OngoingPurchase(amount: amount, purchase: state.purchase);
  }

  Future<void> purchase(String cardToken) async {
    final resp =
        callables.recharge({"value": state.amount, "cardToken": cardToken});
  }
}
