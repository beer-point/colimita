import 'package:colimita/pages/payments/filled_in_beer_custom_painter.dart';
import 'package:colimita/providers/purchase_provider.dart';
import 'package:colimita/widgets/app_typography.dart';
import 'package:colimita/widgets/b_app_bar.dart';
import 'package:colimita/widgets/loading_full_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaymentsPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRecharging = useState(false);

    Future<void> handleRecharge(num value) async {
      ref.read(purchaseProvider.notifier).setAmount(value);

      Navigator.pushNamed(
        context,
        '/payments/select-payment-method',
        arguments: value,
      );
    }

    if (isRecharging.value) {
      // return const PaymentsMercadopagoView();
      return const LoadingScreen();
    }

    return Scaffold(
      appBar: BAppBar(title: '¡Paga por lo que tomas!'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 32),
                _PrepayValueCard(200, handleRecharge),
                const SizedBox(height: 32),
                _PrepayValueCard(500, handleRecharge),
                const SizedBox(height: 32),
                _PrepayValueCard(1000, handleRecharge),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PrepayValueCard extends StatelessWidget {
  num value;
  void Function(num value) onPressed;

  _PrepayValueCard(this.value, this.onPressed);

  @override
  Widget build(BuildContext context) {
    final filledPercent = value / 1000;

    return Center(
      child: FractionallySizedBox(
        widthFactor: .7,
        child: ElevatedButton(
          // elevation: 4,
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsets.all(0),
            ),
            backgroundColor: MaterialStateProperty.all(
              Colors.white,
            ),
          ),
          onPressed: () => onPressed(value),
          child: RepaintBoundary(
            child: CustomPaint(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: Text(
                    '\$ $value',
                    style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(0, 0, 0, 0.68)
                        // Colors.purple.shade900
                        ),
                  ),
                ),
              ),
              painter: FilledInBeerCustomPainter(filledPercent),
            ),
          ),
        ),
      ),
    );
  }
}
