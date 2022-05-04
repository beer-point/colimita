import 'package:colimita/pages/payments/create_card_token_webview.dart';
import 'package:colimita/providers/purchase_provider.dart';
import 'package:colimita/widgets/loading_full_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreatePaymentPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mountTokenCreationWebview = useState<bool>(true);

    void handleTokenCreated(String token) {
      mountTokenCreationWebview.value = false;

      ref.read(purchaseProvider.notifier).purchase(token).then((data) {
        Navigator.popUntil(context, (route) => route.settings.name == '/home');
      }).catchError((error) {
        Navigator.popUntil(context, (route) => route.settings.name == '/home');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Hubo un error'),
          ),
        );
        return;
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          if (mountTokenCreationWebview.value)
            CreateCardTokenWebView(onTokenCreated: handleTokenCreated),
          const LoadingScreen(),
        ],
      ),
    );
  }
}
