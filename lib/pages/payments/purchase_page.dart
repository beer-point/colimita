import 'package:colimita/providers/purchase_provider.dart';
import 'package:colimita/widgets/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PurchasePage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardToken = ModalRoute.of(context)?.settings.arguments as String;

    useEffect(() {
      ref.read(purchaseProvider.notifier).purchase(cardToken).then((value) {
        Navigator.popUntil(context, (route) => route.settings.name == '/home');
      });
    }, []);

    return Scaffold(
        body: Center(child: AppTypography.subtitle('Comprando...')));
  }
}
