import 'package:colimita/pages/payments/card_form.dart';
import 'package:colimita/pages/payments/card_model.dart';
import 'package:colimita/pages/payments/card_verification_model.dart';
import 'package:colimita/providers/purchase_provider.dart';
import 'package:colimita/widgets/b_app_bar.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ValidateCardPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardId = ModalRoute.of(context)?.settings.arguments as String;

    void handleContinue(CreditCardModel card, {bool saveCard = false}) {
      final cardTokenCreation = CardVerificationModel(
        cardId: cardId,
        cvv: card.cvvCode,
      );

      ref.read(purchaseProvider.notifier).setEitherCardOrVerification(
            Right<CardModel, CardVerificationModel>(cardTokenCreation),
          );

      Navigator.pushNamed(
        context,
        '/payments/create',
      );
    }

    return Scaffold(
      appBar: BAppBar(),
      body: SafeArea(
        child: Column(children: <Widget>[
          CardForm(
            actionButtonText: 'Pagar',
            actionButtonPressed: handleContinue,
            isCvvOnly: true,
          )
        ]),
      ),
    );
  }
}
