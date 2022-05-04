import 'dart:convert';

import 'package:colimita/pages/payments/card_verification_model.dart';
import 'package:colimita/providers/purchase_provider.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:async';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

import 'card_model.dart';

class CreateCardTokenWebView extends ConsumerStatefulWidget {
  void Function(String) onTokenCreated;

  CreateCardTokenWebView({required this.onTokenCreated}) : super();

  @override
  ConsumerState<CreateCardTokenWebView> createState() =>
      CreateCardTokenWebViewState();
}

class CreateCardTokenWebViewState
    extends ConsumerState<CreateCardTokenWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    final eitherCardModelOrCardVerificationModel =
        ref.watch(purchaseProvider).eitherCardOrVerification;

    return SizedBox(
      width: 1,
      height: 1,
      child: WebView(
        javascriptChannels: <JavascriptChannel>{
          _processControllerJavascriptChannel()
        },
        initialUrl: 'https://www.google.com',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
          _controller.future.then((value) => value.clearCache());
          webViewController.loadHtmlString(
            generateWebpageDefinitionWithCardValues(
                eitherCardModelOrCardVerificationModel!),
          );
        },
        onPageFinished: (String url) {},
        gestureNavigationEnabled: true,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      ),
    );
  }

  JavascriptChannel _processControllerJavascriptChannel() {
    return JavascriptChannel(
        name: 'MercadopagoProcessController',
        onMessageReceived: (JavascriptMessage message) {
          Map<String, dynamic> decodedMessage = json.decode(message.message);
          if (decodedMessage['action'] == 'token') {
            Map<String, dynamic> decodedPayload = json.decode(
              decodedMessage['payload'],
            );
            widget.onTokenCreated(decodedPayload["id"]);
          }
        });
  }
}

const createCardTokenBodyPlaceholderReplacement =
    '%&createCardTokenBodyPlaceholderReplacement';

final mercadoPagoAPIPublicKey = 'TEST-c376ecc7-0bcb-4101-90ee-76c4b549dbf6';

String generateWebpageDefinitionWithCardValues(
    Either<CardModel, CardVerificationModel> eitherCardOrById) {
  var webpageDef = mercadoPagoLocalWebpageDefinition;

  eitherCardOrById.fold(
    (card) {
      webpageDef = webpageDef.replaceFirst(
        createCardTokenBodyPlaceholderReplacement,
        '''
      cardNumber: '${card.cardNumber}',
      cardholderName: '${card.cardholderName}', 
      cardExpirationMonth: '${card.expMonth}',
      cardExpirationYear: '${card.expYear}',
      securityCode: '${card.securityCode}',
    ''',
      );
    },
    (cardCreation) {
      webpageDef = webpageDef.replaceFirst(
        createCardTokenBodyPlaceholderReplacement,
        '''
        cardId: '${cardCreation.cardId}',
        securityCode: '${cardCreation.cvv}',
      ''',
      );
    },
  );

  return webpageDef;
}

final mercadoPagoLocalWebpageDefinition = '''
<!DOCTYPE html>
<html lang="en">
<head>
<title>Mercadopago card token creation</title>
</head>
<body>

<script src="https://sdk.mercadopago.com/js/v2"></script>
<script>

  function createAction(action, payload){
    return JSON.stringify({"action": action, "payload": payload})
  }


// Agrega credenciales de SDK
  const mp = new MercadoPago('$mercadoPagoAPIPublicKey', {
        locale: 'es-UY'
  });

MercadopagoProcessController.postMessage(createAction("startup", undefined));
mp.createCardToken({
  $createCardTokenBodyPlaceholderReplacement
}).then((res) => {
  MercadopagoProcessController.postMessage(createAction("token", JSON.stringify(res)));
}).catch((e)=>{
  MercadopagoProcessController.postMessage(createAction("error", JSON.stringify(e)));
}).finally(()=>{
  MercadopagoProcessController.postMessage(createAction("finish", undefined));
})
</script>
</body>
</html>
''';
