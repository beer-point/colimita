import 'package:colimita/pages/payments/card_form.dart';
import 'package:colimita/pages/payments/card_model.dart';
import 'package:colimita/pages/payments/card_token_creation_model.dart';
import 'package:colimita/widgets/back_button_row.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class AddCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void handleContinue(CreditCardModel card, {bool? saveCard}) {
      final cardModel = CardModel(
        cardNumber: card.cardNumber.replaceAll(" ", ""),
        cardholderName: card.cardHolderName,
        securityCode: card.cvvCode,
        expDate: card.expiryDate,
      );
      Navigator.pushNamed(context, '/payments/create-card-token',
          arguments: Left<CardModel, CardTokenCreationModel>(cardModel));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(children: <Widget>[
          BackButtonRow(),
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
