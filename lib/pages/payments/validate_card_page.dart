import 'package:colimita/pages/payments/card_form.dart';
import 'package:colimita/pages/payments/card_model.dart';
import 'package:colimita/pages/payments/card_token_creation_model.dart';
import 'package:colimita/widgets/back_button_row.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class ValidateCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cardId = ModalRoute.of(context)?.settings.arguments as String;
    void handleContinue(CreditCardModel card, {bool? saveCard}) {
      final cardTokenCreation =
          CardTokenCreationModel(cardId: cardId, cvv: card.cvvCode);
      Navigator.pushNamed(context, '/payments/create-card-token',
          arguments:
              Right<CardModel, CardTokenCreationModel>(cardTokenCreation));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(children: <Widget>[
          BackButtonRow(),
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
