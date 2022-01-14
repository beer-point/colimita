import 'dart:convert';

import 'package:colimita/pages/payments/card_token_creation_model.dart';
import 'package:colimita/widgets/loading_full_body.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

import 'card_model.dart';

const createCardTokenBodyPlaceholderReplacement =
    '%&createCardTokenBodyPlaceholderReplacement';

final mercadoPagoAPIPublicKey = 'TEST-c376ecc7-0bcb-4101-90ee-76c4b549dbf6';

class CreateCardTokenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _CreateCardTokenWebView(),
        LoadingScreen(),
      ],
    );
  }
}

class _CreateCardTokenWebView extends StatefulWidget {
  const _CreateCardTokenWebView() : super();

  @override
  State<_CreateCardTokenWebView> createState() =>
      _CreateCardTokenWebViewState();
}

class _CreateCardTokenWebViewState extends State<_CreateCardTokenWebView> {
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
    final eitherCardModelOrCardTokenCreationModel = ModalRoute.of(context)
        ?.settings
        .arguments as Either<CardModel, CardTokenCreationModel>;

    return Scaffold(
      body: SafeArea(
        child: Container(
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
                    eitherCardModelOrCardTokenCreationModel),
              );
            },

            onPageFinished: (String url) {},
            // onPageStarted: getCodeFromUrlAndNotify,
            onProgress: (int progress) {
              // TODO(lg): should we show a custom loader?
              print(progress.toString());
            },

            gestureNavigationEnabled: true,
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
          ),
        ),
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
            Navigator.pushNamed(
              context,
              '/payments/purchase',
              arguments: decodedPayload["id"],
            );
          }
        });
  }
}

String generateWebpageDefinitionWithCardValues(
    Either<CardModel, CardTokenCreationModel> eitherCardOrById) {
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
