import 'package:colimita/widgets/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CardForm extends StatefulWidget {
  String actionButtonText;
  void Function(CreditCardModel, {bool saveCard}) actionButtonPressed;
  bool isCvvOnly;

  CardForm({
    required this.actionButtonText,
    required this.actionButtonPressed,
    this.isCvvOnly = false,
  });

  @override
  State<StatefulWidget> createState() {
    return CardFormState();
  }
}

class CardFormState extends State<CardForm> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool storeCard = false;
  bool isCardFormValid = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    isCvvFocused = widget.isCvvOnly;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    InputDecorationTheme inputDecorationTheme =
        Theme.of(context).inputDecorationTheme;

    void handleUnfocus() {
      FocusManager.instance.primaryFocus?.unfocus();
    }

    OutlineInputBorder border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.amber[800]!,
        width: 1.0,
      ),
    );

    InputDecoration baseInputDecoration = InputDecoration(
      border: border,
      focusedBorder: border,
      enabledBorder: inputDecorationTheme.enabledBorder,
      hintStyle: TextStyle(color: Colors.amber[800]),
      labelStyle: TextStyle(color: Colors.amber[800]),
    );

    return Expanded(
      child: GestureDetector(
        onTap: handleUnfocus,
        child: Column(
          children: <Widget>[
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              obscureCardNumber: false,
              obscureCardCvv: false,
              isHolderNameVisible: true,
              cardBgColor: Colors.amber,
              isSwipeGestureEnabled: !widget.isCvvOnly,
              isChipVisible: false,
              onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CreditCardForm(
                      formKey: formKey,
                      obscureCvv: false,
                      obscureNumber: false,
                      cardNumber: cardNumber,
                      cvvCode: cvvCode,
                      isHolderNameVisible: !widget.isCvvOnly,
                      isCardNumberVisible: !widget.isCvvOnly,
                      isExpiryDateVisible: !widget.isCvvOnly,
                      cvvValidationMessage: 'CVV invalido',
                      dateValidationMessage: 'Fecha invalida',
                      numberValidationMessage: 'Numero invalido',
                      cardHolderName: cardHolderName,
                      expiryDate: expiryDate,
                      themeColor: Colors.amber,
                      textColor: Colors.amber[800]!,
                      cardNumberDecoration: baseInputDecoration.copyWith(
                        labelText: 'Numero',
                        hintText: 'XXXX XXXX XXXX XXXX',
                      ),
                      expiryDateDecoration: baseInputDecoration.copyWith(
                        labelText: 'Fecha de expiración',
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: baseInputDecoration.copyWith(
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      cardHolderDecoration: baseInputDecoration.copyWith(
                        labelText: 'Nombre',
                      ),
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                    if (!widget.isCvvOnly)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          children: [
                            Checkbox(
                                value: storeCard,
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value != null) {
                                      storeCard = value;
                                    }
                                  });
                                }),
                            AppTypography.body("¿Queres guardar esta tarjeta?")
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    ElevatedButton(
                      onPressed:
                          isCardFormValid ? handleActionButtonPressed : null,
                      child: Text(widget.actionButtonText),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleActionButtonPressed() {
    final creditCardModel = CreditCardModel(
      cardNumber,
      expiryDate,
      cardHolderName,
      cvvCode,
      isCvvFocused,
    );

    widget.actionButtonPressed(creditCardModel, saveCard: storeCard);
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
      if (formKey.currentState != null) {
        if (widget.isCvvOnly) {
          isCardFormValid = cvvCode.isNotEmpty && cvvCode.length >= 3;
        } else {
          isCardFormValid = formKey.currentState!.validate();
        }
      }
    });
  }
}
