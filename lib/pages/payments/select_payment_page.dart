import 'package:colimita/domain/payment_card.dart';
import 'package:colimita/providers/cards_provider.dart';
import 'package:colimita/providers/user_provider.dart';
import 'package:colimita/widgets/app_typography.dart';
import 'package:colimita/widgets/loading_full_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kt_dart/collection.dart';

class SelectPaymentPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCards = ref.watch(cardsProvider);
    return asyncCards.when(
      data: (cards) => _SelectPaymentPage(cards: cards),
      loading: () => LoadingScreen(),
      error: (err, stack) {
        print(err);
        print(stack);
        return Text('Error');
      },
    );
  }
}

class _SelectPaymentPage extends HookConsumerWidget {
  KtList<PaymentCard> cards;
  _SelectPaymentPage({required this.cards});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCard = useState<PaymentCard?>(null);
    final recharge = ModalRoute.of(context)?.settings.arguments as num;

    void handleGoToAddCardForm() {
      Navigator.pushNamed(context, '/payments/add-card');
      // Navigator.pushNamed(context, '/payments/create-card-token');
    }

    void handleContinue() {
      Navigator.pushNamed(
        context,
        '/payments/validate-card',
        arguments: selectedCard.value!.id,
      );
    }

    void handleSelectCard(PaymentCard card) {
      if (selectedCard.value == card) {
        selectedCard.value = null;
      } else {
        selectedCard.value = card;
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  const BackButton(),
                ],
              ),
              Text(
                '\$ $recharge',
                style: const TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              AppTypography.body('Elegi como vas a pagar:'),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ...cards
                        .asList()
                        .map(
                          (card) => _CardItem(
                            card: card,
                            onSelect: handleSelectCard,
                            selected: card == selectedCard.value,
                          ),
                        )
                        .toList(),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: IconButton(
                          onPressed: handleGoToAddCardForm,
                          icon: const Icon(Icons.add),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: selectedCard.value != null ? handleContinue : null,
                child: const Text('Continuar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  PaymentCard card;
  bool selected;
  void Function(PaymentCard card) onSelect;

  _CardItem({required this.card, required this.onSelect, this.selected = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(card),
      child: Card(
        shape: selected
            ? const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4.0),
                ),
                side: BorderSide(
                  color: Colors.amber,
                ),
              )
            : null,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(card.methodThumbnail,
                        headers: {'Cache-Control': 'max-age=200'}),
                  ),
                ),
              ),
            ),
            AppTypography.body(
              card.number,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}

final a = {
  "id": "e64ec6f0a034c256d8c55d70c7b6712a",
  "public_key": "APP_USR-c3ec8e37-737f-4d99-9f21-16d1a8a952dd",
  "first_six_digits": "503143",
  "expiration_month": 11,
  "expiration_year": 2025,
  "last_four_digits": "6351",
  "cardholder": {"identification": {}, "name": "APRO"},
  "status": "active",
  "date_created": "2022-01-13T18:13:25.539-04:00",
  "date_last_updated": "2022-01-13T18:13:25.539-04:00",
  "date_due": "2022-01-21T18:13:25.539-04:00",
  "luhn_validation": true,
  "live_mode": true,
  "require_esc": false,
  "card_number_length": 16,
  "security_code_length": 3
};
