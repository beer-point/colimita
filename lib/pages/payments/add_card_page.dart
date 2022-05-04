import 'package:colimita/pages/payments/card_form.dart';
import 'package:colimita/pages/payments/card_model.dart';
import 'package:colimita/pages/payments/card_verification_model.dart';
import 'package:colimita/providers/purchase_provider.dart';
import 'package:colimita/widgets/b_app_bar.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddCardPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void handleContinue(CreditCardModel card, {bool saveCard = false}) {
      final cardModel = CardModel(
        cardNumber: card.cardNumber.replaceAll(" ", ""),
        cardholderName: card.cardHolderName,
        securityCode: card.cvvCode,
        expDate: card.expiryDate,
      );

      ref.read(purchaseProvider.notifier).setEitherCardOrVerification(
            Left<CardModel, CardVerificationModel>(cardModel),
          );
      ref.read(purchaseProvider.notifier).setSaveCard(
            saveCard: saveCard,
          );
      Navigator.pushNamed(context, '/payments/create');
    }

    return Scaffold(
      appBar: BAppBar(),
      body: SafeArea(
        child: Column(children: <Widget>[
          CardForm(
            actionButtonText: 'Continuar',
            actionButtonPressed: handleContinue,
            isCvvOnly: false,
          )
        ]),
      ),
    );
  }
}
